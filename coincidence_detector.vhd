-- coincidence_detector.vhd

--**********************************************************************
-- Program to detect if STOP pulse is leading and lagging edge wrt START
--**********************************************************************

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use ieee.std_logic_arith.all ;

entity coincidence_detector is
port (
        rst 	 	: in std_logic;		
        slow_clk 	: in std_logic; 
        fast_clk 	: in std_logic;         
        leading 	: out std_logic;   -- SLOW CLK = Reference
        lagging 	: out std_logic    -- SLOW CLK = Reference
     ); 
end entity;

architecture behave of coincidence_detector is 

signal edge_1 		: std_logic;
signal edge_2 		: std_logic;
signal rising_edge  : std_logic;
signal falling_edge : std_logic;
 
begin 

  process(rst,slow_clk,fast_clk)
	begin
		if rst = '1' then
		   edge_1 <= '0';
		   edge_2 <= '0';
		elsif FAST_CLK'event and FAST_CLK = '1' then
		   edge_1 <=  SLOW_CLK;
		   edge_2 <= edge_1;
		end if;
	end process;

  rising_edge <= edge_1 and (not edge_2);
  falling_edge <= edge_2 and (not edge_1);

leading <= rising_edge;
lagging <= falling_edge;

end behave;