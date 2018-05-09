namespace ControlSignalGenerator {
	partial class Form1 {
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing) {
			if (disposing && (components != null)) {
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent() {
			this.RST = new System.Windows.Forms.CheckBox();
			this.WMFC = new System.Windows.Forms.CheckBox();
			this.RW = new System.Windows.Forms.CheckBox();
			this.ALU = new System.Windows.Forms.ComboBox();
			this.SETC = new System.Windows.Forms.CheckBox();
			this.BusAin = new System.Windows.Forms.ComboBox();
			this.BusBout = new System.Windows.Forms.ComboBox();
			this.BusCin = new System.Windows.Forms.ComboBox();
			this.BusCout = new System.Windows.Forms.ComboBox();
			this.Add = new System.Windows.Forms.Button();
			this.Save = new System.Windows.Forms.Button();
			this.Microprogram = new System.Windows.Forms.ListBox();
			this.labelAin = new System.Windows.Forms.Label();
			this.labelBout = new System.Windows.Forms.Label();
			this.labelCout = new System.Windows.Forms.Label();
			this.labelCin = new System.Windows.Forms.Label();
			this.labelMicroprogram = new System.Windows.Forms.Label();
			this.Remove = new System.Windows.Forms.Button();
			this.AssmbInst = new System.Windows.Forms.TextBox();
			this.opcode = new System.Windows.Forms.TextBox();
			this.labelOpcode = new System.Windows.Forms.Label();
			this.labelInst = new System.Windows.Forms.Label();
			this.NewMicro = new System.Windows.Forms.Button();
			this.HLT = new System.Windows.Forms.CheckBox();
			this.labelALU = new System.Windows.Forms.Label();
			this.NC = new System.Windows.Forms.CheckBox();
			this.NXT = new System.Windows.Forms.ComboBox();
			this.labelNxt = new System.Windows.Forms.Label();
			this.X = new System.Windows.Forms.CheckBox();
			this.SuspendLayout();
			// 
			// RST
			// 
			this.RST.AutoSize = true;
			this.RST.Location = new System.Drawing.Point(96, 155);
			this.RST.Name = "RST";
			this.RST.Size = new System.Drawing.Size(55, 21);
			this.RST.TabIndex = 0;
			this.RST.Text = "RST";
			this.RST.UseVisualStyleBackColor = true;
			this.RST.CheckedChanged += new System.EventHandler(this.checkBox1_CheckedChanged);
			// 
			// WMFC
			// 
			this.WMFC.AutoSize = true;
			this.WMFC.Location = new System.Drawing.Point(157, 155);
			this.WMFC.Name = "WMFC";
			this.WMFC.Size = new System.Drawing.Size(70, 21);
			this.WMFC.TabIndex = 2;
			this.WMFC.Text = "WMFC";
			this.WMFC.UseVisualStyleBackColor = true;
			// 
			// RW
			// 
			this.RW.AutoSize = true;
			this.RW.Location = new System.Drawing.Point(97, 183);
			this.RW.Name = "RW";
			this.RW.Size = new System.Drawing.Size(58, 21);
			this.RW.TabIndex = 3;
			this.RW.Text = "R/W";
			this.RW.UseVisualStyleBackColor = true;
			// 
			// ALU
			// 
			this.ALU.FormattingEnabled = true;
			this.ALU.Items.AddRange(new object[] {
            "INC",
            "ADD",
            "SUB",
            "DEC",
            "AND",
            "OR",
            "XOR",
            "NOTA",
            "LSR",
            "ROR",
            "RRC",
            "ASR",
            "LSL",
            "ROL",
            "RLC",
            "CLR"});
			this.ALU.Location = new System.Drawing.Point(636, 162);
			this.ALU.Name = "ALU";
			this.ALU.Size = new System.Drawing.Size(121, 24);
			this.ALU.TabIndex = 4;
			// 
			// SETC
			// 
			this.SETC.AutoSize = true;
			this.SETC.Location = new System.Drawing.Point(161, 183);
			this.SETC.Name = "SETC";
			this.SETC.Size = new System.Drawing.Size(63, 21);
			this.SETC.TabIndex = 5;
			this.SETC.Text = "SETC";
			this.SETC.UseVisualStyleBackColor = true;
			// 
			// BusAin
			// 
			this.BusAin.FormattingEnabled = true;
			this.BusAin.Items.AddRange(new object[] {
            "DST",
            "SRC",
            "PC",
            "SP",
            "IR",
            "MAR",
            "MDR",
            "FLAG",
            "TMP"});
			this.BusAin.Location = new System.Drawing.Point(99, 254);
			this.BusAin.Name = "BusAin";
			this.BusAin.Size = new System.Drawing.Size(121, 24);
			this.BusAin.TabIndex = 6;
			// 
			// BusBout
			// 
			this.BusBout.FormattingEnabled = true;
			this.BusBout.Items.AddRange(new object[] {
            "DST",
            "SRC",
            "PC",
            "SP",
            "IR",
            "MAR",
            "MDR",
            "FLAG",
            "TMP"});
			this.BusBout.Location = new System.Drawing.Point(275, 254);
			this.BusBout.Name = "BusBout";
			this.BusBout.Size = new System.Drawing.Size(121, 24);
			this.BusBout.TabIndex = 7;
			// 
			// BusCin
			// 
			this.BusCin.FormattingEnabled = true;
			this.BusCin.Items.AddRange(new object[] {
            "DST",
            "SRC",
            "PC",
            "SP",
            "IR",
            "MAR",
            "MDR",
            "FLAG",
            "TMP"});
			this.BusCin.Location = new System.Drawing.Point(636, 254);
			this.BusCin.Name = "BusCin";
			this.BusCin.Size = new System.Drawing.Size(121, 24);
			this.BusCin.TabIndex = 10;
			// 
			// BusCout
			// 
			this.BusCout.FormattingEnabled = true;
			this.BusCout.Items.AddRange(new object[] {
            "DST",
            "SRC",
            "PC",
            "SP",
            "IR",
            "MAR",
            "MDR",
            "FLAG",
            "TMP"});
			this.BusCout.Location = new System.Drawing.Point(460, 254);
			this.BusCout.Name = "BusCout";
			this.BusCout.Size = new System.Drawing.Size(121, 24);
			this.BusCout.TabIndex = 9;
			// 
			// Add
			// 
			this.Add.Location = new System.Drawing.Point(341, 345);
			this.Add.Name = "Add";
			this.Add.Size = new System.Drawing.Size(165, 23);
			this.Add.TabIndex = 11;
			this.Add.Text = "Add Instruction";
			this.Add.UseVisualStyleBackColor = true;
			this.Add.Click += new System.EventHandler(this.Add_Click);
			// 
			// Save
			// 
			this.Save.Location = new System.Drawing.Point(99, 345);
			this.Save.Name = "Save";
			this.Save.Size = new System.Drawing.Size(165, 23);
			this.Save.TabIndex = 12;
			this.Save.Text = "Save Microprogram";
			this.Save.UseVisualStyleBackColor = true;
			this.Save.Click += new System.EventHandler(this.Save_Click);
			// 
			// Microprogram
			// 
			this.Microprogram.FormattingEnabled = true;
			this.Microprogram.ItemHeight = 16;
			this.Microprogram.Location = new System.Drawing.Point(875, 45);
			this.Microprogram.Name = "Microprogram";
			this.Microprogram.Size = new System.Drawing.Size(651, 404);
			this.Microprogram.TabIndex = 13;
			this.Microprogram.SelectedIndexChanged += new System.EventHandler(this.Microprogram_SelectedIndexChanged);
			// 
			// labelAin
			// 
			this.labelAin.AutoSize = true;
			this.labelAin.Location = new System.Drawing.Point(96, 230);
			this.labelAin.Name = "labelAin";
			this.labelAin.Size = new System.Drawing.Size(16, 17);
			this.labelAin.TabIndex = 14;
			this.labelAin.Text = "A";
			// 
			// labelBout
			// 
			this.labelBout.AutoSize = true;
			this.labelBout.Location = new System.Drawing.Point(272, 230);
			this.labelBout.Name = "labelBout";
			this.labelBout.Size = new System.Drawing.Size(16, 17);
			this.labelBout.TabIndex = 15;
			this.labelBout.Text = "B";
			// 
			// labelCout
			// 
			this.labelCout.AutoSize = true;
			this.labelCout.Location = new System.Drawing.Point(457, 230);
			this.labelCout.Name = "labelCout";
			this.labelCout.Size = new System.Drawing.Size(42, 17);
			this.labelCout.TabIndex = 16;
			this.labelCout.Text = "C out";
			// 
			// labelCin
			// 
			this.labelCin.AutoSize = true;
			this.labelCin.Location = new System.Drawing.Point(633, 230);
			this.labelCin.Name = "labelCin";
			this.labelCin.Size = new System.Drawing.Size(31, 17);
			this.labelCin.TabIndex = 17;
			this.labelCin.Text = "C in";
			// 
			// labelMicroprogram
			// 
			this.labelMicroprogram.AutoSize = true;
			this.labelMicroprogram.Location = new System.Drawing.Point(872, 26);
			this.labelMicroprogram.Name = "labelMicroprogram";
			this.labelMicroprogram.Size = new System.Drawing.Size(93, 17);
			this.labelMicroprogram.TabIndex = 18;
			this.labelMicroprogram.Text = "Microprogram";
			// 
			// Remove
			// 
			this.Remove.Location = new System.Drawing.Point(592, 345);
			this.Remove.Name = "Remove";
			this.Remove.Size = new System.Drawing.Size(165, 23);
			this.Remove.TabIndex = 19;
			this.Remove.Text = "Remove Instruction";
			this.Remove.UseVisualStyleBackColor = true;
			this.Remove.Click += new System.EventHandler(this.Remove_Click);
			// 
			// AssmbInst
			// 
			this.AssmbInst.Location = new System.Drawing.Point(243, 68);
			this.AssmbInst.Name = "AssmbInst";
			this.AssmbInst.Size = new System.Drawing.Size(164, 24);
			this.AssmbInst.TabIndex = 20;
			// 
			// opcode
			// 
			this.opcode.Location = new System.Drawing.Point(593, 68);
			this.opcode.Name = "opcode";
			this.opcode.Size = new System.Drawing.Size(164, 24);
			this.opcode.TabIndex = 21;
			// 
			// labelOpcode
			// 
			this.labelOpcode.AutoSize = true;
			this.labelOpcode.Location = new System.Drawing.Point(491, 71);
			this.labelOpcode.Name = "labelOpcode";
			this.labelOpcode.Size = new System.Drawing.Size(96, 17);
			this.labelOpcode.TabIndex = 22;
			this.labelOpcode.Text = "binary opcode";
			// 
			// labelInst
			// 
			this.labelInst.AutoSize = true;
			this.labelInst.Location = new System.Drawing.Point(102, 71);
			this.labelInst.Name = "labelInst";
			this.labelInst.Size = new System.Drawing.Size(135, 17);
			this.labelInst.TabIndex = 23;
			this.labelInst.Text = "Assembly Instruction";
			// 
			// NewMicro
			// 
			this.NewMicro.Location = new System.Drawing.Point(99, 12);
			this.NewMicro.Name = "NewMicro";
			this.NewMicro.Size = new System.Drawing.Size(165, 23);
			this.NewMicro.TabIndex = 28;
			this.NewMicro.Text = "New Microprogram";
			this.NewMicro.UseVisualStyleBackColor = true;
			this.NewMicro.Click += new System.EventHandler(this.NewMicro_Click);
			// 
			// HLT
			// 
			this.HLT.AutoSize = true;
			this.HLT.Location = new System.Drawing.Point(233, 182);
			this.HLT.Name = "HLT";
			this.HLT.Size = new System.Drawing.Size(54, 21);
			this.HLT.TabIndex = 29;
			this.HLT.Text = "HLT";
			this.HLT.UseVisualStyleBackColor = true;
			// 
			// labelALU
			// 
			this.labelALU.AutoSize = true;
			this.labelALU.Location = new System.Drawing.Point(633, 142);
			this.labelALU.Name = "labelALU";
			this.labelALU.Size = new System.Drawing.Size(32, 17);
			this.labelALU.TabIndex = 30;
			this.labelALU.Text = "ALU";
			// 
			// NC
			// 
			this.NC.AutoSize = true;
			this.NC.Location = new System.Drawing.Point(233, 155);
			this.NC.Name = "NC";
			this.NC.Size = new System.Drawing.Size(48, 21);
			this.NC.TabIndex = 31;
			this.NC.Text = "NC";
			this.NC.UseVisualStyleBackColor = true;
			// 
			// NXT
			// 
			this.NXT.FormattingEnabled = true;
			this.NXT.Items.AddRange(new object[] {
            "Increment",
            "Execute",
            "SrcToDst",
            "Opcode",
            "END"});
			this.NXT.Location = new System.Drawing.Point(477, 164);
			this.NXT.Name = "NXT";
			this.NXT.Size = new System.Drawing.Size(121, 24);
			this.NXT.TabIndex = 32;
			// 
			// labelNxt
			// 
			this.labelNxt.AutoSize = true;
			this.labelNxt.Location = new System.Drawing.Point(474, 142);
			this.labelNxt.Name = "labelNxt";
			this.labelNxt.Size = new System.Drawing.Size(89, 17);
			this.labelNxt.TabIndex = 33;
			this.labelNxt.Text = "Next Address";
			// 
			// X
			// 
			this.X.AutoSize = true;
			this.X.Location = new System.Drawing.Point(298, 167);
			this.X.Name = "X";
			this.X.Size = new System.Drawing.Size(38, 21);
			this.X.TabIndex = 34;
			this.X.Text = "X";
			this.X.UseVisualStyleBackColor = true;
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 16F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(1747, 479);
			this.Controls.Add(this.X);
			this.Controls.Add(this.labelNxt);
			this.Controls.Add(this.NXT);
			this.Controls.Add(this.NC);
			this.Controls.Add(this.labelALU);
			this.Controls.Add(this.HLT);
			this.Controls.Add(this.NewMicro);
			this.Controls.Add(this.labelInst);
			this.Controls.Add(this.labelOpcode);
			this.Controls.Add(this.opcode);
			this.Controls.Add(this.AssmbInst);
			this.Controls.Add(this.Remove);
			this.Controls.Add(this.labelMicroprogram);
			this.Controls.Add(this.labelCin);
			this.Controls.Add(this.labelCout);
			this.Controls.Add(this.labelBout);
			this.Controls.Add(this.labelAin);
			this.Controls.Add(this.Microprogram);
			this.Controls.Add(this.Save);
			this.Controls.Add(this.Add);
			this.Controls.Add(this.BusCin);
			this.Controls.Add(this.BusCout);
			this.Controls.Add(this.BusBout);
			this.Controls.Add(this.BusAin);
			this.Controls.Add(this.SETC);
			this.Controls.Add(this.ALU);
			this.Controls.Add(this.RW);
			this.Controls.Add(this.WMFC);
			this.Controls.Add(this.RST);
			this.Name = "Form1";
			this.Text = "Form1";
			this.Load += new System.EventHandler(this.Form1_Load);
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.CheckBox RST;
		private System.Windows.Forms.CheckBox WMFC;
		private System.Windows.Forms.CheckBox RW;
		private System.Windows.Forms.ComboBox ALU;
		private System.Windows.Forms.CheckBox SETC;
		private System.Windows.Forms.ComboBox BusAin;
		private System.Windows.Forms.ComboBox BusBout;
		private System.Windows.Forms.ComboBox BusCin;
		private System.Windows.Forms.ComboBox BusCout;
		private System.Windows.Forms.Button Add;
		private System.Windows.Forms.Button Save;
		private System.Windows.Forms.ListBox Microprogram;
		private System.Windows.Forms.Label labelAin;
		private System.Windows.Forms.Label labelBout;
		private System.Windows.Forms.Label labelCout;
		private System.Windows.Forms.Label labelCin;
		private System.Windows.Forms.Label labelMicroprogram;
		private System.Windows.Forms.Button Remove;
		private System.Windows.Forms.TextBox AssmbInst;
		private System.Windows.Forms.TextBox opcode;
		private System.Windows.Forms.Label labelOpcode;
		private System.Windows.Forms.Label labelInst;
		private System.Windows.Forms.Button NewMicro;
		private System.Windows.Forms.CheckBox HLT;
		private System.Windows.Forms.Label labelALU;
		private System.Windows.Forms.CheckBox NC;
		private System.Windows.Forms.ComboBox NXT;
		private System.Windows.Forms.Label labelNxt;
		private System.Windows.Forms.CheckBox X;
	}
}

