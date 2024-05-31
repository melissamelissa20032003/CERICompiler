# CERICompiler
C++ program that compiles Pascal code and produces AT&T (processor x86 ) , which is a variant of the assembly code using recursive descent analysis. It can compile arithmetic expressions with basic conditional statements such as for, while, if, case, etc.

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






![Screenshot from 2024-05-30 20-20-20](https://github.com/melissamelissa20032003/CERICompiler/assets/109720240/7e5cd2bd-d1b0-4ad7-9b14-ecb807797a9a)

![Screenshot from 2024-05-30 20-02-15](https://github.com/melissamelissa20032003/CERICompiler/assets/109720240/d6ef06d0-f8ed-48de-969f-fe4c12420a63)



__CaseStatement__

let's dive into the CaseStament :
I followed this grammar :

<case statement> ::= case <expression> of <case list element> {; <case list element> } end
<case list element> ::= <case label list> : <statement> | <empty>
<case label list> ::= <constant> {, <constant> }
<empty>::=

in pascale a  case can be empty exemple: 
'''
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
'''
-This is why we first do a function that detetct this empty case if there is a ';' after : of the case.

There is two version of case statement the first is without else and the second if with the else part.
vs without else :
the function void CaseLabelList(unsigned long long tag)
- first we check if the current is a constante (NUMBER or ID) because there is two types of switch cases
 ''' 
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

  '''
The %rax register should contain the value of the expression being tested in the case statement. This value is computed by the Expression() function, which should leave its result in %rax.















