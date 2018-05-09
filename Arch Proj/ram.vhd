LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ram IS
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		MFC : OUT std_logic;
		WMFC : IN std_logic;
		WordMode : IN std_logic;
		address : IN  std_logic_vector(10 DOWNTO 0);
		datain  : IN  std_logic_vector(31 DOWNTO 0);
		dataout : OUT std_logic_vector(31 DOWNTO 0));
END ENTITY ram;

ARCHITECTURE syncrama OF ram IS

	TYPE ram_type IS ARRAY(0 TO 2047) OF std_logic_vector(15 DOWNTO 0);
	SIGNAL ram : ram_type ;
	BEGIN
	PROCESS(clk, WMFC) IS
		BEGIN
		IF rising_edge(WMFC) THEN
			MFC <= '0';
		ELSIF WMFC = '1' AND rising_edge(clk) THEN  
			IF WordMode = '1' THEN
				IF we = '1' THEN
					ram(to_integer(unsigned(address))) <= datain(15 downto 0);
				END IF;
				dataout(15 downto 0) <= ram(to_integer(unsigned(address)));
				dataout(31 downto 16) <= (others => '0');
			ELSE
				IF we = '1' THEN
					ram(to_integer(unsigned(address))) <= datain(31 downto 16);
					ram(to_integer(unsigned(address)) + 1) <= datain(15 downto 0);
				END IF;
				dataout(31 downto 16) <= ram(to_integer(unsigned(address)));
				dataout(15 downto 0) <= ram(to_integer(unsigned(address)) + 1);
			END IF;
			IF WMFC = '1' THEN
				MFC <= '1';
			END IF;
		ELSIF WMFC = '0' THEN
			MFC <= '0';
		END IF;
	END PROCESS;
END syncrama;
