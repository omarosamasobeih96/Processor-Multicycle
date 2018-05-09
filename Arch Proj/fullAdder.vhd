LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity fullAdder is 
	Generic(N: integer:= 16);
	port(A, B : IN std_logic_vector(N-1 downto 0);
		Cin : IN std_logic;
		F : OUT std_logic_vector(N-1 downto 0);
		Cout : OUT std_logic);
End Entity fullAdder;

ARCHITECTURE struct of fullAdder IS

Component adder is 
	port(A, B, Cin : IN std_logic;
		S, Cout : OUT std_logic);
END COMPONENT;

Signal temp : std_logic_vector(N-1 downto 0);
Begin
	loop1: For i in 0 to n-1 Generate
		start: IF i=0 Generate
			f0: adder PORT MAP(A(i), B(i), Cin, F(i), temp(i));
		End Generate start;
		othr: IF i>0 Generate
			fx: adder PORT MAP(A(i), B(i), temp(i-1), F(i), temp(i));
		End Generate othr;
	End Generate;
	Cout <= temp(N-1);
End struct;