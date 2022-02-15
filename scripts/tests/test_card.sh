#! /bin/bash

source card.sh

function test_generate_card () {
    local DATA="$1"
    local CARD_TEMPLATE="$2"
    local EXPECTED_OUTPUT_FILE="$3"
    local DESCRIPTION="$4"
    local EXPECTED_OUTPUT=$( cat "$EXPECTED_OUTPUT_FILE" )
    local ACTUAL_OUPUT=$( generate_card "$DATA" "$CARD_TEMPLATE" )

    local INPUTS="Data : ${DATA}, Card template : ${CARD_TEMPLATE}"
    assert "${INPUTS}" "$EXPECTED_OUTPUT" "$ACTUAL_OUPUT" "$DESCRIPTION"
    local TEST_RESULT=$?
    update_result $TEST_RESULT
}

function test_cases_generate_card () {
    local CARD_TEMPLATE=$( cat ../template/pokemon_card.html )
    test_generate_card "1|test1|type1,type2|45|45|64|49|49|69" "$CARD_TEMPLATE" "tests/expected_output/card.html" "should generate html for single pokemon card"
}

function test_get_all_cards () {
    local DATA="$1"
    local CARD_TEMPLATE="$2"
    local EXPECTED_OUTPUT_FILE="$3"
    local DESCRIPTION="$4"

    local EXPECTED_OUTPUT=$( cat "$EXPECTED_OUTPUT_FILE" )
    local ACTUAL_OUPUT=$( get_all_cards "$DATA" "$CARD_TEMPLATE" )

    local INPUTS="Data : ${DATA}, Card template : ${CARD_TEMPLATE}"
    assert "${INPUTS}" "$EXPECTED_OUTPUT" "$ACTUAL_OUPUT" "$DESCRIPTION"
    local TEST_RESULT=$?
    update_result $TEST_RESULT
}

function test_cases_get_all_cards () {
    local CARD_TEMPLATE=$( cat ../template/pokemon_card.html )

    local TEST1_DATA=$( tail -n+2 tests/data/pokemons1.csv )
    test_get_all_cards "$TEST1_DATA" "$CARD_TEMPLATE" "tests/expected_output/get_all_card1.html" "should generate html for single pokemon card"

    local TEST2_DATA=$( tail -n+2 tests/data/pokemons2.csv )
    test_get_all_cards "$TEST2_DATA" "$CARD_TEMPLATE" "tests/expected_output/get_all_card2.html" "should generate html for multiple pokemon cards"
}