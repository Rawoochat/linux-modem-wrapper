#!/bin/bash

# The script must accept exactly 4 arguments:
# $1 -- Mode
# $2 -- Interface to use
# $3 -- Baud rate
# $4 -- File to send/receive


# Send file
lmwSend () {
  stty -F $LMW_INTERFACE $LMW_BAUD
  sz $LMW_FILE > $LMW_INTERFACE < $LMW_INTERFACE
}


# Receive file
lmwReceive () {
  stty -F $LMW_INTERFACE $LMW_BAUD
  rz > $LMW_INTERFACE < $LMW_INTERFACE
}


# Check the arguments.
#
# If the first argument is --help, print the help message and stop the script.
# Else check the amount of arguments.
#
# If it's less the 3, print the insufficient arg num error message.
# It's less or equal to three, because in case of -s option you have to
# choose the file to send.

lmwArgCheck () {
  if [ $LMW_MODE == --help ]; then
    echo "Syntaxis: ./zmodem.sh <MODE> <INTERFACE> <BAUD> [FILE]"
    echo ""
    echo "MODE:"
    echo "-s -- send a file."
    echo "-r -- receive a file"
    echo "--help -- display this message."
    echo ""
    echo "INTERFACE:"
    echo "Which interface to use. You must use full path. For example, /dev/ttyUSB0"
    echo "You can find usable interfaces by typing 'ls -l /dev | grep tty'"
    echo ""
    echo "BAUD:"
    echo "Baud rate to use. Must be equal on both sides."
    echo ""
    echo "FILE:"
    echo "File to send. Only makes sense with -s option."
    exit 1
  elif [ ${#LMW_ARGS[@]} -lt 3 ]; then
    echo "Illegal number of arguments."
    echo "Enter ./zmodem.sh --help for syntaxis."
    exit 1
  elif [ ! -e $LMW_INTERFACE ]; then
    echo "No such interface."
    exit 1
  else
    case $LMW_MODE in
      -s)
        lmwSend
        ;;

      -r)
        lmwReceive
        ;;

      *)
        echo "Unknown argument $LMW_MODE."
        echo "Enter ./zmodem.sh --help for syntaxis."
        ;;
    esac
  fi
}


# Place script arguments into an array for applying to variables
LMW_ARGS=( "$@" )

LMW_MODE="${LMW_ARGS[0]}"
LMW_INTERFACE="${LMW_ARGS[1]}"
LMW_BAUD="${LMW_ARGS[2]}"
LMW_FILE="${LMW_ARGS[3]}"


# Calling the first function
lmwArgCheck
