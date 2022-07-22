library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity proyecto is
port (clk: in std_logic;
		servo1,servo2,servo3: in std_logic;
		control1,control2,control3: out std_logic;
		UDmotpasos : in std_logic;--Es el encargado de hacer cambio de direccion.
		stmotpasos : in std_logic;
		MOT : out std_logic_vector(3 downto 0));
end proyecto;

architecture behavioral of proyecto is

begin

u1: entity work.servomotor(behavioral) port map(clk, servo1, servo2, servo3, control1, control2, control3);
u2: entity work.motpasos(behavioral) port map (clk, udmotpasos, stmotpasos,mot);


end behavioral;