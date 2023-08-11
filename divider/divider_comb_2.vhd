library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_bit.ALL;

ENTITY N_bits_divider_2 IS
generic (
      N : integer := 4
); 
   PORT( mode : IN std_logic;
         a, b : IN signed (N-1 DOWNTO 0);
         m,r : OUT signed (N-1 DOWNTO 0)
         --result : OUT signed (2*N-1 DOWNTO 0)

         --busy,error,valid : OUT std_logic 
         ); 
END ENTITY N_bits_divider_2;

architecture rtl of N_bits_divider_2 is
begin
    process (a,b)
    variable A_Q : signed(2*N-1 downto 0);
    variable restored_A : signed(N-1 downto 0);
    variable M_divisor : signed(N-1 downto 0);
    begin
        A_Q(2*N-1 downto N) := a;
        A_Q := shift_right(A_Q,N);
        M_divisor := b;
        for i in N-1 downto 0 loop
            A_Q := shift_left(A_Q,1);
            restored_A := A_Q(2*N-1 downto N);

            if A_Q(2*N-1) = M_divisor(N-1) then
                A_Q(2*N-1 downto N) := A_Q(2*N-1 downto N) - M_divisor;
            else
                A_Q(2*N-1 downto N) := A_Q(2*N-1 downto N) + M_divisor;
            end if ;

            if A_Q(2*N-1) = restored_A(N-1) then
                A_Q(2*N-1 downto N) := A_Q(2*N-1 downto N) ;
                A_Q(0):= '1' ;
            else
                A_Q(2*N-1 downto N) := restored_A;
                A_Q(0):= '0' ;
            end if ;

        end loop;

        if a(N-1) = b(N-1) then
            m <= A_Q(N-1 downto 0);
        else
            m <= not(A_Q(N-1 downto 0)) + 1;
        end if;

        r <= A_Q(2*N-1 downto N);

    end process;
end architecture;