# Compile of mux4x1.vhd was successful.
# Compile of muxGeneric.vhd was successful.
# Compile of partA.vhd was successful.
# Compile of partB.vhd was successful.
# Compile of partC.vhd was successful.
# Compile of partD.vhd was successful.
# Compile of ram.vhd was successful.
# Compile of register.vhd was successful.
# Compile of rom.vhd was successful.
# Compile of tristate_buffer.vhd was successful.
# Compile of mux5x1.vhd was successful.
# Compile of DFlipFlop.vhd was successful.
# 19 compiles, 0 failed with no errors.
vsim -gui work.registerfile
# vsim -gui work.registerfile 
# Start time: 22:48:54 on Dec 16,2017
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.registerfile(structuralmodel)
# Loading work.dflipflop(structuralmodel)
# Loading work.decoder(structuralmodel)
# Loading work.mux2x1(arch1)
# Loading work.registergeneric(structuralmodel)
# Loading work.tristate_buffer(structuralmodel)
# Loading work.muxgeneric(arch1)
# Loading work.alu(struct)
# Loading work.parta(struct)
# Loading work.fulladder(struct)
# Loading work.adder(struct)
# Loading work.mux4x1(arch1)
# Loading work.partb(struct)
# Loading work.partc(struct)
# Loading work.partd(struct)
# Loading work.ram(syncrama)
# Loading work.rom(arch1)
# Loading work.mux5x1(arch1)
mem load -i {D:/Projects/Arch Proj/ram.mem} /registerfile/u49/ram
add wave -position insertpoint  \
sim:/registerfile/oscillator \
sim:/registerfile/clkRam
add wave -position insertpoint  \
sim:/registerfile/PC \
sim:/registerfile/MAR \
sim:/registerfile/MDR
add wave -position insertpoint  \
sim:/registerfile/IR
add wave -position insertpoint  \
sim:/registerfile/clk
add wave -position insertpoint  \
sim:/registerfile/romAddress
add wave -position insertpoint  \
sim:/registerfile/NextRomAddressSel
add wave -position insertpoint  \
sim:/registerfile/MFC
add wave -position insertpoint  \
sim:/registerfile/HLT
add wave -position insertpoint  \
sim:/registerfile/MFCDelayed
add wave -position insertpoint  \
sim:/registerfile/RamOut
add wave -position insertpoint  \
sim:/registerfile/RamWriteEnable
add wave -position insertpoint  \
sim:/registerfile/MDRWriteEnable
add wave -position insertpoint  \
sim:/registerfile/SP
add wave -position insertpoint  \
sim:/registerfile/R0
add wave -position insertpoint  \
sim:/registerfile/R1
add wave -position insertpoint  \
sim:/registerfile/R2
add wave -position insertpoint  \
sim:/registerfile/R3
add wave -position insertpoint  \
sim:/registerfile/NextRomAddress
add wave -position insertpoint  \
sim:/registerfile/WMFC
add wave -position insertpoint  \
sim:/registerfile/WMFCDelayed
add wave -position insertpoint  \
sim:/registerfile/TMP
add wave -position insertpoint  \
sim:/registerfile/BranchCondition
force -freeze sim:/registerfile/oscillator 1 0, 0 {50 ns} -r 100
force -freeze sim:/registerfile/clkRam 1 0, 0 {70 ns} -r 140
add wave -position insertpoint  \
sim:/registerfile/rst
add wave -position insertpoint  \
sim:/registerfile/FLAG
add wave -position insertpoint  \
sim:/registerfile/BranchMuxSel
add wave -position insertpoint  \
sim:/registerfile/BRCond
add wave -position insertpoint  \
sim:/registerfile/BranchConditionBit
add wave -position insertpoint  \
sim:/registerfile/CarryOut
add wave -position insertpoint  \
sim:/registerfile/FLAGInput
add wave -position insertpoint  \
sim:/registerfile/WordMode

force -freeze sim:/registerfile/rst 1 0
run
run
force -freeze sim:/registerfile/rst 0 0
run
run
run
run
run


run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run