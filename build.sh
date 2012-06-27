#!/bin/bash

scons ARDUINO_BOARD=diecimila ARDUINO_PORT=/dev/ttyUSB1 EXTRA_LIB=`realpath libs/` $1

