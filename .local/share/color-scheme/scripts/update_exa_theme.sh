#!/bin/sh

variant="$1"

prog_name="exa"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"/${prog_name}
light_theme="$config_dir"/colors-light.config
dark_theme="$config_dir"/colors-dark.config
system_theme="$config_dir"/colors.config
mkdir -p "$config_dir"

if [ "$variant" = "--init" ]; then
    if [ -e "$system_theme" ]; then
        printf "$prog_name color scheme aready set, skipping init\n" >&2
        exit 0
    fi
    variant=1
fi

case "$variant" in
    0|2) target_theme="$light_theme";;
    1) target_theme="$dark_theme";;
    *) printf "Unrecognized color-scheme variant %s\n" "$variant" >&2; exit 1;;
esac

printf "Setting $prog_name color scheme to %s\n" "$(basename "$target_theme")" >&2
rm -f "$system_theme"
ln -rs "$target_theme" "$system_theme"
rm -f "${XDG_CACHE_HOME:-$HOME/.cache}"/exa/colors
