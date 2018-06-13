# bash config

Some aliases and config options for bash.

bash is mostly used on the raspberry pi's scattered arround the place. For some
reason zsh does not cut it.

```
.
├── .config/
│   └── bash/
│       └── alias.d/
│           ├── common.alias
│           ├── dvcs.alias.disable
│           ├── python3.alias
│           ├── vbox.alias
│           └── vim.alias
└── .bashrc

```


*MACHINE_LOCATION* is set in /etc/bash.rc so all bash shells gets that. That variable
switches things on (proxy) when a VM or machine is deployed or running at work. 
Setting proxies depending on network may be better.

I only control home subnet so maybe test for that, as a generic setup should be run at work,
digital ocean or anywhere else where subnets are not known or configurable.
