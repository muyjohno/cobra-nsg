#!/bin/bash

source "$(dirname "$0")/upgrade-functions.sh"
compose_for_upgrade "$@"
