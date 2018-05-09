LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity ALU is 
	Generic(N: integer := 16);
	port(A, B : IN std_logic_vector(N-1 downto 0);
		S : IN std_logic_vector(3 downto 0);
		Cin: IN std_logic;
		F : OUT std_logic_vector(N-1 downto 0);
		Cout: OUT std_logic);
End Entity ALU;

ARCHITECTURE struct of ALU IS
Signal F1, F2, F3, F4 : std_logic_vector(N-1 downto 0);
Signal Cout1, Cout2, Cout3, Cout4, C : std_logic_vector(0 downto 0);
Signal C1, C2, C3, C4 : std_logic;
Begin
	u1: entity work.partA GENERIC MAP(N => N) PORT MAP(A, B, S(1 downto 0), Cin, F1, C1);
	u2: entity work.partB GENERIC MAP(N => N) PORT MAP(A, B, S(1 downto 0), F2);
	u3: entity work.partC GENERIC MAP(N => N) PORT MAP(A, S(1 downto 0),Cin, F3, C3);
	u4: entity work.partD GENERIC MAP(N => N) PORT MAP(A, S(1 downto 0),Cin, F4, C4);
	--I had to transfer C1->C4 into Cout1->C4 because my generic 4x1 multiplexer only accepts std_logic_vector and the Carry is only 1 bit wide
	Cout1(0) <= C1;
	Cout2(0) <= Cin;
	Cout3(0) <= C3;
	Cout4(0) <= C4;

	u : entity work.mux4x1 PORT MAP (F1, F2, F3, F4, S(3 downto 2), F);
	uC : entity work.mux4x1 GENERIC MAP(n => 1) PORT MAP(Cout1, Cout2, Cout3, Cout4, S(3 downto 2), C);
	Cout <= C(0);
End struct;


