#! /bin/bash

source card.sh
source types.sh
source sidebar.sh
source tools.sh
IFS=$'\n'
TYPE_CARDS=()

function generate_files () {
    local MAIN_TEMPLATE="$1"
    local DATA="$2"
    local TYPE="$3"
    local DESTINATION="$4"
    
    local CARD_TEMPLATE=$( cat "../template/pokemon_card.html" )
    local ALL_CARDS=$( get_all_cards "$DATA" "$CARD_TEMPLATE" )
    local EACH_FILE_CONTENT=$( replace "$MAIN_TEMPLATE" "_MAIN_" "${ALL_CARDS}" )
    EACH_FILE_CONTENT=$( replace "$EACH_FILE_CONTENT" "sidebar-${TYPE}" "sidebar-${TYPE} active-${TYPE}" )
    
    echo "$EACH_FILE_CONTENT" > $DESTINATION/${TYPE}.html
}

function generate_html () {
    local DATA_FILE="$1"
    local LOCATION="$2"
    local ALL_DATA=$( tail -n+2 $DATA_FILE )

    #sorting out all types and giving it a index
    local ALL_TYPES=$( get_field "$ALL_DATA" "3" | tr "," "\n" | sort | uniq )
    ALL_TYPES=$( echo "all" ; echo "$ALL_TYPES" )

    # getting all sidebar based on types
    local SIDEBAR=$( get_all_sidebar "$ALL_TYPES" )

    #making the main template ready for use
    local MAIN_TEMPLATE=$( cat ../template/main.html )
    MAIN_TEMPLATE=$( replace "$MAIN_TEMPLATE" "_SIDEBARS_" "${SIDEBAR}" )
    MAIN_TEMPLATE=$( replace "$MAIN_TEMPLATE" "_CSS_FILE_" "styles.css" )
    MAIN_TEMPLATE=$( replace "$MAIN_TEMPLATE" "_PAGE_TITLE_" "Pokemon" )

    # removing all files and generating new files
    rm -rf ./${LOCATION} &> /dev/null
    mkdir ./${LOCATION}
    tar xfz ../data/images.tar.gz --directory="./${LOCATION}"
    cp ../template/styles.css ${LOCATION}/styles.css

    # generate all card and sort out based on types
    for TYPE in `echo "$ALL_TYPES"`
    do
        local FILTERED_DATA=$( filter_data "$ALL_DATA" $TYPE )
        generate_files "$MAIN_TEMPLATE" "$FILTERED_DATA" "$TYPE" "$LOCATION" &
    done
}