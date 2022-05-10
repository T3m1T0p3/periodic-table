#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"
atomic_number=""
name=""
symbol=""
properties=""
str=$1
if [[ -z $1 ]]
then
 echo "Please provide an element as an argument."
 exit
fi

if [[ $1 =~ [0-9] ]]
then
 atomic_number=$1
 name=$($PSQL "SELECT name FROM elements WHERE atomic_number=$atomic_number")
 symbol=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$atomic_number")
elif [[ ${#str} == 1 || ${#str} == 2 ]]
then
 symbol=$1
 name=$($PSQL "SELECT name FROM elements WHERE symbol='$symbol'")
 atomic_number=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$symbol'")
 
else
 name=$1
 symbol=$($PSQL "SELECT symbol FROM elements WHERE name='$name'")
 atomic_number=$($PSQL "SELECT atomic_number FROM elements WHERE name='$name'")
fi


type=$($PSQL  "SELECT  type FROM properties WHERE atomic_number=$atomic_number")
atomic_mass=$($PSQL  "SELECT atomic_mass FROM properties where atomic_number=$atomic_number")
melting_point=$($PSQL  "SELECT melting_point_celsius FROM properties WHERE atomic_number=$atomic_number")
boiling_point=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$atomic_number")
echo "The element with atomic number "$atomic_number" is "$name" ("$symbol"). It's a "$type", with a mass of "$atomic_mass" amu. Hydrogen has a melting point of "$melting_point" celsius and a boiling point of "$boiling_point" celsius."
