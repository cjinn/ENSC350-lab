Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity TBDiv7 is
Generic ( N : natural := 18 );
End Entity TBDiv7;

Architecture behavioural of TBDiv7 is
	Constant Period : time := 10 ns;
	Constant StableTime : time := 4 ns;
	Signal clock : std_logic := '0';
	Signal start, done : std_logic := '0';
-- Now declare the internal signals for the architecture
	Signal x : std_logic_vector( N-1 downto 0 );
	Signal IsDivisible, TBIsDivisible1, TBIsDivisible2 : std_logic;
	Type	IntList is array ( 1 to 10 ) of integer;
	Constant TestValue : IntList := ( 0, 20, 569, 100, 70, 12345, 38572, 958472372, 2344, 43535 );   
Begin
	clock <= not clock after Period/2;
DUT:	Entity work.Div7 generic map( N => N )
		port map ( x => x, IsDivisible => IsDivisible );


-- Enter your code for generating stimuli.
Stimulus:
	Process
		variable counter : integer := 0;
	Begin
		x (N-1 downto 0) <= "X";
		start <= '0';
		for i in 0 to 6 loop
			wait until clock'event and clock = '1';
			x <= std_logic_vector(to_unsigned(TestValue(counter) + i, x'length));
			start <= '1';
			assert start = '1' report "start not equal to 1" severity error;
			wait until Done = '1';
		end loop;
		counter := counter + 1;
		if counter = 10 then
			counter := 0;
		end if;
	End Process Stimulus;

TBDiv7:
	process ( x ) is
		variable y : natural;
	Begin
		y := to_integer( unsigned(x) );
		if (y mod 7) = 0 then
			TBIsDivisible1 <= '1';
		else
			TBIsDivisible1 <= '0';
		end if;

		y := to_integer( unsigned(x) );
		while (y >= 7) loop
			y := y - 7;
		end loop;
		if y = 0 then
			TBIsDivisible2 <= '1';
		else
			TBIsDivisible2 <= '0';
		end if;
	End Process TBDiv7;

-- Enter your code for detecting response errors.
Detector:
	Process
	Begin
		wait until Start = '1';
		wait until clock'event and clock = '1';
		wait until IsDivisible'STABLE(StableTime);
		assert TBIsDivisible1 = IsDivisible report "TBIsDivisible1 != IsDivisible, x is " 
			& integer'image(to_integer(unsigned(x))) severity error;
		Done <= '1';
	End Process Detector;
End Architecture behavioural;

