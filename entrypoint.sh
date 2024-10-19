#!/bin/bash

# Echo message indicating the custom action is running
echo "This is my custom action. :@"


# Configure Git to trust the /github/workspace directory
git config --global --add safe.directory /github/workspace

# Check if README.md file exists, create it if not
if [ ! -f "README.md" ]; then
  echo "Creating README.md file..."

  # Get the repository name from the environment variable
  REPO_NAME=${GITHUB_REPOSITORY##*/} # Extract the repo name
  echo "# $REPO_NAME" > README.md
  
  # Add a prompt for OpenAI API to generate content
  PROMPT="Generate a brief description and usage instructions for the repository named '$REPO_NAME'"

  # List all files in the repository
  FILE_LIST=$(ls | grep -v README.md)
  PROMPT="$PROMPT\n$FILE_LIST"

  echo "Prompt for GEMINI API: $PROMPT"
  # Call OpenAI API to get content
  API_KEY=$OPENAI_API_KEY # Use the secret for the API key
  RESPONSE=$(curl -H 'Content-Type: application/json' -d '{"contents":[{"parts":[{"text":  "'"$PROMPT"'"}]}]}' -X POST 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyB8m4NaeJHGvOFk5jg90M_RMKxoTKA7rzU')
  echo "Response from Open AI: $RESPONSE"
  # Extract the generated text from the API response
  GENERATED_CONTENT=$(echo $RESPONSE | jq -r '.candidates[0].content.parts[0].text')

  # Append the generated content to the README
  echo -e "\n## Description" >> README.md
  echo "$GENERATED_CONTENT" >> README.md

  echo "README.md file created successfully!"
else
  echo "README.md already exists."
fi

# Set up Git config (adjust the email and name if needed)
git config --global user.email "yuneshshrestha24@gmail.com"
git config --global user.name "GitHub Action"

# Add README.md to the staging area
git add README.md

# Commit the changes (add a message to describe the change)
git commit -m "Add/Update README.md via custom GitHub Action"

# Push the changes back to the repository
git push
