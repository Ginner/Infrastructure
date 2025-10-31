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
Hosts [Plausible](https://plausible.io/) and [ntfy.sh](https://ntfy.sh/).

### ntfy.sh
Easy post notification with username and password:
  - Using curl: `$ curl -u <username>:<password> -d "Whatever message you want" ntfy.example.dk/<topic>`.
  - Python: `requests.post("https://ntfy.example.com/mysecrets", data="Look ma, with auth", headers={ "Authorization": "Basic dGVzdHVzZXI6ZmFrZXBhc3N3b3Jk" })`
  - HTTP:
    ```
    POST /mysecrets HTTP/1.1
    Host: ntfy.example.com
    Authorization: Basic dGVzdHVzZXI6ZmFrZXBhc3N3b3Jk

    Look ma, with auth
    ```
In the above, `dGVzdHVzZXI6ZmFrZXBhc3N3b3Jk` is a base64 encoded string containing `<username>:<password>`, e.g. `$ echo "Basic $(echo -n 'testuser:fakepassword' | base64)"`

Notifications using tokens:
  - Using curl: `$ curl -H "Authorization: Bearer tk_AgQdq7mVBoFD37zQVN29RhuMzNIz2" -d "Look ma, with auth" https://ntfy.example.com/<topic>`
  - Python: `requests.post("https://ntfy.example.com/topic", data="Look ma, with auth", headers={ "Authorization": "Bearer tk_AgQdq7mVBoFD37zQVN29RhuMzNIz2" })`
  - HTTP:
    ```
    POST /mysecrets HTTP/1.1
    Host: ntfy.example.com
    Authorization: Bearer tk_AgQdq7mVBoFD37zQVN29RhuMzNIz2

    Look ma, with auth
    ```

For a LOT more methods, checkout [docs.ntfy.sh](docs.ntfy.sh).


It is setup such that `<ntfy_user>` receives messages in all topics starting with `alerts-`. `<ntfy_user>` also receives messages to the `home-alerts` topic.

