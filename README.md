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





![Screenshot from 2024-05-30 20-01-25](https://github.com/melissamelissa20032003/CERICompiler/assets/109720240/4bc7062c-a0fe-4209-a32c-6ce49e9b2da0)
![Screenshot from 2024-05-30 20-02-15](https://github.com/melissamelissa20032003/CERICompiler/assets/109720240/d6ef06d0-f8ed-48de-969f-fe4c12420a63)






__CaseStatement__

