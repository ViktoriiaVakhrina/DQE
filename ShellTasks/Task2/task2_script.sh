#!/bin/bash
# Arguments are passed to script when executing; 
# $1: name of file
# $2: range of years to process: 'start_year end_year'
if ! [[ -f $1 ]];
then
    echo 'Error, exit code 3'
    exit 3
fi

if [[ $# -ne 2 ]]
then
    echo 'Error, exit code 4'
    exit 4
fi

# read second argument as array
years=($2)


start_date=${years[0]}
end_date=${years[1]}

# to delete first row - set counter
counter=0

# change separator
IFS=','

# If file temperature.csv exists - delete it

if [[ -f temperature.csv ]]
then
    rm temperature.csv
fi

# starting checks line by line

while read line
do
    (( counter ++))
    # remove 1st line
    if [[ counter -eq 1 ]]
    then   
        continue
    fi
    # making array from line
    arr=($line)
    #  Years filter
    if [[ ${arr[1]} -ge $start_date && ${arr[1]} -le $end_date ]]
    then
        # Check if temperature and year are not empty
        if [[ ${arr[0]} != "" ]] && [[ ${arr[1]} != "" ]]
        then
            # if country is missing - replace with unknown
            if [[ ${arr[3]} = "" ]]
            then
                arr[3]=unknown
            fi
            # write necessary fields of line that passed all conditions to file
            echo ${arr[0]},${arr[1]},${arr[3]} >> temperature.csv
        fi
    fi
done < "$1"
echo 'Finish!'
# return standard separator
unset IFS;












