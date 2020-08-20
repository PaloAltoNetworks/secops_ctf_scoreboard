# Test Ansible Roles with Molecule

## Setup

```
python3 -m venv ctf_venv
# because I am in fish shell
bash 
. ctf_venv/bin/activate
python3 -m pip install molecule[docker]
```

## Testing

```
cd roles/webserver
molecule converge
```

## Cleanup

```
cd ../..
deactivate
rm -rf ctf_venv
# because I am in fish shell
exit
```