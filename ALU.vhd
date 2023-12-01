library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ALU is
port(
	  A : in std_logic_vector(7 downto 0);
	  B : in std_logic_vector(7 downto 0);
	  ALU_Sel : in std_logic_vector(2 downto 0);
	  NZVC : out std_logic_vector (3 downto 0);
	  ALU_Result: out std_logic_vector(7 downto 0)
	  );
end entity;

architecture ALU_arch of ALU is
begin 
ALU_PROCESS : process (A, B, ALU_Sel)

variable Sum_uns : unsigned(8 downto 0);
variable Res_uns : unsigned(8 downto 0);

begin
if (ALU_Sel = "000") then --ADDITION

--- Sum Calculation ---------------------------------–
Sum_uns := unsigned('0' & A) + unsigned('0' & B);
ALU_Result <= std_logic_vector(Sum_uns(7 downto 0));
--- Negative Flag (N) -------------------------------
NZVC(3) <= Sum_uns(7);

--- Zero Flag (Z) ---------------------------------–
if (Sum_uns(7 downto 0) = x"00") then
NZVC(2) <= '1';
else
NZVC(2) <= '0';
end if;
--- Overflow Flag (V) -------------------------------
if ((A(7)='0' and B(7)='0' and Sum_uns(7)='1') or
(A(7)='1' and B(7)='1' and Sum_uns(7)='0')) then
NZVC(1) <= '1';
else
NZVC(1) <= '0';
end if;
--- Carry Flag (C) ------------------------------------
NZVC(0) <= Sum_uns(8);
elsif(ALU_Sel = "001") then
--- Res Calculation ---------------------------------–
Res_uns := unsigned('0' & A) - unsigned('0' & B);
ALU_Result <= std_logic_vector(Res_uns(7 downto 0));
--- Negative Flag (N) -------------------------------
NZVC(3) <= Res_uns(7);

--- Zero Flag (Z) ---------------------------------–
if (Res_uns(7 downto 0) = x"00") then
NZVC(2) <= '1';
else
NZVC(2) <= '0';
end if;
--- Overflow Flag (V) -------------------------------
if ((A(7)='1' and B(7)='0' and Res_uns(7)='0') or
(A(7)='0' and B(7)='1' and Res_uns(7)='1')) then
NZVC(1) <= '1';
else
NZVC(1) <= '0';
end if;
--- Carry Flag (C) ------------------------------------
NZVC(0) <= Res_uns(8);
end if;
end process;
end architecture;