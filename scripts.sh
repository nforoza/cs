#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Usage: $0 project_name"
    exit 1
fi

input="$1"

if [ ${#input} -lt 5 ]; then
    echo "Error: Project name must be at least 5 characters long"
    exit 1
fi

# Initialize a flag to track input validity
valid_input_type=false

# Validate the input
while [ "$valid_input_type" = false ]; do
    # Prompt the user for input
    read -p "Enter a project type (classlib_api, api, or console): " projecttype
    #Prompt for input
    if [[ "$projecttype" == "classlib_api" || "$projecttype" == "api" || "$projecttype" == "console" ]]; then
        # Execute the command with the valid project type
        valid_input_type=true
    else
        echo "Invalid project type. Please enter either 'classlib_api,' 'api,' or 'console'. (ctrl-c to quit)"
    fi
done

# Solution folders
sln_src_contracts="src/${input}.Contracts/"
sln_src="src/${input}/"
sln_test="tests/Domain.UnitTests"

if [ "$projecttype" == "classlib_api" ]; then
    dotnet new sln -n $input
    dotnet new classlib -o $sln_src_contracts
    dotnet new webapi -o $sln_src
    dotnet new mstest -o tests/Contracts.UnitTests
    dotnet sln add $sln_src $sln_src_contracts
fi


