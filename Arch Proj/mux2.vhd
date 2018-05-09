LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mux2 IS  
		PORT (IN1,IN2,S	: 	 IN std_logic;
  		      OUT1      :	 OUT  std_logic);    
END ENTITY mux2;


ARCHITECTURE Data_flow OF mux2 IS
BEGIN  
   OUT1 <= (IN1 AND (NOT S)) OR (IN2 AND S);     
END Data_flow;

