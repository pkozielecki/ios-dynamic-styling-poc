#!/bin/sh

STORAGE_FILE="formatted_files"

# Removing old storage file if needed:
[ -e STORAGE_FILE ] && rm STORAGE_FILE

# Get the list of all modified files - staged or otherwise:
git diff --diff-filter=d --name-only -- "*.swift" | while read filename; do
	echo $filename >> STORAGE_FILE
done
git diff --cached --diff-filter=d --name-only -- "*.swift" | while read filename; do
	echo $filename >> STORAGE_FILE
done
git ls-files --others --exclude-standard -- "*.swift" | while read filename; do
	echo $filename >> STORAGE_FILE
done

# Perform formatting:
cat STORAGE_FILE | while read filename
do
	$(swiftformat "$filename")
done

# Remove storage file:
rm STORAGE_FILE
