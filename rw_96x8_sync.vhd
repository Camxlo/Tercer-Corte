library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity rw_96x8_sync is
  port (
    address : in std_logic_vector(7 downto 0);
    clock : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    writen : in std_logic;
    data_out : out std_logic_vector(7 downto 0)
  );
end entity;

architecture RAM_arch of rw_96x8_sync is
  type RAM_type is array (128 to 223) of std_logic_vector(7 downto 0);
  signal RW : RAM_type;
  signal EN : std_logic := '0';

begin
  enable: process(address)
  begin
    if (to_integer(unsigned(address)) >= 128 and to_integer(unsigned(address)) <= 223) then
      EN <= '1';
    else
      EN <= '0';
    end if;
  end process;

  memory: process(clock)
  begin
    if rising_edge(clock) then
      if EN = '1' and writen = '1' then
        RW(to_integer(unsigned(address))) <= data_in;
      elsif EN = '1' and writen = '0' then
        data_out <= RW(to_integer(unsigned(address)));
      end if;
    end if;
  end process;

end architecture;
