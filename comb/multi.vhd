--PACKAGE pack_a IS
--   TYPE op_type IS (mul, div);
--END PACKAGE pack_a;

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_bit.ALL;
--USE WORK.pack_a.ALL;

ENTITY N_bits_multiplier IS
generic (
      N : integer := 4
); 
   PORT( mode : IN std_logic;
         a, b : IN signed (N-1 DOWNTO 0);
         m,r : OUT signed (N-1 DOWNTO 0);
         result : OUT signed (2*N-1 DOWNTO 0)

         --busy,error,valid : OUT std_logic 
         ); 
END ENTITY N_bits_multiplier;

architecture rtl of N_bits_multiplier is
begin
      process (a,b)
      variable temp : signed (2*N-1 DOWNTO 0) := (others => '0');
      variable temp_1 : signed (2*N-1 DOWNTO 0) := (others => '0');
      begin
            
            for i in 0 to N-1 loop
                  if b(i) = '1' then
                        --temp := temp + ((others => a(N-1)) & a & repeat(i,'0'));
                        temp_1(2*N-1 DOWNTO N+i) := (others => a(N-1));
                        temp_1(N-1+i DOWNTO i) := a(N-1 DOWNTO 0);
                        if i = 0 then
                              temp_1 := temp_1;   
                        else
                              temp_1(i-1 DOWNTO 0) := (others => '0');        
                        end if;
                        temp := temp + temp_1;
                  else
                        temp := temp + 0;
                  end if ; 
            end loop;
            m <= temp(2*N-1 DOWNTO N);
            r <= temp(N-1 DOWNTO 0);
            result <= temp;
      end process;
end architecture rtl;

