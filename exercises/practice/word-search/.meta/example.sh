#!/usr/bin/env bash

main() {
    local -a words grid
    local width height found

    mapfile -t words < <(printf "%s\n" "$1" | tr ' ' '\n')
    shift
    grid=( "$@" )

    width=${#grid[0]}
    height=${#grid[@]}

     for word in "${words[@]}"; do
        search "$word"
    done
}

search() {
    for (( X = 0; X < width; X++ )); do
        for (( Y = 0; Y < height; Y++ )); do
            for check_row in -1 0 1; do
                for check_col in -1 0 1; do
                    found=$(find "$word" "$X" "$Y" "$check_row" "$check_col")

                    if [[ ! -z $found ]]; then
                        break 4
                    else
                        found=null
                    fi
                done
            done
        done
    done

    printf "%s: %s\n" "$word" "$found"
}

find() {
    local word="$1"
    local X="$2"
    local Y="$3"
    local nextX="$4"
    local nextY="$5"
    local currentX="$X"
    local currentY="$Y"

    for (( i = 0; i < ${#word}; i++ )); do
        next_letter=$(find_next_letter "$currentX" "$currentY")

        if [[ $next_letter != "${word:i:1}" ]]; then
            return 0
        fi

        (( currentX += nextX ))
        (( currentY += nextY ))
    done

    echo "start($(( X + 1 )), $(( Y + 1 ))), end($(( currentX + 1 - nextX )), $(( currentY + 1 - nextY)))"
}

find_next_letter() {
    local X="$1"
    local Y="$2"

    if (( X < 0 || Y < 0 || X >= width || Y >= height )); then
        return
    fi

    echo "${grid[$Y]:$X:1}"
}

main "$@"
