LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity mux5x1 is 
	Generic(n: integer:= 32);
	port(IN1, IN2, IN3, IN4, IN5 : IN std_logic_vector(n-1 downto 0);
		S : IN std_logic_vector(2 downto 0);
		F : OUT std_logic_vector(n-1 downto 0));
End Entity mux5x1;

Architecture arch1 OF mux5x1 is 
Begin
	F <= IN1 when(S = "000") else IN2 when(S = "001") else IN3 when(s = "010") else IN4 when(s = "011") else IN5;
End arch1;
