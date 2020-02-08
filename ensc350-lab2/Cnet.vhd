-----------------------------------------------------------------------------
-- Declare the Carry network for the adder.
-----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Cnet is
     generic ( width : integer := 16 );
     port (
          G, P     :     in     std_logic_vector(width-1 downto 0);
          Cin      :     in     std_logic;
          C        :     out    std_logic_vector(width downto 0) );
end entity Cnet;



-----------------------------------------------------------------------------
-- Students must Create the following Carry Network Architectures.
-----------------------------------------------------------------------------
architecture Ripple of Cnet is
	signal a : std_logic_vector(width downto 0); -- Don't read from output signal C
begin
	a(0) <= Cin;

	-- Cprop1: entity Work.Cprop port map( G(0), P(0), a(0), a(1));
	-- Cprop2: entity Work.Cprop port map( G(1), P(1), a(1), a(2));
	-- Cprop3: entity Work.Cprop port map( G(2), P(2), a(2), a(3));
	-- Cprop4: entity Work.Cprop port map( G(3), P(3), a(3), a(4));
	-- Cprop5: entity Work.Cprop port map( G(4), P(4), a(4), a(5));
	-- Cprop6: entity Work.Cprop port map( G(5), P(5), a(5), a(6));
	-- Cprop7: entity Work.Cprop port map( G(6), P(6), a(6), a(7));
	-- Cprop8: entity Work.Cprop port map( G(7), P(7), a(7), a(8));

	-- Cprop9: entity Work.Cprop port map( G(8), P(8), a(8), a(9));
	-- Cprop10: entity Work.Cprop port map( G(9), P(9), a(9), a(10));
	-- Cprop11: entity Work.Cprop port map( G(10), P(10), a(10), a(11));
	-- Cprop12: entity Work.Cprop port map( G(11), P(11), a(11), a(12));
	-- Cprop13: entity Work.Cprop port map( G(12), P(12), a(12), a(13));
	-- Cprop14: entity Work.Cprop port map( G(13), P(13), a(13), a(14));
	-- Cprop15: entity Work.Cprop port map( G(14), P(14), a(14), a(15));
	-- Cprop16: entity Work.Cprop port map( G(15), P(15), a(15), a(16));

	CpropGenerate: for i in 0 to width-1 generate
		Cpropi: entity Work.Cprop port map(G(i), P(i), a(i), a(i + 1));
	end generate CpropGenerate;

	C(width downto 0) <= a(width downto 0);
end architecture Ripple;




architecture BookSkip of Cnet is
	signal a : std_logic_vector(width downto 0);
	signal b : std_logic;
begin
	-- Assuming width %4 == 0
	Recur: if (width > 4) generate
		BookSkip1: entity Cnet(BookSkip) generic map(width/2)
		port map (G(width/2 - 1 downto 0), P(width/2 - 1 downto 0), Cin, a(width/2 downto 0));
		BookSkip2: entity Cnet(BookSkip) generic map(width/2)
		port map (G(width - 1 downto width/2), P(width - 1 downto width/2), a(width/2), a(width downto width/2));

		C(width downto 0) <= a(width downto 0);
	End generate Recur;

	BaseCase: if (width = 4) generate
		Cprop1: entity Work.Cprop port map(G(0), P(0), Cin, a(0));
		Cprop2: entity Work.Cprop port map(G(1), P(1), a(0), a(1));
		Cprop3: entity Work.Cprop port map(G(2), P(2), a(1), a(2));
		Cprop4: entity Work.Cprop port map(G(3), P(3), a(2), a(3));

		Cand: entity Work.and4 port map(P(0), P(1), P(2), P(3), b);

		Cpropout: entity Work.Cprop port map(a(3), b, Cin, C(4));
		C(width - 1 downto 0) <= a(width - 1 downto 0);
	End generate BaseCase;
end architecture BookSkip;




architecture GoodSkip of Cnet is
begin
end architecture GoodSkip;




architecture BrentKung of Cnet is

begin
	-- Recur: if (width > 2) generate

	-- 	InputPrep: for i in width - 1 downto 0 generate
	-- 	End generate InputPrep;
	-- End generate Recur;

	-- BaseCase: if (width == 2) generate
	-- 	Cprop: entity Work.Cprop port map (G(0), P(0), Cin, C);
	-- End generate BaseCase;
end architecture BrentKung;