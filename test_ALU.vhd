library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity test_ALU is
port(
	  A : in std_logic_vector(7 downto 0);
	  B : in std_logic_vector(7 downto 0);
	  ALU_Sel : in std_logic_vector(2 downto 0);
	  NZVC : out std_logic_vector (3 downto 0);
	  Dis_1 : out std_LOGIC_VECTOR(6 downto 0);
	  Dis_2 : out std_LOGIC_VECTOR(6 downto 0);
	  Dis_3 : out std_LOGIC_VECTOR(6 downto 0);
	  Dis_4 : out std_LOGIC_VECTOR(6 downto 0));
end entity;
architecture ALU_arch of test_ALU is
component ALU is
port(
	  A : in std_logic_vector(7 downto 0);
	  B : in std_logic_vector(7 downto 0);
	  ALU_Sel : in std_logic_vector(2 downto 0);
	  NZVC : out std_logic_vector (3 downto 0);
	  ALU_Result: out std_logic_vector(7 downto 0)
	  );
end component;

component BCD is
port ( HEXA : in  STD_LOGIC_VECTOR (3 downto 0);
       LED : out STD_LOGIC_VECTOR (6 downto 0));
end component ;

signal B0 : std_logic_vector(7 downto 0);
signal Alu_Result : std_logic_vector(7 downto 0);
signal B1 : std_logic_vector(3 downto 0):=B0(3 downto 0);
signal B2 : std_logic_vector(3 downto 0):=B0(7 downto 4);
signal Result1 : std_logic_vector(3 downto 0):=Alu_Result(3 downto 0);
signal Result2 : std_logic_vector(3 downto 0):=Alu_Result(7 downto 4);


begin
B0 <= B;

L0: ALU port map(A,B,ALU_Sel,NZVC,Alu_Result);
L1: BCD port map(B1,Dis_1);
L2: BCD port map(B2,Dis_2);
L3: BCD port map(Result1,Dis_3);
L4: BCD port map(Result2,Dis_4);

end architecture;
















