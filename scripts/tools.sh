#! /bin/bash

function get_field () {
    local DATA="$1"
    local FIELD="$2"
    
    cut -d"|" -f"${FIELD}" <<< "$DATA"
}

function replace () {
    local DATA="$1"
    local OLD_STRING="$2"
    local NEW_STRING="$3"
    local IS_GLOBAL="$4"
    if [[ -z $IS_GLOBAL ]] || [[ $IS_GLOBAL == "0" ]]; then
        sed "s;$OLD_STRING;$NEW_STRING;" <<< $DATA
    else
        sed "s;$OLD_STRING;$NEW_STRING;g" <<< $DATA
    fi
}

function get_html () {
    local TAG="$1"
    local DATA="$2"
    local CLASS="$3"

    if [[ -z $CLASS ]]
    then
        echo "<$TAG>$DATA</$TAG>"
    else
        echo "<$TAG class=\"$CLASS\">$DATA</$TAG>"
    fi
}

function filter_data() {
    local DATA="$1"
    local TYPE="$2"

    if [[ $TYPE == all ]]
    then
        echo "$DATA"
    else
        grep "^.*|.*|.*$TYPE.*|" <<< "$DATA"
    fi
}

function capitalize() {
    local STRING="$1"
    local FIRST_LETTER=$( tr "[:lower:]" "[:upper:]" <<< ${STRING:0:1} )
    echo "${FIRST_LETTER}${STRING:1}"
}

function generate_report() {
    while [[ 1 ]]
    do
        local TOTAL_JOBS=$( jobs | grep -c " Running " )
        [[ $TOTAL_JOBS -lt 10 ]] && TOTAL_JOBS=" ${TOTAL_JOBS}"
        [[ $TOTAL_JOBS -eq 0 ]] && echo -e "\nAll files are generated" && break
        echo -ne "Generating ${TOTAL_JOBS} Files\r"
        sleep 0.5
    done
}