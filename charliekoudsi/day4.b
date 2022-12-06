>>>>>,
[
    <<<+
    >>>
    ---------------------------------------------
    [
        [
            ---
            <[->++++++++++<]    add current number 10 times to current digit
            >[-<+>]             replace current number by current digit
        ]
        ,
        ---------------------------------------------
    ]
    >>>+>>
    >,
    --------------------------------------------
    [
        [
            ----
            <[->++++++++++<]    add current number 10 times to current digit
            >[-<+>]             replace current number by current digit
        ]
        ,
        --------------------------------------------
    ]
    <<<<<<
    >,
    ---------------------------------------------
    [
        [
            ---
            <[->++++++++++<]    add current number 10 times to current digit
            >[-<+>]             replace current number by current digit
        ]
        ,
        ---------------------------------------------
    ]
    >>>>>
    >,
    ----------
    [
        [
            --------------------------------------
            <[->++++++++++<]    add current number 10 times to current digit
            >[-<+>]             replace current number by current digit
        ]
        ,
        ----------
    ]
    <<<<<<<<
now we check if the first value is greater than or equal to the second
    [->-[>]<<]
    <[
        this case means geq
        if we have exact equality than we are done
        >>
        [
            this case means they are not equal
            [-]
            <<
            -
            we need to swap the two values and then compare them
            >>>>>>>>
            [<+>-]
            >[<+>-]
            <<[>>+<<-]
            >
            compare the second set of values
            [->-[>]<<]
            <[
                this case meets the p1 requirements so we add 1 cell 0
                -
                <<<<<<<<
                +
                >>>>>>>>>
            ]
            <[
                otherwise we do nothing and just zero it out
                -
            ]
            <<<<
        ]
        <<
        [
            this handles the strict equality case
            [-]
            <<
            +
            >>
        ]
    ]
    now we need to handle the less than case
    <
    [
        -
        >>>>>>>>
        [->-[>]<<]
        <
        [
            -
            go back to start and increment
            <<<<<<<<
            +
            >>>>>>>>
        ]
        <[-<]
        <<<<<<[-]
    ]
    zero everything out and reset
    >[-]
    >[-]
    >[-]
    >[-]
    >[-]
    >[-]
    >[-]
    >[-]
    >[-]
    >[-]
    >[-]
    <<<<<<<,
]
<<<<<
time to print it out!
>>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-
<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++
<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<
