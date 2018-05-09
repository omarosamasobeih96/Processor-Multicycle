LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;

Entity muxGeneric is 
	Generic(n: integer:= 3);
	port(input : IN std_logic_vector((2**n)-1 downto 0);
		enable : IN std_logic;
		s : IN std_logic_vector(n-1 downto 0);
		output : OUT std_logic);
End Entity muxGeneric;

Architecture arch1 OF muxGeneric is 
Begin
	PROCESS(input, enable)
		VARIABLE x : integer;
	BEGIN
		x := to_integer(unsigned(s));
		output <= '0';
		IF enable = '1' THEN
			output <= input(x);
		END IF;
	END PROCESS;
End arch1;