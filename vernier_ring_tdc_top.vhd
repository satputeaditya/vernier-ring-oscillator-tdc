-- vernier_ring_tdc_top.vhd

--**********************************************************************
-- Program to detect if STOP pulse is leading and lagging edge wrt START
--**********************************************************************

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use ieee.std_logic_arith.all ;

entity vernier_ring_tdc_top is
port (
		rst 	: in 	std_logic; 
        start   : in 	std_logic; 
        stop 	: in 	std_logic;
        count 	: out 	std_logic_Vector(15 downto 0):=x"0000" 
        ); 
end entity;

architecture behave of vernier_ring_tdc_top is 

signal slow_clk : std_logic:='0';
signal fast_clk : std_logic:='0';
signal leading  : std_logic:='0';
signal lagging  : std_logic:='0';
 
component coincidence_detector 
port (
        rst 	 	: in std_logic;		
        slow_clk 	: in std_logic;
        fast_clk 	: in std_logic;         
        leading 	: out std_logic;   -- SLOW CLK = Reference
        lagging 	: out std_logic    -- SLOW CLK = Reference
     ); 
end component;

component fast_oscillator 
port (
        stop 		: in std_logic;
        fast_clk  	: out std_logic:='0' 
      ); 
end component;

component slow_oscillator 
port (
        start 		: in std_logic;
        slow_clk  	: out std_logic:='0' 
      ); 
end component;

component counter 
port (
        rst 		: in 	std_logic;
        slow_clk   	: in 	std_logic; 
        fast_clk   	: in 	std_logic; 		
		latch 		: in 	std_logic; 
        count 		: out 	std_logic_Vector(15 downto 0):=x"0000"
        ); 
end component;

begin

U1 : coincidence_detector 
port map(
			rst 	 	=> 		rst,
			slow_clk 	=>		slow_clk,
			fast_clk 	=>		fast_clk,
			leading 	=>		leading,
			lagging 	=>		lagging
		 ); 

U2 : fast_oscillator 
port map(
			stop 		=>		stop,
			fast_clk  	=>  	fast_clk
		  ); 

U3 : slow_oscillator 
port map(
			start 		=>		start,
			slow_clk  	=>		slow_clk
		); 

U4 : counter 
port map(
			rst 		=>		rst,
			slow_clk   	=>		slow_clk,
			fast_clk   	=>		fast_clk,
			latch 		=>		leading,
			count 		=>		count
        ); 
		
end behave;