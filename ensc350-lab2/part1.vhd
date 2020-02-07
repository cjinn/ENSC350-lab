-----------------------------------------------------------------------------
-- First couple of question in Assignment 2
-- These questions demonstrate the use of 
--     a) formal GENERICS
--     b) ENTITYs with multiple ARCHITECTURES and
--     c) GENERATING simple and recursive structures.
-----------------------------------------------------------------------------
library IEEE;
library LWS02;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity ParityCheck is
     generic( width : integer := 8 );
     port( input : in std_logic_vector( width-1 downto 0 );
           output: out std_logic );
end entity ParityCheck;




architecture Tree1 of ParityCheck is
	signal iq : std_logic_vector( width-1 downto 0 );
begin
	A0: entity LWS02.xor2 port map ( input(0), input(1), iq(0) );
	A1: entity LWS02.xor2 port map ( input(2), input(3), iq(1) );
	A2: entity LWS02.xor2 port map ( input(4), input(5), iq(2) );
	A3: entity LWS02.xor2 port map ( input(6), input(7), iq(3) );

	A4: entity LWS02.xor2 port map ( iq(0), iq(1), iq(4) );
	A5: entity LWS02.xor2 port map ( iq(2), iq(3), iq(5) );
	A6: entity LWS02.xor2 port map ( iq(4), iq(5), output );
end architecture tree1;




architecture Chain1 of ParityCheck is
	signal iq : std_logic_vector( width-1 downto 0 );
begin
	iq(0) <= input(0);
	A0: entity LWS02.xor2 port map ( iq(0), input(1), iq(1) );
	A1: entity LWS02.xor2 port map ( iq(1), input(2), iq(2) );
	A2: entity LWS02.xor2 port map ( iq(2), input(3), iq(3) );
	A3: entity LWS02.xor2 port map ( iq(3), input(4), iq(4) );
	A4: entity LWS02.xor2 port map ( iq(4), input(5), iq(5) );
	A5: entity LWS02.xor2 port map ( iq(5), input(6), iq(6) );
	A6: entity LWS02.xor2 port map ( iq(6), input(7), output );
end architecture chain1;




architecture Chain2 of ParityCheck is
	signal iq : std_logic_vector( width - 1 downto 0 );
begin
	iq(0) <= input(0);
	gg: 	for z in 0 to width - 2 generate
		Az:	entity LWS02.xor2 port map (iq(z), input(z+1), iq(z+1));
	end generate gg;
	output <= iq(width - 1);
end architecture chain2;



-----------------------------------------------------------------------------
-- This version of the architecture performs a recursive instantiation of
-- the ENTITY/ARCHITECTURE. The GENERIC parameter width controls the recursion
-- The recursion stops when the parameter is either 2 or 3. We do not allow
-- the width to become 1 as this may cause problems in specifying the range
-- for the indices of the input array.
-- The division by 2 truncates so you must be very careful when dividing the
-- circuit into two sub-circuits and indexing their input arrays.
-----------------------------------------------------------------------------
architecture Tree2 of ParityCheck is
	signal iq : std_logic_vector( 1 downto 0 );
begin
	-- width = 8
	-- width/2 = 4
	-- width - width/2 - 4 

	-- width = 7
	-- width/2 = 3 (integer division truncates)
	-- width - width/2 = 4

	Recur: if (width > 2) generate
		A0: entity ParityCheck(Tree2) generic map(width/2)
		port map ( input(width - width/2-1 downto 0), iq(0));

		A1: entity ParityCheck(Tree2) generic map(width - width/2)
		port map ( input(width-1 downto width - width/2), iq(1));

		A2: entity LWS02.xor2 port map ( iq(0), iq(1), output );
	End generate Recur;

	BaseCase2: if (width = 2) generate
		Root: entity LWS02.xor2 port map ( input(0), input(1), output ); 
	End generate BaseCase2;

	BaseCase1: if (width = 1) generate
		output <= input(0);
	End generate BaseCase1;


end architecture Tree2;
