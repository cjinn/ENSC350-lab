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
	signal b : std_logic_vector(width/4 - 1 downto 0);
	signal andOutput : std_logic_vector(width/4 - 1 downto 0);
	signal output1 : std_logic_vector(width downto 0);
begin
	-- Assuming width %4 == 0

	-- a(0) <= Cin;
	-- skip(0) <= Cin;
	-- Cprop1: entity Work.Cprop port map( G(0), P(0), a(0), a(1));
	-- Cprop2: entity Work.Cprop port map( G(1), P(1), a(1), a(2));
    -- Cprop3: entity Work.Cprop port map( G(2), P(2), a(2), a(3));
    -- Cprop4: entity Work.Cprop port map( G(3), P(3), a(3), interC(0));
    -- Cand1: entity Work.and4 port map(P(0), P(1), P(2), P(3), andOutput(0));
	-- Cskip1: entity Work.Cprop port map(interC(0), andOutput(0), skip(0), a(4));
	
	-- skip(1) <= a(4);    
	-- Cprop5: entity Work.Cprop port map( G(4), P(4), a(4), a(5));
	-- Cprop6: entity Work.Cprop port map( G(5), P(5), a(5), a(6));
	-- Cprop7: entity Work.Cprop port map( G(6), P(6), a(6), a(7));
    -- Cprop8: entity Work.Cprop port map( G(7), P(7), a(7), interC(1));
    -- Cand2: entity Work.and4 port map(P(4), P(5), P(6), P(7), andOutput(1));
	-- Cskip2: entity Work.Cprop port map(interC(1), andOutput(1), skip(1), a(8));
	
	-- skip(2) <= a(8);
	-- Cprop9: entity Work.Cprop port map( G(8), P(8), a(8), a(9));
	-- Cprop10: entity Work.Cprop port map( G(9), P(9), a(9), a(10));
	-- Cprop11: entity Work.Cprop port map( G(10), P(10), a(10), a(11));
    -- Cprop12: entity Work.Cprop port map( G(11), P(11), a(11), interC(2));
    -- Cand3: entity Work.and4 port map(P(8), P(9), P(10), P(11), andOutput(2));
	-- Cskip3: entity Work.Cprop port map(interC(2), andOutput(2), skip(2), a(12));

	-- skip(3) <= a(12);
	-- Cprop13: entity Work.Cprop port map( G(12), P(12), a(12), a(13));
	-- Cprop14: entity Work.Cprop port map( G(13), P(13), a(13), a(14));
	-- Cprop15: entity Work.Cprop port map( G(14), P(14), a(14), a(15));
    -- Cprop16: entity Work.Cprop port map( G(15), P(15), a(15), interC(3));
    -- Cand4: entity Work.and4 port map(P(12), P(13), P(14), P(15), andOutput(3));
    -- Cskip4: entity Work.Cprop port map(interC(3), andOutput(3), skip(3), a(16));

	a(0) <= Cin;
	ForLoop: for i in 0 to width/4 - 1 generate
		Cprop1: entity Work.Cprop port map(G(i*4 + 0), P(i*4 + 0), a(i*4 + 0), a(i*4 + 1));
		Cprop2: entity Work.Cprop port map(G(i*4 + 1), P(i*4 + 1), a(i*4 + 1), a(i*4 + 2));
		Cprop3: entity Work.Cprop port map(G(i*4 + 2), P(i*4 + 2), a(i*4 + 2), a(i*4 + 3));
		Cprop4: entity Work.Cprop port map(G(i*4 + 3), P(i*4 + 3), a(i*4 + 3), b(i));

		Cand: entity Work.and4 port map(P(i*4 + 0), P(i*4 + 1), P(i*4 + 2), P(i*4 + 3), andOutput(i));
		Cprop5: entity Work.Cprop port map(b(i), andOutput(i), a(i*4 + 0), a(i*4 + 4));
	End generate ForLoop;

	C(width downto 0) <= a(width downto 0);
end architecture BookSkip;




architecture GoodSkip of Cnet is
	signal a : std_logic_vector(width downto 0);
	signal b : std_logic_vector(width downto 0);
	signal ctemp : std_logic_vector(width/4 - 1 downto 0);
	signal andOutput1 : std_logic_vector(width/4 - 1 downto 0);
	signal andOutput2 : std_logic_vector(width/4 - 1 downto 0);
	signal orOutput1 : std_logic_vector(width/4 - 1 downto 0);
begin
	-- Assuming width %4 == 0

	a(0) <= Cin;
	ForLoop: for i in 0 to width/4 - 1 generate
		Cprop1: entity Work.Cprop port map(G(i*4 + 0), P(i*4 + 0), a(i*4 + 0), b(i*4 + 0));
		Cprop2: entity Work.Cprop port map(G(i*4 + 1), P(i*4 + 1), a(i*4 + 1), b(i*4 + 1));
		Cprop3: entity Work.Cprop port map(G(i*4 + 2), P(i*4 + 2), a(i*4 + 2), b(i*4 + 2));
		Cprop4: entity Work.Cprop port map(G(i*4 + 3), P(i*4 + 3), a(i*4 + 3), b(i*4 + 3));

		Cand1: entity Work.and4 port map(P(i*4 + 0), P(i*4 + 1), P(i*4 + 2), P(i*4 + 3), andOutput1(i));
		Cprop5: entity Work.Cprop port map(b(i*4 + 3), andOutput1(i), a(i*4 + 0), ctemp(i));

		-- GoodSkip to skip propogation based on carries
		Cand2: entity Work.and2 port map(a(i*4 + 0), andOutput1(i), andOutput2(i));

		OrSkipLoop: for j in 0 to width/4 - 2 generate
			CorSkip: entity Work.or2 port map(b(i*4 + j), andOutput2(i), a(i*4 + j + 1));
		End generate OrSkipLoop;
		-- CorOutput: entity Work.or3 port map(b(i*4 + 3), andOutput2(i), ctemp(i), a(i*4 + 4));
		a(i*4 + 4) <= ctemp(i);
	End generate ForLoop;

	C(width downto 0) <= a(width downto 0);
end architecture GoodSkip;




architecture BrentKung of Cnet is
-- 	-- Gtemp : std_logic;
-- 	-- Ptemp : std_logic;


-- 	-- Ga
-- 	-- Pa

-- 	-- Gb
-- 	-- Pb

-- 	-- Gc
-- 	-- Pc
begin
-- 	-- Assuming width % 2 == 0
-- -- 	Recur: if (width > 2) generate
 
-- -- 	End generate Recur;


-- 	Case4: if (width > 2) generate
-- 		Level1a: entity Work.Cnet(BrentKung) generic map(width/2) port map
-- 		(G(width/2 - 1 downto 0), P(width/2 - 1 downto 0), Cin, Ga(width/2 - 1 downto 0), Pa(width/2 - 1 downto 0));
-- 		Level1b: entity Work.Cnet(BrentKung) generic map(width/2) port map
-- 		(G(width - 1 downto width/2), P(width - 1 downto width/2), Cin, Ga(width - 1 downto width/2), Pa(width - 1 downto width/2));

-- 		Gb(1) <= Ga(width - 1);
-- 		Gb(0) <= (Ga(width/2 - 1));
-- 		Pb(1) <= Pa(width - 1);
-- 		Pb(0) <= Pa(width/2 - 1)


-- 		Level2: entity Work.Cnet(BrentKung) generic map(width/2) port map
-- 		(Gb(1 downto 0), Pb(1 downto 0), Cin, Gc(width - 1 downto 0), Pc(width - 1 downto 0));

-- 		-- Needs work

-- 	End generate Case4;

-- 	BaseCase2: if (width = 2) generate
-- 		Cprop: entity Work.Cprop port map(G(1), P(1), G(0), C(0));
-- 		Cand: entity Work.and2 port map(P(1), P(0), C(1));
-- 	End generate BaseCase2;

-- -- 	BaseCase1: if (width = 1) generate
-- -- 		C(0) <= G(0);
-- -- 		C(1) <= P(1);
-- -- End generate BaseCase1; 
end architecture BrentKung;