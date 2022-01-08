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

# This library contains docker related utilities

# Updates a docker container to a newer version of the image by tag,
# and relaunches the container with a specified script.
# Signature: (<string container_name>, <string container_tag>, <string run_script>) -> void
update_docker() {
    container_name=$1
    container_tag=$2
    run_script=$3
    
    info "Seaching for updates for $container_name..."
    run_as_root "docker pull $container_tag"
    
    eq=$(run_as_root "docker ps" | awk -F ' {2,}' '$7 == "'$container_name'" { print $2 }')
    if [ -z "$eq" ]; then
        # No published ports, so we check field 6.
        eq=$(run_as_root "docker ps" | awk -F ' {2,}' '$6 == "'$container_name'" { print $2 }')
    fi
    # If the image doesn't have the awaited tag, then  
    if [[ $eq != "$container_tag" ]]; then
        # On relance le conteneur.
        info "Restarting container $container_name..."
        run_as_root "bash $run_script"
        # On supprime l'ancienne image pour libérer de l'espace.
        success "$container_name restarted!"
        info "Deleting old image version of $container_name..."
        sudo -p "" -i -S bash -c "docker rmi $eq"
        if [ $? -eq 0 ]; then
            success "Old image of $container_name deleted!"
        else
            error "Old image of $container_name could not be removed."
        fi
    else
        success "$container_name up to date!"
    fi
    echo ""
}
