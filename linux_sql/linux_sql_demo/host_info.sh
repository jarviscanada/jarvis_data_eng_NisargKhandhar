#!/bin/bash
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5
# Check the number of arguments
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <psql_host> <psql_port> <db_name> <psql_user> <psql_password>"
    exit 1
fi

# Parse host hardware specifications using Bash commands
hostname=$(hostname -f)
cpu_model=$(lscpu | awk -F: '/^Model name/{print $2}' | xargs)
memory=$(free -m | awk '/Mem/{print $2}' | xargs)
disk=$(df -h / | awk 'NR==2{print $2}' | xargs)
cpu_number=$(lscpu | grep "CPU(s):" | awk '{print $2}')
cpu_architecture=$(lscpu | grep "Architecture" | awk '{print $2}')
cpu_mhz=$(lscpu | grep "CPU MHz" | awk '{print $3}')
l2_cache=$(lscpu | grep "L2 cache" | awk '{print $3}')

# Escape single quotes in CPU model
cpu_model_escaped=$(echo "$cpu_model" | sed "s/'/''/g")

# Construct the INSERT statement
insert_stmt="INSERT INTO host_info (hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, l2_cache) VALUES ('$hostname', $cpu_number, '$cpu_architecture', '$cpu_model_escaped', $cpu_mhz, '$l2_cache');"

# Set up the environment variable for the psql command
export PGPASSWORD=$psql_password

# Execute the INSERT statement through the psql CLI tool
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"

# Check the exit status of the psql command
if [ $? -eq 0 ]; then
    echo "Data insertion successful"
else
    echo "Data insertion failed"
fi

exit $?
