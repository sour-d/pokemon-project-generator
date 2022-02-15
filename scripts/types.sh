#! /bin/bash 

source tools.sh

IFS=$'\n'

function get_type_template () {
    local TYPE="$1"

    local CAPITALIZE_TYPE=$( capitalize "$TYPE" )
    local TEMPLATE=$( get_html "div" "$CAPITALIZE_TYPE" "type ${TYPE}" ) 
    echo $TEMPLATE
}

function get_types () {
    local DATA="$1"

    DATA=$( echo $DATA | tr "," "\n" )

    for TYPE in `echo "$DATA"`; do
        local TYPE_TEMPLATE=$( get_type_template "$TYPE" )
        local GENERATED_HTML="${GENERATED_HTML}${TYPE_TEMPLATE}"
    done
    echo "$GENERATED_HTML"
}