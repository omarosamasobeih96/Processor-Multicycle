LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RegisterGeneric IS
	Generic (n : integer :=32);

	port ( input, initVal : in std_logic_vector (n-1 downto 0);
			rst, enable, clk : in std_logic;
			output : out std_logic_vector (n-1 downto 0));
	Signal Data : std_logic_vector(n-1 downto 0);
END RegisterGeneric;

ARCHITECTURE StructuralModel OF RegisterGeneric IS
BEGIN
	PROCESS(clk, rst)
	BEGIN
		IF(rst = '1') THEN
			output <= initVal;
		ELSIF(enable = '1' AND falling_edge(clk)) THEN
			output <= input;
		END IF;
	END PROCESS;
END StructuralModel;
