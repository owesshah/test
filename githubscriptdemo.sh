#!/bin/bash

# Check the number of arguments
if [ $# -lt 2 ]; then
    echo "usage: $0 [your github token] [REST expression]"
    exit 1
fi

GITHUB_TOKEN=$1
GITHUB_API_REST=$2
GITHUB_API_HEADER_ACCEPT="Accept: application/vnd.github.v3+json"

# Create a temporary file with a unique name
temp=$(basename "$0")
TMPFILE=$(mktemp "/tmp/${temp}.XXXXXX") || exit 1

function rest_call {
    curl -s "$1" -H "$GITHUB_API_HEADER_ACCEPT" -H "Authorization: token $GITHUB_TOKEN" >> "$TMPFILE"
}

# Get the total number of pages using the Link header
last_page=$(curl -s -I "https://api.github.com${GITHUB_API_REST}" -H "$GITHUB_API_HEADER_ACCEPT" -H "Authorization: token $GITHUB_TOKEN" | grep '^Link:' | sed -e 's/^Link:.*page=//g' -e 's/>.*$//g')

# Check if pagination is needed
if [ -z "$last_page" ]; then
    # No pagination needed, make a single API call
    rest_call "https://api.github.com${GITHUB_API_REST}"
else
    # Pagination is needed, loop through pages
    for ((p = 1; p <= last_page; p++)); do
        # Debugging output
echo "Making API request: https://api.github.com${GITHUB_API_REST}"

rest_call "https://api.github.com${GITHUB_API_REST}"

echo "API request completed"

    done
fi

# Clean up the temporary file when the script exits
trap 'rm -f "$TMPFILE"' EXIT

