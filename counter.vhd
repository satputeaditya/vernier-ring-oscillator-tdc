-- counter.vhd

--**********************************************************************
-- Program to detect if STOP pulse is leading and lagging edge wrt START
--**********************************************************************

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use ieee.std_logic_arith.all ;

entity counter is
port (
        rst 		: in 	std_logic;
        slow_clk   	: in 	std_logic; 
        fast_clk   	: in 	std_logic; 		
		latch 		: in 	std_logic; 
        count 		: out 	std_logic_Vector(15 downto 0):=x"0000"
        ); 
end entity;

architecture behave of counter is 

signal slow_counter: std_logic_vector(15 downto 0):=x"0000";
signal fast_counter: std_logic_vector(15 downto 0):=x"0000";

begin 

process(rst,slow_clk,fast_clk,latch)
begin
-- PROCESS 1 : SLOW COUNTER
	if rst = '1' then
	   slow_counter <= (others =>'0');   
	elsif slow_clk'event and slow_clk = '1' then
			if latch = '0' then
				slow_counter <= slow_counter + '1';
			else
				slow_counter <= slow_counter;
			end if;
	end if;		

-- PROCESS 2 : FAST COUNTER	
	if rst = '1' then
	   fast_counter <= (others =>'0');   
	elsif fast_clk'event and fast_clk = '1' then
			if latch = '0' then
				fast_counter <= fast_counter + '1';
			else
				fast_counter <= fast_counter;
			end if;
	end if;
	
-- PROCESS 3 : COUNTER	LATCHING
	if rst = '1' then
	   count <= (others =>'0');   
	elsif latch'event and latch = '1' then
		count <= (slow_counter-fast_counter);
	end if;		
		
end process;

end behave;