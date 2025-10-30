# Ansible
## Running playbooks
In general, playbooks are run in the following fashion:
1. Activate the python environment (ansible should be installed with pip in a virtual environment): `$ activate`
2. Use an SSH-agent: `$ ssh-agent bash`
3. Add your ssh-key to the agent: `$ ssh-add ~/.ssh/id_rsa`
4. Run the playbook: `$ ansible-playbook -i hosts <playbook> --ask-vault-pass`
   On the first run on a VPS, you'll have to add `-e ansible_user=root` as the admin-user has not yet been configured.
5. Bob's your uncle


## MARVIN
Hosts [Plausible](https://plausible.io/).

