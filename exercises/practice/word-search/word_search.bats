#!/usr/bin/env bats
load bats-extra

@test "Should accept an initial game grid and a target search word" {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash word_search.sh "clojure" "jefblpepre"
    assert_success
    assert_output "clojure: null"
}

@test "Should locate one word written left to right" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash word_search.sh "clojure" "clojurermt"
    assert_success
    assert_output "clojure: start(1, 1), end(7, 1)"
}

@test "Should locate the same word written left to right in a different position" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash word_search.sh "clojure" "mtclojurer"
    assert_success
    assert_output "clojure: start(3, 1), end(9, 1)"
}

@test "Should locate a different left to right word" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash word_search.sh "coffee" "coffeelplx"
    assert_success
    assert_output "coffee: start(1, 1), end(6, 1)"
}

@test "Should locate that different left to right word in a different position" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash word_search.sh "coffee" "xcoffeezlp"
    assert_success
    assert_output "coffee: start(2, 1), end(7, 1)"
}

@test "Should locate a left to right word in two line grid" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    grid=(
        "jefblpepre"
        "tclojurerm"
    )
    run bash word_search.sh "clojure" "${grid[@]}"
    assert_success
    assert_output "clojure: start(2, 2), end(8, 2)"
}

@test "Should locate a left to right word in three line grid" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    grid=(
        "camdcimgtc"
        "jefblpepre"
        "clojurermt"
    )
    run bash word_search.sh "clojure" "${grid[@]}"
    assert_success
    assert_output "clojure: start(1, 3), end(7, 3)"
}

@test "Should locate a left to right word in ten line grid" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    grid=(
        "jefblpepre"
        "camdcimgtc"
        "oivokprjsm"
        "pbwasqroua"
        "rixilelhrs"
        "wolcqlirpc"
        "screeaumgr"
        "alxhpburyi"
        "jalaycalmp"
        "clojurermt"
    )
    run bash word_search.sh "clojure" "${grid[@]}"
    assert_success
    assert_output "clojure: start(1, 10), end(7, 10)"
}

@test "Should locate that left to right word in a different position in a ten line grid" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    grid=(
        "jefblpepre"
        "camdcimgtc"
        "oivokprjsm"
        "pbwasqroua"
        "rixilelhrs"
        "wolcqlirpc"
        "screeaumgr"
        "alxhpburyi"
        "clojurermt"
        "jalaycalmp"
    )
    run bash word_search.sh "clojure" "${grid[@]}"
    assert_success
    assert_output "clojure: start(1, 9), end(7, 9)"
}

@test "Should locate a different left to right word in a ten line grid" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    grid=(
        "jefblpepre"
        "camdcimgtc"
        "oivokprjsm"
        "pbwasqroua"
        "rixilelhrs"
        "wolcqlirpc"
        "fortranftw"
        "alxhpburyi"
        "clojurermt"
        "jalaycalmp"
    )
    run bash word_search.sh "fortran" "${grid[@]}"
    assert_success
    assert_output "fortran: start(1, 7), end(7, 7)"
}

@test "Should locate multiple words" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    wordsToSearchFor="fortran clojure"
    grid=(
        "jefblpepre"
        "camdcimgtc"
        "oivokprjsm"
        "pbwasqroua"
        "rixilelhrs"
        "wolcqlirpc"
        "fortranftw"
        "alxhpburyi"
        "jalaycalmp"
        "clojurermt"
    )
    expected=(
        "clojure: start(1, 10), end(7, 10)"
        "fortran: start(1, 7), end(7, 7)"
    )
    run bash word_search.sh "$wordsToSearchFor" "${grid[@]}"
    assert_success
    assert_line "${expected[@]}"
}

@test "Should locate a single word written right to left" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash word_search.sh "elixir" "rixilelhrs"
    assert_success
    assert_output "elixir: start(6, 1), end(1, 1)"
}

@test "Should locate multiple words written in different horizontal directions" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    wordsToSearchFor="elixir clojure"
    grid=(
        "jefblpepre"
        "camdcimgtc"
        "oivokprjsm"
        "pbwasqroua"
        "rixilelhrs"
        "wolcqlirpc"
        "screeaumgr"
        "alxhpburyi"
        "jalaycalmp"
        "clojurermt"
    )
    expected=(
        "clojure: start(1, 10), end(7, 10)"
        "elixir: start(6, 5), end(1, 5)"
    )
    run bash word_search.sh "$wordsToSearchFor" "${grid[@]}"
    assert_success
    assert_line "${expected[@]}"
}

@test "Should locate words written top to bottom" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    wordsToSearchFor="elixir clojure ecmascript"
    grid=(
        "jefblpepre"
        "camdcimgtc"
        "oivokprjsm"
        "pbwasqroua"
        "rixilelhrs"
        "wolcqlirpc"
        "screeaumgr"
        "alxhpburyi"
        "jalaycalmp"
        "clojurermt"
    )
    expected=(
        "clojure: start(1, 10), end(7, 10)"
        "elixir: start(6, 5), end(1, 5)"
        "ecmascript: start(10, 1), end(10, 10)"
    )
    run bash word_search.sh "$wordsToSearchFor" "${grid[@]}"
    assert_success
    assert_line "${expected[@]}"
}

@test "Should locate words written bottom to top" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    wordsToSearchFor="elixir clojure ecmascript rust"
    grid=(
        "jefblpepre"
        "camdcimgtc"
        "oivokprjsm"
        "pbwasqroua"
        "rixilelhrs"
        "wolcqlirpc"
        "screeaumgr"
        "alxhpburyi"
        "jalaycalmp"
        "clojurermt"
    )
    expected=(
        "clojure: start(1, 10), end(7, 10)"
        "elixir: start(6, 5), end(1, 5)"
        "ecmascript: start(10, 1), end(10, 10)"
        "rust: start(9, 5), end(9, 2)"
    )
    run bash word_search.sh "$wordsToSearchFor" "${grid[@]}"
    assert_success
    assert_line "${expected[@]}"
}

@test "Should locate words written top left to bottom right" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    wordsToSearchFor="elixir clojure ecmascript rust java"
    grid=(
        "jefblpepre"
        "camdcimgtc"
        "oivokprjsm"
        "pbwasqroua"
        "rixilelhrs"
        "wolcqlirpc"
        "screeaumgr"
        "alxhpburyi"
        "jalaycalmp"
        "clojurermt"
    )
    expected=(
        "clojure: start(1, 10), end(7, 10)"
        "elixir: start(6, 5), end(1, 5)"
        "ecmascript: start(10, 1), end(10, 10)"
        "rust: start(9, 5), end(9, 2)"
        "java: start(1, 1), end(4, 4)"
    )
    run bash word_search.sh "$wordsToSearchFor" "${grid[@]}"
    assert_success
    assert_line "${expected[@]}"
}

@test "Should locate words written bottom right to top left" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    wordsToSearchFor="elixir clojure ecmascript rust java lua"
    grid=(
        "jefblpepre"
        "camdcimgtc"
        "oivokprjsm"
        "pbwasqroua"
        "rixilelhrs"
        "wolcqlirpc"
        "screeaumgr"
        "alxhpburyi"
        "jalaycalmp"
        "clojurermt"
    )
    expected=(
        "clojure: start(1, 10), end(7, 10)"
        "elixir: start(6, 5), end(1, 5)"
        "ecmascript: start(10, 1), end(10, 10)"
        "rust: start(9, 5), end(9, 2)"
        "java: start(1, 1), end(4, 4)"
        "lua: start(8, 9), end(6, 7)"
    )
    run bash word_search.sh "$wordsToSearchFor" "${grid[@]}"
    assert_success
    assert_line "${expected[@]}"
}

@test "Should locate words written bottom left to top right" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    wordsToSearchFor="elixir clojure ecmascript rust java lua lisp"
    grid=(
        "jefblpepre"
        "camdcimgtc"
        "oivokprjsm"
        "pbwasqroua"
        "rixilelhrs"
        "wolcqlirpc"
        "screeaumgr"
        "alxhpburyi"
        "jalaycalmp"
        "clojurermt"
    )
    expected=(
        "clojure: start(1, 10), end(7, 10)"
        "elixir: start(6, 5), end(1, 5)"
        "ecmascript: start(10, 1), end(10, 10)"
        "rust: start(9, 5), end(9, 2)"
        "java: start(1, 1), end(4, 4)"
        "lua: start(8, 9), end(6, 7)"
        "lisp: start(3, 6), end(6, 3)"
    )
    run bash word_search.sh "$wordsToSearchFor" "${grid[@]}"
    assert_success
    assert_line "${expected[@]}"
}

@test "Should locate words written top right to bottom left" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    wordsToSearchFor="elixir clojure ecmascript rust java lua lisp ruby"
    grid=(
        "jefblpepre"
        "camdcimgtc"
        "oivokprjsm"
        "pbwasqroua"
        "rixilelhrs"
        "wolcqlirpc"
        "screeaumgr"
        "alxhpburyi"
        "jalaycalmp"
        "clojurermt"
    )
    expected=(
        "clojure: start(1, 10), end(7, 10)"
        "elixir: start(6, 5), end(1, 5)"
        "ecmascript: start(10, 1), end(10, 10)"
        "rust: start(9, 5), end(9, 2)"
        "java: start(1, 1), end(4, 4)"
        "lua: start(8, 9), end(6, 7)"
        "lisp: start(3, 6), end(6, 3)"
        "ruby: start(8, 6), end(5, 9)"
    )
    run bash word_search.sh "$wordsToSearchFor" "${grid[@]}"
    assert_success
    assert_line "${expected[@]}"
}

@test "Should fail to locate a word that is not in the puzzle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    wordsToSearchFor="elixir clojure ecmascript rust java lua lisp ruby haskell"
    grid=(
        "jefblpepre"
        "camdcimgtc"
        "oivokprjsm"
        "pbwasqroua"
        "rixilelhrs"
        "wolcqlirpc"
        "screeaumgr"
        "alxhpburyi"
        "jalaycalmp"
        "clojurermt"
    )
    expected=(
        "clojure: start(1, 10), end(7, 10)"
        "elixir: start(6, 5), end(1, 5)"
        "ecmascript: start(10, 1), end(10, 10)"
        "rust: start(9, 5), end(9, 2)"
        "java: start(1, 1), end(4, 4)"
        "lua: start(8, 9), end(6, 7)"
        "lisp: start(3, 6), end(6, 3)"
        "ruby: start(8, 6), end(5, 9)"
        "haskell: null"
    )
    run bash word_search.sh "$wordsToSearchFor" "${grid[@]}"
    assert_success
    assert_line "${expected[@]}"
}

@test "Should fail to locate words that are not on horizontal, vertical, or diagonal lines" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    wordsToSearchFor="aef ced abf cbd"
    grid=(
        "abc"
        "def"
    )
    expected=(
        "aef: null"
        "ced: null"
        "abf: null"
        "cbd: null"
    )
    run bash word_search.sh "$wordsToSearchFor" "${grid[@]}"
    assert_success
    assert_line "${expected[@]}"
}

@test "Should not concatenate different lines to find a horizontal word" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    grid=(
        "abceli"
        "xirdfg"
    )
    run bash word_search.sh "elixir" "${grid[@]}"
    assert_success
    assert_output "elixir: null"
}

@test "Should not wrap around horizontally to find a word" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash word_search.sh "lisp" "silabcdefp"
    assert_success
    assert_output "lisp: null"
}

@test "Should not wrap around vertically to find a word" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    grid=(
        "s"
        "u"
        "r"
        "a"
        "b"
        "c"
        "t"
    )
    run bash word_search.sh "rust" "${grid[@]}"
    assert_success
    assert_output "rust: null"
}
