
variable "instances" {
  description = <<-EOS
  Definition of specific instantiations of this template. There will be a
  directory below "output" created with the "hostname" value. Each package
  group names specific to "machine", "system" and "roles" will be merged
  and the resulting list will be written to the cloud-config "packages" list.
  If any of the network's ipv?s lists is empty, the corresponding dhcp? will
  be set to true in the generated 'network-data' file. The config map will
  be merged on top into the cloud-config file in such a way that you're able
  to specify any keys that cloud-init accepts. Any key in this map will in
  effect overwrite keys with the same name written by this template.
  EOS
  default = {
    "demo" = {
      config  = {}
      machine = ["amd64pc", "netbook"]
      system  = ["ubuntu", "focal"]
      roles   = ["generic", "client", "guardedwire"]
      netzone = "demo"
      networks = {
        ethernets = {
          eth0 = {
            ipv4s = []
            ipv6s = []
          }
        }
      }
    },
  }
  type = map(any)
}


#
# Networking parameters
#
variable "ethernets" {
  description = <<-EOS
  The addresses of the next hop router(s) must be specified 'gateway4: 172.16.0.1'
  and / or 'gateway6: \"2001:4::1\"'. Please also specify at least one Nameserver.
  The template currently uses the first search domain for it's fqdn generation logic.
  EOS

  default = {
    "demo" = {
      gateway4 = "192.168.1.1"
      nameservers = {
        addresses = [
          "192.168.1.1",
        ]
        search = ["home.network"]
      }
    },
  }
  type = map(any)
}

variable "wifis" {
  description = <<-EOS
  The top level map's keys represent the Wifi's SSID value.
  EOS

  default = {
    demo = {}
  }
  type = map(any)
}

variable "matcher" {
  description = <<-EOS
  Specify machine types which should be matched to your Networking Interface Cards.
  This could be everything cloud-init/netplan would accept as a matching expression
  like 'driver', 'macaddress' or 'name'. Please extend according to your hardware.
  EOS

  default = {
    kvm = {
      driver = "virtio"
    }
    raspi4b = {
      driver = "bcmgenet smsc95xx lan78xx"
    }
  }
  type = map(any)
}

#
# Software installation and + configuration
#
variable "structs" {
  description = "Define the cloud-init-specific types of data-structures under 'config' to search during uer-data generation."
  default     = ["packages", "bootcmd", "runcmd"]
  type        = list(string)
}

variable "types" {
  description = "Define the instance-specific types of data-structures under 'config' to search during user-data generation."
  default     = ["machine", "system", "roles"]
  type        = list(string)
}

variable "config" {
  description = <<-EOS
    bootcmd: Please state shell commands that shall be executed per boot for 'machine' type, operating 'system', instance 'role'.
    runcmd: Please state shell commands that shall be executed on first boot for 'machine' type, operating 'system', instance 'role'.
    packages: Please state packages that shall be installed per 'machine' type, operating 'system', instance 'role'.
    EOS
  type        = map(map(map(list(string))))
  default = {
    bootcmd = {
      roles = {
        generic = [
          "neofetch --stdout",
        ],
      },
    },
    runcmd = {
      roles = {
        generic = [
          "python -m pip install -U pip setuptools wheel",
        ],
        guardedwire = [
          "mkdir /root/wg",
          "wg genkey > /root/wg/privatekey",
          "wg pubkey > /root/wg/publickey < /root/wg/privatekey",
          "ufw allow from 192.168.1.0/24 to any port 51820 proto udp comment 'wireguard'",
        ],
        server = [
          "ufw enable",
          "ufw allow out domain",
          "ufw allow in domain",
          "ufw allow in ssh",
          "ufw limit ssh comment 'Limit SSH connections'",
        ],
      },
    },
    packages = {
      machine = {
        metal = [
          "cpufreqd",
          "cpufrequtils",
        ],
        amd64pc = [
          "linux-lowlatency",
          "linux-tools-lowlatency",
        ],
        raspi4b = [
          "rpi-eeprom",
        ],
      },
      system = {
        ubuntu = [
          "language-pack-de",
        ],
        bionic = [
          "python",
          "python3-pip",
        ],
        focal = [
          "python-is-python3",
          "python3-pip",
        ],
        groovy = [
          "python-is-python3",
          "python3-pip",
        ],
      },
      roles = {
        generic = [
          "byobu",
          "ncdu",
          "neofetch",
          "neovim",
          "unattended-upgrades",
        ],
        client = [
          "nmap",
        ],
        server = [
          "net-tools",
          "ufw",
        ],
        guardedwire = [
          "wireguard",
        ],
      },
    },
  }
}


#
# Access definitions
#
variable "users" {
  default = ["default"]
  type    = list(any)
}

variable "byobu_by_default" {
  description = "If to activate Byobu.io and on what level."
  default     = "user"
  type        = string
}

variable "chpasswd" {
  description = <<-EOS
  Sets the password for users. Be careful on what you configure here!

  If you set a definitive user:password (like ubuntu:ubuntu) pair it is recommended
  to expire the password on the first login, then change it right away to your secret.

  On the other hand if you know in advance that you're going to use an SSH key pair
  you might use a RANDOM value here. Please note that this effectively locks you out
  of console access so you should have some fallback plan like to boot into a shell.

  EOS
  default = {
    expire = true
    users = [
      "ubuntu:ubuntu",
    ]
  }
  type = object({
    expire = bool
    users  = list(string)
  })
}

variable "ssh" {
  description = <<-EOS
  Setting for cloud-init's SSH module. You can e.g. import from launchpad or github.
  If you use an SSH key pair you probably want to disable password based ssh login.
  EOS
  default = {
    ssh_pwauth    = true
    ssh_import_id = []
  }
  type = object({
    ssh_pwauth    = bool
    ssh_import_id = list(string)
  })
}


#
# Package manager config
#
variable "apt" {
  description = "Module 'apt' for Debian-style package manager's configuration. Proxy is optional."
  default     = {}
}

variable "snap" {
  description = "Please state assertions and commands that shall be forwarded to snapd."
  default     = {}
  type        = map(any)
}

variable "package" {
  description = "System package manager options for first boot."
  default = {
    package_update             = true
    package_upgrade            = true
    package_reboot_if_required = true
  }
  type = object({
    package_update             = bool
    package_upgrade            = bool
    package_reboot_if_required = bool
  })
}


#
# Trust store handling
#
variable "ca_certs" {
  description = "Inserted from ca-certs examples https://cloudinit.readthedocs.io/en/latest/topics/examples.html?highlight=cert#configure-an-instances-trusted-ca-certificates"
  default = {
    remove-defaults = false
    trusted         = []
  }
  type = object({
    remove-defaults = bool
    trusted         = list(string)
  })
}


#
# Localization
#
variable "locale" {
  description = "Cloud-init compatible string to set the locale."
  default     = "de_DE.UTF-8"
  type        = string
}

variable "timezone" {
  description = "Cloud-init compatible string to set the timezone."
  default     = "Europe/Berlin"
  type        = string
}

variable "ntp" {
  description = "Specify if and where to fetch the current time from."
  default = {
    enabled = true
    servers = [
      "de.pool.ntp.org",
    ]
  }
  type = object({
    enabled = bool
    servers = list(string)
  })
}

#
# Finalization
#
variable "power_state" {
  description = "How the machines should act when cloud-init finishes."
  default = {
    delay     = "now"
    mode      = "reboot"
    message   = "Finishing..."
    timeout   = "600"
    condition = "exit 0"
  }
  type = object({
    delay     = string
    mode      = string
    message   = string
    timeout   = string
    condition = string
  })
}

#
# Where does it go?
#
variable "write" {
  description = "Wether to write everything back to disk. Outputs will always be provided!"
  default     = false
  type        = bool
}

variable "output" {
  description = "Root directory where the generated files will be written to."
  default     = "../.output/instances"
  type        = string
}
