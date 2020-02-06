
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY majority IS
PORT ( x1, x2, x3 : IN STD_LOGIC ;
f : OUT STD_LOGIC) ;
END majority;
ARCHITECTURE LogicFunction OF majority IS
BEGIN
f <= (x1 AND x2) OR (x1 AND x3) OR (x2 AND x3);
END LogicFunction;