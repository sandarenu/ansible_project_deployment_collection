
## Setup the project for development

* Clone Project
* Run `ansible-galaxy install -r requirements.yml` to download the `sansoft.common_tasks` collection.


## Running Tasks in DEV environment

* Run tasks available in common_tasks collection

```
ansible-playbook -e @playbooks/common_tasks_1/vars/main.yml playbooks/common_tasks_1/playbooks/run_common_tasks_1.yaml

```

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