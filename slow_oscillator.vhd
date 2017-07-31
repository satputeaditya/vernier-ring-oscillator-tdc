-- slow_oscillator.vhd

--************************************
-- Program to simulate slow oscillator
--************************************

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use ieee.std_logic_arith.all ;

entity slow_oscillator is
port (
        start 		: in std_logic;
        slow_clk  	: out std_logic:='0' 
      ); 
end entity;

architecture behave of slow_oscillator   is 

signal clk: std_logic:='0';

begin 

process(clk,start)
begin
	if start = '1' then
	   clk <= not clk after 100 pS;   
	elsif start = '0' then
		clk <= '0';
	end if;
end process;

slow_clk <= clk;

end behave;