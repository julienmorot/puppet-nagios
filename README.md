# nagios

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with nagios](#setup)
    * [What nagios affects](#what-nagios-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nagios](#beginning-with-nagios)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Module to assist you to build a Nagios Server and configure an agent with NRPE.
A few standard plugins and check are configured by default making a template 
for your own configurations.

I've only tested this module with Ubuntu LTS.

## Setup

### Setup Requirements

PuppetDB.

### Beginning with nagios


## Usage

You must customize files and check under the files directory to fit your needs.


For a server :
```
node 'nagios' {
    class { nagios::server:
		adminuser => 'nagiosadmin',
		adminpwd  => 'secret',
	}
}
```

For a client :
```
node 'agent' {
    class { nagios::agent:
        nagservers => [ '192.168.100.10 ']
    }
	include nagios::export::linux
}
```

