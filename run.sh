#!/bin/bash

# Get list of disks
disklist=$(lsblk -I 8 -o name,size,type,model,serial)

# User input for disk
echo "\nWARNING: This script is DESTRUCTIVE."
echo "It will overwrite data on the specified disk."
echo "DO NOT run this on any disk with data you wish to keep!\n"
echo "$disklist\n"
read -p "Enter the target disk (e.g., /dev/sdb): " disk
read -p "Enter the test runtime in seconds": runtime
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

echo -e "Running random read test\n"
FILENAME=$disk DIRECT=$direct RUNTIME=$runtime fio randomread.fio --output=resultsrandomread.csv --minimal &&

echo -e "Running random write test\n"
FILENAME=$disk DIRECT=$direct RUNTIME=$runtime fio randomwrite.fio --output=resultsrandomwrite.csv --minimal &&

echo -e "Running continuous read test\n"
FILENAME=$disk DIRECT=$direct RUNTIME=$runtime fio throughputread.fio --output=resultsthroughputread.csv --minimal &&

echo -e "Running continuous write test\n"
FILENAME=$disk DIRECT=$direct RUNTIME=$runtime fio throughputwrite.fio --output=resultsthroughputwrite.csv --minimal 




# Developemnt cd .. && rm -rf fio-test-suite/ && git clone https://github.com/AngelGarzaDev/fio-test-suite.git && cd fio-test-suite/ && chmod +x run.sh && ./run.sh