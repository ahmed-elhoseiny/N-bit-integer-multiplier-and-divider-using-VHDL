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
      variable temp : signed (2*N-1 DOWNTO 0) ;
      variable temp_1 : signed (2*N-1 DOWNTO 0) ;
      --variable temp_2 : signed (1 DOWNTO 0) ;
      --variable temp_a : signed (N-1 DOWNTO 0) ;
      --variable temp_b : signed (N-1 DOWNTO 0) ;
      begin
            temp := (others => '0');
            temp_1 := (others => '0');
            --temp_2(1) := a(N-1);
            --temp_2(0) := b(N-1);
            --case (temp_2) is
                  --when "00" => temp_a := a;
                  --             temp_b := b;
                  
                 -- when "01" => temp_a := (not a) + 1;
                  --             temp_b := (not B) + 1;

                  --when "10" => temp_a := a;
                  --             temp_b := b;

                  --when "11" => temp_a := (not a) + 1;
                  --             temp_b := (not B) + 1;
                  --when others =>temp_a := a;
                  --              temp_b := b;
                   
            --end case;

            for i in 0 to N-1 loop
                  if b(i) = '1' then
                        temp_1(2*N-1 DOWNTO N+i) := (others => a(N-1));
                        temp_1(N-1+i DOWNTO i) := a(N-1 DOWNTO 0);
                        if i = 0 then
                              temp_1 := temp_1;   
                        else
                              temp_1(i-1 DOWNTO 0) := (others => '0');        
                        end if;
                  else
                        temp_1 := (others => '0');
                  end if ;
                  
                  if i = N-1 then
                        temp := temp - temp_1;
                  else
                        temp := temp + temp_1;
                  end if ;

            end loop;
            m <= temp(2*N-1 DOWNTO N);
            r <= temp(N-1 DOWNTO 0);
            result <= temp;
      end process;
end architecture rtl;



