################################################################
# creator:CJY
# my-drone
################################################################

#	The target to build
DEFAULT_TARGET	?= STM32F405
TARGET			?=
CONFIG			?=

#	Compile-time options
OPTION	?=

#	Compile for External Storage Bootloader support
EXST	?= no

#	Compile for target loaded into RAM
RAM_BASED	?= no

# reserve space for custom defaults
custom_DEFAULTS_EXTENDED	?= no

# Debugger optons:
#   empty - ordinary build with all optimizations enabled
#   INFO - ordinary build with debug symbols and all optimizations enabled
#   GDB - debug build with minimum number of optimizations
DEBUG     ?=

# Insert the debugging hardfault debugger
# releases should not be built with this flag as it does not disable pwm output
DEBUG_HARDFAULTS ?=

# Serial port/Device for flashing
SERIAL_DEVICE   ?= $(firstword $(wildcard /dev/ttyACM*) $(firstword $(wildcard /dev/ttyUSB*) no-port-found))

# Flash size (KB).  Some low-end chips actually have more flash than advertised, use this to override.
FLASH_SIZE ?=

###############################################################################
# Things that need to be maintained as the source changes
#

FORKNAME      = betaflight

# Working directories
ROOT            := $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST))))
SRC_DIR         := $(ROOT)/src/main
OBJECT_DIR      := $(ROOT)/obj/main
BIN_DIR         := $(ROOT)/obj
CMSIS_DIR       := $(ROOT)/lib/main/CMSIS
INCLUDE_DIRS    := $(SRC_DIR) \
                   $(ROOT)/src/main/target \
                   $(ROOT)/src/main/startup
LINKER_DIR      := $(ROOT)/src/link
MAKE_SCRIPT_DIR := $(ROOT)/mk

## V                 : Set verbosity level based on the V= parameter
##                     V=0 Low
##                     V=1 High

