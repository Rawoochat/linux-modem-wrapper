# linux-modem-wrapper
A terminal wrapper to send and receive files using Z-modem.

## What is it?
An absolutely diabolical script that calls sz and rz utilities from lrzsz package to send or recieve a file using Z-modem protocol.

## Installation
### Install lrzsz package

Debian and Debian-based distos:

`sudo apt-get install lrzsz -y`

Fedora:

`sudo dnf install lrzsz -y`

### Download the script
You may find it under Releases tab or you can clone the project and run it from there.

## Usage
`./zmodem.sh <MODE> <INTERFACE> <BAUD> [FILE]"`

#### MODE
-s  -- send a file."

-r  -- receive a file"

#### INTERFACE
Which interface to use.

Interfaces are located in `/dev` directory. The script actually does not check which block device or interface you've passed to it, but as you're using Z-modem protocol, which sends data over Serial port, you should use only use tty devices, such as `/dev/ttyUSB0`.

#### BAUD
Baud rate to use. The speed must be equal on both sides.

#### FILE
File to send. Only makes sense with `-s` option.
