#!/usr/bin/env bats
load bats-extra

@test 'Calculate transmit sequences -> Empty message' {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash intergalactic_transmission.sh transmit_sequence ""
    assert_success
    assert_output ""
}

@test 'Calculate transmit sequences -> 0x00 is transmitted as 0x0000' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash intergalactic_transmission.sh transmit_sequence "0x00"
    assert_success
    assert_output "0x00 0x00"
}

@test 'Calculate transmit sequences -> 0x02 is transmitted as 0x0300' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash intergalactic_transmission.sh transmit_sequence "0x02"
    assert_success
    assert_output "0x03 0x00"
}

@test 'Calculate transmit sequences -> 0x06 is transmitted as 0x0600' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash intergalactic_transmission.sh transmit_sequence "0x06"
    assert_success
    assert_output "0x06 0x00"
}

@test 'Calculate transmit sequences -> 0x05 is transmitted as 0x0581' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash intergalactic_transmission.sh transmit_sequence "0x05"
    assert_success
    assert_output "0x05 0x81"
}

@test 'Calculate transmit sequences -> 0x29 is transmitted as 0x2881' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash intergalactic_transmission.sh transmit_sequence "0x29"
    assert_success
    assert_output "0x28 0x81"
}

@test 'Calculate transmit sequences -> 0xc001c0de is transmitted as 0xc000711be1' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    sequence=( "0xc0" "0x01" "0xc0" "0xde" )
    run bash intergalactic_transmission.sh transmit_sequence "${sequence[@]}"
    assert_success
    assert_output "0xc0 0x00 0x71 0x1b 0xe1"
}

@test 'Calculate transmit sequences -> Six byte message' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    sequence=( "0x47" "0x72" "0x65" "0x61" "0x74" "0x21" )
    run bash intergalactic_transmission.sh transmit_sequence "${sequence[@]}"
    assert_success
    assert_output "0x47 0xb8 0x99 0xac 0x17 0xa0 0x84"
}

@test 'Calculate transmit sequences -> Seven byte message' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    sequence=( "0x47" "0x72" "0x65" "0x61" "0x74" "0x31" "0x21" )
    run bash intergalactic_transmission.sh transmit_sequence "${sequence[@]}"
    assert_success
    assert_output "0x47 0xb8 0x99 0xac 0x17 0xa0 0xc5 0x42"
}

@test 'Calculate transmit sequences -> Eight byte message' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    sequence=( "0xc0" "0x01" "0x13" "0x37" "0xc0" "0xde" "0x21" "0x21" )
    run bash intergalactic_transmission.sh transmit_sequence "${sequence[@]}"
    assert_success
    assert_output "0xc0 0x00 0x44 0x66 0x7d 0x06 0x78 0x42 0x21 0x81"
}

@test 'Calculate transmit sequences -> Twenty byte message' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    sequence=(
        "0x45"
        "0x78"
        "0x65"
        "0x72"
        "0x63"
        "0x69"
        "0x73"
        "0x6d"
        "0x20"
        "0x69"
        "0x73"
        "0x20"
        "0x61"
        "0x77"
        "0x65"
        "0x73"
        "0x6f"
        "0x6d"
        "0x65"
        "0x21"
    )
    expected=(
        "0x44"
        "0xbd"
        "0x18"
        "0xaf"
        "0x27"
        "0x1b"
        "0xa5"
        "0xe7"
        "0x6c"
        "0x90"
        "0x1b"
        "0x2e"
        "0x33"
        "0x03"
        "0x84"
        "0xee"
        "0x65"
        "0xb8"
        "0xdb"
        "0xed"
        "0xd7"
        "0x28"
        "0x84"
    )
    run bash intergalactic_transmission.sh transmit_sequence "${sequence[@]}"
    assert_success
    assert_output "${expected[*]}"
}

@test 'Decode received messages -> Empty message' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run bash intergalactic_transmission.sh decode_message ""
    assert_success
    assert_output ""
}

@test 'Decode received messages -> Zero message' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=( "0x00" "0x00" )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "0x00"
}

@test 'Decode received messages -> 0x0300 is decoded to 0x02' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=( "0x03" "0x00" )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "0x02"
}

@test 'Decode received messages -> 0x0581 is decoded to 0x05' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=( "0x05" "0x81" )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "0x05"
}

@test 'Decode received messages -> 0x2881 is decoded to 0x29' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=( "0x28" "0x81" )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "0x29"
}

@test 'Decode received messages -> First byte has wrong parity' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=( "0x07" "0x00" )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "wrong parity"
}

@test 'Decode received messages -> Second byte has wrong parity' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=( "0x03" "0x68" )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "wrong parity"
}

@test 'Decode received messages -> 0xcf4b00 is decoded to 0xce94' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=( "0xcf" "0x4b" "0x00" )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "0xce 0x94"
}

@test 'Decode received messages -> 0xe2566500 is decoded to 0xe2ad90' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=( "0xe2" "0x56" "0x65" "0x00" )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "0xe2 0xad 0x90"
}

@test 'Decode received messages -> Six byte message' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=( "0x47" "0xb8" "0x99" "0xac" "0x17" "0xa0" "0x84" )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "0x47 0x72 0x65 0x61 0x74 0x21"
}

@test 'Decode received messages -> Seven byte message' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=( "0x47" "0xb8" "0x99" "0xac" "0x17" "0xa0" "0xc5" "0x42" )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "0x47 0x72 0x65 0x61 0x74 0x31 0x21"
}

@test 'Decode received messages -> Last byte has wrong parity' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=( "0x47" "0xb8" "0x99" "0xac" "0x17" "0xa0" "0xc5" "0x43" )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "wrong parity"
}

@test 'Decode received messages -> Eight byte message' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=( "0xc0" "0x00" "0x44" "0x66" "0x7d" "0x06" "0x78" "0x42" "0x21" "0x81" )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "0xc0 0x01 0x13 0x37 0xc0 0xde 0x21 0x21"
}

@test 'Decode received messages -> Twenty byte message' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=(
        "0x44"
        "0xbd"
        "0x18"
        "0xaf"
        "0x27"
        "0x1b"
        "0xa5"
        "0xe7"
        "0x6c"
        "0x90"
        "0x1b"
        "0x2e"
        "0x33"
        "0x03"
        "0x84"
        "0xee"
        "0x65"
        "0xb8"
        "0xdb"
        "0xed"
        "0xd7"
        "0x28"
        "0x84"
    )
    expected=(
        "0x45"
        "0x78"
        "0x65"
        "0x72"
        "0x63"
        "0x69"
        "0x73"
        "0x6d"
        "0x20"
        "0x69"
        "0x73"
        "0x20"
        "0x61"
        "0x77"
        "0x65"
        "0x73"
        "0x6f"
        "0x6d"
        "0x65"
        "0x21"
    )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "${expected[*]}"
}

@test 'Decode received messages -> Wrong parity on 16th byte' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    message=(
        "0x44"
        "0xbd"
        "0x18"
        "0xaf"
        "0x27"
        "0x1b"
        "0xa5"
        "0xe7"
        "0x6c"
        "0x90"
        "0x1b"
        "0x2e"
        "0x33"
        "0x03"
        "0x84"
        "0xef"
        "0x65"
        "0xb8"
        "0xdb"
        "0xed"
        "0xd7"
        "0x28"
        "0x84"
    )
    run bash intergalactic_transmission.sh decode_message "${message[@]}"
    assert_success
    assert_output "wrong parity"
}
