#!/bin/bash

set -e

# Get the Giphy API key from the input argument
GIPHY_API_KEY=$1

# Get a random "thank you" GIF from Giphy
GIPHY_RESPONSE=$(curl -s "https://api.giphy.com/v1/gifs/random?api_key=${GIPHY_API_KEY}&tag=thank+you&rating=g")
RANDOM_GIF=$(echo $GIPHY_RESPONSE | jq --raw-output .data.images.original.url)

# Create the comment
COMMENT="![Thank you](${RANDOM_GIF})\n\nThanks for the contribution!"

# Get the PR number
PR_NUMBER=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")

# Post the comment
curl -s -H "Authorization: token $GITHUB_TOKEN" -X POST -d "{\"body\": \"$COMMENT\"}" "https://api.github.com/repos/${GITHUB_REPOSITORY}/issues/${PR_NUMBER}/comments"