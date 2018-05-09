LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity mux4x1 is 
	Generic(n: integer:= 32);
	port(IN1, IN2, IN3, IN4 : IN std_logic_vector(n-1 downto 0);
		S : IN std_logic_vector(1 downto 0);
		F : OUT std_logic_vector(n-1 downto 0));
End Entity mux4x1;

Architecture arch1 OF mux4x1 is 
Begin
	F <= IN1 when(S = "00") else IN2 when(S = "01") else IN3 when(s = "10") else IN4;
End arch1;
