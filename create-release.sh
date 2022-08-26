#! /bin/bash

INSTALL_LOCATION_BASE_PATH=/hms/installs/ansible
GIT_TAG_NAME=$(git describe --tags)

# Remove the previous builds
rm -rf collections

ansible-galaxy collection download -r requirements_download.yml

cp -r playbooks collections/playbooks

echo "$GIT_TAG_NAME" >> collections/release_version

# Create installation script
cp ext/setup/install_collection.sh collections/install_collection.sh

chmod +x collections/install_collection.sh


# Create simple release note
cat << EOF >> collections/readme.md
## Ansible Collection Release : ${GIT_TAG_NAME}

* Release packaged on: $(date)
* Git tag: ${GIT_TAG_NAME}
* Git last commit: $( git rev-parse HEAD)
* Release package created by: $(git config --get user.name) <$(git config --get user.email)>
EOF


