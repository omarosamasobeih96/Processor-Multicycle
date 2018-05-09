LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Decoder IS
	Generic (n : integer :=4);
	port ( 	input : in std_logic_vector (n-1 downto 0);
		enable : in std_logic;
		output : out std_logic_vector ((2**n) - 1 downto 0));
END Decoder;

ARCHITECTURE StructuralModel OF Decoder IS
BEGIN
	PROCESS(input, enable)
		VARIABLE x : integer;
	BEGIN
		x := to_integer(unsigned(input));
		output <= (others => '0');
		IF enable = '1' THEN
			output(x) <= '1';
		END IF;
	END PROCESS;
END StructuralModel;
