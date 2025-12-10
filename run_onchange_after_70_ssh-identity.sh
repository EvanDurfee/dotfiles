#!/bin/bash

set -euo pipefail


cat <<'EOF'
===================================================
Initialize ssh identity
===================================================
EOF

# Ensure profile is configured when running on a fresh system
if [ -z "${DOTFILES_PROFILE_LOADED:-}" ]; then . ~/.bash_profile; fi


echo "Check for BW session"
did_unlock=false
if [ -z "${BW_SESSION:-}" ]; then
	echo "Unlocking bitwarden"
	bw login --check
	export BW_SESSION="$(bw unlock --raw)"
	did_unlock=true
fi


bw() {
	flatpak run --command=bw com.bitwarden.desktop "$@"
}


key_id='SSH Identity Key'
mkdir -p "$HOME"/.ssh
touch "$HOME"/.ssh/known_hosts

if ! [ -e "$HOME/.ssh/identity.pub" ]; then
	echo "Fetching SSH identity public key"
	bw get item "$key_id" | jq '.sshKey.publicKey' --raw-output > ~/.ssh/identity.pub
	chmod 600 ~/.ssh/identity.pub
else
	echo "~/.ssh/identity.pub exists, skipping"
fi


if ! [ -e "$HOME/.ssh/identity-cert.pub" ]; then
	attachment_id="$(bw get item 'SSH Identity Key' | jq '.attachments[] | select(.fileName == "identity-cert.pub") | .id' --raw-output)"

	if [ -z "${attachment_id:-}" ]; then break; fi

	echo "Fetching SSH identity cert"
	bw get attachment "$attachment_id" --itemid "$(bw get item 'SSH Identity Key' | jq .id --raw-output)" --output ~/.ssh/identity-cert.pub
else
	echo "~/.ssh/identity-cert.pub exists, skipping"
fi

if bw get item 'SSH CA Key' >/dev/null && ! grep --quiet '@cert-authority' ~/.ssh/known_hosts; then
	echo "Adding SSH CA to trusted authorities"
	cat >> ~/.ssh/known_hosts <<< "@cert-authority * $(bw get item 'SSH CA Key' | jq .sshKey.publicKey --raw-output)"
fi


if $did_unlock; then
	echo "Locking bitwarden session"
	bw lock
	unset BW_SESSION
fi

if ! grep --quiet 'IdentityFile' ~/.ssh/config; then
	echo "Adding identity template to ssh config"
	cat <<'EOF' | tee -a "$HOME"/.ssh/config >/dev/null
Host *
	IdentityFile ~/.ssh/identity.pub
#	CertificateFile ~/.ssh/identity-cert.pub
EOF
fi
