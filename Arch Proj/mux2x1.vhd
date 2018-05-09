LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity mux2x1 is 
	Generic(n: integer:= 32);
	port(IN1, IN2 : IN std_logic_vector(n-1 downto 0);
		enable, S : IN std_logic;
		F : OUT std_logic_vector(n-1 downto 0));
End Entity mux2x1;

Architecture arch1 OF mux2x1 is 
Begin
	F <= (others => 'Z') when (enable = '0') 
	else IN1 when(S = '0') 
	else IN2 when(S = '1');
End arch1;
