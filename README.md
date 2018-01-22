# multitor

## Releases

| STABLE RELEASE                           | TESTING RELEASE                          |
| ---------------------------------------- | ---------------------------------------- |
| [![](https://img.shields.io/badge/Branch-master-brightgreen.svg)]() | [![](https://img.shields.io/badge/Branch-testing-red.svg)]() |
| [![](https://img.shields.io/badge/Version-v1.1.0-lightgrey.svg)]() | [![](https://img.shields.io/badge/Version-v1.1.0-lightgrey.svg)]() |
| [![Build Status](https://travis-ci.org/trimstray/multitor.svg?branch=master)](https://travis-ci.org/trimstray/multitor) | [![Build Status](https://travis-ci.org/trimstray/multitor.svg?branch=testing)](https://travis-ci.org/trimstray/multitor) |

## Description

A tool that allows you to create multiple **Tor** instances. In addition, it allows you to view previously started **Tor** processes and create a new identity for each of them.

> The **multitor** has been completely rewritten on the basis of:
>
> - **Multi-TOR** project written by *Jai Seidl*: [Multi-TOR](https://github.com/jseidl/Multi-TOR)
> - original source is (*Sebastian Wain* project): [Distributed Scraping With Multiple Tor Circuits](http://blog.databigbang.com/distributed-scraping-with-multiple-tor-circuits/)

## Parameters

Provides the following options:

``````
  Usage:
    multitor <option|long-option>

  Examples:
    multitor --init 2 --user debian-tor --socks-port 9000 --control-port 9900
    multitor --show-id --socks-port 9000

  Options:
        --help                      show this message
        --debug                     displays information on the screen (debug mode)
    -i, --init <num>                init new tor processes
    -s, --show-id                   show specific tor process id
    -n, --new-id                    regenerate tor circuit
    -u, --user <string>             set the user (only with -i|--init)
        --socks-port <port_num|all> set socks port number
        --control-port <port_num>   set control port number
``````

## Requirements

**<u>Multitor</u>** uses external utilities to be installed before running:

- [tor](https://www.torproject.org/)
- [netcat](http://netcat.sourceforge.net/)

## Use example

### Creating processes

Then an example of starting the tool:

``````
multitor --init 10 -u debian-tor --socks-port 9000 --control-port 9900
``````

Creates new **Tor** processes and specifies the number of processes to create:

- `--init 10`

Specifies the user from which new processes will be created (the user must exist in the system):

- `-u debian-tor`

Specifies the port number for **Tor** communication. Increased by 1 for each subsequent process:

- `--socks-port 9000`

Specifies the port number of the **Tor** process control. Increased by 1 for each subsequent process:

- `--control-port 9900`

### Reviewing processes

Examples of obtaining information about a given **Tor** process created by **multitor**:

```
multitor --show-id --socks-port 9000
```

We want to get information about a given **Tor** process:

- `--show-id`

> You can use the **all** value to display all processes.

Specifies the port number for communication. Allows you to find the process after this port number:

- `--socks-port 9000`

### New Tor identity

If there is a need to create a new identity:

```
multitor --new-id --socks-port 9000
```

We set up creating a new identity for **Tor** process:

- `--new-id`

> You can use the **all** value to regenerate identity for all processes.

Specifies the port number for communication. Allows you to find the process after this port number:

- `--socks-port 9000`

### Output example

So if We created 2 **Tor** processes by **multitor** example output will be given:

![multitor_output](doc/img/multitor_output.png)

## Password authentication

**Multitor** uses password for authorization on the control port. The password is generated automatically and contains 18 random characters - it is displayed in the final report after the creation of new processes.

## Logging

After running the script, the `log/` directory is created and in it the following files with logs:

- `<script_name>.<date>.log` - all `_logger()` function calls are saved in it
- `stdout.log` - a standard output and errors from the `_init_cmd()` and other function are written in it

## Important

If you use this tool in other scripts where the output is saved everywhere, not on the screen, remember that you will not be able to use the generated password. I will correct this in the next version.

## Limitations

- each **Tor** process needs a certain number of memory. If the number of processes is too big, the oldest one will be automatic killed by the system

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Project architecture

    |-- LICENSE.md                 # GNU GENERAL PUBLIC LICENSE, Version 3, 29 June 2007
    |-- README.md                  # this simple documentation
    |-- CONTRIBUTING.md            # principles of project support
    |-- .gitignore                 # ignore untracked files
    |-- .travis.yml                # continuous integration with Travis CI
    |-- setup.sh                   # install multitor on the system
    |-- bin
        |-- multitor               # main script (init)
    |-- doc                        # includes documentation, images and manuals
        |-- man8
            |-- multitor           # man page for multitor
    |-- lib                        # libraries, external functions
    |-- log                        # contains logs, created after init
    |-- src                        # includes external project files
        |-- helpers                # contains core functions
        |-- import                 # appends the contents of the lib directory
        |-- __init__               # contains the __main__ function
        |-- settings               # contains multitor settings

## License

GPLv3 : <http://www.gnu.org/licenses/>

**Free software, Yeah!**
