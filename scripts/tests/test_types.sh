#! /bin/bash

source types.sh

function test_get_type_template () {
    local DATA="$1"
    local EXPECTED_OUTPUT="$2"
    local DESCRIPTION="$3"

    local ACTUAL_OUPUT=$( get_type_template "$DATA" )

    local INPUTS="Data : ${DATA}"
    assert "${INPUTS}" "$EXPECTED_OUTPUT" "$ACTUAL_OUPUT" "$DESCRIPTION"
    local TEST_RESULT=$?
    update_result $TEST_RESULT
}

function test_cases_get_type_template () {
    test_get_type_template "bug" "<div class=\"type bug\">Bug</div>" "should generate template for type"
}

function test_get_types () {
    local DATA="$1"
    local EXPECTED_OUTPUT_FILE="$2"
    local DESCRIPTION="$3"

    local EXPECTED_OUTPUT=$( cat $EXPECTED_OUTPUT_FILE )
    local ACTUAL_OUPUT=$( get_types "$DATA" )

    local INPUTS="Data : ${DATA}"
    assert "${INPUTS}" "$EXPECTED_OUTPUT" "$ACTUAL_OUPUT" "$DESCRIPTION"
    local TEST_RESULT=$?
    update_result $TEST_RESULT
}

function test_cases_get_types () {
    test_get_types "type1" "tests/expected_output/types1.html" "should generate html for single pokemon type"
    test_get_types "type1,type2,type3" "tests/expected_output/types2.html" "should generate html for multiple pokemon types"
}