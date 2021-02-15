#!/bin/bash
# Arguments are passed to script when executing; 
# $1: name of file
# $2: range of years to process: 'year1 year2 year3...'
# results are written to temperatures.csv


# if input file does not exist - exit with code 3
if ! [[ -f $1 ]];
then
    echo 'Error, exit code 3'
    exit 3;
fi;

# if more/less than 2 parameters are passed - exit with code 4
if [[ $# -ne 2 ]];
then
    echo 'Error, exit code 4'
    exit 4;
fi;


# # read second argument as array
years=($2)

# If file temperature.csv exists - delete it.
if [[ -f temperature.csv ]]
then
    rm temperature.csv
fi


for yr in ${years[@]}
    do 
    awk -F, 'NR>1 {if ($2=='$yr' && $1 != "") {if ($4=="") {$4="unknown"} print $1,$2,$4} }' $1 >> temperature.csv
    done
echo 'Finish!'