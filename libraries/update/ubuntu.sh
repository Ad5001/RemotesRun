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

# This library contains information for debian & ubuntu based systems.

export DEBIAN_FRONTEND=noninteractive


# Updates a debian system when the user isn't root (runs with sudo)
# Signature: () -> void
update_non_root() {
    info "Checking for updates..."
    run_as_root "apt-get update"
    count=$(apt list --upgradeable | wc -l) # Count, with 1 additional line
    if [[ $count -ne 1 ]]; then
        info "Updating $(expr $count - 1) packets..."
        run_as_root "apt-get dist-upgrade -y"
        success "System has been updated!"
    else
        success "System up to date."
    fi
}

# Updates a redhat system when the user is root (runs without sudo)
# Signature: () -> void
update_as_root() {
    info "Checking for updates..."
    apt-get update
    count=$(apt list --upgradeable | wc -l) # Count, with 1 additional line
    if [[ $count -ne 1 ]]; then
        info "Updating $(expr $count - 1) packets..."
        apt-get dist-upgrade -y
        success "System has been updated!"
    else
        success "System up to date."
    fi
}
