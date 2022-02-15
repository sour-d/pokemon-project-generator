#! /bin/bash

cd scripts

if echo $@ | grep -q -e "\-q" -e "\-quick" ; then
    bash main.sh "../data/pokemons_quick.csv" "../html"
else
    bash main.sh "../data/pokemons.csv" "../html"
fi

if echo $@ | grep -q -e "\-o" -e "\-open" ; then
    open ../html/all.html
fi
