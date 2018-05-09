#define _CRT_SECURE_NO_WARNINGS 1
#include<iostream>
#include<fstream>
#include<string>
#include<vector>
#include<sstream>
#include<map>
#include <bits/stdc++.h>
using namespace std;


void syntax_error(int line) {
	printf("Syntax Error at line %d please fix the error and assemble again.\n", line);
}

string to_binary(int x, int bitsCnt) {
	string s;
	while (x) {
		s += x % 2 + '0';
		x /= 2;
	}
	while (s.size() < bitsCnt)
		s += '0';
	reverse(s.begin(), s.end());
	return s;
}
int to_int(string s)
{
    int x = 0;
    int a = 1;
    reverse(s.begin() , s.end());
    for(int i = 0 ; i<s.size() ; ++i)
    {
        if(s[i] != '0') x += a;
        a*=2;
    }
    return x;
}
string to_hex(int x)
{
    string s = "";
    while(x)
    {
        int a = x%16;
        if(a<=9) s+=a + '0';
        else s+= (a-10) + 'A';
        x/=16;
    }
    if(s.empty()) s = "0";
    reverse(s.begin() , s.end());
    return s;
}
map<string, int> mp;
string arr[] = { "MOV", "ADD", "ADC", "SUB", "SBC", "AND", "OR", "XOR", "BIS", "BIC", "CMP", "INC", "DEC", "CLR", "INV", "LSR", "ROR", "RRC", "ASR", "LSR", "ROL", "RLC", "BR", "BEQ", "BNE", "BLO", "BLS", "BHI","JSR", "BHS", "HLT", "NOP", "RESET", "RTS" };
const int twoOperandCnt = 11, twoOperandStart = 0;
const int oneOperandCnt = 11, oneOperandStart = 11;
const int branchesCnt = 7, branchesStart = 22;
const int noOperandCnt = 3, noOperandStart = 29;
const int jumpsCnt = 2, jumpsStart = 32;
int srcOffset = -1, dstOffset = -1;
set<string>bran;
ofstream ram;
long long mem[2500];

void init() {
    memset(mem , -1 ,sizeof mem);
    for(int i = 22 ; i<= 29 ; ++i)
        bran.insert(arr[i]);
	ifstream opcodes("opcodes.txt");
	for (int i = 0; i < 34; i++) {
		string s;
		string x;
		opcodes >> s >> x;
		mp[s] = to_int(x);
	}
	opcodes.close();
    ram.open("ram.mem");
    ram << "// memory data file (do not edit the following line - required for mem load use)"<<endl
        << "// instance=/registerfile/u49/ram"<<endl
        << "// format=bin addressradix=h dataradix=b version=1.0 wordsperline=1"<<endl;
}

int getOperandsCnt(int instructionCode)
{
    if( (instructionCode & 192) == 0) return 2;
    else if( ((instructionCode & 64) != 0) && ((instructionCode & 128) == 0) ) return 1;
    return 0;
}

string to_bin_signed(int x, int bitsCnt)
{
    string s(bitsCnt , '0');
    bool flag = 0;
    s[0] = '1';
    for(int i = bitsCnt - 1 ; i> 0 ; --i)
    {
        int a = x%2;
        if(a == 1)
        {
            if(flag) s[i] = '0';
            else s[i] = '1' , flag = 1;
        }
        else
        {
            if(flag) s[i] = '1';
            else s[i] = '0';
        }
        x/=2;
    }
    return s;
}
int getOperand(stringstream& ss, int instructionCode, int cnt, int& offset) {
	if (getOperandsCnt(instructionCode) < cnt)
		return 0;
	string operand;
	ss >> operand;
	if (operand[0] == ',')
		ss >> operand;
	if (operand[0] == 'R') { //register Mode
		if (operand.size() < 2 || operand[1] - '0' < 0 || operand[1] - '0' >= 4)
			return -1;
		return (operand[1] - '0');
	}
	else if (operand[0] == '(') { //auto increment
		if (operand.size() < 5 || operand[1] != 'R' || operand[2] < '0' || operand[2] > '3' || operand[3] != ')' || operand[4] != '+')
			return -1;
		return 4 + (operand[2] - '0');
	}
	else if (operand[0] == '-') { //auto decrement
		if (operand.size() < 5 || operand[1] != '(' || operand[2] != 'R' || operand[3] < '0' || operand[3] >= '3' || operand[4] != ')')
			return -1;
		return 8 + (operand[3] - '0');
	}
	else if (operand[0] >= '0' && operand[0] <= '9') { //indexed
		int i = 0;
		offset = 0;
		while (operand[i] >= '0' && operand[i] <= '9') {
			offset = offset*10 + (operand[i] - '0');
			i++;
		}
		if (operand.size() < i+4 || operand[i] != '(' || operand[i + 1] != 'R' || operand[i + 2] < '0' || operand[i + 2] > '3' || operand[i + 3] != ')')
			return -1;
		return 12 + (operand[i+2] - '0');
	}
	return -1;
}
map<string , int>labels;
vector<string> opcodes[200];
vector<string> lines;
int main() {
	init();
	string s;
	cout << "Please enter the file path : ";
	cin >> s;
	ifstream inp(s.c_str());
	bool AddressData = false;
	int lineNumber = 0;
	while (getline(inp, s) && ++lineNumber) {
        stringstream ss(s);
        lines.push_back(s);
        string Instruction;
        ss >> Instruction;
        if(Instruction.back() == ':')
            {
                Instruction = Instruction.substr(0,Instruction.size()-1);
                labels[Instruction]  = lineNumber;
                continue;
            }
	}
	lineNumber = 0;
	inp.close();
	inp.open(s.c_str());
	int a = 0;
	while (a<lines.size() && ++lineNumber) {
        s = lines[a++];
		srcOffset = dstOffset = -1;
		if (s.size() == 0) {
			AddressData = true;
			continue;
		}
		if (s.size() == 1) {
			syntax_error(lineNumber);
			return 0;
		}
		if (s[0] == s[1] && s[0] == '/') continue;
		stringstream ss(s);
		if (!AddressData) {
			string Instruction;
			ss >> Instruction;
            if(Instruction.back() == ':')
            {
                ss >> Instruction;
            }
            if(bran.count(Instruction))
            {
                opcodes[lineNumber].push_back(Instruction);
                ss >> Instruction;
                opcodes[lineNumber].push_back(Instruction);
                continue;
            }
			if (mp.count(Instruction) == 0) {
				syntax_error(lineNumber);
				return 0;
			}
			int instructionCode = mp[Instruction];
			int srcCode = getOperand(ss, instructionCode, 1, srcOffset);
			if (srcCode == -1) {
				syntax_error(lineNumber);
				return 0;
			}
			int dstCode = getOperand(ss, instructionCode, 2, dstOffset);
			if (dstCode == -1) {
				syntax_error(lineNumber);
				return 0;
			}
            if(getOperandsCnt(instructionCode) == 2)opcodes[lineNumber].push_back(to_binary(instructionCode, 8) + to_binary(srcCode, 4) + to_binary(dstCode, 4));
            else opcodes[lineNumber].push_back(to_binary(instructionCode, 8) +"0000" +  to_binary(srcCode, 4));

            if (srcOffset != -1)
				opcodes[lineNumber].push_back(to_binary(srcOffset, 16));
			if (dstOffset != -1)
				opcodes[lineNumber].push_back(to_binary(dstOffset, 16));

		}
		else {
			int x;
			long long y;
			ss >> x >> y;
			mem[x] = y;
		}
	}
    int ramAdress = 0;
    for(int i = 1 ; i<=lineNumber ; ++i)
    {
        if(opcodes[i].empty()) continue;
        //cout<<i<<endl;
        if(!bran.count(opcodes[i][0]))
        {
            ram<<"@"<<to_hex(ramAdress++)<<" "<<opcodes[i][0]<<endl;
            if(opcodes[i].size() > 1) ram<<"@"<<to_hex(ramAdress++)<<" "<<opcodes[i][1]<<endl;
            if(opcodes[i].size() > 2) ram<<"@"<<to_hex(ramAdress++)<<" "<<opcodes[i][2]<<endl;
        }
        else if(opcodes[i][0] != "JSR")
        {
            int x = labels[opcodes[i][1]];
            int j = i+1;
            string offset;
            if(j<=x)
            {
                int sum = 0;
                while(j<x) sum += opcodes[j].size() , j++;
                offset = to_binary(sum , 16);
            }
            else
            {
                j--;
                int sum = 0;
                while(j>=x) sum += opcodes[j].size() , j--;
                offset = to_bin_signed(sum , 16);
            }
            ram<<"@"<<to_hex(ramAdress++)<<" "<<to_binary(mp[opcodes[i][0]] , 8) + string(8,'0')<<endl;
            ram<<"@"<<to_hex(ramAdress++)<<" "<<offset<<endl;
        }
        else
        {
            int x = labels[opcodes[i][1]];
            int j = 1;
            int sum = 0;
            while(j<x) sum += opcodes[j].size() , j++;
            string offset = to_binary(sum , 16);
            ram<<"@"<<to_hex(ramAdress++)<<" "<<to_binary(mp[opcodes[i][0]] , 8) + string(8,'0')<<endl;
            ram<<"@"<<to_hex(ramAdress++)<<" "<<offset<<endl;
        }
    }
    long long upper = 4294901760;
    long long lower = 65535;
    for( ; ramAdress <= 2047 ; ++ramAdress)
    {
        if(mem[ramAdress] == -1)ram<<"@"<<to_hex(ramAdress)<<" "<<string(16,'X')<<endl;
        else
        {
            long long  x = mem[ramAdress];
            ram<<"@"<<to_hex(ramAdress++)<<" "<<to_binary( (x & upper)>>16 , 16)<<endl;
            ram<<"@"<<to_hex(ramAdress)<<" "<<to_binary(x & lower , 16)<<endl;
        }
    }
    ram.close();
	return 0;
}
