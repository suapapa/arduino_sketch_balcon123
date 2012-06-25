#!/bin/bash

scons ARDUINO_BOARD=diecimila ARDUINO_PORT=/dev/ttyUSB2 EXTRA_LIB=`realpath libs/` $1

