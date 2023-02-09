# Compilation_Flex
> The project was built in C and Flex

### `Description `
---
The program writes to the output a description of the tokens it recognizes in its input.
 It will use a lexical analyzer - the function (yylex) - written by flex. The yylex interface will return a number indicating the type of token it found. In case the token has a semantic value, it will write it to the global variable yylval which will be defined as union.

##### `input` 
---
> test_airport.txt file

The input includes information about outgoing flights.

```
<departures>
  
LY1 00:10a.m. "JFK"  
  
BA289 10:15p.m. "Heathrow" cargo 
  
AF1234 03:20p.m. "Charles de Gaulle"
  
OP78 05:37a.m. "Athens" freight
  
AA17 11:00a.m. "LAX"
  
 ```
#### `A list of the types of tokens that the lexical analyzer should recognize.`
--- 
| example for lexeme | Token Type |
| ----------- | ----------- |
| < departures > | DEPARTURES |
| LY1 AF1234 | FLIGHT_NUMBER |
| 00:10a.m. 10:15p.m. | TIME |
| “JFK” “Charles de Gaulle”| AIRPORT |
| cargo | CARGO |
| freight | FREIGHT |


##### `Output` 
--- 
<img width="1123" alt="Screenshot 2023-02-08 at 0 58 07" src="https://user-images.githubusercontent.com/72464761/217385978-07a93225-3e8d-46c4-9cc5-dd15d4624bd4.png">


##### `Steps for running the program` (in Ubuntu)
---
 ```
1. flex airport.lex 
2. gcc -o airport lex.yy.c 
3. ./airport test_airport.txt 
 ```


