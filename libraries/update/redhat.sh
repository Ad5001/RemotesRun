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

# This library contains information for redhat based systems (fedora, centos, redhat).


# Updates a redhat system when the user isn't root (runs with sudo)
# Signature: () -> void
update_non_root() {
    info "Checking for updates..."
    run_as_root "yum check-update"
    info "Updating..."
    run_as_root "yum update -y"
    success "Updated!"
}

# Updates a redhat system when the user is root (runs without sudo)
# Signature: () -> void
update_as_root() {
    info "Checking for updates..."
    yum check-update
    info "Updating..."
    yum update -y
    success "Updated!"
}
