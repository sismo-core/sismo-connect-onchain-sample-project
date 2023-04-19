#!/bin/sh

# This script generates the ABI files for the contracts in the project.
# It is intended to be run from the project root directory
# the generated ABI will be used to call the contracts from the frontend
mkdir -p ./abi
touch ./abi/AirdropLevel0.json
touch ./abi/AirdropLevel1.json
touch ./abi/AirdropLevel2.json

echo "{\n  \"abi\": $(forge inspect AirdropLevel0 abi)\n}" >| ./abi/AirdropLevel0.json
echo "{\n  \"abi\": $(forge inspect AirdropLevel1 abi)\n}" >| ./abi/AirdropLevel1.json
echo "{\n  \"abi\": $(forge inspect AirdropLevel2 abi)\n}" >| ./abi/AirdropLevel2.json