LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY testbench IS
END testbench;

ARCHITECTURE testbench_a OF testbench IS
	SIGNAL  RomAddress :  std_logic_vector (2 downto 0);
	SIGNAL Clk, ClkRam, Rst :  std_logic;
	SIGNAL InternalBus :  std_logic_vector (31 downto 0);

        CONSTANT timestep : time :=10 ps;
	CONSTANT InternalBusZERO :  std_logic_vector (31 downto 0) := (others =>'0');
	
	BEGIN

	ux: entity work.RegisterFile port map ( RomAddress, Clk, Rst, ClkRam, InternalBus );

        -- Generate the clock signal
	PROCESS
	Begin
		Clk <= '0';
		wait for timestep;
		Clk <= '1';
		wait for timestep;
	end process;

	PROCESS
	Begin
		ClkRam <= '1';
		wait for timestep;
		ClkRam <= '0';
		wait for timestep;
	end process;

	-- Create Test Cases
	PROCESS
		BEGIN
				-- Test Case 0, Reset All registers and try register ax value
			Rst <= '1';
			RomAddress <= (others => '0');
			InternalBus <= (others => 'Z');
			WAIT FOR 4*timestep;
			
				-- Lower the reset signal
			InternalBus <= (others => 'Z');
			Rst <= '0';	

			RomAddress <= (others => '0');
			InternalBus <= x"00000002";
			WAIT FOR 4*timestep;

			RomAddress <= "001";
			InternalBus <= x"00009999";
			WAIT FOR 4*timestep;

			RomAddress <= "010";
			InternalBus <= x"00000005";
			WAIT FOR 4*timestep;


			RomAddress <= "011";
			InternalBus <= (others => 'Z');
			WAIT FOR 4*timestep;

			RomAddress <= "100";
			InternalBus <= x"00000002";
			WAIT FOR 4*timestep;


			RomAddress <= "101";
			InternalBus <= (others => 'Z');
			WAIT FOR 4*timestep;

			WAIT;
	END PROCESS;		
END testbench_a;
