LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity partD is 
	Generic(N: integer:= 16);
	port(A : IN std_logic_vector(N-1 downto 0);
		S : IN std_logic_vector(1 downto 0);
		Cin: IN std_logic;
		F : OUT std_logic_vector(N-1 downto 0);
		Cout: OUT std_logic);
End Entity partD;

ARCHITECTURE struct of partD IS
Component mux4x1 is 
	Generic(n: integer:= N);
	port(IN1, IN2, IN3, IN4 : IN std_logic_vector(n-1 downto 0);
			S : IN std_logic_vector(1 downto 0);
			F : OUT std_logic_vector(n-1 downto 0));
END COMPONENT;

Signal F1, F2, F3, F4 : std_logic_vector(n-1 downto 0);
Signal oldCarry : std_logic;
Begin
	F1 <= A(N-2 downto 0) & '0';
	F2 <= A(N-2 downto 0) & A(N-1);
	F3 <= A(N-2 downto 0) & Cin;
	F4 <= (others => '0');

	u : mux4x1 PORT MAP (F1, F2, F3, F4, S, F);
	oldCarry <= Cin;
	Cout <= A(N-1) when (S = "10") else oldCarry;
End struct;
