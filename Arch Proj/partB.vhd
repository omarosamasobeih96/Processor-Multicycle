LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity partB is 
	Generic(N: integer:= 16);
	port(A, B : IN std_logic_vector(N-1 downto 0);
		S : IN std_logic_vector(1 downto 0);
		F : OUT std_logic_vector(N-1 downto 0));
End Entity partB;

ARCHITECTURE struct of partB IS
Component mux4x1 is 
	Generic(n: integer:= N);
	port(IN1, IN2, IN3, IN4 : IN std_logic_vector(n-1 downto 0);
			S : IN std_logic_vector(1 downto 0);
			F : OUT std_logic_vector(n-1 downto 0));
END COMPONENT;

Signal F1, F2, F3, F4 : std_logic_vector(N-1 downto 0);
Begin
	F1 <= (A AND B);
	F2 <= (A OR B);
	F3 <= (A XOR B);
	F4 <= (NOT A);
	u : mux4x1 PORT MAP (F1, F2, F3, F4, S, F);
End struct;