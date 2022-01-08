#!/bin/bash
#  ____                      _            ____              
# |  _ \ ___ _ __ ___   ___ | |_ ___  ___|  _ \ _   _ _ __  
# | |_) / _ \ '_ ` _ \ / _ \| __/ _ \/ __| |_) | | | | '_ \ 
# |  _ <  __/ | | | | | (_) | ||  __/\__ \  _ <| |_| | | | |
# |_| \_\___|_| |_| |_|\___/ \__\___||___/_| \_\\__,_|_| |_|
#                                                           
# Run several scripts on remote servers automatically.
# Copyright (C) 2022  Ad5001
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# This file contains library common functions for all update files.

# Ansi codes

# Resets all ansi codes.
RESET="\e[0m"
# Inverts foreground color and background color.
INVERT="\e[7m"
# Deactivates invertion of foreground color and background color.
RESET_INVERT="\e[27m"

# Sets the forground color to gray.
GRAY_FG="\e[90m"
# Sets the forground color to green.
GREEN_FG="\e[92m"
# Sets the forground color to blue.
BLUE_FG="\e[94m"

# Sets the background color to gray.
GRAY_BG="\e[100m"
# Sets the background color to green.
GREEN_BG="\e[102m"
# Sets the background color to blue.
BLUE_BG="\e[104m"

# Sets the forground color to black.
BLACK_FG="\e[30m"
# Sets the forground color to light green.
L_GREEN_FG="\e[32m"
# Sets the forground color to orange.
ORANGE_FG="\e[33m"
# Sets the forground color to red.
RED_FG="\e[38;5;204m"

# Sets the background color to black.
BLACK_BG="\e[40m"
# Sets the background color to light green.
L_GREEN_BG="\e[42m"
# Sets the background color to orange.
ORANGE_BG="\e[43m"
# Sets the background color to red.
RED_FG="\e[48;5;204m"

# Run a command as root.
# Signature: (<string command>) -> string
run_as_root() {
    echo "$PASSWORD" | sudo -p "" -i -S bash -c "$@"
}

# Simple info blue command.
# Signature: (<string message>) -> string
info() {
    echo -e "$BLUE_FG 🗘 $@ $RESET"
}

# Simple error command.
# Signature: (<string message>) -> string
error() {
    echo -e "$RED_FG 🗙 $@ $RESET"
}

# Simple success green command.
# Signature: (<string message>) -> string
success() {
    echo -e "$GREEN_FG ✓ $@ $RESET"
}

# Display text in a box
# Signature: (<string message>) -> string
box() {
    len=$(expr length "$1")
    echo "┌─$(yes ─ | head -$len | tr -d "\n")─┐"
    echo "│ $1 │"
    echo "└─$(yes ─ | head -$len | tr -d "\n")─┘"
}
