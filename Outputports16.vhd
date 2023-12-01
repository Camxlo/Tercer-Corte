library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Outputports16 is
    port (
        address   : in std_logic_vector(7 downto 0);
        data_in   : in std_logic_vector(7 downto 0);
        clock     : in std_logic;
        reset     : in std_logic;
        writen    : in std_logic;
        port_out_00 : out std_logic_vector(7 downto 0);
        port_out_01 : out std_logic_vector(7 downto 0)
    );
end Outputports16;

architecture Outputports of Outputports16 is
begin

    process (clock, reset)
    begin
        if (reset = '0') then
            port_out_00 <= x"00";
        elsif (rising_edge(clock)) then
            if (address = x"E0" and writen = '1') then
                port_out_00 <= data_in;
            end if;
        end if;
    end process;

    process (clock, reset)
    begin
        if (reset = '0') then
            port_out_01 <= x"00";
        elsif (rising_edge(clock)) then
            if (address = x"E1" and writen = '1') then
                port_out_01 <= data_in;
            end if;
        end if;
    end process;

end Outputports;