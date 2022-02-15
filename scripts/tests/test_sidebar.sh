#! /bin/bash

source sidebar.sh

function test_get_all_sidebar () {
    local DATA="$1"
    local EXPECTED_OUTPUT="$2"
    local DESCRIPTION="$3"

    local ACTUAL_OUPUT=$( get_all_sidebar "$DATA" )

    local INPUTS="Data : ${DATA}"
    assert "${INPUTS}" "$EXPECTED_OUTPUT" "$ACTUAL_OUPUT" "$DESCRIPTION"
    local TEST_RESULT=$?
    update_result $TEST_RESULT
}


function test_cases_get_all_sidebar () {
    local TEST1_EXPECTED_OUTPUT="<li class=\"sidebar-grass\"><a href=\"grass.html\">grass</a></li>"
    test_get_all_sidebar "grass" "$TEST1_EXPECTED_OUTPUT" "Should generate html for sidebar"

    local TEST2_TYPES="grass\npoison"
    local TEST2_EXPECTED_OUTPUT="<li class=\"sidebar-grass\"><a href=\"grass.html\">grass</a></li><li class=\"sidebar-poison\"><a href=\"poison.html\">poison</a></li>"
    test_get_all_sidebar "$( echo -e "$TEST2_TYPES" )" "$TEST2_EXPECTED_OUTPUT" "Should generate html for sidebar"
}