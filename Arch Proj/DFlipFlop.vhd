LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY DFlipFlop IS
	port ( input : in std_logic;
			rst, clk : in std_logic;
			output : out std_logic);
END DFlipFlop;

ARCHITECTURE StructuralModel OF DFlipFlop IS
BEGIN
	PROCESS(clk, rst)
	BEGIN
		IF(rst = '1') THEN
			output <= '0';
		ELSIF(falling_edge(clk)) THEN
			output <= input;
		END IF;
	END PROCESS;
END StructuralModel;
