----------------------------------------------------------------------------------
-- Company: California State University, Northridge
-- Engineer: Shahbaz Hassan Khan Malik
-- 
-- Create Date: 11/30/2021 12:44:52 PM
-- Design Name: Digital Lock 
-- Module Name: LOCK - Behavioral
-- Project Name: Computer Assignment 5
-- Target Devices: FPGA
-- Tool Versions: 1.0, BETA
-- Description: This is a digital combinational lock implemented via a finite state machine. 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LOCK is

Port (new_in, clock, reset: in std_logic;
c1: in std_logic_vector(3 downto 0);
status: out std_logic);

end LOCK;

architecture Behavioral of LOCK is

type StateType is (ST0, ST1, ST2, ST3, ERROR);
signal CurrentState, NextState: StateType;
signal c1_ref, c2_ref, c3_ref: std_logic_vector(3 downto 0);

begin
c1_ref <= "0111";
c2_ref <= "1100";
c3_ref <= "0011";

--next state and output logic

COMB: process(new_in, c1, c1_ref, c2_ref, c3_ref, CurrentState)
begin

case CurrentState is
when ST0 =>
if (new_in = '1') and (c1=c1_ref) then 
NextState <= ST1;
status <= '0';
elsif (new_in = '0') then
NextState <= ST0;
status <= '0';
else
NextState <= ERROR;
status <= '0';
end if;


when ST1 =>
if (new_in = '1') and (c1=c2_ref) then
NextState <= ST2;
status <= '0';
elsif (new_in = '0') then
NextState <= ST1;
status <= '0';
else
NextState <= ERROR;
status <= '0';
end if;

when ST2 =>
if (new_in = '1') and (c1=c3_ref) then
NextState <= ST3;
status <= '0';
elsif(new_in = '0') then
NextState <= ST2;
status <= '0';
else
NextState <= ERROR;
status <= '0';
end if;

when ST3 =>
if (new_in = '0') or (new_in = '1') then
status <= '1'; --Lock is OPEN
NextState <= ST0; --Once the Lock is OPEN, we reset the Lock
else
status <= '1';
NextState <= ST0;
end if;

when ERROR =>
NextState <= ST0;
status <= '0'; --Lock is CLOSED

end case;
end process;

--Current State Logic
SEQ: process(clock, reset, NextState)
begin

if(reset = '1') then
CurrentState<=ST0;
elsif (clock'event and clock='1') then
CurrentState <= NextState;
end if;
end process;

end Behavioral;
