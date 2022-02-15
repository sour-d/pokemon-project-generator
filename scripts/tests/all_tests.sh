#! /bin/bash

source tests/library.sh
source tests/test_card.sh
source tests/test_types.sh
source tests/test_generate_html.sh
source tests/test_sidebar.sh
source tests/test_tools.sh

RESULT=( 0 0 )
ERROR=()


function all_tests () {
    heading "get_field"
    test_cases_get_field
    
    heading "replace"
    test_cases_replace

    heading "get_html"
    test_cases_get_html

    heading "filter_data"
    test_cases_filter_data

    heading "capitalize"
    test_cases_capitalize
    
    heading "get_type_template"
    test_cases_get_type_template

    heading "get_types"
    test_cases_get_types

    heading "generate_card"
    test_cases_generate_card

    heading "get_all_cards"
    test_cases_get_all_cards

    heading "get_all_sidebar"
    test_cases_get_all_sidebar
    
    # heading "get_indexed_type"
    # test_cases_get_indexed_type
    
    # heading "update_type_card"
    # test_cases_update_type_card
    
    # heading "generate_files"
    # test_cases_generate_files
    
    # heading "generate_html"
    # test_cases_generate_html

    display_tests_summary "${RESULT[@]}"
}

all_tests