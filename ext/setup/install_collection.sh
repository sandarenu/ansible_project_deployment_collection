#! /bin/bash

# This script will install the ansible collections.

COLOR_END='\e[0m'
COLOR_RED='\e[0;31m'
COLOR_GREEN='\033[0;32m'  
# Exit msg
msg_exit() {
    printf "$COLOR_RED$@$COLOR_END"
    printf "\n"
    printf "Exiting...\n"
    exit 1
}

# General message
msg_txt(){
   printf "$COLOR_GREEN$@$COLOR_END"
printf "\n" 
}

#Install the collections and playbooks to installation location
RELEASE_VERSION=$(cat release_version)
INSTALL_PATH=/hms/installs/ansible/$RELEASE_VERSION

[ -z "$RELEASE_VERSION" ] && msg_exit "Release version number not available. Please check release_version file exists and not empty."

msg_txt "Stating the intallation of Ansible collection  $RELEASE_VERSION"
msg_txt "Collections will be copied to $INSTALL_PATH"

[[ -d "$INSTALL_PATH" ]]  && msg_exit "Folder '$INSTALL_PATH' already exist or permssion issue.\nPlease check and rerun."

if [ ! -d "$INSTALL_PATH" ]; then
    mkdir -p $INSTALL_PATH

    echo "[defaults]" > ansible.cfg
    echo "collections_path=$INSTALL_PATH" >> ansible.cfg

    cp -r playbooks $INSTALL_PATH

    ansible-galaxy install -r requirements.yml
    cp ansible.cfg $INSTALL_PATH/playbooks
    rm -rf ansible.cfg

    echo "" >> readme.md
    echo "* Release deployed on: $(date)" >> readme.md 
    cp readme.md $INSTALL_PATH

    msg_txt "Ansible collection $RELEASE_VERSION installed successfully."
fi

exit 0


