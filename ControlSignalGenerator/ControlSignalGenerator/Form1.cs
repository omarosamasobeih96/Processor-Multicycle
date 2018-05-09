using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace ControlSignalGenerator {

	
	public partial class Form1 : Form {

		public class MICROINSTRUCTTION : Form {
			public bool csNC, csRST, csWMFC, csRW, csSETC, csHLT, csNxt0, csNxt1, csNxt2, csX;
			public int csALU, csBusAin, csBusBout, csBusCin, csBusCout;
			public MICROINSTRUCTTION() {
				csALU = csBusAin = csBusBout = csBusCin = csBusCout = 0;
				csRW = csSETC = csWMFC = csNC = csX = false;
				csRST = csHLT = csNxt0 = csNxt1 = csNxt2 = false;
			}
		}

		List<MICROINSTRUCTTION> microInstructions;
		List<string> microInstructionsOut;
		public Form1() {
			InitializeComponent();
			microInstructions = new List<MICROINSTRUCTTION>();
			microInstructionsOut = new List<string>();
		}

		private void checkBox1_CheckedChanged(object sender, EventArgs e) {

		}

		private bool check_binary(string bin) {
			for (int i = 0; i < bin.Length; ++i)
				if (bin[i] != '0' && bin[i] != '1') return false;
			return bin.Length == 6;
		}
		
		private char zo(bool flag) {
			int i = flag ? 1 : 0;
			return "01"[i];
		}

		private string getBin(int x) {
			if (x == -1) return "1111";
			string[] bin = {"0000", "0001", "0010", "0011", "0100", "0101", "0110"
			, "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111"};
			return bin[x];
		}

		private string instructionToBin(MICROINSTRUCTTION x) {
			return getBin(x.csALU) + getBin(x.csBusAin) + getBin(x.csBusBout)
				+ getBin(x.csBusCin) + getBin(x.csBusCout) + zo(x.csRST)
				+ zo(x.csRW) + zo(x.csSETC) + zo(x.csWMFC) + zo(x.csNC) + zo(x.csX)
				+ zo(x.csHLT) + zo(x.csNxt2) + zo(x.csNxt1) + zo(x.csNxt0);			
		}

		private void Microprogram_SelectedIndexChanged(object sender, EventArgs e) {
			MICROINSTRUCTTION instruction = microInstructions.ElementAt(Microprogram.SelectedIndex);
			NC.Checked = instruction.csNC;
			RST.Checked = instruction.csRST;
			WMFC.Checked = instruction.csWMFC;
			RW.Checked = instruction.csRW;
			SETC.Checked = instruction.csSETC;
			HLT.Checked = instruction.csHLT;
			X.Checked = instruction.csX;
			ALU.SelectedIndex = instruction.csALU;
			BusAin.SelectedIndex = instruction.csBusAin;
			BusBout.SelectedIndex = instruction.csBusBout;
			BusCin.SelectedIndex = instruction.csBusCin;
			BusCout.SelectedIndex = instruction.csBusCout;
			NXT.SelectedIndex = Convert.ToInt32(instruction.csNxt0) + Convert.ToInt32(instruction.csNxt1) * 2 + Convert.ToInt32(instruction.csNxt2) * 4;
		}

		private MICROINSTRUCTTION getInstruction() {
			MICROINSTRUCTTION instruction = new MICROINSTRUCTTION();
			instruction.csNC = NC.Checked;
			instruction.csRST = RST.Checked;
			instruction.csWMFC = WMFC.Checked;
			instruction.csRW = RW.Checked;
			instruction.csSETC = SETC.Checked;
			instruction.csHLT = HLT.Checked;
			instruction.csX = X.Checked;
			instruction.csALU = ALU.SelectedIndex;
			instruction.csBusAin = BusAin.SelectedIndex;
			instruction.csBusBout = BusBout.SelectedIndex;
			instruction.csBusCin = BusCin.SelectedIndex;
			instruction.csBusCout = BusCout.SelectedIndex;
			if (NXT.SelectedIndex == -1) NXT.SelectedIndex = 0;
			instruction.csNxt0 = (NXT.SelectedIndex & 1) > 0;
			instruction.csNxt1 = (NXT.SelectedIndex & 2) > 0;
			instruction.csNxt2 = (NXT.SelectedIndex & 4) > 0;
			return instruction;
		}

		private void clearCurrentInst() {
			NC.Checked = false;
			RST.Checked = false;
			HLT.Checked = false;
			WMFC.Checked = false;
			RW.Checked = false;
			SETC.Checked = false;
			X.Checked = false;
			NXT.SelectedIndex = 0;
			ALU.SelectedIndex = -1;
			BusAin.SelectedIndex = -1;
			BusBout.SelectedIndex = -1;
			BusCin.SelectedIndex = -1;
			BusCout.SelectedIndex = -1;
		}

		private string parseInstruction(MICROINSTRUCTTION instruction) {
			string inst = "";
			bool spc = false;
			if (instruction.csBusBout != -1) { inst += (spc ? "   " : "") + BusBout.Text + "-Bout"; spc = true; }
			if (instruction.csBusCout != -1) { inst += (spc ? "   " : "") + BusCout.Text + "-Cout"; spc = true; }
			if (instruction.csBusCin != -1) { inst += (spc ? "   " : "") + BusCin.Text + "-Cin"; spc = true; }
			if (instruction.csNC) { inst += (spc ? "   " : "") + "NC"; spc = true; }
			if (instruction.csWMFC) { inst += (spc ? "   " : "") + (instruction.csRW ? "Wr" : "Rd") + "   WMFC"; spc = true; }
			if (instruction.csSETC) { inst += (spc ? "   " : "") + "SETC"; spc = true; }
			if (instruction.csALU != -1) { inst += (spc ? "   " : "") + ALU.Text; spc = true; }
			if (instruction.csBusAin != -1) { inst += (spc ? "   " : "") + BusAin.Text + "-Ain"; spc = true; }
			if (instruction.csRST) { inst += (spc ? "   " : "") + "RST"; spc = true; }
			if (instruction.csX) { inst += (spc ? "   " : "") + "X"; spc = true; }
			if (instruction.csNxt1 || instruction.csNxt0 || instruction.csNxt2) { inst += (spc ? "   " : "") + NXT.Text; spc = true; }
			if (instruction.csHLT) { inst += (spc ? "   " : "") + "HLT"; spc = true; }
			return inst;
		}

		private void Add_Click(object sender, EventArgs e) {
			MICROINSTRUCTTION instruction = getInstruction();
			string inst = parseInstruction(instruction);
			Microprogram.Items.Add(inst);
			microInstructions.Add(instruction);
			microInstructionsOut.Add(inst);
			clearCurrentInst();
		}

		private void Save_Click(object sender, EventArgs e) {
			string binaryOpcode = opcode.Text;

			if (check_binary(binaryOpcode) == false) {
				MessageBox.Show("invalid opcode, should be binary length = 6");
				return;
			}

			string comment = "# " + AssmbInst.Text;
			string IR = "$ " + binaryOpcode;

			try {
				string newFile = "";
				using (StreamReader sr = new StreamReader("CS.txt")) {
					newFile += sr.ReadToEnd() + "\n";
				}
				newFile += IR + "\n" + comment + "\n";
				foreach(MICROINSTRUCTTION instruction in microInstructions) {
					newFile += instructionToBin(instruction) + "\n";
				}
				System.IO.File.WriteAllText("CS.txt", newFile);
			}
			catch (Exception exp) {
				Console.WriteLine("The file could not be read:");
				Console.WriteLine(exp.Message);
			}
			try {
				string newFile = "";
				using (StreamReader sr = new StreamReader("MicroPrograms.txt")) {
					newFile += sr.ReadToEnd() + "\n";
				}
				newFile += IR + "\n" + comment + "\n";
				foreach (string instruction in microInstructionsOut) {
					newFile += instruction + "\n";
				}
				System.IO.File.WriteAllText("MicroPrograms.txt", newFile);
			}
			catch (Exception exp) {
				Console.WriteLine("The file could not be read:");
				Console.WriteLine(exp.Message);
			}
			microInstructions.Clear();
			microInstructionsOut.Clear();
			while (Microprogram.Items.Count > 0)
				Microprogram.Items.RemoveAt(Microprogram.Items.Count - 1);
			clearCurrentInst();
		}
		
		private void Remove_Click(object sender, EventArgs e) {
			if (Microprogram.SelectedIndex == -1)
				Microprogram.SelectedIndex = Microprogram.Items.Count - 1;
			microInstructions.RemoveAt(Microprogram.SelectedIndex);
			microInstructionsOut.RemoveAt(Microprogram.SelectedIndex);
			Microprogram.Items.RemoveAt(Microprogram.SelectedIndex);
			clearCurrentInst();
		}

		private void Form1_Load(object sender, EventArgs e) {

		}

		private void NewMicro_Click(object sender, EventArgs e) {
			microInstructions.Clear();
			microInstructionsOut.Clear();
			while(Microprogram.Items.Count > 0)
				Microprogram.Items.RemoveAt(Microprogram.Items.Count - 1);
			opcode.Text = "";
			AssmbInst.Text = "";
			clearCurrentInst();
		}
	}
}
