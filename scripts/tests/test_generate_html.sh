#! /bin/bash

source generate_html.sh

function test_generate_html () {
    local DATA_FILE="$1"
    local EXPECTED_OUTPUT_FILE="$2"
    local DESCRIPTION="$3"
    local EXPECTED_OUTPUT=$( cat "$EXPECTED_OUTPUT_FILE" )
    local ACTUAL_OUPUT=$( generate_html "$DATA_FILE" )

    local INPUTS="Data file : ${DATA_FILE}"
    assert "${INPUTS}" "$EXPECTED_OUTPUT" "$ACTUAL_OUPUT" "$DESCRIPTION"
    local TEST_RESULT=$?
    update_result $TEST_RESULT
}

function test_cases_generate_html () {
    test_generate_html "tests/data/pokemons1.csv" "tests/expected_output/main_html1.html" "Should generate html for single pokemon"
    test_generate_html "tests/data/pokemons2.csv" "tests/expected_output/main_html2.html" "Should generate html for multiple pokemons"
}


function test_get_indexed_type () {
    local ALL_TYPES="$1"
    local EXPECTED_OUTPUT="$2"
    local DESCRIPTION="$3"
    local ACTUAL_OUPUT=$( get_indexed_type "$ALL_TYPES" )

    local INPUTS="ALl types : ${ALL_TYPES}"
    assert "${INPUTS}" "$EXPECTED_OUTPUT" "$ACTUAL_OUPUT" "$DESCRIPTION"
    local TEST_RESULT=$?
    update_result $TEST_RESULT
}

function test_cases_get_indexed_type () {
    local ALL_TYPES="bug\ngrass\npoison"
    local EXPECTED_OUTPUT="0|all\n1|bug\n2|grass\n3|poison"
    test_get_indexed_type "$( echo -e $ALL_TYPES )" "$( echo -e $EXPECTED_OUTPUT )" "Should assign index to the types"
}


function test_update_type_card () {
    local CARD="$1"
    local TYPE="$2"
    local INDEXED_TYPE="$3"
    local DESCRIPTION="$4"

    TYPE_CARDS[0]="Venuasur"
    TYPE_CARDS[1]="Venuasur"
    local EXPECTED_OUTPUT=( "VenuasurIvyasur" "VenuasurIvyasur" "Ivyasur" )

    update_type_card "$CARD" "$TYPE" "$INDEXED_TYPE"

    local INPUTS="Card : $CRAD, Type : $TYPE, Indexed type : $INDEXED_TYPE"
    assert "${INPUTS}" "${EXPECTED_OUTPUT[*]}" "${TYPE_CARDS[*]}" "$DESCRIPTION"
    local TEST_RESULT=$?
    update_result $TEST_RESULT
}

function test_cases_update_type_card {
    local CARD="Ivyasur"
    local TYPE="grass,poison"
    local INDEXED_TYPE="0|all\n1|grass\n2|poison"
    test_update_type_card "$CARD" "$TYPE" "$( echo -e $INDEXED_TYPE )" "Should find out the type of pokemon and update the array"
}


function test_generate_files {
    local MAIN_TEMPLATE="$1"
    local INDEXED_TYPE="$2"
    local DESTINATION="$3"
    local EXPECTED_OUTPUT="$4"
    local DESCRIPTION="$5"
    local TEST_RESULT=1

    
    TYPE_CARDS[0]="VenuasurIvyasur"
    TYPE_CARDS[1]="Venuasur"
    generate_files "$MAIN_TEMPLATE" "$INDEXED_TYPE" "$DESTINATION"

    local INPUTS="MAIN_TEMPLATE : $MAIN_TEMPLATE, Indexed type : ${INDEXED_TYPE}"
    if [[ -f "tests/tmp/all.html" ]] && [[ -f "tests/tmp/grass.html" ]];
    then
        TEST_RESULT=0
        local ACTUAL_OUTPUT=$( cat "tests/tmp/all.html" )
        assert "${INPUTS}" "$EXPECTED_OUTPUT" "$ACTUAL_OUTPUT" "$DESCRIPTION"
    fi
    update_result $TEST_RESULT
}

function test_cases_generate_files {
    local MAIN_TEMPLATE="<html><body><nav><li class=\"sidebar-all\"></li><li class=\"sidebar-grass\"></li></nav><main>_MAIN_</main></body></html>"
    local EXPECTED_OUTPUT="<html><body><nav><li class=\"sidebar-all active-all\"></li><li class=\"sidebar-grass\"></li></nav><main>VenuasurIvyasur</main></body></html>"
    local INDEXED_TYPE="0|all\n1|grass"

    mkdir tests/tmp &> /dev/null
    test_generate_files "$MAIN_TEMPLATE" "$( echo -e $INDEXED_TYPE )" "tests/tmp" "$EXPECTED_OUTPUT" "Should assign index to the types"
    rm -r tests/tmp &> /dev/null
}