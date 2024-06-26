# CERICompiler
C++ program that compiles Pascal code and produces AT&T (processor x86 ) , which is a variant of the assembly code using recursive descent analysis. It can compile arithmetic expressions with basic conditional statements such as for, while, if, case, etc.


Download the repository :

git clone https://github.com/melissamelissa20032003/CERICompiler.git

Build the compiler and test it :

make test

Have a look at the output :

gedit test.s

Debug the executable :

ddd ./test

Commit the new version :

git commit -a -m "What's new..."

Send to your framagit :

git push -u origin master

Get from your framagit :

git pull -u origin master

This version Can handle :

 ForStatement := "For" ID ":=" Expression ("TO"|"DOWNTO") Expression "DO" Statement

<case statement> ::= case <expression> of <case list element> {; <case list element> } end
<case list element> ::= <case label list> : <statement> | <empty>
<case label list> ::= <constant> {, <constant> }
<empty>::=












**ForStatement**

-First, I declared a variable that will count the nested loops.

-Declared an enum TYPES variable and a string variable.

-I begin by reading the current character. If the current character is not a keyword or is not for, I will return an error message.

-I move on using current = (TOKEN) lexer->yylex().

-I get the result returned by the function AssignementStatement().

-While moving, I will test my loop whether it is a to loop or a downto loop.

-I store the keyword downto or to and move on.

-I call Expression().

-Then I start the assembly part.

-Declare a label, then using cout << "\tmov (%rsp), %rax \t# Get the result of expression we can find at the stack top".

-I compare the result of AssignementStatement() after separating the two cases, the TO and the DOWNTO, after making sure that my current has read the DO keyword and calling Statement().

-Then, if I have TO:
cout << "\tjae EndFor" << tag << "\t# if i >= result of the expression, jump out of the loop" << tag << endl;

-If I have DOWNTO:
cout << "\tjbe EndFor" << tag << "\t# if i <= result of the expression, jump out of the loop" << tag << endl;

-Last but not least, I increment the count if (keyword == "TO"):
cout << "incq " << var_boucle << endl;
And decrement the count if (keyword == "DOWNTO"):
cout << "decq " << var_boucle << endl;

-We jump into the TestFor while incrementing or decrementing.

-Jump to EndFor.

here is some screanshots 






![Screenshot from 2024-05-31 06-05-28](https://github.com/melissamelissa20032003/CERICompiler/assets/109720240/08fd36f7-c2ef-4504-8c66-1ffa1930e991)
![Screenshot from 2024-05-31 06-04-53](https://github.com/melissamelissa20032003/CERICompiler/assets/109720240/914e72c1-1b31-4196-afeb-c8fded0b3f14)


if we try to emplimeNt it with nested for loop or even while loop it works 

here is the for screenshots for a nested for loop 
![Screenshot from 2024-05-31 20-42-58](https://github.com/melissamelissa20032003/CERICompiler/assets/109720240/8747a68e-7ca7-4975-98fe-17a18a1ae071)

assembly code : 
![Screenshot from 2024-05-31 20-28-08](https://github.com/melissamelissa20032003/CERICompiler/assets/109720240/36082bc6-2b33-440a-88ed-02a7bad8cd51)

![Screenshot from 2024-05-31 20-28-36](https://github.com/melissamelissa20032003/CERICompiler/assets/109720240/381b4f32-e3f8-4c1e-bc99-0db3a08e29ea)

![Screenshot from 2024-05-31 20-29-02](https://github.com/melissamelissa20032003/CERICompiler/assets/109720240/6c9ae887-4c71-445b-bfc9-1f96649bdee0)

code to test 

```
VAR		i,a,j,k:	INTEGER.
i:=2;
a:= 0;
k:=1;
FOR i:=2 DOWNTO 0 DO
   FOR j:= 0 TO 2 DO
   WHILE k < 3 DO
     a:=a+1;
     k:=k+1.
```


__CaseStatement__

let's dive into the CaseStament :
I followed this grammar :

<case statement> ::= case <expression> of <case list element> {; <case list element> } end
<case list element> ::= <case label list> : <statement> | <empty>
<case label list> ::= <constant> {, <constant> }
<empty>::=

in pascale a  case can be empty exemple: 
```
  VAR		j, a :	INTEGER.
        j := 2;
        a := 1;
        BEGIN
            CASE j OF
                100: a := 5;
                **2: ; (* cas vide *)**
                30: a := 7;
                ELSE:
               j := j*2
            END
        END.
```
-This is why we first do a function that detetct this empty case if there is a ';' after : of the case.

There is two version of case statement the first is without else and the second if with the else part.
vs without else :
the function void CaseLabelList(unsigned long long tag)
- first we check if the current is a constante (NUMBER or ID) because there is two types of switch cases
``` 
case x of
  1: // instruction pour le cas où x vaut 1
  2: // instruction pour le cas où x vaut 2
end;


const
  RED = 1;
  GREEN = 2;
  BLUE = 3;
case color of
  RED: // instruction pour le cas où color vaut RED (1)
  GREEN: // instruction pour le cas où color vaut GREEN (2)
  BLUE: // instruction pour le cas où color vaut BLUE (3)
end;

```
The %rax register should contain the value of the expression being tested in the case statement. This value is computed by the Expression() function, which should leave its result in %rax.




*CaseStatement*
I used this grammar : 
<case statement> ::= case <expression> of <case list element> {; <case list element> } end
<case list element> ::= <case label list> : <statement> | <empty>
<case label list> ::= <constant> {, <constant> }
<empty>::=

some utility functions that I have used :

```
// to check the empty case 
bool Empty() {
    return current == SEMICOLON;
}

// the move forward the lecture 
TOKEN lexer_advance() {
    return (TOKEN)lexer->yylex();
}

//liblise the case statment 
string GenerateTag(string label) {
    return label + to_string(TagNumber++);
}

```
<empty>::= : in the Case Statement there is somtimes an empty case that we distinguish if we find ';' right after ':'

//<case label list> ::= <constant> {, <constant> }
- I considered a constante every NUMBER or ID that we find after the 'OF' witch markes the case
- there is two types of switch cases in pascal :
- exemple :

 ```
1- Constantes Numériques (NUMBER) :
case x of
  1: // instruction pour le cas où x vaut 1
  2: // instruction pour le cas où x vaut 2
end;

2-Constantes Identifier (IDENTIFIER) :
const
  RED = 1;
  GREEN = 2;
  BLUE = 3;
case color of
  RED: // instruction pour le cas où color vaut RED (1)
  GREEN: // instruction pour le cas où color vaut GREEN (2)
  BLUE: // instruction pour le cas où color vaut BLUE (3)
end;
```
the %rax register contains the result of Expression() which is the value of the variable between 'CASE' and 'OF' that we will compare with the cases that we will find in our CaseStatement(). While comparing the two values, we produce a label for the corresponding case, and according to the result, we jump to the right instruction. If we find a comma, we are facing another possibility in our case, so we move on and perform the same thing until we find a COLON. That means the current will be the instruction, so we print the label of the case and check if the case is empty (we move to another case) or we call Statement(), and we jump to the endCase. During the execution of this function, if we find that ',' or ':' is missing, we return an error message.

//<case list element> ::= <case label list> : <statement> | <empty>
void CaseListElement(unsigned long long tag)

According to the statement after the ':' of each case, we either move on or call CaseLabelList(tag).

I used tag as an argument to make sure there is coherence between the functions that I call inside the CaseStatement() and to guarantee that I am dealing with the right case each time.

//<case statement> ::= case <expression> of <case list element> {; <case list element> } end
void CaseStatement()
In this function, first, I create a unique tag for this case statement:

unsigned long long tag = TagNumber++;
After checking the correct syntax (no 'CASE' missing), I move on and call expression (push the value that will be used for comparison). I check if there is no 'OF' missing, move on, and produce case labels. I call CaseListElement(tag) if the current is not a keyword. If we find a semicolon, we just move to the next case.

Here I included the else part:
I check if the keyword 'ELSE' exists. I move forward while the current is not ':' and return an error message. After that, I produce an else label and call statement.

I jump to the end after checking that there is no END missing.



here is screenshots for the implementation 

![Screenshot from 2024-05-31 07-13-56](https://github.com/melissamelissa20032003/CERICompiler/assets/109720240/321f750b-3859-418d-961c-2cb7f8e810e9)

![Screenshot from 2024-05-31 07-14-26](https://github.com/melissamelissa20032003/CERICompiler/assets/109720240/0468cd3a-8cc4-4121-8c1a-c601ab117c7f)

![Screenshot from 2024-05-31 07-14-44](https://github.com/melissamelissa20032003/CERICompiler/assets/109720240/4c858a04-1c65-4b14-8c86-a19ac024901e)


code to test 
```
VAR		j, a :	INTEGER.
          j := 2;
          a := 1;
          BEGIN
              CASE j OF
                  100: a := 5;
                  2: a := 3; (* cas vide *)
                  30: a := 7;
                  ELSE:
                 j := j*2
              END
          END.
```














