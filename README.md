# Multi-TOR

## Version

Stable release: **v1.0.0**  
Testing release: **testing**

## Description

A tool that allows you to create multiple **Tor** instances.

This is fork **Multi-TOR** project written by *Jai Seidl*: [Multi-TOR](https://github.com/jseidl/Multi-TOR)

Original source is (*Sebastian Wain* project): [http://blog.databigbang.com/distributed-scraping-with-multiple-tor-circuits/](http://blog.databigbang.com/distributed-scraping-with-multiple-tor-circuits/)

## Parameters

Provides the following options:

``````
  Usage:
    multitor <option|long-option>

  Examples:
    multitor --init 2 -u debian-tor --socks-port 9000 --control-port 9900
    multitor --show-id --socks-port 9000

  Options:
        --help                      show this message
        --debug                     displays information on the screen (debug mode)
    -i, --init <num>                init new tor processes
    -s, --show-id                   show specific tor process id
    -n, --new-id                    regenerate tor circuit
    -u, --user <string>             set the user (only with -i|--init)
        --socks-port <port_num>     set socks port number
        --control-port <port_num>   set control port number
``````

## Requirements

**<u>Multi-TOR</u>** uses external utilities to be installed before running:

- [tor](https://www.torproject.org/)
- [netcat](http://netcat.sourceforge.net/)

## Use example

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

Examples of obtaining information about a given **Tor** process created by **Multi-TOR**:

```
multitor --show-id --socks-port 9000
```

We want to get information about a given **Tor** process:

- `--show-id`

Specifies the port number for communication. Allows you to find the process after this port number:

- `--socks-port 9000`

If there is a need to create a new identity:

```
multitor --new-id --socks-port 9000
```

We set up creating a new identity for **Tor** process:

- `--new-id`

Specifies the port number for communication. Allows you to find the process after this port number:

- `--socks-port 9000`

So if We created 2 **Tor** processes by **Multi-TOR** example output will be given:

![multitor_output](doc/img/multitor_output.png)

## Limitations

- each **Tor** process needs a certain number of memory. If the number of processes is too big, the oldest one will be automatic killed by the system

## Project architecture

    |-- multitor                # main script (init)
    |-- LICENSE.md              # GNU GENERAL PUBLIC LICENSE, Version 3, 29 June 2007
    |-- README.md               # this simple documentation
    |-- .gitignore              # ignore untracked files
    |-- .gitkeep                # track empty directory
    |-- src                     # includes external project files
        |-- _import_            # external variables and functions
    |-- doc                     # includes documentation, images and manuals

## License

GPLv3 : <http://www.gnu.org/licenses/>

**Free software, Yeah!**
