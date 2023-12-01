library IEEE;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory_test is
port (
	   address     : in std_logic_vector(7 downto 0);
		data_in     : in std_logic_vector(7 downto 0);
		writen      : in std_logic;
		clock       : in std_logic;
		reset       : in std_logic;
		port_in_00  : in std_logic_vector(7 downto 0);
		port_in_01  : in std_logic_vector(7 downto 0);
		port_out_00 : out std_logic_vector(7 downto 0);
		port_out_01 : out std_logic_vector(7 downto 0);
		Dis_1 : out std_LOGIC_VECTOR(6 downto 0);
		Dis_2 : out std_LOGIC_VECTOR(6 downto 0);
		Dis_3 : out std_LOGIC_VECTOR(6 downto 0);
		Dis_4 : out std_LOGIC_VECTOR(6 downto 0)
		);
end entity;

architecture memory_test_arch of memory_test is

component memory
port(
	  address     : in std_logic_vector(7 downto 0);
	  data_in     : in std_logic_vector(7 downto 0);
	  writen      : in std_logic;
	  clock       : in std_logic;
	  reset       : in std_logic;
	  port_in_00  : in std_logic_vector(7 downto 0);
	  port_in_01  : in std_logic_vector(7 downto 0);
	  data_out    : out std_logic_vector(7 downto 0);
	  port_out_00 : out std_logic_vector(7 downto 0);
	  port_out_01 : out std_logic_vector(7 downto 0)
);
end component;

component BCD
port ( HEXA : in  STD_LOGIC_VECTOR (3 downto 0);
       LED : out STD_LOGIC_VECTOR (6 downto 0)
		);
end component;
signal address1  : std_logic_vector(7 downto 0);
signal data_out  : std_LOGIC_VECTOR(7 downto 0);
signal Uni : std_LOGIC_VECTOR(3 downto 0):=data_out(3 downto 0);
signal Dec : std_LOGIC_VECTOR(3 downto 0):=data_out(7 downto 4);
signal Uni1 : std_LOGIC_VECTOR(3 downto 0):=address1(3 downto 0);
signal Dec1 : std_LOGIC_VECTOR(3 downto 0):=address1(7 downto 4);

begin

address1<=address;

L0 : memory port map(address,data_in,writen,clock,reset,port_in_00,port_in_01,data_out,port_out_00,port_out_01);
L1 : BCD port map(Uni,Dis_1);
L2 : BCD port map(Dec,Dis_2);
L3 : BCD port map(Uni1,Dis_3);
L4 : BCD port map(Dec1,Dis_4);

end architecture;