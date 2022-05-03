----------------------------------------------------------------------------------
-- Company: California State University, Northridge
-- Engineer: Shahbaz Hassan Khan Malik
-- 
-- Create Date: 11/30/2021 12:44:52 PM
-- Design Name: Digital Lock, TEST BENCH
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

entity LOCK_TB is
--  Port ( );
end LOCK_TB;

architecture Behavioral of LOCK_TB is

component LOCK is

Port (new_in, clock, reset: in std_logic;
c1: in std_logic_vector(3 downto 0);
status: out std_logic);

end component;

signal new_in, clock, reset, status: std_logic;
signal c1: std_logic_vector(3 downto 0);

constant CP: time := 10ns;

begin

uut: LOCK port map(new_in=>new_in, clock=>clock, reset=>reset, status=>status, c1=>c1);

clock_process: process
begin
clock <= '1';
wait for CP/2;
clock <= '0';
wait for CP/2;
end process;

main_process: process
begin
--Testing Correct Case--
reset <= '0';
new_in <= '0';

wait for CP;
new_in <= '1';
c1 <= "0111";
wait for CP;
new_in <= '0';
wait for CP;

new_in <= '1';
c1 <= "1100";
wait for CP;
new_in <= '0';
wait for CP;

new_in <= '1';
c1 <= "0011";
wait for CP;
new_in <= '0';
wait for 2*CP;

--Testing Wrong Case--
reset <= '0';
new_in <= '0';

wait for CP;
new_in <= '1';
c1 <= "1111";
wait for CP;
new_in <= '0';
wait for CP;

new_in <= '1';
c1 <= "1100";
wait for CP;
new_in <= '0';
wait for CP;

new_in <= '1';
c1 <= "0011";
wait for CP;
new_in <= '0';
wait for 2*CP;

--Testing RESET = 1 WITH CORRECT INPUTS--
reset <= '0';
new_in <= '0';

wait for CP;
new_in <= '1';
c1 <= "0111";
wait for CP;
new_in <= '0';
wait for CP;

reset <= '1'; --INPUTING RESET = 1

new_in <= '1';
c1 <= "1100";
wait for CP;
new_in <= '0';
wait for CP;
new_in <= '1';
c1 <= "0011";
wait for CP;
new_in <= '0';
wait for 2*CP;

--Testing Wrong Input Followed By Correct Input--
--Wrong:
reset <= '0';
new_in <= '0';

wait for CP;
new_in <= '1';
c1 <= "1111";
wait for CP;
new_in <= '0';
wait for CP;

new_in <= '1';
c1 <= "1100";
wait for CP;
new_in <= '0';
wait for CP;

new_in <= '1';
c1 <= "0011";
wait for CP;
new_in <= '0';
wait for 2*CP;

--Correct:
new_in <= '1';
c1 <= "0111";
wait for CP;
new_in <= '0';
wait for CP;

new_in <= '1';
c1 <= "1100";
wait for CP;
new_in <= '0';
wait for CP;

new_in <= '1';
c1 <= "0011";
wait for CP;
new_in <= '0';
wait for 2*CP;

--correct values without using the push button--
c1 <= "0111";
wait for CP;

c1 <= "1100";
wait for CP;

c1 <= "0011";
wait for CP;

wait for 2*CP;


wait;

end process;

end Behavioral;
