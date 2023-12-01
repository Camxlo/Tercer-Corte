library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is 
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
end memory;

architecture memory_arch of memory is
component rom_128x8_sync 
  port (
    address : in std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0);
    clock : in std_logic
  );
end component;
component rw_96x8_sync 
  port (
    address : in std_logic_vector(7 downto 0);
    clock : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    writen : in std_logic;
    data_out : out std_logic_vector(7 downto 0)
  );
end component;
component Outputports16 
    port (
        address   : in std_logic_vector(7 downto 0);
        data_in   : in std_logic_vector(7 downto 0);
        clock     : in std_logic;
        reset     : in std_logic;
        writen    : in std_logic;
        port_out_00 : out std_logic_vector(7 downto 0);
        port_out_01 : out std_logic_vector(7 downto 0)
    );
end component;
signal rom_data_out : std_logic_vector(7 downto 0);
signal rw_data_out  : std_logic_vector(7 downto 0);

begin
L0 : rom_128x8_sync port map (address,rom_data_out,clock);
L1 : rw_96x8_sync port map (address,clock,data_in,writen,rw_data_out);
L2 : Outputports16 port map (address,data_in,clock,reset,writen,port_out_00,port_out_01);

MUX1 : process (address, rom_data_out, rw_data_out,port_in_00, port_in_01)

begin
if ( (to_integer(unsigned(address)) >= 0) and
(to_integer(unsigned(address)) <= 127)) then
data_out <= rom_data_out;
elsif ( (to_integer(unsigned(address)) >= 128) and
(to_integer(unsigned(address)) <= 223)) then
data_out <= rw_data_out;
elsif (address = x"F0") then data_out <= port_in_00;
elsif (address = x"F1") then data_out <= port_in_01;
else data_out <= x"00";
end if;
end process;
end architecture;