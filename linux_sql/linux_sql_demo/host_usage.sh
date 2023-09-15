#!/bin/bash
# Assign CLI arguments to variables
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

# Parse server CPU and memory usage data using Bash scripts
timestamp=$(date +'%Y-%m-%d %H:%M:%S')
hostname=$(hostname -f)
memory_free=$(free -m | awk '/Mem/{print $4}')
cpu_idle=$(vmstat 1 2 | tail -1 | awk '{print $15}')

# Construct the INSERT statement using a subquery to get the host_id
insert_stmt="INSERT INTO host_usage (timestamp, host_id, memory_free, cpu_idle) VALUES ('$timestamp', (SELECT id FROM host_info WHERE hostname='$hostname'), $memory_free, $cpu_idle);"

# Set up the environment variable for the psql command
export PGPASSWORD=$psql_password

# Execute the INSERT statement through the psql CLI tool
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?
