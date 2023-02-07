%{

#define DEPARTURES 300
#define FLIGHTNUMBER 301
#define TIME 302
#define AIRPORT 303
#define CARGO 304
#define FREIGHT 305


union {
  char departures [30];
  char flightNumber[80];
  char time[80];
  char airport[80];
  char flightType[80];
} yylval;

#include <string.h>
#include <stdio.h>

%}

/* it give us the option to continue to the next filen */
%option noyywrap 

/* exclusive start condition -- deals with C++ style comments */
%x COMMENT 


%%

\<departures> { strcpy (yylval.departures, yytext); return DEPARTURES; } //example for <intial>

[A-Z]{2}[A-Za-z0-9]{1,4} { strcpy (yylval.flightNumber, yytext); return FLIGHTNUMBER; }

((1[0-2]{1})|(0[0-9]{1})):([0-5]{1}[0-9]{1})[ap]\.m\. { strcpy (yylval.time, yytext); return TIME; }

\"[A-Za-z][A-Za-z ]*\"  { strcpy (yylval.airport, yytext); return AIRPORT; }

[c][a][r][g][o] { strcpy (yylval.flightType, yytext); return CARGO; }

[f][r][e][i][g][h][t] { strcpy (yylval.flightType, yytext); return FREIGHT; }

[\n\t\r ]+  /* skip white space */

"//"       { BEGIN (COMMENT); }

<COMMENT>.+ /* skip comment */
<COMMENT>\n {  
                BEGIN (0); } /* BEGIN(INTIAL) , end of comment --> resume normal processing */

.          { fprintf (stderr, "unrecognized token %c\n", yytext[0]); }


%%


main (int argc, char **argv)
{
   int token;

   if (argc != 2) {
      fprintf(stderr, "Usage: mylex <input file name>\n", argv [0]);
      exit (1);
   }

   yyin = fopen (argv[1], "r");

   printf("TOKEN\t\t\tLEXEME\t\t\tSEMANTIC VALUE\n");
   printf("-----------------------------------------------------------------\n");

   
   while ((token = yylex ()) != 0)
     switch (token) {
case DEPARTURES: printf("DEPARTURES\t\t%s\t\t\n", yylval.departures);
             break;
case FLIGHTNUMBER: printf ("FLIGHT_NUMBER\t\t%s\n",  yylval.flightNumber);
             break;
case TIME: printf ("TIME\t\t\t%s\t\t%.*s\n",yylval.time, 3, yylval.time + 5);
             break;
case AIRPORT: printf ("AIRPORT\t\t\t%s\n", yylval.airport);
             break;
case CARGO: printf ("CARGO\t\t\t%s\n",  yylval.flightType);
             break;
case FREIGHT: printf ("FREIGHT\t\t\t%s\n" , yylval.flightType);
	     break;
         default:     fprintf (stderr, "error ... \n"); exit (1);
     }
   fclose (yyin);
   exit (0);
}

