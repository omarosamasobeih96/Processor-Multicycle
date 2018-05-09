LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity adder is 
	port(A, B, Cin : IN std_logic;
		S, Cout : OUT std_logic);
End Entity adder;

ARCHITECTURE struct of adder IS
Begin
	S <= A XOR B XOR Cin;
	Cout <= (A AND B) OR (Cin AND (A XOR B));
End struct;
