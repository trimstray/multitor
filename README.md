<h1 align="center">multitor</h1>

<h4 align="center">Create multiple TOR instances with a load-balancing.</h4>

<p align="center">
  <a href="https://travis-ci.org/trimstray/multitor">
    <img src="https://travis-ci.org/trimstray/multitor.svg?branch=master" alt="Travis-CI">
  </a>
  <a href="https://img.shields.io/badge/Version-v1.3.0-lightgrey.svg">
    <img src="https://img.shields.io/badge/Version-v1.3.0-lightgrey.svg" alt="Version">
  </a>
  <a href="http://www.gnu.org/licenses/">
    <img src="https://img.shields.io/badge/license-GNU-blue.svg" alt="License">
  </a>
</p>

<p align="center">
   <a href="#description">Description</a>
 • <a href="#introduction">Introduction</a>
 • <a href="#how-to-use">How To Use</a>
 • <a href="#parameters">Parameters</a>
 • <a href="#requirements">Requirements</a>
 • <a href="#docker">Docker</a>
 • <a href="#other">Other</a>
 • <a href="#license">License</a>
 • <a href="https://github.com/trimstray/multitor/wiki">Wiki</a>
</p>

<div align="center">
  <sub>Created by
  <a href="https://twitter.com/trimstray">trimstray</a> and
  <a href="https://github.com/trimstray/multitor/graphs/contributors">contributors</a>
</div>

<br>

<p align="center">
  <img src="https://github.com/trimstray/multitor/blob/master/static/img/multitor_output_1.png" alt="Master">
</p>

## Description

It provides one single endpoint for clients. Supports **[HAProxy](http://www.haproxy.org/)**, **socks** protocol and **http-proxy** servers: **[polipo](https://www.irif.fr/~jch/software/polipo/)**, **[privoxy](https://www.privoxy.org/)** and **[hpts](https://github.com/oyyd/http-proxy-to-socks)**.

In addition, you can **view** previously running **TOR** processes and create a **new identity** for all or selected processes.

> The `multitor` has been completely rewritten on the basis of:
>
> - **Multi-TOR** project written by *Jan Seidl*: [Multi-TOR](https://github.com/jseidl/Multi-TOR)
> - original source is (*Sebastian Wain* project): [Distributed Scraping With Multiple TOR Circuits](http://blog.databigbang.com/distributed-scraping-with-multiple-tor-circuits/)

## Introduction

`multitor` was created with the aim of initialize many **TOR** processes as quickly as possible. I could use many instances for my daily use programs (web browsers, messangers and other). In addition, I was looking for a tool that would increase anonymity when conducting penetration tests and testing the security of infrastructure.

Before using the `multitor` you need to remember:

- **TOR** does attempt to generate a bunch of streams for you already. From this perspective, it is already load balancing (and it's much smarter at it than **HAproxy**)
- the main goal is masking from where we get by sending requests to multiple streams. It is not so easy to locate where an attacker comes from. If you used http/https servers e.g. proxy servers, you will know what is going on but...
- using multiple **TOR** instances can increase the probability of using a compromised circuit
- `multitor` getting some bandwidth improvements just because it's a different way of connecting to **TOR** network
- in `multitor` configuration mostly **HAProxy** checks the local (syn, syn/ack) socket - not all **TOR** nodes (also exist nodes). If there is a problem with the socket it tries to send traffic to others available without touching what's next - it does not ensure that the data will arrive
- **TOR** network is a separate organism on which the `multitor` has no effect If one of the nodes is damaged and somehow the data can not leave the exit node, it is likely that a connection error will be returned or, at best, the data will be transferred through another local socket
- **HAProxy** load balance network traffic between local **TOR** or **http-proxy** processes - not nodes inside **TOR** network

> **TOR** is a fine security project and an excellent component in a strategy of defence in depth but it isn’t (sadly) a cloak of invisibility. When using the **TOR**, always remember about ssl (e.g. https) wherever it is possible.

Look also at **[Limitations](#limitations)**.

## How To Use

> :heavy_exclamation_mark: For a more detailed understanding of `multitor`, its parameters, functions and how it all works, see the **[Manual](https://github.com/trimstray/multitor/wiki/Manual)**.

It's simple:

```bash
# Clone this repository
git clone https://github.com/trimstray/multitor

# Go into the repository
cd multitor

# Install
./setup.sh install

# Run the app
multitor --init 2 --user debian-tor --socks-port 9000 --control-port 9900 --proxy privoxy --haproxy
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
    multitor --init 10 --user debian-tor --socks-port 9000 --control-port 9900 --proxy socks
    multitor --show-id --socks-port 9000

  Options:
        --help                        show this message
        --debug                       displays information on the screen (debug mode)
        --verbose                     displays more information about TOR processes
    -i, --init <num>                  init new tor processes
    -k, --kill                        kill all multitor processes
    -s, --show-id                     show specific tor process id
    -n, --new-id                      regenerate tor circuit
    -u, --user <string>               set the user (only with -i|--init)
        --socks-port <port_num|all>   set socks port number
        --control-port <port_num>     set control port number
        --proxy <proxy_type>          set socks or http (polipo, privoxy, hpts) proxy server
        --haproxy                     set HAProxy as a frontend for http proxies (only with --proxy)
```

## Requirements

`multitor` uses external utilities to be installed before running:

- [tor](https://www.torproject.org/)
- [netcat](http://netcat.sourceforge.net/)
- [haproxy](https://www.haproxy.org/)
- [polipo](https://www.irif.fr/~jch/software/polipo/)
- [privoxy](https://www.privoxy.org/)
- [http-proxy-to-socks](https://github.com/oyyd/http-proxy-to-socks)

This tool working with:

- **GNU/Linux** (testing on Debian and CentOS)
- **[Bash](https://www.gnu.org/software/bash/)** (testing on 4.4.19)

Also you will need **root access**.

## Docker

See this project: **[docker-multitor](https://github.com/evait-security/docker-multitor)**

## Other

### Important

If you use this tool in other scripts where the output is saved everywhere, not on the screen, remember that you will not be able to use the generated password. I will correct this in the next version. If you do not use regenerate function of single or all **TOR** circuits with a password, you can safely restart the `multitor` which will do it for you.

### Limitations

- each **TOR**, **http-proxy** and **HAProxy** processes needs a certain number of memory. If the number of **TOR** processes is too big, the oldest one will be automatically killed by the system
- **Polipo** is no longer supported but it is still a very good and light proxy. In my opinion the best http-proxy solution is **Privoxy**
- I think this topic will be usefull for You before using `multitor` - [How to run multiple Tor processes at once with different exit IPs?](https://stackoverflow.com/questions/14321214/how-to-run-multiple-tor-processes-at-once-with-different-exit-ips)

### Contributing

See **[this](.github/CONTRIBUTING.md)**.

### Project architecture

See **[this](https://github.com/trimstray/multitor/wiki/Project-architecture)**.

## License

GPLv3 : <http://www.gnu.org/licenses/>

**Free software, Yeah!**
