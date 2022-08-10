library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity UALCore is
    Port ( 
    	A : in std_logic_vector (3 downto 0);
        B : in std_logic_vector (3 downto 0);
        SR_IN_L : in std_logic;
        SR_IN_R : in std_logic;
        S : out std_logic_vector (7 downto 0);
        SR_OUT_L : out std_logic;
        SR_OUT_R : out std_logic;
        SEL_FCT : in std_logic_vector (3 downto 0));
end UALCore;

architecture UALCore_Arch of UALCore is
    signal My_A, My_B : std_logic_vector(3 downto 0); 
    signal My_SR_IN_R, My_SR_IN_L, My_SR_OUT_R, My_SR_OUT_L : std_logic;
    signal My_S : std_logic_vector(7 downto 0); 

begin
	MyUALCore_Proc : process (A, B, SR_IN_L, SR_IN_R, SEL_FCT)
    variable My_S_Var, My_A_Var, My_B_Var : std_logic_vector (7 downto 0); 
  
begin
    case SEL_FCT is
    	when "0001" => -- S = Déc. droite A (avec SR_IN_L) | SR_IN_L pour le bit entrant et SR_OUT_R pour le bit sortant
            S(7 downto 4) <= (others => '0');
            S(3) <= SR_IN_L; S(2 downto 0) <= A(3 downto 1); 
            SR_OUT_L <= '0'; SR_OUT_R <= A(0);
      
        when "0010" => -- S = Déc. gauche A (avec SR_IN_R) | SR_IN_R pour le bit entrant et SR_OUT_L pour le bit sortant
            S(7 downto 4) <= (others => '0');
            S(0) <= SR_IN_R; S(3 downto 1) <= A(2 downto 0); 
            SR_OUT_L <= A(3); SR_OUT_R <= '0';
      
        when "0011" => -- S = Déc. droite B (avec SR_IN_L) | SR_IN_L pour le bit entrant et SR_OUT_R pour le bit sortant
            S(7 downto 4) <= (others => '0');
            S(3) <= SR_IN_L; S(2 downto 0) <= B(3 downto 1); 
            SR_OUT_L <= '0'; SR_OUT_R <= B(0);
      
        when "0100" => -- S = Déc. gauche B (avec SR_IN_R) | SR_IN_R pour le bit entrant et SR_OUT_L pour le bit sortant
            S(7 downto 4) <= (others => '0');
            S(0) <= SR_IN_R; S(3 downto 1) <= B(2 downto 0); 
            SR_OUT_L <= B(3); SR_OUT_R <= '0'; 
      
        when "0101" => -- S = A * B multiplication binaire | SR_OUT_L = 0 et SR_OUT_R = 0
            S <= A * B; 
            SR_OUT_L <= '0'; SR_OUT_R <= '0';
      
        when "0110" => -- S = A + B addition binaire avec SR_IN_R comme retenue d'entrée | SR_OUT_L = 0 et SR_OUT_R = 0
            My_A_Var(3 downto 0) := A; My_B_Var(3 downto 0) := B;
            My_A_Var(7 downto 4) := (others => A(3)); My_B_Var(7 downto 4) := (others => B(3));
            My_S_Var := My_A_Var + My_B_Var;
            My_S_Var := My_S_Var + ("0000000" & SR_IN_R);
            S <= My_S_Var;
            SR_OUT_L <= '0'; SR_OUT_R <= '0';
      
        when "0111" => -- S = A + B addition binaire sans retenue d'entrée | SR_OUT_L = 0 et SR_OUT_R = 0
            My_A_Var(3 downto 0) := A; My_B_Var(3 downto 0) := B;
            My_A_Var(7 downto 4) := (others => A(3)); My_B_Var(7 downto 4) := (others => B(3));
            My_S_Var := My_A_Var + My_B_Var;
            S <= My_S_Var;
            SR_OUT_L <= '0'; SR_OUT_R <= '0';
      
        when "1000" => -- S = A - B soustraction binaire | SR_OUT_L = 0 et SR_OUT_R = 0
            My_A_Var(3 downto 0) := A; My_B_Var(3 downto 0) := B;
            My_A_Var(7 downto 4) := (others => A(3)); My_B_Var(7 downto 4) := (others => B(3));
            My_S_Var := My_A_Var - My_B_Var;
            S <= My_S_Var;
            SR_OUT_L <= '0'; SR_OUT_R <= '0';
      
        when "1001" => -- S = A | SR_OUT_L = 0 et SR_OUT_R = 0
            S(7 downto 4) <= (others => '0');
            S(3 downto 0) <= A; SR_OUT_L <= '0'; SR_OUT_R <= '0';
      
        when "1010" => -- S = B | SR_OUT_L = 0 et SR_OUT_R = 0
            S(7 downto 4) <= (others => '0');
            S(3 downto 0) <= B; SR_OUT_L <= '0'; SR_OUT_R <= '0';
      
        when "1011" => -- S = not A | SR_OUT_L = 0 et SR_OUT_R = 0
            S(7 downto 4) <= (others => '0');
            S(3 downto 0) <= not A; SR_OUT_L <= '0'; SR_OUT_R <= '0';
      
        when "1100" => -- S = not B | SR_OUT_L = 0 et SR_OUT_R = 0
            S(7 downto 4) <= (others => '0');
            S(3 downto 0) <= not B; SR_OUT_L <= '0'; SR_OUT_R <= '0';
      
        when "1101" => -- S = A and B | SR_OUT_L = 0 et SR_OUT_R = 0
            S(7 downto 4) <= (others => '0');
            S(3 downto 0) <= A and B; SR_OUT_L <= '0'; SR_OUT_R <= '0';
      
        when "1110" => -- S = A or B | SR_OUT_L = 0 et SR_OUT_R = 0
            S(7 downto 4) <= (others => '0');
            S(3 downto 0) <= A or B; SR_OUT_L <= '0'; SR_OUT_R <= '0';
      
        when "1111" => -- S = A xor B | SR_OUT_L = 0 et SR_OUT_R = 0
            S(7 downto 4) <= (others => '0');
            S(3 downto 0) <= A xor B; SR_OUT_L <= '0'; SR_OUT_R <= '0';
      
        when others => --nop (no operation) S = 0 | SR_OUT_L = 0 et SR_OUT_R = 0
            S(7 downto 0) <= (others => '0');
            SR_OUT_L <= '0'; SR_OUT_R <= '0';
    end case;
end process;

end UALCore_Arch;