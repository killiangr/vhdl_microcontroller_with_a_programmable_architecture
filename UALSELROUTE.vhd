library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UALSELROUTE is
    Port ( 
    	SEL_ROUTE : in std_logic_vector (3 downto 0);
        S : in std_logic_vector (7 downto 0);
        A : in std_logic_vector (3 downto 0);
        B : in std_logic_vector (3 downto 0);
        Buf_A_out : in std_logic_vector (3 downto 0);
        Buf_B_out : in std_logic_vector (3 downto 0);
        Mem_1_out : in std_logic_vector (7 downto 0);
        Mem_2_out : in std_logic_vector (7 downto 0);
        Buf_A_in : out std_logic_vector (3 downto 0);
        Buf_B_in : out std_logic_vector (3 downto 0);
        Mem_1_In : out std_logic_vector (7 downto 0);
        Mem_2_In : out std_logic_vector (7 downto 0);
        CE_Buf_A : out std_logic;
        CE_Buf_B : out std_logic;
        CE_Mem_1 : out std_logic;
        CE_Mem_2 : out std_logic            
    );
end UALSELROUTE;

architecture UALSELROUTE_Arch of UALSELROUTE is

begin
    MySelRouteProc : process (SEL_ROUTE, S, A, B, Buf_A_out, Buf_B_out, Mem_1_out, Mem_2_out)
    begin
        case SEL_ROUTE is
            when "0000" => -- Stockage de l'entrée A_IN dans Buffer_A
                CE_Buf_A <= '1';
                CE_Buf_B <= '0';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= A;
                Buf_B_in <= (others => '0');
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');
                
            when "0001" => -- Stockage de l'entrée B_IN dans Buffer_B
                CE_Buf_A <= '0';
                CE_Buf_B <= '1';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= (others => '0');
                Buf_B_in <= B;
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');
                
            when "0010" => -- Stockage de S dans Buffer_A (4 bits de poids faibles)
                CE_Buf_A <= '1';
                CE_Buf_B <= '0';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= S(3 downto 0);
                Buf_B_in <= (others => '0');
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');
            
            when "0011" => -- Stockage de S dans Buffer_A (4 bits de poids forts)
                CE_Buf_A <= '1';
                CE_Buf_B <= '0';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= S(7 downto 4);
                Buf_B_in <= (others => '0');
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');
                
            when "0100" => -- Stockage de S dans Buffer_B (4 bits de poids faibles)
                CE_Buf_A <= '0';
                CE_Buf_B <= '1';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= (others => '0');
                Buf_B_in <= S(3 downto 0);
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');
            
            when "0101" => -- Stockage de S dans Buffer_B (4 bits de poids forts)
                CE_Buf_A <= '0';
                CE_Buf_B <= '1';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= (others => '0');
                Buf_B_in <= S(7 downto 4);
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');    
                
            when "0110" => -- Stockage de S dans MEM_CACHE_1
                CE_Buf_A <= '0';
                CE_Buf_B <= '0';
                CE_Mem_1 <= '1';
                CE_Mem_2 <= '0';
                Buf_A_in <= (others => '0');
                Buf_B_in <= (others => '0');
                Mem_1_In <= S;
                Mem_2_In <= (others => '0');
            
            when "0111" others => -- Stockage de S dans MEM_CACHE_2
                CE_Buf_A <= '0';
                CE_Buf_B <= '0';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '1';
                Buf_A_in <= (others => '0');
                Buf_B_in <= (others => '0');
                Mem_1_In <= (others => '0');
                Mem_2_In <= S;    
                
            when "1000" => -- Stockage de MEM_CACHE_1 dans Buffer_A (4 bits de poids faibles)
                CE_Buf_A <= '1';
                CE_Buf_B <= '0';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= Mem_1_out(3 downto 0);
                Buf_B_in <= (others => '0');
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');
            
            when "1001" => -- Stockage de MEM_CACHE_1 dans Buffer_A (4 bits de poids forts)
                CE_Buf_A <= '1';
                CE_Buf_B <= '0';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= Mem_1_out(7 downto 4);
                Buf_B_in <= (others => '0');
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');    
                
            when "1010" => -- Stockage de MEM_CACHE_1 dans Buffer_B (4 bits de poids faibles)
                CE_Buf_A <= '0';
                CE_Buf_B <= '1';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= (others => '0');
                Buf_B_in <= Mem_1_out(3 downto 0);
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');
            
            when "1011" => -- Stockage de MEM_CACHE_1 dans Buffer_B (4 bits de poids forts)
                CE_Buf_A <= '0';
                CE_Buf_B <= '1';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= (others => '0');
                Buf_B_in <= Mem_1_out(7 downto 4);
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');    
                 
            when "1100" => -- Stockage de MEM_CACHE_2 dans Buffer_A (4 bits de poids faibles)
                CE_Buf_A <= '1';
                CE_Buf_B <= '0';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= Mem_2_out(3 downto 0);
                Buf_B_in <= (others => '0');
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');
            
            when "1101" => -- Stockage de MEM_CACHE_2 dans Buffer_A (4 bits de poids forts)
                CE_Buf_A <= '1';
                CE_Buf_B <= '0';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= Mem_2_out(7 downto 4);
                Buf_B_in <= (others => '0');
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');
  
            when "1110" => -- Stockage de MEM_CACHE_2 dans Buffer_B (4 bits de poids faibles)
                CE_Buf_A <= '0';
                CE_Buf_B <= '1';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= (others => '0');
                Buf_B_in <= Mem_2_out(3 downto 0);
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');
            
            when "1111" => -- Stockage de MEM_CACHE_2 dans Buffer_B (4 bits de poids forts)
                CE_Buf_A <= '0';
                CE_Buf_B <= '1';
                CE_Mem_1 <= '0';
                CE_Mem_2 <= '0';
                Buf_A_in <= (others => '0');
                Buf_B_in <= Mem_1_out(7 downto 4);
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');
        end case;
    end process;

end UALSELROUTE_Arch;
