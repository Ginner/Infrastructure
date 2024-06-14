# NixOS configurations

## GLaDOS

### TODO
- [ ] Expand on this README
- [ ] Setup persistent storage
  - [ ] Omada needs persistent storage for `containers/omada/(data & logs)/`
  - [ ] linkding needs persistent storage for `containers/linkding/data/`
  - [ ] baikal needs persistent storage
- [ ] Backup persistent storage
- [ ] Check up on the necessity of my configurations
  - [ ] Are my directory creation in `podman-virtualisation.nix` necessary? Do they have to be owned by root?
- [ ] My local egress ip is hardcoded in `.secrets/namecheap-api.age` which causes caddy to be unable to obtain SSL cert when it changes... Fix it.
- [ ] Further more, my public IP has to be whitelisted in my namecheap API Access - It'll be difficult to automate that... Get your public IP with `curl ifconfig.io` go to namecheap.com -> Profile -> Tools -> Business & Dev tools -> Manage -> Whitelisted IPs -> Edit and update the IP.
