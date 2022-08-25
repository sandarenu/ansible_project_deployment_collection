
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