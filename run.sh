#!/bin/bash

# User input for disk
echo "WARNING: This script is DESTRUCTIVE."
echo "It will overwrite data on the specified disk."
echo "DO NOT run this on any disk with data you wish to keep!"
read -p "Enter the target disk (e.g., /dev/sdb): " disk
#read -p "Use caching during test (0/1)" direct

# Validate that the disk variable is not empty
if [[ -z "$disk" ]]; then
  echo "Error: No disk entered. Exiting."
  exit 1
fi

# Confirmation prompt
read -p "Are you sure you want to proceed with $disk? (yes/no): " response
if [[ "$response" != "yes" ]]; then
  echo "Operation cancelled."
  exit 1
fi

# Other Variables
direct=1
runtime=300

FILENAME=$disk DIRECT=$direct RUNTIME=$runtime fio randomread.fio --output=resultsrandomread.csv --minimal &&

FILENAME=$disk DIRECT=$direct RUNTIME=$runtime fio randomwrite.fio --output=resultsrandomwrite.csv --minimal &&

FILENAME=$disk DIRECT=$direct RUNTIME=$runtime fio throughputread.fio --output=resultsthroughputread.csv --minimal &&

FILENAME=$disk DIRECT=$direct RUNTIME=$runtime fio throughputwrite.fio --output=resultsthroughputwrite.csv --minimal 