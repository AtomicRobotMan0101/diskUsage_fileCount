#!/bin/bash

###############################
#
# https://github.com/AtomicRobotMan0101/diskUsage_fileCount
# diskusage.sh
# VERSION 1.0
#
###############################

# Run this from the terminal
# Put this in your $PATH so it may run from anywhere
# Use sudo for where permissions are denied for root accessed files/directories

# IMPORTANT!
# This script will NOT count soft-mounted, nor hard-mounted links
# It is designed to capture what is ON THE DEVICE upon which it is run
# One may specify a mount in /mnt/foo

# USAGE
# It takes one, or two, paramaters
# First is depth you wish to count
#     i.e. 1,2,3... one deep, or N-deep
# Second is the directory to target, then the count
#
# The script will assume the currect directory unless an alternative is
# specified

# EXAMPLES
###############################
# ./diskusage.sh 1
# ./diskusage.sh 5
# ./diskusage.sh /etc 1
# ./diskusage.sh ~/ 3
# ./diskusage.sh /mnt/NAS/Movies/ 3
#
#

# There are TWO scripts, each outputs content in a particular way
# that I found useful for the task at hand

# Please feel free to modify this to suit you own needs, or offer
# suggestions, improvements or pull requests for updates :)
#




# Check if the first argument is a number
if [[ $1 =~ ^[0-9]+$ ]]; then
    directory=$(pwd)
    depth=$1
else
    directory=${1:-$(pwd)}
    depth=${2:-1}
fi

# Function to print disk usage and file count for a given directory
print_usage_and_count() {
    local dir=$1
    local usage=$(du -sh "$dir" 2>/dev/null | cut -f1)
    local count=$(find "$dir" -type f ! -path "/mnt/*" | wc -l)
    printf "%-10s %-10s %s\n" "$usage" "$count" "$dir"
}

# Print the header
printf "%-10s %-10s %s\n" "Disk Usage" "File Count" "Directory"
printf "%-10s %-10s %s\n" "----------" "----------" "---------"

# Print usage and count for the main directory
print_usage_and_count "$directory"

# Find and process subdirectories up to the specified depth
find "$directory" -mindepth 1 -maxdepth "$depth" -type d | while read -r subdir; do
    print_usage_and_count "$subdir"
done
