LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity partA is 
	Generic(N: integer:= 16);
	port(A, B : IN std_logic_vector(N-1 downto 0);
		S : IN std_logic_vector(1 downto 0);
		Cin: IN std_logic;
		F : OUT std_logic_vector(N-1 downto 0);
		Cout: OUT std_logic);
End Entity partA;

ARCHITECTURE struct of partA IS
Component mux4x1 is 
	Generic(n: integer:= N);
	port(IN1, IN2, IN3, IN4 : IN std_logic_vector(n-1 downto 0);
			S : IN std_logic_vector(1 downto 0);
			F : OUT std_logic_vector(n-1 downto 0));
END COMPONENT;

Component fullAdder is 
	Generic(n: integer:= N);
	port(A, B : IN std_logic_vector(n-1 downto 0);
		Cin : IN std_logic;
		F : OUT std_logic_vector(n-1 downto 0);
		Cout : OUT std_logic);
END COMPONENT;

Signal F1, F2, F3, F4, tempF4, In1, In2 : std_logic_vector(N-1 downto 0);
Signal C1, C2, C3, C4, tempC4, outC : std_logic_vector(0 downto 0);
Begin
	u1: fullAdder PORT MAP (A, (others => '0'), Cin, F1, C1(0));
	u2: fullAdder PORT MAP (A, B, Cin, F2, C2(0));
	In1 <= A;
	In2 <= NOT B;
	u3: fullAdder PORT MAP (In1, In2, Cin, F3, C3(0));
	u4: fullAdder PORT MAP (A, (others => '1'), Cin, tempF4, tempC4(0));
	F4 <= (others => '0') when(Cin = '1') else tempF4;
	C4 <= (others => '0') when(Cin = '1') else tempC4;

	u : mux4x1 PORT MAP (F1, F2, F3, F4, S, F);
	C : mux4x1 GENERIC MAP(n => 1) PORT MAP(C1, C2, C3, C4, S, outC);
	Cout <= outC(0);
End struct;
