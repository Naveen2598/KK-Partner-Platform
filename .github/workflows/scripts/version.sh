#!/bin/bash

set -e  # stop if any error

echo "Fetching tags..."
git fetch --tags

# Get latest tag
latest_tag=$(git tag | sort -V | tail -n 1)

echo "Latest tag: $latest_tag"

# If no tag exists
if [ -z "$latest_tag" ]; then
  new_version="v1.0.1"
else
  # Remove 'v'
  version=${latest_tag#v}

  # Split version
  IFS='.' read -r major minor patch <<< "$version"

  # Increment patch
  patch=$((patch + 1))

  new_version="v$major.$minor.$patch"
fi

echo "New version: $new_version"

# Create tag
git config user.name "github-actions"
git config user.email "actions@github.com"

git tag $new_version
git push origin $new_version

# Output for GitHub Actions
echo "NEW_VERSION=$new_version" >> $GITHUB_OUTPUT