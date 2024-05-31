(*VAR		i,a,j,k:	INTEGER.
i:=2;
a:= 0;
k:=1;
FOR i:=2 DOWNTO 0 DO
   FOR j:= 0 TO 2 DO
   WHILE k < 3 DO
     a:=a+1;
     k:=k+1.
*)

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
