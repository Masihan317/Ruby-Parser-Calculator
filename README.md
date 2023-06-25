# Ruby-Parser-Calculator

## Calculator Program Description

The calculator program I implemented allows users to type a variety of inputs where it would then be evaluated.

My calculator program is specified by the following grammar:

```
program ::= statement | program statement
statement ::= exp | id = exp | clear id | list | quit | exit | ε
exp ::= term  |  exp + term  |   exp - term
term ::= power  |  term * power | term / power
power ::= factor  |  factor ** power
factor ::= id  |  number  |  ( exp ) | sqrt ( exp ) | sin ( exp ) | cos ( exp ) | tan ( exp )
```

For example, the user can type an expression like 3+5 or 3\*\*4+(5\*6)-7/2 where the expression will be evaluated and results returned.
The user can also assign, clear and list variables. For example, x = 3\*\*2 will assign the variable x to 9. clear x will clear the previous value assigned. list will show the user a list of all variables currently stored.
The user can also type quit or exit to finish the execution of the program.
The calculator also has some built-in functions such as sqrt, sin, cos, and tan where the user can evaluate expressions using these functions.

## Extra Notes
1. My program will print a message after assignment, clear, and list statements telling the user what value the variable is assigned to, what variable is cleared, and that the above variables are all of the variables stored.
2. My program allows empty lines (statements) in the input where it will get skipped and continue the execution of the program.
3. Trig functions such as sin, cos, and tan are added to my program in addition to the required sqrt where the user can now calculate trig values.
4. My program also have some simple error checking. If the user types an unbound variable, an error message will be printed. If the user types an invalid token such as _ or ., the progran will prints an error message indicating that there's an invalid token somewhere.

## Sample Output
Some sample output can be found in sample.txt