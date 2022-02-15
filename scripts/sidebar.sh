#! /bin/bash

source tools.sh

function get_all_sidebar () {
    local ALL_TYPES="$1"
    
    for SIDEBAR_NAME in `echo "$ALL_TYPES"`; do
        local SIDEBAR_HTML=$( get_html "li" "<a href=\"${SIDEBAR_NAME}.html\">${SIDEBAR_NAME}</a>" "sidebar-${SIDEBAR_NAME}" )
        local SIDEBAR="${SIDEBAR}${SIDEBAR_HTML}"
    done
    echo "$SIDEBAR"
}