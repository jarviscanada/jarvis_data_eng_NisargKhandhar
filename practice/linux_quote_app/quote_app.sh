#!/bin/bash
API_URL="https://alpha-vantage.p.rapidapi.com/query"
API_KEY="70f4d28ddfmsh9b644f71f665fa0p183714jsn98dc481dae19"
HEADERS="-H 'x-rapidapi-host: alpha-vantage.p.rapidapi.com' -H 'x-rapidapi-key:70f4d28ddfmsh9b644f71f665fa0p183714jsn98dc481dae19'"

psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5
symbols=${@7}

export PGPASSWORD=$psql_password

if [ "$#" -ne 7 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

JSON_RESPONSE=$(curl -s -X GET https://alpha-vantage.p.rapidapi.com/query -d 'function =TIME_SERIES_INTRADAY' $HEADERS)

SYMBOL=$(echo $JSON_RESPONSE|jq -r '.Meta Data."2. Symbol"')
OPEN=$(echo $JSON_RESPONSE| jq -r '')
HIGH=$(echo $JSON_RESPONSE)
LOW=$(echo $JSON_RESPONSE)
PRICE=$(echo $JSON_RESPONSE)
VOLUME-$(echo $JSON_RESPONSE)

#mysql -u postgres -p host_agent <<EOF
#INSERT INTO quotes (symbol, open, high, low, price, volume)