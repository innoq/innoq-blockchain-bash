#!/bin/bash

DIFFICULTY=3

node=$1
modulo=$2
block_first=$3
block_last=$4

proof_count=0

current_block=""

proof_of_concept=$(expr $node + $proof_count \* $modulo)

try_new_block() {
  current_block="$block_first$proof_of_concept$block_last"
  current_block_hash=$(echo $current_block | sha256sum | head -c 64)
}

try_new_block

hash_should_match_regex=^0{$DIFFICULTY}.+$
while ! [[ "${current_block_hash}" =~ ${hash_should_match_regex} ]]; do # TODO: cat /proc/... CPU temp
  proof_of_concept=$(expr $proof_of_concept + $modulo)
  try_new_block
done

echo $current_block
exit 0
