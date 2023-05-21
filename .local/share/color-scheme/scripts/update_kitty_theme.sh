#!/bin/sh

# Script for updating the kitty terminal emulator's color scheme.
# Updates a symlink to a kitty conf whenever the color-scheme variant changes
# and reloads kitty.

kitty="$(which kitty 2>/dev/null)"
if [ $? -ne 0 ]; then
	printf "Kitty not installed, exiting\n" >&2
	exit 0
fi

variant="$1"

kitty_config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"/kitty
light_theme="$kitty_config_dir"/light-theme.conf
dark_theme="$kitty_config_dir"/dark-theme.conf
system_theme="$kitty_config_dir"/system-theme.conf
mkdir -p "$kitty_config_dir"

if [ "$variant" = "--init" ]; then
	if [ -e "$system_theme" ]; then
		printf "Color scheme aready set, skipping init\n" >&2
		exit 0
	fi
	variant=1
fi

case "$variant" in
	0|2) target_theme="$light_theme";;
	1) target_theme="$dark_theme";;
	*) printf "Unrecognized color-scheme variant %s\n" "$variant" >&2; exit 1;;
esac

printf "Setting kitty color scheme to %s\n" "$(basename "$target_theme")" >&2
rm -f "$system_theme"
ln -rs "$target_theme" "$system_theme"
printf "Signaling kitty to reload\n" >&2
pkill -USR1 -f "$kitty"
