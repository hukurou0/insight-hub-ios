#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

prompt_install() {
    read -p "$1 is not installed. Do you want to install it? (y/n): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        $2
    else
        exit 1
    fi
}

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    prompt_install "Homebrew" '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
fi

# Check for Python
if ! python3 --version &>/dev/null; then
    printf "${RED} ERROR: Python 3 is not installed.${NC}\n"
fi

# Check for SwiftFormat
if ! command -v swiftformat &> /dev/null; then
    prompt_install "SwiftFormat" 'brew install swiftformat'
fi

# Remove file if it already exists
if test -f $PWD/.git/hooks/pre-commit; then
    rm $PWD/.git/hooks/pre-commit
fi

# Create a symbolic link to the pre-commit script
OUTPUT=$(ln -s $PWD/scripts/pre-commit $PWD/.git/hooks/pre-commit)
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: $OUTPUT${NC}"
    exit 1
fi

chmod +x $PWD/.git/hooks/pre-commit

# Function to convert string to camelCase
to_camel_case() {
    echo "$1" | awk -F'_' '{for(i=1;i<=NF;i++) $i=tolower($i); $1=tolower($1); for(i=2;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1' OFS=''
}

# Setup environment variable
if [ -f "$PWD/.env" ]; then
    echo "Reading .env file..."
    echo "struct EnvironmentVariable {" > $PWD/InsightHub/EnvironmentVariable.swift
    while IFS='=' read -r key value || [ -n "$key" ]; do
        key=$(echo "$key" | tr -d '[:space:]')
        value=$(echo "$value" | tr -d '[:space:]')
        camel_key=$(to_camel_case "$key")
        echo "    static let $camel_key: String = \"$value\"" >> $PWD/InsightHub/EnvironmentVariable.swift
    done < "$PWD/.env"
    echo "}" >> $PWD/InsightHub/EnvironmentVariable.swift
else
    echo -e "${RED}Error: .env file not found.${NC}"
    exit 1
fi

echo -e "${GREEN}Setup complete.${NC}"
exit 0