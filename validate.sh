#!/bin/bash

function validate () {
    count=$(ls -t data/blocks/ | head -c1)

    for ((i=1;i<=$count;i++)); do
        sum=$(sha256sum ./data/blocks/$i | head -c64)
        check=$(echo data/blocks/$(expr $i + 1) | ./JSON.awk | grep -i previousBlockHash | cut -f2 | sed s/\"//g)
        if [[ "$sum" == "$check" ]]; then
            echo -e "block $i ok"
        else
            echo -e "\e[31mblock $i NOT ok"
            return 1
        fi
    done
    return 0
}

validate
