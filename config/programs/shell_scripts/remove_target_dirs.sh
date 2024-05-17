#!/bin/bash

# This script recursively removes all 'target' directories
# from the current working directory.

# Find and remove 'target' directories
find . -type d -name 'target' -exec rm -rf {} +

echo "All 'target' directories from $(pwd) have been recursively removed."
