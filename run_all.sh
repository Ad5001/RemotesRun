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

echo ""
# Cd into the directory of the library
script="$(readlink $0)"
if [ -z "$script" ]; then script="$0"; fi
cd "$(dirname "$script")"
# Importing common functions.
. ./libraries/common.sh

# Set remotes to remote folder to "remotes folder if not set.
if [ -z "$REMOTES" ]; then
    REMOTES="remotes"
fi


for folder in "$REMOTES"/*; do
    host=$(basename "$folder")
    # Check for powerline.
    if [ -z "$(which powerline)" ]; then
        echo -e -n "${L_GREEN_BG}${BLACK_FG} Password for ${RESET_INVERT}${ORANGE_BG}   $host  ${RESET} 🔑 > "
    else
        echo -e -n "${L_GREEN_BG}${BLACK_FG} Password for ${ORANGE_FG}${INVERT}${RESET_INVERT}${ORANGE_BG}${YELLOW_FG}  ${host} ${GRAY_FG}${INVERT}${RESET_INVERT}${GRAY_BG}${BLACK_FG} 🔑 ${INVERT} ${RESET}"
    fi
    read -s pswd
    echo -e "\n"
    # Executing all necessary scripts
    if [[ $pswd != "skip" ]]; then
        for script in $folder/*.sh; do
            scriptname=$(basename $script)
            scriptname=${scriptname//_/ }
            scriptname=${scriptname::-3}
            box "Executing script $scriptname..."
            # Taking dependencies into account.
            dependencies="libraries/common.sh $(sed -n '2p' $script | grep "# Requires: " | cut -d" " -f3-)" # Get dependencies from file.
            # Cat dependencies, remove all empty or comment lines, and pipe them into sshed bash.
            cat $dependencies $script | awk '$1 != "#" && $1 != ""' | sshpass -p "$pswd" -P "pass" ssh $host PASSWORD="$pswd" "bash -s"
        done
    else
        box "Skipping ${host}..."
    fi
done
