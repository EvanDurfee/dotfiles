#!/bin/python3

# script curteousy of Kindall at https://unix.stackexchange.com/questions/679821/is-there-a-way-to-have-snapback-in-tmux

import string

for c in string.printable:
    if ord(c) > 31:     # printable contains control chars we don't want
        c = repr(c).replace(r"\\", "\\")
        print('bind-key -T copy-mode', c,
              'send-keys -X cancel \; send-keys', c)
        print('bind-key -T copy-mode-vi', c,
              'send-keys -X cancel \; send-keys', c)
