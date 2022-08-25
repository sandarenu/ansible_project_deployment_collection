## Directory Structure

```
ansible.cfg                     # ansible configuration file used during the development stage  
ansible_collections/            # ansible collections specific to this project
create-release.sh               # shell script used to create the deployment package 
ext/                            # contains some support scripts  
playbooks/                      # playbooks and vars for this project. create playbooks as needed.
    <play_1>/                   # playbooks for specific task
        <playbooks>/            # all the playbooks for the task
            01_play.yml
            02_play.yml
        <var>
            main.yml            # variables for the playbooks
readme.md  
requirements_download.yml       # requirements file used to create deployment package
requirements.yml                # requirements file used to setup up dependent collections to be used during development stage
```

## How to manage the Roles

* This project make use of the concept of collection reuse. There are two types of roles.
  * Common roles for any project. Eg: setting up the OS configurations, installing java
  * Project specific roles. Eg: installing project specific tool, installing project modules
 * Common roles are hosted in a separate GIT repository and will generally be managed and maintained separatetly. You can find that repository at `https://github.com/sandarenu/ansible_common_tasks_collection`.
 * To import such resuable collections add there git locations to `requirements.yml` file.
 * Project specific roles will be kept inside `ansible_collections` folder.
 * To create new collection use

  ```sh
  cd ansible_collections
  ansible-galaxy collections init <namespace>.<collection_name>
  ```

## Setup the project for development

* Clone Project
* Run `ansible-galaxy install -r requirements.yml` to download the reuseable collections from their GIT repositories.
* Those will be downloaded and installed at `/var/tmp`. This location can be controlled by `collections_path=/var/tmp:./` parameter in `ansible.cfg` file.

## Running Tasks in DEV environment

* Run tasks available in common_tasks collection

```
ansible-playbook -e @playbooks/common_tasks_1/vars/main.yml playbooks/common_tasks_1/playbooks/run_common_tasks_1.yaml

```
* By default it will use the `playbooks/dev.ini` inventory file. That is controlled by `inventory=./playbooks/dev.ini` configuration in `ansible.cfg` file.

* Run tasks specified in the project's collection

```
ansible-playbook playbooks/project_task_1/playbooks/run_project_tasks_1.yaml
```

## Packaging the collections to release

* Run the script `create-release.sh`, it will package all the dependent collections, project collections and playbooks to a folder callded `collections`.
* Copy the entire folder to the server where you want to run the ansible plays.


## Installing the packaged collection

* Create a directory `/hms/installs/ansible`
* Run the script `install_collection.sh`
* Collections will be installed in directory `/hms/installs/ansible` under the release version.
* Go to `/hms/installs/ansible/<VERSION>/playbooks` and run the playbooks as needed.