# instance configuration generator

This module generates configuration for cloud-init and netplan.
I aims as complete as necessary to create meaningful instances
for your bare metal or virtual machines with Ubuntu or other
operating systems that work with cloud-init. Right now it's
optimized to generate working user-data and network-config
files for Ubuntu 20.10 Groovy Gorilla on Raspberry Pi 4B.
I believe older releases should work out of the box.

## References

### Modules

- [network-config](./modules/network-config/README.md )
- [user-data](./modules/user-data/README.md )
- [static-copy](./modules/static-copy/README.md )

### Technologies

- [cloud-init](https://cloudinit.readthedocs.io/ )
- [netplan](https://netplan.io/ )
- [terraform](https://terraform.io/ )

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apt | Module 'apt' for Debian-style package manager's configuration. Proxy is optional. | `map` | `{}` | no |
| byobu\_by\_default | If to activate Byobu.io and on what level. | `string` | `"user"` | no |
| ca\_certs | Inserted from ca-certs examples https://cloudinit.readthedocs.io/en/latest/topics/examples.html?highlight=cert#configure-an-instances-trusted-ca-certificates | <pre>object({<br>    remove-defaults = bool<br>    trusted         = list(string)<br>  })</pre> | <pre>{<br>  "remove-defaults": false,<br>  "trusted": []<br>}</pre> | no |
| chpasswd | Sets the password for users. Be careful on what you configure here!<br><br>If you set a definitive user:password (like ubuntu:ubuntu) pair it is recommended<br>to expire the password on the first login, then change it right away to your secret.<br><br>On the other hand if you know in advance that you're going to use an SSH key pair<br>you might use a RANDOM value here. Please note that this effectively locks you out<br>of console access so you should have some fallback plan like to boot into a shell. | <pre>object({<br>    expire = bool<br>    list   = list(string)<br>  })</pre> | <pre>{<br>  "expire": true,<br>  "list": [<br>    "ubuntu:ubuntu"<br>  ]<br>}</pre> | no |
| config | bootcmd: Please state shell commands that shall be executed per boot for 'machine' type, operating 'system', instance 'role'.<br>runcmd: Please state shell commands that shall be executed on first boot for 'machine' type, operating 'system', instance 'role'.<br>packages: Please state packages that shall be installed per 'machine' type, operating 'system', instance 'role'. | `map(map(map(list(string))))` | <pre>{<br>  "bootcmd": {<br>    "roles": {<br>      "generic": [<br>        "neofetch --stdout"<br>      ]<br>    }<br>  },<br>  "packages": {<br>    "machine": {<br>      "amd64pc": [<br>        "linux-lowlatency",<br>        "linux-tools-lowlatency"<br>      ],<br>      "metal": [<br>        "cpufreqd",<br>        "cpufrequtils"<br>      ],<br>      "raspi4b": [<br>        "rpi-eeprom"<br>      ]<br>    },<br>    "roles": {<br>      "client": [<br>        "nmap"<br>      ],<br>      "generic": [<br>        "byobu",<br>        "ncdu",<br>        "neofetch",<br>        "neovim",<br>        "unattended-upgrades"<br>      ],<br>      "guardedwire": [<br>        "wireguard"<br>      ],<br>      "server": [<br>        "net-tools",<br>        "ufw"<br>      ]<br>    },<br>    "system": {<br>      "bionic": [<br>        "python",<br>        "python3-pip"<br>      ],<br>      "focal": [<br>        "python-is-python3",<br>        "python3-pip"<br>      ],<br>      "groovy": [<br>        "python-is-python3",<br>        "python3-pip"<br>      ],<br>      "ubuntu": [<br>        "language-pack-de"<br>      ]<br>    }<br>  },<br>  "runcmd": {<br>    "roles": {<br>      "generic": [<br>        "python -m pip install -U pip setuptools wheel"<br>      ],<br>      "guardedwire": [<br>        "mkdir /root/wg",<br>        "wg genkey > /root/wg/privatekey",<br>        "wg pubkey > /root/wg/publickey < /root/wg/privatekey",<br>        "ufw allow from 192.168.1.0/24 to any port 51820 proto udp comment 'wireguard'"<br>      ],<br>      "server": [<br>        "ufw enable",<br>        "ufw allow out domain",<br>        "ufw allow in domain",<br>        "ufw allow in ssh",<br>        "ufw limit ssh comment 'Limit SSH connections'"<br>      ]<br>    }<br>  }<br>}</pre> | no |
| ethernets | The addresses of the next hop router(s) must be specified 'gateway4: 172.16.0.1'<br>and / or 'gateway6: \"2001:4::1\"'. Please also specify at least one Nameserver.<br>The template currently uses the first search domain for it's fqdn generation logic. | `map(any)` | <pre>{<br>  "demo": {<br>    "gateway4": "192.168.1.1",<br>    "nameservers": {<br>      "addresses": [<br>        "192.168.1.1"<br>      ],<br>      "search": [<br>        "home.network"<br>      ]<br>    }<br>  }<br>}</pre> | no |
| instances | Definition of specific instantiations of this template. There will be a<br>directory below "output" created with the "hostname" value. Each package<br>group names specific to "machine", "system" and "roles" will be merged<br>and the resulting list will be written to the cloud-config "packages" list.<br>If any of the network's ipv?s lists is empty, the corresponding dhcp? will<br>be set to true in the generated 'network-data' file. The config map will<br>be merged on top into the cloud-config file in such a way that you're able<br>to specify any keys that cloud-init accepts. Any key in this map will in<br>effect overwrite keys with the same name written by this template. | `map(any)` | <pre>{<br>  "demo": {<br>    "config": {},<br>    "machine": [<br>      "amd64pc",<br>      "netbook"<br>    ],<br>    "networks": {<br>      "ethernets": {<br>        "eth0": {<br>          "ipv4s": [],<br>          "ipv6s": []<br>        }<br>      }<br>    },<br>    "netzone": "demo",<br>    "roles": [<br>      "generic",<br>      "client",<br>      "guardedwire"<br>    ],<br>    "system": [<br>      "ubuntu",<br>      "focal"<br>    ]<br>  }<br>}</pre> | no |
| locale | Cloud-init compatible string to set the locale. | `string` | `"de_DE.UTF-8"` | no |
| matcher | Specify machine types which should be matched to your Networking Interface Cards.<br>This could be everything cloud-init/netplan would accept as a matching expression<br>like 'driver', 'macaddress' or 'name'. Please extend according to your hardware. | `map(any)` | <pre>{<br>  "kvm": {<br>    "driver": "virtio"<br>  },<br>  "raspi4b": {<br>    "driver": "bcmgenet smsc95xx lan78xx"<br>  }<br>}</pre> | no |
| ntp | Specify if and where to fetch the current time from. | <pre>object({<br>    enabled = bool<br>    servers = list(string)<br>  })</pre> | <pre>{<br>  "enabled": true,<br>  "servers": [<br>    "de.pool.ntp.org"<br>  ]<br>}</pre> | no |
| output | Root directory where the generated files will be written to. | `string` | `"../.output/instances"` | no |
| package | System package manager options for first boot. | <pre>object({<br>    package_update             = bool<br>    package_upgrade            = bool<br>    package_reboot_if_required = bool<br>  })</pre> | <pre>{<br>  "package_reboot_if_required": true,<br>  "package_update": true,<br>  "package_upgrade": true<br>}</pre> | no |
| power\_state | How the machines should act when cloud-init finishes. | <pre>object({<br>    delay     = string<br>    mode      = string<br>    message   = string<br>    timeout   = string<br>    condition = string<br>  })</pre> | <pre>{<br>  "condition": "exit 0",<br>  "delay": "now",<br>  "message": "Finishing...",<br>  "mode": "reboot",<br>  "timeout": "600"<br>}</pre> | no |
| snap | Please state assertions and commands that shall be forwarded to snapd. | `map(any)` | `{}` | no |
| ssh | Setting for cloud-init's SSH module. You can e.g. import from launchpad or github.<br>If you use an SSH key pair you probably want to disable password based ssh login. | <pre>object({<br>    ssh_pwauth    = bool<br>    ssh_import_id = list(string)<br>  })</pre> | <pre>{<br>  "ssh_import_id": [],<br>  "ssh_pwauth": true<br>}</pre> | no |
| structs | Define the cloud-init-specific types of data-structures under 'config' to search during user-data generation. | `list(string)` | <pre>[<br>  "packages",<br>  "bootcmd",<br>  "runcmd"<br>]</pre> | no |
| timezone | Cloud-init compatible string to set the timezone. | `string` | `"Europe/Berlin"` | no |
| types | Define the instance-specific types of data-structures under 'config' to search during user-data generation. | `list(string)` | <pre>[<br>  "machine",<br>  "system",<br>  "roles"<br>]</pre> | no |
| users | Access definitions | `list(any)` | <pre>[<br>  "default"<br>]</pre> | no |
| wifis | The top level map's keys represent the Wifi's SSID value. | `map(any)` | <pre>{<br>  "demo": {}<br>}</pre> | no |
| write | Wether to write everything back to disk. Outputs will always be provided! | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| network-config | n/a |
| static-copy | n/a |
| user-data | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
