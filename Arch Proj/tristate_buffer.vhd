LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tristate_buffer IS
	Generic (n : integer :=32);
	port ( 	input : in std_logic_vector (n-1 downto 0);
		enable : in std_logic;
		output : out std_logic_vector (n-1 downto 0));
END tristate_buffer;

ARCHITECTURE StructuralModel OF tristate_buffer IS
BEGIN
	output <= (others => 'Z') when (enable = '0')
		else input when (enable = '1');
END StructuralModel;
