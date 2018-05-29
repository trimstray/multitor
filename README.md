<h1 align="center">Multitor</h1>

<h4 align="center">A tool that lets you create multiple TOR instances with a load-balancing.</h4>

<p align="center">
  <a href="https://img.shields.io/badge/Branch-master-green.svg">
    <img src="https://img.shields.io/badge/Branch-master-green.svg"
        alt="Branch">
  </a>
  <a href="https://img.shields.io/badge/Version-v1.2.3-lightgrey.svg">
    <img src="https://img.shields.io/badge/Version-v1.2.3-lightgrey.svg"
        alt="Version">
  </a>
  <a href="https://travis-ci.org/trimstray/multitor">
    <img src="https://travis-ci.org/trimstray/multitor.svg?branch=master"
        alt="Travis-CI">
  <a href="http://www.gnu.org/licenses/">
    <img src="https://img.shields.io/badge/license-GNU-blue.svg"
        alt="License">
  </a>
</p>

<p align="center">
   <a href="#description">Description</a>
 • <a href="#how-to-use">How To Use</a>
 • <a href="#parameters">Parameters</a>
 • <a href="#requirements">Requirements</a>
 • <a href="#other">Other</a>
 • <a href="#license">License</a>
 • <a href="https://github.com/trimstray/multitor/wiki">Wiki</a>
</p>

<div align="center">
  <sub>Created by
  <a href="https://twitter.com/trimstray">trimstray</a> and
  <a href="https://github.com/trimstray/multitor/graphs/contributors">
    contributors
  </a>
</div>

<br>

<p align="center">
    <img src="https://github.com/trimstray/multitor/blob/master/doc/img/multitor_output_1.png"
        alt="Master">
</p>

## Description

A tool that lets you **create multiple TOR** instances with a **load-balancing** traffic between them by **HAProxy**. It's provides one single endpoint for clients. In addition, you can **view** previously running **TOR** processes and create a **new identity** for all or selected processes.

> The **multitor** has been completely rewritten on the basis of:
>
> - **Multi-TOR** project written by *Jai Seidl*: [Multi-TOR](https://github.com/jseidl/Multi-TOR)
> - original source is (*Sebastian Wain* project): [Distributed Scraping With Multiple TOR Circuits](http://blog.databigbang.com/distributed-scraping-with-multiple-tor-circuits/)

## How To Use

> Before using the **multitor**, detailed understanding all parameters and how it works, see the **<a href="https://github.com/trimstray/multitor/wiki/Manual">Manual</a>**.

It's simple:

```bash
# Clone this repository
git clone https://github.com/trimstray/multitor

# Go into the repository
cd multitor

# Install
./setup.sh install

# Run the app
multitor --init 2 --user debian-tor --socks-port 9000 --control-port 9900
```

> * symlink to `bin/multitor` is placed in `/usr/local/bin`
> * man page is placed in `/usr/local/man/man8`

## Parameters

Provides the following options:

```bash
  Usage:
    multitor <option|long-option>

  Examples:
    multitor --init 2 --user debian-tor --socks-port 9000 --control-port 9900
    multitor --show-id --socks-port 9000

  Options:
        --help                      show this message
        --debug                     displays information on the screen (debug mode)
        --verbose                   displays more information about TOR processes
    -i, --init <num>                init new tor processes
    -s, --show-id                   show specific tor process id
    -n, --new-id                    regenerate tor circuit
    -u, --user <string>             set the user (only with -i|--init)
        --socks-port <port_num|all> set socks port number
        --control-port <port_num>   set control port number
        --proxy <socks|http>        set load balancer
```

## Requirements

**<u>Multitor</u>** uses external utilities to be installed before running:

- [tor](https://www.torproject.org/)
- [netcat](http://netcat.sourceforge.net/)
- [haproxy](https://www.haproxy.org/)
- [polipo](https://www.irif.fr/~jch/software/polipo/)

Also you will need **root access**.

## Other

### Important

If you use this tool in other scripts where the output is saved everywhere, not on the screen, remember that you will not be able to use the generated password. I will correct this in the next version. If you do not use regenerate function of single or all **TOR** circuits with a password, you can safely restart the **multitor** which will do it for you.

### Limitations

- each **TOR** process needs a certain number of memory. If the number of processes is too big, the oldest one will be automatic killed by the system
- **Polipo** is no longer supported but it is still a very good and light proxy. In the next version I will give you the option to choose a different solution.

### Contributing

See **[this](CONTRIBUTING.md)**.

### Project architecture

See **<a href="https://github.com/trimstray/multitor/wiki/Project-architecture">this</a>**.

## License

GPLv3 : <http://www.gnu.org/licenses/>

**Free software, Yeah!**
