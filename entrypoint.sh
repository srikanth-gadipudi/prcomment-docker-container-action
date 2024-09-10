#!/bin/bash

set -e

# Define the GIFs array
GIFS=("https://media.giphy.com/media/3o7aD2saalBwwftBIY/giphy.gif" "https://media.giphy.com/media/l0MYt5jPR6QX5pnqM/giphy.gif" "https://media.giphy.com/media/26ufdipQqU2lhNA4g/giphy.gif")

# Select a random GIF
RANDOM_GIF=${GIFS[$RANDOM % ${#GIFS[@]}]}

# Create the comment
COMMENT="![Thank you](${RANDOM_GIF})\n\nThanks for the contribution!"

# Get the PR number
PR_NUMBER=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")

# Post the comment
curl -s -H "Authorization: token $GITHUB_TOKEN" -X POST -d "{\"body\": \"$COMMENT\"}" "https://api.github.com/repos/${GITHUB_REPOSITORY}/issues/${PR_NUMBER}/comments"