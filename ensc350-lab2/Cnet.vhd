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
	signal tempCarry1 : std_logic; -- Don't read from output signal C
	signal tempCarry2 : std_logic;
begin
	C(0) <= Cin;
	C(8) <= Cin;
	tempCarry1 <= Cin;
	CpropGenerate: for i in 0 to width-1 generate
		C(i) <= tempCarry1;
		Cpropi: entity Work.Cprop port map(G(i), P(i), tempCarry1, tempCarry2);
		tempCarry1 <= tempCarry2;
	end generate CpropGenerate;
	C(width) <= tempCarry2;
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