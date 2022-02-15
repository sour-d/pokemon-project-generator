#! /bin/bash

source generate_html.sh

DATA_FILE="$1"
DESTINATION="$2"
generate_html "$DATA_FILE" "$DESTINATION"

time generate_report