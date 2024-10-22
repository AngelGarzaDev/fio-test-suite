#!/bin/bash

# User input for disk
echo "WARNING: This script is DESTRUCTIVE."
echo "It will overwrite data on the specified disk."
echo "DO NOT run this on any disk with data you wish to keep!"
read -p "Enter the target disk (e.g., /dev/sdb): " disk
read -p "Use caching during test (0/1)" caching

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

FILENAME=$disk DIRECT=$caching fio randomread.fio --output=resultsrandomread.csv &&

FILENAME=$disk DIRECT=$caching1 fio randomwrite.fio --output=resultsrandomwrite.csv &&

FILENAME=$disk DIRECT=$caching1 fio throughputread.fio --output=resultsthroughputread.csv &&

FILENAME=$disk DIRECT=$caching fio throughputwrite.fio --output=resultsthroughputwrite.csv