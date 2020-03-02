Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity Div7 is
Generic ( N : natural := 6 );
Port ( x : in std_logic_vector( N-1 downto 0 );
	IsDivisible : out std_logic );
End Entity Div7;

-- Assume N = 18 for this design
Architecture structural of Div7 is
	signal Y : std_logic_vector(N-1 downto 0);
	signal iCarry: std_logic_vector(N-1 downto 0);
Begin
-- Insert your design here -------------------------------------------------------------------------------------
	Y(N downto 0) <= "0";
	IterateX: for i in 0 to (N/3) - 1 generate
		FullAdderFirstBit: entity work.FullAdder port map (Y(0), x(i*3 + 0), '0'		, iCarry(0), Y(0));
		FullAdderSeconBit: entity work.FullAdder port map (Y(1), x(i*3 + 1), iCarry(0), iCarry(1), Y(1));
		FullAdderThirdBit: entity work.FullAdder port map (Y(2), x(i*3 + 2), iCarry(1), iCarry(2), Y(2));
		Remaining: for k in 3 to (N-1) generate
			FullAdderRemainingBits: entity work.FullAdder port map
			(Y(k), '0', iCarry(k - 1)	, iCarry(k), Y(k));
		end generate Remaining;
	end generate IterateX;

	IsDivisible <= '0';
	IsDivTrue: if (to_integer(unsigned(Y)) = 7 or to_integer(unsigned(Y)) = 0) generate
		IsDivisible <= '1';
	End generate IsDivTrue;

	RecursiveCall: if (to_integer(unsigned(Y)) > 7) generate
		RecursiveDiv7: entity work.Div7 port map (Y, IsDivisible);
	end generate RecursiveCall;
End Architecture structural;
