#!/bin/bash

# slock -m "Locked at $(date "+%Y.%m.%d %H:%M")"
firejail --net=none slock -m "Locked at $(date "+%Y.%m.%d %H:%M")"
