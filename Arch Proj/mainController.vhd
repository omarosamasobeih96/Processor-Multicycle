LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY RegisterFile IS
	Generic (n : integer :=32);
	port (oscillator, clkRam : in std_logic);
	Signal BusC, BusA, BusB : std_logic_vector(n-1 downto 0);
	Signal EnSrcB, EnSrcC, EnDstC, EnDstA : std_logic_vector(15 downto 0);
	Signal R0Input, R1Input, R2Input, R3Input, R4Input, PcInput, SPInput, MARInput, MDRInput, IRInput, FLAGInput, TMPInput : std_logic_vector(31 downto 0);
	Signal R0, R1, R2, R3, PC, SP, MAR, MDR, IR, FLAG, TMP, RamOut : std_logic_vector(31 downto 0);
	Signal RegisterEnable : std_logic_vector(15 downto 0);
	Signal MuxEnable, DecoderEnable, clk, clkInverted, oscillatorInverted, MDRRamSel : std_logic;
	--ALU Signals
	Signal CarryOut, CarryIn, FlagRegisterEnable : std_logic;
	-- tmp signals
	Signal MDRIn, BranchCondition : std_logic_vector(31 downto 0);
	Signal MDRWriteEnable, BranchConditionBit, d1Enable, MDRSel, MFCFlipFlopInput, RamWriteEnableFlipFlopInput, WMFCFlipFlopInput : std_logic;
	Signal BranchMuxSel : std_logic_vector(2 downto 0);
	Signal BRCond : std_logic_vector(7 downto 0);
	Signal d1, d2, d3, d4, d5, d6, d7, d8, GeneralRegSel, GeneralRegDstEN, GeneralRegSrcBEN, GeneralRegSrcCEN : std_logic_vector(3 downto 0);
	Signal ChangeFlag : std_logic;
	--Control Signals
	Signal Ain, Bout, Cin, Cout, ALUOperation : std_logic_vector(3 downto 0);
	Signal rst, RamWriteEnable, SetCarry, NeedCarry, DestinationWrite, MFC, HLT, WMFC, WMFCDelayed, MFCDelayed, RamWriteEnableDelayed, WordMode : std_logic;	
	Signal NextRomAddressSel : std_logic_vector(2 downto 0);
	--ROM Addresses
	CONSTANT FetchSrcRegMode : std_logic_vector(5 downto 0) := "011111";
	CONSTANT FetchSrcAutoInc : std_logic_vector(5 downto 0) := "100000";
	CONSTANT FetchSrcAutoDec : std_logic_vector(5 downto 0) := "100010";
	CONSTANT FetchSrcOffset : std_logic_vector(5 downto 0) := "100100";
	CONSTANT FetchDstRegMode : std_logic_vector(5 downto 0) := "100111";
	CONSTANT FetchDstAutoInc : std_logic_vector(5 downto 0) := "101000";
	CONSTANT FetchDstAutoDec : std_logic_vector(5 downto 0) := "101001";
	CONSTANT FetchDstOffset : std_logic_vector(5 downto 0) := "101011";
	CONSTANT FetchAndDecode : std_logic_vector(5 downto 0) := "101101";
	CONSTANT Branching : std_logic_vector(5 downto 0) := "101111"; 
	CONSTANT FullAdder2ndOp : std_logic_vector(5 downto 0) := "000000";
	CONSTANT FullAdderCin : std_logic  := '1';
	CONSTANT RomRegisterEnable : std_logic := '1';
	CONSTANT RomRegisterReset : std_logic := '0';
		--ROM Signals
	Signal romAddress, FetchSrcAddress, FetchDstAddress, ExecuteAddress, NextRomAddress, IncrementedRomAddress : std_logic_vector(5 downto 0);
	Signal FullAdderCout : std_logic;
		--Initialization
	CONSTANT RegInitInput : std_logic_vector(31 downto 0) := (others => '0');
	CONSTANT RomRegInitInput : std_logic_vector(5 downto 0) := (others => '0');
	CONSTANT SPInitialInput : std_logic_vector(31 downto 0) := x"00000700";
END RegisterFile;

ARCHITECTURE StructuralModel OF RegisterFile IS
BEGIN
	MFCFlipFlopInput <= MFC OR (DestinationWrite AND (IR(2) OR IR(3)));
	RamWriteEnableFlipFlopInput <= RamWriteEnable OR (DestinationWrite AND (IR(2) OR IR(3)));
	q1: entity work.DFlipFlop PORT MAP(MFCFlipFlopInput, rst, clk, MFCDelayed);
	q2: entity work.DFlipFlop PORT MAP(RamWriteEnableFlipFlopInput, rst, clk, RamWriteEnableDelayed);
	WMFCFlipFlopInput <= (WMFC OR (DestinationWrite AND (IR(2) OR IR(3)))) AND (NOT MFC);
	q3: entity work.DFlipFlop PORT MAP(WMFCFlipFlopInput, rst, oscillator, WMFCDelayed);
	clk <= oscillator AND (NOT HLT) AND (NOT WMFCDelayed);
	clkInverted <= NOT clk;
	oscillatorInverted <= NOT oscillator;
	MuxEnable <= '1';
	FlagRegisterEnable <= '1';
	DecoderEnable <= '1';
	RegisterEnable <= EnDstC OR EnDstA;

	-- mapping the src/dst decoders
	u0: entity work.decoder GENERIC MAP(n => 4) PORT MAP(Ain, DecoderEnable, EnDstA);
	u1: entity work.decoder GENERIC MAP(n => 4) PORT MAP(Bout, DecoderEnable, EnSrcB);
	u2: entity work.decoder GENERIC MAP(n => 4) PORT MAP(Cin, DecoderEnable, EnDstC);
	u3: entity work.decoder GENERIC MAP(n => 4) PORT MAP(Cout, DecoderEnable, EnSrcC);
	
	--decoder mapping
	d1Enable <= (DestinationWrite AND NOT (IR(2) OR IR(3))) OR ENDstA(0);
	s0: entity work.decoder GENERIC MAP(n => 2) PORT MAP(IR(1 downto 0), d1Enable, d1);
	s1: entity work.decoder GENERIC MAP(n => 2) PORT MAP(IR(5 downto 4), ENDstA(1), d2);
	s2: entity work.decoder GENERIC MAP(n => 2) PORT MAP(IR(1 downto 0), ENDstC(0), d3);
	s3: entity work.decoder GENERIC MAP(n => 2) PORT MAP(IR(5 downto 4), ENDstC(1), d4);
	s4: entity work.decoder GENERIC MAP(n => 2) PORT MAP(IR(1 downto 0), ENSrcB(0), d5);
	s5: entity work.decoder GENERIC MAP(n => 2) PORT MAP(IR(5 downto 4), ENSrcB(1), d6);
	s6: entity work.decoder GENERIC MAP(n => 2) PORT MAP(IR(1 downto 0), ENSrcC(0), d7);
	s7: entity work.decoder GENERIC MAP(n => 2) PORT MAP(IR(5 downto 4), ENSrcC(1), d8);
	
	GeneralRegSel <= d1 OR d2;
	GeneralRegDstEn <= d1 OR d2 OR d3 or d4;
	GeneralRegSrcBEn <= d5 OR d6;
	GeneralRegSrcCEn <= d7 OR d8;

	-- by default choosing Bus C to out
	-- port mapping for register R0
	u4: entity work.mux2x1 GENERIC MAP(n => n) PORT MAP(BusC, BusA, MuxEnable, GeneralRegSel(0), R0Input);
	u5: entity work.RegisterGeneric GENERIC MAP(n => n) PORT MAP(R0Input, RegInitInput, rst, GeneralRegDstEn(0), clk, R0);
	u6: entity work.tristate_buffer PORT MAP(R0, GeneralRegSrcBEn(0), BusB);
	u7: entity work.tristate_buffer PORT MAP(R0, GeneralRegSrcCEn(0), BusC);
	-- port mapping for register R1
	u8: entity work.mux2x1 GENERIC MAP(n => n) PORT MAP(BusC, BusA, MuxEnable, GeneralRegSel(1), R1Input);
	u9: entity work.RegisterGeneric GENERIC MAP(n => n) PORT MAP(R1Input, RegInitInput, rst, GeneralRegDstEn(1), clk, R1);
	u10: entity work.tristate_buffer PORT MAP(R1, GeneralRegSrcBEn(1), BusB);
	u11: entity work.tristate_buffer PORT MAP(R1, GeneralRegSrcCEn(1), BusC);
	-- port mapping for register R2
	u12: entity work.mux2x1 GENERIC MAP(n => n) PORT MAP(BusC, BusA, MuxEnable, GeneralRegSel(2), R2Input);
	u13: entity work.RegisterGeneric GENERIC MAP(n => n) PORT MAP(R2Input, RegInitInput, rst, GeneralRegDstEn(2), clk, R2);
	u14: entity work.tristate_buffer PORT MAP(R2, GeneralRegSrcBEn(2), BusB);
	u15: entity work.tristate_buffer PORT MAP(R2, GeneralRegSrcCEn(2), BusC);
	-- port mapping for register R3
	u16: entity work.mux2x1 GENERIC MAP(n => n) PORT MAP(BusC, BusA, MuxEnable, GeneralRegSel(3), R3Input);
	u17: entity work.RegisterGeneric GENERIC MAP(n => n) PORT MAP(R3Input, RegInitInput, rst, GeneralRegDstEn(3), clk, R3);
	u18: entity work.tristate_buffer PORT MAP(R3, GeneralRegSrcBEn(3), BusB);
	u19: entity work.tristate_buffer PORT MAP(R3, GeneralRegSrcCEn(3), BusC);
	-- port mapping for register PC
	u20: entity work.mux2x1 GENERIC MAP(n => n) PORT MAP(BusC, BusA, MuxEnable, EnDstA(2), PcInput);
	u21: entity work.RegisterGeneric GENERIC MAP(n => n) PORT MAP(PcInput, RegInitInput, rst, RegisterEnable(2), clk, PC);
	u22: entity work.tristate_buffer PORT MAP(PC, EnSrcB(2), BusB);
	u23: entity work.tristate_buffer PORT MAP(PC, EnSrcC(2), BusC);
	-- port mapping for register SP
	u24: entity work.mux2x1 GENERIC MAP(n => n) PORT MAP(BusC, BusA, MuxEnable, EnDstA(3), SPInput);
	u25: entity work.RegisterGeneric GENERIC MAP(n => n) PORT MAP(SPInput, SPInitialInput, rst, RegisterEnable(3), clk, SP);
	u26: entity work.tristate_buffer PORT MAP(SP, EnSrcB(3), BusB);
	u27: entity work.tristate_buffer PORT MAP(SP, EnSrcC(3), BusC);
		-- port mapping for register MAR
	u28: entity work.mux2x1 GENERIC MAP(n => n) PORT MAP(BusC, BusA, MuxEnable, EnDstA(5), MARInput);
	u29: entity work.RegisterGeneric GENERIC MAP(n => n) PORT MAP(MARInput, RegInitInput, rst, RegisterEnable(5), clk, MAR);
	u30: entity work.tristate_buffer PORT MAP(MAR, EnSrcB(5), BusB);
	u31: entity work.tristate_buffer PORT MAP(MAR, EnSrcC(5), BusC);
		-- port mapping for register MDR
	MDRSel <= EnDstA(6) OR (DestinationWrite AND (IR(2) OR IR(3)));
	MDRWriteEnable <= (RegisterEnable(6) OR (DestinationWrite AND (IR(2) OR IR(3)))) OR MFC;
	MDRRamSel <= MFC AND (NOT RamWriteEnableDelayed);
	m1: entity work.mux2x1 GENERIC MAP(n => n) PORT MAP(MDRIn, RamOut, MuxEnable, MDRRamSel, MDRInput);
	u32: entity work.mux2x1 GENERIC MAP(n => n) PORT MAP(BusC, BusA, MuxEnable, MDRSel, MDRIn);
	u33: entity work.RegisterGeneric GENERIC MAP(n => n) PORT MAP(MDRInput, RegInitInput, rst, MDRWriteEnable, oscillator, MDR);
	u34: entity work.tristate_buffer PORT MAP(MDR, EnSrcB(6), BusB);
	u35: entity work.tristate_buffer PORT MAP(MDR, EnSrcC(6), BusC);
	-- port mapping for register IR
	u36: entity work.mux2x1 GENERIC MAP(n => n) PORT MAP(BusC, BusA, MuxEnable, EnDstA(4), IRInput);
	u37: entity work.RegisterGeneric GENERIC MAP(n => n) PORT MAP(IRInput, RegInitInput, rst, RegisterEnable(4), clk, IR);
	u38: entity work.tristate_buffer PORT MAP(IR, EnSrcB(4), BusB);
	u39: entity work.tristate_buffer PORT MAP(IR, EnSrcC(4), BusC);

		-- port mapping for register FLAG
	ChangeFlag <= '1' when (romAddress = "011000") or ( romAddress(5) = '0' and ( romAddress(4) =  '0' or ( romAddress(4) =  '1' and romAddress(3) =  '0') ) )
	else '0';
	FLAGInput(31 downto 2) <= (others => '0');
	FLAGInput(0) <= CarryOut when ChangeFlag  = '1';
	FLAGInput(1) <= '1' when(to_integer(unsigned(Ain)) = 0) and ChangeFlag = '1'
	else '0' when ChangeFlag = '1';
	u40: entity work.RegisterGeneric GENERIC MAP(n => n) PORT MAP(FLAGInput, RegInitInput, rst, FlagRegisterEnable, clk, FLAG);
	--Branches Condition
	BRCond(0) <= '1';				--BR
	BRCond(1) <= FLAG(1);				--BEQ
	BRCond(2) <= NOT FLAG(1);			--BNE
	BRCond(3) <= NOT FLAG(0);			--BLO
	BRCond(4) <= (NOT FLAG(0)) OR FLAG(1);		--BLS
	BRCond(5) <= FLAG(0);				--BHI
	BRCond(6) <= FLAG(0) OR FLAG(1);		--BHS	
	BRCond(7) <= '0';
	BranchMuxSel <= IR(10 downto 8);
	u41: entity work.mux8x1 PORT MAP(BRCond, BranchMuxSel, BranchConditionBit);
	BranchCondition <= (others => BranchConditionBit);	
	u42: entity work.tristate_buffer PORT MAP(BranchCondition, EnSrcB(7), BusB);
	u43: entity work.tristate_buffer PORT MAP(BranchCondition, EnSrcC(7), BusC);
		-- port mapping for register TMP
	u44: entity work.mux2x1 GENERIC MAP(n => n) PORT MAP(BusC, BusA, MuxEnable, EnDstA(8), TMPInput);
	u45: entity work.RegisterGeneric GENERIC MAP(n => n) PORT MAP(TMPInput, RegInitInput, rst, RegisterEnable(8), clk, TMP);
	u46: entity work.tristate_buffer PORT MAP(TMP, EnSrcB(8), BusB);
	u47: entity work.tristate_buffer PORT MAP(TMP, EnSrcC(8), BusC);
		--ALU Port Mapping
	CarryIn <= SetCarry OR (FLAG(0) AND NeedCarry);
	u48: entity work.ALU GENERIC MAP(N => 32) PORT MAP(BusB, BusC, ALUOperation, CarryIn, BusA, CarryOut);
		--Ram Port Mapping
	u49: entity work.ram PORT MAP(clkRam, RamWriteEnableDelayed, MFC, WMFCDelayed, WordMode, MAR(10 downto 0), MDR, RamOut);
		--Rom Port Mapping
	mm1: entity work.fullAdder GENERIC MAP(N => 6) PORT MAP(romAddress, FullAdder2ndOp, FullAdderCin, IncrementedRomAddress, FullAdderCout); 
	u50: entity work.rom PORT MAP(romAddress, Ain, Bout, Cin, Cout, ALUOperation, rst, RamWriteEnable, SetCarry, NeedCarry, DestinationWrite, WMFC, HLT, WordMode, NextRomAddressSel);
	u51: entity work.mux4x1 GENERIC MAP(n => 6) PORT MAP(FetchSrcRegMode, FetchSrcAutoInc, FetchSrcAutoDec, FetchSrcOffset, IR(7 downto 6), FetchSrcAddress);
	u52: entity work.mux4x1 GENERIC MAP(n => 6) PORT MAP(FetchDstRegMode, FetchDstAutoInc, FetchDstAutoDec, FetchDstOffset, IR(3 downto 2), FetchDstAddress);
	u53: entity work.mux4x1 GENERIC MAP(n => 6) PORT MAP(FetchSrcAddress, FetchDstAddress, Branching, IR(13 downto 8), IR(15 downto 14), ExecuteAddress);
	u54: entity work.mux5x1 GENERIC MAP(n => 6) PORT MAP(IncrementedRomAddress, ExecuteAddress, FetchDstAddress, IR(13 downto 8), FetchAndDecode, NextRomAddressSel, NextRomAddress);
	u55: entity work.RegisterGeneric GENERIC MAP(n => 6) PORT MAP(NextRomAddress, RomRegInitInput, RomRegisterReset, RomRegisterEnable, clkInverted, romAddress);

	process(rst)
		BEGIN
		IF rst = '1' THEN
			NextRomAddressSel <= "100";
			Ain <= (others => '1');
			Bout <= (others => '1');
			Cin <= (others => '1');
			Cout <= (others => '1');
			ALUOperation <= (others => '1');
			RamWriteEnable <= '0';
			SetCarry <= '0';
			NeedCarry <= '0';
			DestinationWrite <= '0';
			MFC <= '0';
			HLT <= '0';
			MFCDelayed <= '0';
			RamWriteEnableDelayed <= '0';
			BranchMuxSel <= (others => '0');
		ELSE
			NextRomAddressSel <= (others => 'Z');
			Ain <= (others => 'Z');
			Bout <= (others => 'Z');
			Cin <= (others => 'Z');
			Cout <= (others => 'Z');
			ALUOperation <= (others => 'Z');
			RamWriteEnable <= 'Z';
			SetCarry <= 'Z';
			NeedCarry <= 'Z';
			DestinationWrite <= 'Z';
			MFC <= 'Z';
			HLT <= 'Z';
			MFCDelayed <= 'Z';
			RamWriteEnableDelayed <= 'Z';
			BranchMuxSel <= (others => 'Z');
		END IF;
	END PROCESS;
END StructuralModel;


