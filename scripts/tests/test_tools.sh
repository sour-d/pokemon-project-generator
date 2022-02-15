#! /bin/bash

source tools.sh

function test_get_field () {
    local DATA="$1"
    local FIELD="$2"
    local EXPECTED_OUTPUT="$3"
    local DESCRIPTION="$4"

    local ACTUAL_OUPUT=$( get_field "$DATA" "$FIELD" )

    local INPUTS="Data : ${DATA}, Field : ${FIELD}"
    assert "${INPUTS}" "$EXPECTED_OUTPUT" "$ACTUAL_OUPUT" "$DESCRIPTION"
    local TEST_RESULT=$?
    update_result $TEST_RESULT
}

function test_cases_get_field () {
    test_get_field "1|hi|hello" "2" "hi" "Should display the field value"
    test_get_field "1|hi|hello" "4" "" "Should display nothing for invalid fields"
}

function test_replace () {
    local DATA="$1"
    local OLD_STRING="$2"
    local NEW_STRING="$3"
    local IS_GLOBAL="$4"
    local EXPECTED_OUTPUT="$5"
    local DESCRIPTION="$6"

    local ACTUAL_OUPUT=$( replace "$DATA" "$OLD_STRING" "$NEW_STRING" "$IS_GLOBAL" )

    local INPUTS="Data : ${DATA}, Field : ${FIELD}"
    assert "${INPUTS}" "$EXPECTED_OUTPUT" "$ACTUAL_OUPUT" "$DESCRIPTION"
    local TEST_RESULT=$?
    update_result $TEST_RESULT
}

function test_cases_replace () {
    test_replace "hi how are you" "you" "you?" "0" "hi how are you?" "Should replace the string"
    test_replace "You fool, You fool" "You" "I" "" "I fool, You fool" "Should replace first occurace IS_GLOBAL is not mentioned"
    test_replace "You fool, You fool" "You" "I" "1" "I fool, I fool" "Should replace first occurace IS_GLOBAL is not mentioned"
}

function test_get_html () {
    local TAG="$1"
    local DATA="$2"
    local CLASS="$3"
    local EXPECTED_OUTPUT="$4"
    local DESCRIPTION="$5"

    local ACTUAL_OUPUT=$( get_html "$TAG" "$DATA" "$CLASS" )

    local INPUTS="Tag : ${TAG}, Data : ${DATA}, Class : ${CLASS}"
    assert "${INPUTS}" "$EXPECTED_OUTPUT" "$ACTUAL_OUPUT" "$DESCRIPTION"
    local TEST_RESULT=$?
    update_result $TEST_RESULT
}

function test_cases_get_html () {
    test_get_html "li" "bug" "" "<li>bug</li>" "Should generate the html"
    test_get_html "li" "bug" "sidebar" "<li class=\"sidebar\">bug</li>" "Should generate the html with class"
}

function test_filter_data () {
    local DATA="$1"
    local TYPE="$2"
    local EXPECTED_OUTPUT="$3"
    local DESCRIPTION="$4"

    local ACTUAL_OUPUT=$( filter_data "$DATA" "$TYPE" )

    local INPUTS="Data : ${DATA}, Type : ${TYPE}"
    assert "${INPUTS}" "$EXPECTED_OUTPUT" "$ACTUAL_OUPUT" "$DESCRIPTION"
    local TEST_RESULT=$?
    update_result $TEST_RESULT
}

function test_cases_filter_data () {
    local TEST1_DATA=$( cat tests/data/pokemons2.csv )
    test_filter_data "$TEST1_DATA" "type2" "1|test1|type1,type2|45|45|64|49|49|69" "Should filter data based on type"
}

function test_capitalize () {
    local STRING="$1"
    local EXPECTED_OUTPUT="$2"
    local DESCRIPTION="$3"

    local ACTUAL_OUPUT=$( capitalize "$STRING" )

    local INPUTS="String : ${STRING}"
    assert "${INPUTS}" "$EXPECTED_OUTPUT" "$ACTUAL_OUPUT" "$DESCRIPTION"
    local TEST_RESULT=$?
    update_result $TEST_RESULT
}

function test_cases_capitalize () {
    test_capitalize "poison" "Poison" "Should capitalize the first letter"
}