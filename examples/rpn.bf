rpn calculator 

Patrick Schultz patrickschultz@usa.net 
Sat, 4 Aug 2001 02:36:57 -0700

Hello everybody,

  I discovered brainfuck about a year ago, and in my first period of
interest I wrote a calculator program with addition, subtraction,
multiplication and division.  It uses the reverse polish notation, so it
takes input like this:
    56 4 / 5 13 * +     (the line must end with a end line, ascii
13, or the program will infinite loop)

Now I have remembered this fun little language and want to try doing
something else.  I found this mailing list while surfing the web, and
promptly joined.  I though I would first share my program in case anyone
is interested.  The code, both with comments and without, is at the
bottom of the message.  The comments are from when I was working on the
program, and I never intended them for anyone but myself, so they
probably won't make much sense, so I apologize.  I have only run this
program on the online javascript bf interpreter, so I don't know for
sure if it would run elsewhere.

So now I am looking for a new project.  Some ideas I have had are: 
write an interpreter for another language in brainfuck, implement the
encryption  algorithm RC4, or perhaps a library of sorts, with various
useful algorithms and data structures.  If anybody has any ideas, things
you were thinking about or wanted to see done, or even better, would
like to work on something with me, I would really like to hear.

Anyways, here is the code:

+[   set continue flag to true and start loop
    -,   clear continue flag and get input
    >+>+>+>+>+>+<<<<<<     set five bools
    -------------
    [>-<-------------------   if not 13 (ret) sub 19
    [>>-<<----------   if not 32 (space) clear first bool
    [>>>-<<<-    if not 42 (mul) clear second bool
    [>>>>-<<<<--  if not 43 (add) clear third bool
    [>>>>>-<<<<<--   if not 45 (sub) clear fourth bool
    [>>>>>>[-]>+<<<<<<<-]]]]]] if not 47 (div) clear fifth
bool and move remaining number (digit plus one) to sixth spot

    >[->->->->->-<<<<<]   if input was a ret
clear rest of bools and do not reset continue flag

    >[->->->->-<<<<<<+>>]   if input was a
space clear rest of bools and reset continue flag

    >[->->->-<<<<<<<-<-  if
input was (mul) clear rest of bools and go back to second to last num on
stack
 [>[>+>+<<-]>>[<<+>>-]<<<-]+>[-]+>[<<+>>-]>>]     
multiply last two items together leaving answer in spot of first; reset
continue flag

    >[->->-<<<<<<<  if
input was (add) clear rest of bools and go back to last num on stack
 -[<+>-]+>>>>]     add
last two items together; reset continue flag

    >[->-<<<<<<<   if input was
(sub) clear rest of bools and go back to last num on stack
 -[<->-]+>>>>>]  sub last item from
second to last; reset continue flag

    >[-<<<<<<<    if input was (div) clear
div bool and go back to second to last num on stack
 -[>+>+<<-]>->[<<+>>-]<<<-  copy B to (1)
using (2) as tmp storage
[     
decrement through A; add one to (3) every Bth time
   >>>>+<<     (3) is
bool; says if (1)==0
   [>+>[-]<<-]>[<+>-]   if (1) != 0
set (3) to 0
   >[-<<<[>+>+<<-]>>[<<+>>-]>>+<]    if (1)=0 reset (1)
and add one to (4)
   <<-<<-
     ]
     +>[-]+>[-]>>>[<<<<<+>>>>>-]>>     clear A and B
and all temporary data and move answer in spot of A
    ]

    >[     if input was first digit of a number
 <+>>    a one in case input is zero;  Resulting
number ends up in the space the "1" is in
 ,>++++++++[<---->-]<  get digit and subtract 32 from it to
test for space
 [    begin main input loop
    >+++++[<--->-]  subtract 15 from remaining number
leaving the inputed number plus one
    ,>++++++++[<---->-]<   get next digit and subtract 32
    ]

    <[<]>>  go back to first digit inputed after
the beginning "1"
    [<-[>++++++++++<-]+>>]   multiply digits together leaving "1"
in every spot
    <[[<]>+[>]<-]<[-<]>  move number back to begginning clear trail
of ones; pntr is at num
    [<<<<<<+>>>>>>-]    move number back to top of stack
    <<<<<+>>>>>>>]     reset continue flag

   <<<<<<<]move pntr back to continue flag and end loop

<[>>+<<-]>     move answer two spaces forward to make sure
printer has room
+>-[>+<<[-]>-]>[<+>-]<if number is zero set spot before num to 1

[while the remainder is not 0; call
current p 0
    >+++++++++<     (1)=9
    [   decrement through the number; adding one
to (4) every tenth time
 >>>+<< (3) is a boolean; says if (1)==0; (3)=1;
 [>+>[-]<<-]  if (1) != 0 { (3)=0 }; moves (1) to (2);
 >[<+>-]move (2) back to (1);
 >[<<++++++++++>>>+<-]    if (3) == true { (1)=10; increment (4)
(dividend)
 <<-<-  dec (1) and (0);
    ]
    <++++++++++     set spot before (0) to 10
    >>[<<->>-]subtract rem in (1) from 9; making spot
before (0) one more than correct digit
    >>[-]>[<<<+>>>-]clear (3) and move (4) to (1)
    <<<
]
<[>]< go to first digit to be displayed; handles case
if number was zero
[->++++++++[<++++++>-]<.[-]<]>>    print sequence of digits backwards;
clearing each one; leaving pntr at original spot


and without comments (this is much more convenient for using with the
online interpreter):

+
[-,>+>+>+>+>+>+<<<<<<-------------[>-<-------------------[>>-<<----------[
 >>>-<<<-[>>>>-<<<<--[>>>>>-<<<<<--[>>>>>>[-]>+<<<<<<<-]]]]]]>
[->->->->->-<<<<<]>[->->->->-<<<<<<+>>]>
[->->->-<<<<<<<-<-[>[>+>+<<-]>>[<<+>>-]<<<-]+>[-]+>[<<+>>-]>>]>
[->->-<<<<<<<-[<+>-]+>>>>]>[->-<<<<<<<-[<->-]+>>>>>]>
[-<<<<<<<-[>+>+<<-]>->[<<+>>-]<<<-[>>>>+<<[>+>[-]<<-]>[<+>-]>
[-<<<[>+>+<<-]>>[<<+>>-]>>+<]<<-<<-]+>[-]+>
[-]>>>[<<<<<+>>>>>-]>>]>[<+>>,>++++++++[<---->-]<[>+++++[<--->-],>++++++++
[<---->-]<]<[<]>>[<-[>++++++++++<-]+>>]<[[<]>+[>]<-]<
[-<]>[<<<<<<+>>>>>>-]<<<<<+>>>>>>>]<<<<<<<]<[>>+<<-]>+>-[>+<<
[-]>-]>[<+>-]<[>+++++++++<[>>>+<<[>+>
[-]<<-]>[<+>-]>[<<++++++++++>>>+<-]<<-<-]<++++++++++>>[<<->>-]>>
[-]>[<<<+>>>-]<<<]<[>]<[->++++++++[<++++++>-]<.[-]<]>>


    -Patrick