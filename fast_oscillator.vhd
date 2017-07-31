-- fast_Oscillator.vhd

--************************************
-- Program to simulate fast oscillator
--************************************

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use ieee.std_logic_arith.all ;

entity fast_oscillator is
port (
        stop 		: in std_logic;
        fast_clk  	: out std_logic:='0' 
      ); 
end entity;

architecture behave of fast_oscillator   is 

signal clk: std_logic:='0';

begin 

process(clk,Stop)
begin
	if Stop = '1' then
	   clk <= not clk after 99 pS;   
	elsif stop = '0' then
		clk <= '0';
	end if;
end process;

fast_clk <= clk;

end behave;