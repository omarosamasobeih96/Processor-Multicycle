#include <bits/stdc++.h>
using namespace std;

struct R {
	string bitstring;
	R(string bitstring, int l = 0, int n = -1) {
		if (n == -1) {
			if (bitstring.length() == 0)bitstring = "0";
			this->bitstring = bitstring;
			return;
		}
		string tmp = "";
		for (int i = l, c = 0; c < n; ++i, ++c)
			tmp += bitstring[i];
		this->bitstring = n ? tmp : "0";
	}
	R(int x) {
		bitstring = "";
		while (x)bitstring += char((x % 2) + '0'), x /= 2;
		reverse(bitstring.begin(), bitstring.end());
		if (bitstring.length() == 0)bitstring = "0";
	}
	string getHex(int digits = 0) {
		string ret = "";
		for (int i = max(0, (int)bitstring.length() - 4), e = bitstring.length(); ; e = i, i = max(0, i - 4)) {
			int tmp = 0, k = 1;
			for (int j = e - 1; j >= i; --j) {
				tmp += k * (bitstring[j] == '1');
				k *= 2;
			}
			ret += "0123456789ABCDEF"[tmp];
			digits--;
			if (!i)break;
		}
		while (digits-- > 0)ret += '0';
		reverse(ret.begin(), ret.end());
		return ret;
	}
	string getOcta(int digits = 0) {
		string ret = "";
		for (int i = max(0, (int)bitstring.length() - 4), e = bitstring.length(); ; e = i, i = max(0, i - 4)) {
			int tmp = 0, k = 1;
			for (int j = e - 1; j >= i; --j) {
				tmp += k * (bitstring[j] == '1');
				k *= 2;
			}
			ret += "01234567"[tmp];
			digits--;
			if (!i)break;
		}
		while (digits-- > 0)ret += '0';
		reverse(ret.begin(), ret.end());
		return ret;
	}
	string getDecimalStr(int digits = 0) {
		int v = 0;
		string ret;
		for (int i = 0; i < bitstring.length(); ++i)
			v = v * 2 + (bitstring[i] == '1');
		stringstream ss;
		ss << v;
		ss >> ret;
		reverse(ret.begin(), ret.end());
		while (digits-- > 0)ret += '0';
		reverse(ret.begin(), ret.end());
		return ret;
	}
	int getDecimal() {
		int v = 0;
		for (int i = 0; i < bitstring.length(); ++i)
			v = v * 2 + (bitstring[i] == '1');
		return v;
	}
};

string oper[] = { "INC", "ADD", "SUB", "DEC", "AND", "OR ", "XOR", "NOT", "LSR", "ROR", "RRC", "ASR", "LSL", "ROL", "RLC", "CLR" };

string reg[] = { "DST", "SRC", "PC ", "SP ", "IR ", "MAR", "MDR", "FLG", "TMP", "XXX", "XXX", "XXX", "XXX", "XXX", "XXX", "XXX" };

string nxt[] = { "inc", "exc", "srcTOdst", "opcode", "end" };


int main() {
#ifndef ONLINE_JUDGE
	freopen("input.txt", "r", stdin);
	freopen("debug microprograms.txt", "w", stdout);

#endif
	string k;
	int cnt = 0;
	int tp = 0;
	while (getline(cin, k)) {
		if (k.length() == 0) {
			continue;
		}
		if (k[0] != '#' && k[0] != '$') {
			R ALU(k, 0, 4);
			R Ain(k, 4, 4);
			R Bout(k, 8, 4);
			R Cin(k, 12, 4);
			R Cout(k, 16, 4);
			R RST(k, 20, 1);
			R RW(k, 21, 1);
			R SETC(k, 22, 1);
			R WMFC(k, 23, 1);
			R NC(k, 24, 1);
			R X(k, 25, 1);
			R HLT(k, 26, 1);
			R NXT(k, 27, 3);
			R c(cnt++);
			cout << (cnt <= 16 ? " @" : "@") << c.getHex() << "   ";
			cout << "ALU:" << oper[ALU.getDecimal()] << "  ";
			cout << "Ain:" << reg[Ain.getDecimal()] << "  ";
			cout << "Bin:" << reg[Bout.getDecimal()] << "  ";
			cout << "Cin:" << reg[Cin.getDecimal()] << "  ";
			cout << "Cout:" << reg[Cout.getDecimal()] << "    ";
			cout << (RST.bitstring == "0" ? "     " : "RST  ");
			cout << (RW.bitstring == "0" ? "    " : "RW  ");
			cout << (SETC.bitstring == "0" ? "      " : "SETC  ");
			cout << (WMFC.bitstring == "0" ? "      " : "WMFC  ");
			cout << (NC.bitstring == "0" ? "    " : "NC  ");
			cout << (X.bitstring == "0" ? "   " : "X  ");
			cout << (HLT.bitstring == "0" ? "     " : "HLT  ");
			cout << nxt[NXT.getDecimal()] << endl;
			cout << endl;
			cout << "--------------------------------------------------------------------------------------------" << endl;
			cout << endl;
			// cout << (cnt <= 16 ? " " : "") << "@" << c.bitstring << " " << k << endl;
		}
		if (k[0] == '#') {
			cout << "############################################################################################" << endl;
			cout << "###############################       " << k.substr(2, k.length()) << "      ###########\n";
			cout << "############################################################################################" << endl;
			cout << endl;

		}
		/*
		if (k[0] == '$') {
			string te[] = { "00", "01", "10", "11" };
			R c(k, 2, 6);
			if (c.getHex() == "1F")return 0;
			if (c.getHex() == "0B")tp = 1;
			if (c.getHex() == "16")tp = 3;
			getline(cin, k);
			string inst = k.substr(2, k.length());
			if (inst.length() == 3)inst += "  ";
			if (inst.length() == 2)inst += "   ";
			//cout << inst << "     " << te[tp] << c.bitstring << endl << endl;
		}
		*/
	}
}