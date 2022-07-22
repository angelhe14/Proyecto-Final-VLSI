library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity motpasos is
	port(	clk : in std_logic;
			UD : in std_logic;--Es el encargado de hacer cambio de direccion.
			rst : in std_logic;
			MOT : out std_logic_vector(3 downto 0) );
end motpasos;

architecture behavioral of motpasos is
	signal div :  std_logic_vector(17 downto 0);
	signal clks : std_logic;
	type estado is (sm0,sm1,sm2,sm3,sm4,sm5,sm6,sm7,sm8,
						sm9,sm10);
	signal pres_S, next_s : estado;
	signal motor : std_logic_vector(3 downto 0);
	
begin
	process (Clk,rst) --divisor de frecuencia
	begin
		if rst='0' then
			div <= (others=>'0');
		elsif Clk'event and Clk='1' then	
			div <= div + 1;
		end if;
	end process;
	clks <= div(17);
	
	process (clks,rst)
	begin
		if rst='0' then
			pres_S <= sm0;
		elsif clks'event and clks='1' then 
			pres_S <= next_s;
		end if;
	end process;
	
	process( pres_S, UD,rst)
	begin
			case(pres_S) is
				when sm0 => 					--Estado 0
					next_s <= sm1;
				when sm1	=>						--Estado 1
						if UD='1' then
							next_s <= sm3;
						else
							next_s <= sm7;
						end if;
				--------------------------------------------------------
				when sm2	=>							--Estado2
						if UD='1' then 
							next_s <= sm1;
						else 
							next_s <= sm7;
						end if;
				--------------------------------------------------------
				when sm3	=>							--Estado3
						if UD='1' then 
							next_s <= sm5;
						else 
							next_s <= sm1;
						end if;
				--------------------------------------------------------
					when sm4	=>							--Estado4
						if UD='1' then 
							next_s <= sm1;
						else 
							next_s <= sm7;
						end if;
				--------------------------------------------------------
					when sm5	=>							--Estado5
						if UD='1' then 
							next_s <= sm7;
						else 
							next_s <= sm3;
						end if;
				when sm6	=>							--Estado6
						if UD='1' then 
							next_s <= sm1;
						else 
							next_s <= sm7;
						end if;
				------------------------------------------------------------------------------
				when sm7	=>							--Estado7
						if UD='1' then 
							next_s <= sm1;
						else 
							next_s <= sm5;
						end if;			
				--------------------------------------------------------------------------------
					when sm8	=>							--Estado8
						if UD='1' then 
							next_s <= sm1;
						else 
							next_s <= sm7;
						end if;
				when sm9	=>							--Estado9
						if UD='1' then 
							next_s <= sm1;
						else 
							next_s <= sm7;
						end if;
				---------------------------------------------------------------
				when sm10	=>							--Estado10
						if UD='1' then 
							next_s <= sm1;
						else 
							next_s <= sm7;
						end if;
				when others =>	next_s <= sm0;
			end case;
	end process;
		
	process (pres_S)
	begin 
		case pres_S is
			when sm0 =>	motor <= "0000";
			when sm1 =>	motor <= "1000";
			when sm2 =>	motor <= "1100";
			when sm3 =>	motor <= "0100";
			when sm4 =>	motor <= "0110";
			when sm5 =>	motor <= "0010";
			when sm6 =>	motor <= "0011";
			when sm7 =>	motor <= "0001";
			when sm8 =>	motor <= "1001";
			when sm9 =>	motor <= "1010";
			when sm10 => motor <= "0101";
			when others =>	motor <= "0000";
		end case;
	end process;
		
	MOT <= motor;
end behavioral;