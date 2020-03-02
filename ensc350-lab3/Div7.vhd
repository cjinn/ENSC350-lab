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
	Y := integer;
Begin
-- Insert your design here -------------------------------------------------------------------------------------
	Y(n-1 downto 0) <= '0';
	for i = 0 to (N-1) loop:
		j := i*3;
		FullAdder(x(j+1), x(j+0), Y(j+0), Y(j+1), Y(j+0));
		FullAdder(x(j+2), x(j+1), Y(j+1), Y(j+2), Y(j+1));
	end loop;

	if (Y > 7):
		Div7(Y, IsDivisible);
	else if (Y = '0' || Y = '7'):
		IsDivisible <= '1';
	else:
		IsDivisible <= '0';
	end if;	
End Architecture structural;
