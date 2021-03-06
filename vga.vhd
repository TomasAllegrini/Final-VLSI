library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity vga is
	generic (constant divider : integer := 1023); 
	port(
		--entradas
		reset : in std_logic;
		clock : in std_logic; -- Clock en 50 MHz
		rojo_in, verde_in, azul_in : in std_logic_vector(5 downto 0); --entradas fondo
																						  --NOTA: estas despues hay que dividirlas en dos pra el cuadradito!!

		--salidas
		vga_clk : out std_logic; -- Clock en 25 MHz en la salida
		vga_sync : out std_logic;
		vga_blank : out std_logic; 
		vga_vs : out std_logic;
		vga_hs : out std_logic;
		rojo_out, verde_out, azul_out : out std_logic_vector(9 downto 0) --salidas fondo	
		);
end vga;

architecture maquina of vga is
	--estados
	type state_type is (inicio,a,b,c,d);
	
	--señales
	signal state : state_type;
	signal state2 : state_type;
	signal rgb_hab1 : std_logic;
	signal rgb_hab2 : std_logic;
	signal horizontal : std_logic;
	signal clock_reducido : std_logic; 

begin
	vga_clk <= clock_reducido;
	vga_sync <= '0';
	
	--Division frecuencia del reloj de 50MHz a 25MHz
	divisor_frecuencia: process(clock)
	variable contador : integer range 0 to 1; -- escala = 50/25 = 2
	begin
		if reset = '1' then 
			clock_reducido <= '0'; --reinicio reloj
			contador := 0; --reinicio contador
		elsif rising_edge(clock) then
			if contador = 1 then
				clock_reducido <= '1';
				contador := 0;
			else
				clock_reducido <= '0';
				contador := contador + 1;
			end if;
		end if;
	end process;

	--Proceso para generar las señales VGA_HS y H_Blank(horizontal)
	signal_hs : process(clock_reducido)
	variable contador : integer range 0 to divider;
	begin
		--Genero las señales con una maquina de estados
		if reset = '1' then 
			state <= inicio;
			contador := 0;
			rgb_hab <= '0';
		elsif rising_edge(clock) then
		
		end if;
	end process;

	--Proceso para generar la señal VGA_HS (vertical)


end maquina;