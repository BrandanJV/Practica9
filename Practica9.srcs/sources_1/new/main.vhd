----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2021 16:48:19
-- Design Name: 
-- Module Name: main - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity main is
    Port (clk: in std_logic; 
            rs, rw, en: out std_logic;
            Db: out std_logic_vector(7 downto 0));
end main;

architecture Behavioral of main is
    type stateType is (S0, Sset, SonOff, SNextLine, SHome, SClear, SEntryMode, Sb, Sr, Sa1, Sn1, Sd, Sa2, Sn2, Si, Sz, Se, Sl, Sfeliz1, Sfeliz2);
	signal currentState, nextState : stateType;
	signal Rst, en_i, delay: std_logic;
	signal cnt: integer:=0;
begin
en <= en_i;
delay <= '1' when cnt = 500_000
            else '0';
-- Un nanosegundo por periodo del reloj, 1 milisegundo es igual a 1,000,000 de nanosegundos
-- Neceito 10,000,000 de pulsos para cumplir un milisegundo.
syncProcess: process(Rst, Clk)
	begin
		if (Rst = '1') then 
			currentState <= S0;
		elsif (rising_edge(Clk)) then
			currentState <= nextState;
			if(cnt = 500_000) then
			 cnt <= 0;
			else
			 cnt <= cnt + 1;
         end if;
		end if;
	end process syncProcess;
	
	combProcess: process(currentState, delay)
	begin
	case currentState is
	   when S0 => 
	       Rs <= '0';
	       rw <= '0';
	       DB <= "00000001";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= SHome;
           else
                nextState <= S0;
           end if;	
           
        when SHome =>
           Rs <= '0';
	       rw <= '0';
	       DB <= "00000010";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Sset;
           else
                nextState <= SHome;
           end if;
           
        when Sset =>
           Rs <= '0';
	       rw <= '0';
	       DB <= "00111000";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= SonOff;
           else
                nextState <= Sset;
           end if;
        when SonOff =>
           Rs <= '0';
	       rw <= '0';
	       DB <= "00001111";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= SEntryMode;
           else
                nextState <= SonOff;
           end if;
           
        when SEntryMode =>
           Rs <= '0';
	       rw <= '0';
	       DB <= "00000110";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Sb;
           else
                nextState <= SEntryMode;
           end if;
           
           -- empezar a escribir las letras 1 por 1.
       when Sb =>
           Rs <= '1';
	       rw <= '0';
	       DB <= "01000010";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Sr;
           else
                nextState <= Sb;
           end if; 	 
           
       when Sr =>
           Rs <= '1';
	       rw <= '0';
	       DB <= "01110010";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Sa1;
           else
                nextState <= Sr;
           end if;
        
        when Sa1 =>
           Rs <= '1';
	       rw <= '0';
	       DB <= "01100001";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Sn1;
           else
                nextState <= Sa1;
           end if;
        
        when Sn1 =>
           Rs <= '1';
	       rw <= '0';
	       DB <= "01101110";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Sd;
           else
                nextState <= Sn1;
           end if;
           
        when Sd =>
           Rs <= '1';
	       rw <= '0';
	       DB <= "01100100";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Sa2;
           else
                nextState <= Sd;
           end if;
        
        when Sa2 =>
           Rs <= '1';
	       rw <= '0';
	       DB <= "01100001";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Sn2;
           else
                nextState <= Sa2;
           end if;
       
        when Sn2 =>
           Rs <= '1';
	       rw <= '0';
	       DB <= "01101110";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= SNextLine;
           else
                nextState <= Sn2;
           end if;
           
        when SNextLine =>
           Rs <= '0';
	       rw <= '0';
	       DB <= "11000000";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= SI;
           else
                nextState <= SNextLine;
           end if;
        
        when SI =>
           Rs <= '1';
	       rw <= '0';
	       DB <= "01001001";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Sz;
           else
                nextState <= SI;
           end if;
           
        when Sz =>
           Rs <= '1';
	       rw <= '0';
	       DB <= "01111010";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Se;
           else
                nextState <= Sz;
           end if;
        
        when Se =>
           Rs <= '1';
	       rw <= '0';
	       DB <= "01100101";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Sl;
           else
                nextState <= Se;
           end if;
           
        when Sl =>
           Rs <= '1';
	       rw <= '0';
	       DB <= "01101100";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Sfeliz1;
           else
                nextState <= Sl;
           end if;
        
        when Sfeliz1 =>
           Rs <= '1';
	       rw <= '0';
	       DB <= "00111010";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Sfeliz2;
           else
                nextState <= Sfeliz1;
           end if;
        
        when Sfeliz2 =>
           Rs <= '1';
	       rw <= '0';
	       DB <= "00101001";
	       en_i <= '1';
	       -- if cnt llega al delay deseado, cambiar de estado.
	       if(delay = '1') then 
	           en_i <= '0';
	           nextState <= Sfeliz2;
           else
                nextState <= Sfeliz2;
           end if;
           
        when others =>
	       nextState <= SHome;
	end case;
	end process;

end Behavioral;
