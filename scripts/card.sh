#! /bin/bash

source tools.sh

function generate_card () {
    local POKEMON_DATA="$1"
    local CARD_TEMPLATE="$2"

    #cutting each values
    local ID=$( get_field "$POKEMON_DATA" "1" )
    local NAME=$( get_field "$POKEMON_DATA" "2" )
    local TYPES=$( get_field "$POKEMON_DATA" "3" )
    local SPEED=$( get_field "$POKEMON_DATA" "4" )
    local HP=$( get_field "$POKEMON_DATA" "5" )
    local BASE_XP=$( get_field "$POKEMON_DATA" "6" )
    local ATTACK=$( get_field "$POKEMON_DATA" "7" )
    local DEFENSE=$( get_field "$POKEMON_DATA" "8" )
    local WEIGHT=$( get_field "$POKEMON_DATA" "9" )
    local CAPITALIZE_NAME=$( capitalize "$NAME" )

    #replacing ID
    CARD_TEMPLATE=$( replace "$CARD_TEMPLATE" "_ARTICLE_ID_" "${ID}" )

    #replacing img tag
    CARD_TEMPLATE=$( replace "$CARD_TEMPLATE" "_IMAGE_LOCATION_" "images\/$NAME.png" )
    CARD_TEMPLATE=$( replace "$CARD_TEMPLATE" "_IMAGE_ALT_" "$NAME" )
    CARD_TEMPLATE=$( replace "$CARD_TEMPLATE" "_IMAGE_TITLE_" "$NAME" )

    #replacing title of card
    CARD_TEMPLATE=$( replace "$CARD_TEMPLATE" "_POKEMON_NAME_" "$CAPITALIZE_NAME" )

    #replacing stats
    CARD_TEMPLATE=$( replace "$CARD_TEMPLATE" "_WEIGHT_" "$WEIGHT" )
    CARD_TEMPLATE=$( replace "$CARD_TEMPLATE" "_BASE_XP_" "$BASE_XP" )
    CARD_TEMPLATE=$( replace "$CARD_TEMPLATE" "_HP_" "$HP" )
    CARD_TEMPLATE=$( replace "$CARD_TEMPLATE" "_ATTACK_" "$ATTACK" )
    CARD_TEMPLATE=$( replace "$CARD_TEMPLATE" "_DEFENSE_" "$DEFENSE" )
    CARD_TEMPLATE=$( replace "$CARD_TEMPLATE" "_SPEED_" "$SPEED" )


    echo "$CARD_TEMPLATE"
}

function get_all_cards () {
    local ALL_DATA="$1"
    local CARD_TEMPLATE="$2"
    local ALL_CARDS

    for DATA in `echo "$ALL_DATA"`; do
        CARD_HTML=$( generate_card "$DATA" "$CARD_TEMPLATE" )
        TYPES=$( get_field "$DATA" "3" )
        TYPES_HTML=$( get_types "$TYPES" )
        CARD_HTML=$( replace "$CARD_HTML" "_POKEMON_TYPES_" "${TYPES_HTML}" )
        ALL_CARDS=${ALL_CARDS}${CARD_HTML}
    done
    echo "$ALL_CARDS"
}