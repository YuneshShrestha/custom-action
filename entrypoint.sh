#!/bin/bash

# Echo message indicating the custom action is running
echo "This is my custom action. :@"

# Check if README.md file exists, create it if not
if [ ! -f "README.md" ]; then
  echo "Creating README.md file..."
  echo "# Project Title" > README.md
  echo "This README file was created by a custom GitHub Action." >> README.md
else
  echo "README.md already exists."
fi

# Set up Git config (you can adjust the email and name if needed)
git config --global user.email "yuneshshrestha24@gmail.com"
git config --global user.name "GitHub Action"

# Add README.md to the staging area
git add README.md

# Commit the changes (add a message to describe the change)
git commit -m "Add/Update README.md via custom GitHub Action"

# Push the changes back to the repository
git push
