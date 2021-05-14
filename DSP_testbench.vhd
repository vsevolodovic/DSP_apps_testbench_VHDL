----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2020 08:39:35
-- Design Name: 
-- Module Name: TB_Filter_Bank_TOP - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Testbench_file is
--  Port ( );
end Testbench_file;

architecture Behavioral of Testbench_file is

COMPONENT <your_design> --modify this section according to your design
    PORT( 
           aclk                     : in std_logic;
           aresetn                  : in std_logic;
           aSel                     : in std_logic_vector (19 downto 0);
           ch_0_m_axis_data_tready  : IN STD_LOGIC;
           ch_1_m_axis_data_tready  : IN STD_LOGIC;
           ch_2_m_axis_data_tready  : IN STD_LOGIC;
           ch_3_m_axis_data_tready  : IN STD_LOGIC;
           ch_0_s_axis_data_tvalid  : IN STD_LOGIC;
           ch_1_s_axis_data_tvalid  : IN STD_LOGIC;
           ch_2_s_axis_data_tvalid  : IN STD_LOGIC;
           ch_3_s_axis_data_tvalid  : IN STD_LOGIC;
           ch_0_s_axis_data_tdata   : IN STD_LOGIC_VECTOR  (31 DOWNTO 0);
           ch_1_s_axis_data_tdata   : IN STD_LOGIC_VECTOR  (31 DOWNTO 0);
           ch_2_s_axis_data_tdata   : IN STD_LOGIC_VECTOR  (31 DOWNTO 0);
           ch_3_s_axis_data_tdata   : IN STD_LOGIC_VECTOR  (31 DOWNTO 0);
           ch_0_m_axis_data_tdata   : out STD_LOGIC_VECTOR  (31 DOWNTO 0);
           ch_1_m_axis_data_tdata   : out STD_LOGIC_VECTOR  (31 DOWNTO 0);
           ch_2_m_axis_data_tdata   : out STD_LOGIC_VECTOR  (31 DOWNTO 0);
           ch_3_m_axis_data_tdata   : out STD_LOGIC_VECTOR  (31 DOWNTO 0);
           ch_0_m_axis_data_tvalid  : out STD_LOGIC;
           ch_1_m_axis_data_tvalid  : out STD_LOGIC;
           ch_2_m_axis_data_tvalid  : out STD_LOGIC;
           ch_3_m_axis_data_tvalid  : out STD_LOGIC
       );
          
           

end COMPONENT;

    constant CLOCK_PERIOD : time   := 4.06901 ns;
    constant NUM_SAMPLES : integer := 50000;
    
    signal aclk                   : std_logic:='0';                         
    signal aresetn                : std_logic:='1';                         
    signal aSel                   : std_logic_vector (19 downto 0):=("00000000100000000000");    
    signal ch_0_m_axis_data_tready: STD_LOGIC:='1';                         
    signal ch_1_m_axis_data_tready: STD_LOGIC:='1';                         
    signal ch_2_m_axis_data_tready: STD_LOGIC:='1';                         
    signal ch_3_m_axis_data_tready: STD_LOGIC:='1';                        
    signal ch_0_s_axis_data_tvalid: STD_LOGIC:='0';                         
    signal ch_1_s_axis_data_tvalid: STD_LOGIC:='0';                         
    signal ch_2_s_axis_data_tvalid: STD_LOGIC:='0';                         
    signal ch_3_s_axis_data_tvalid: STD_LOGIC:='0';                         
    signal ch_0_s_axis_data_tdata : STD_LOGIC_VECTOR  (31 DOWNTO 0):=(others => '0');   
    signal ch_1_s_axis_data_tdata : STD_LOGIC_VECTOR  (31 DOWNTO 0):=(others => '0');   
    signal ch_2_s_axis_data_tdata : STD_LOGIC_VECTOR  (31 DOWNTO 0):=(others => '0');   
    signal ch_3_s_axis_data_tdata : STD_LOGIC_VECTOR  (31 DOWNTO 0):=(others => '0');   
    signal ch_0_m_axis_data_tdata : STD_LOGIC_VECTOR  (31 DOWNTO 0):=(others => '0');  
    signal ch_1_m_axis_data_tdata : STD_LOGIC_VECTOR  (31 DOWNTO 0):=(others => '0');  
    signal ch_2_m_axis_data_tdata : STD_LOGIC_VECTOR  (31 DOWNTO 0):=(others => '0');  
    signal ch_3_m_axis_data_tdata : STD_LOGIC_VECTOR  (31 DOWNTO 0):=(others => '0');  
    signal ch_0_m_axis_data_tvalid: STD_LOGIC:='0';                        
    signal ch_1_m_axis_data_tvalid: STD_LOGIC:='0';                        
    signal ch_2_m_axis_data_tvalid: STD_LOGIC:='0';                        
    signal ch_3_m_axis_data_tvalid: STD_LOGIC:='0';  
    
    signal array_complete_I : std_logic :='0';
    signal array_complete_Q : std_logic :='0';
    
    signal read_complete_I: std_logic :='0';
    signal read_complete_Q: std_logic :='0';
    
    signal start_I : std_logic :='0';
    signal start_Q : std_logic :='0';
    
    
    type t_char_file_I is file of character;
    type t_char_file_Q is file of character;
    type t_byte_arr_I is array (natural range <>) of std_logic_vector(7 downto 0);
    type t_byte_arr_Q is array (natural range <>) of std_logic_vector(7 downto 0);
    type t_sig_arr_I is array (natural range <>) of std_logic_vector(15 downto 0);
    type t_sig_arr_Q is array (natural range <>) of std_logic_vector(15 downto 0);
    
    signal read_arr_byte_I0 : t_byte_arr_I(0 to 2*NUM_SAMPLES-1);
    signal read_arr_byte_I1 : t_byte_arr_I(0 to 2*NUM_SAMPLES-1);
    signal read_arr_byte_I2 : t_byte_arr_I(0 to 2*NUM_SAMPLES-1);
    signal read_arr_byte_I3 : t_byte_arr_I(0 to 2*NUM_SAMPLES-1);
    signal read_arr_byte_Q0 : t_byte_arr_Q(0 to 2*NUM_SAMPLES-1);
    signal read_arr_byte_Q1 : t_byte_arr_Q(0 to 2*NUM_SAMPLES-1);
    signal read_arr_byte_Q2 : t_byte_arr_Q(0 to 2*NUM_SAMPLES-1);
    signal read_arr_byte_Q3 : t_byte_arr_Q(0 to 2*NUM_SAMPLES-1);
    signal sig_arr_I0  : t_sig_arr_I(0 to NUM_SAMPLES-1);
    signal sig_arr_I1  : t_sig_arr_I(0 to NUM_SAMPLES-1); 
    signal sig_arr_I2  : t_sig_arr_I(0 to NUM_SAMPLES-1); 
    signal sig_arr_I3  : t_sig_arr_I(0 to NUM_SAMPLES-1);  
    signal sig_arr_Q0  : t_sig_arr_Q(0 to NUM_SAMPLES-1);
    signal sig_arr_Q1  : t_sig_arr_Q(0 to NUM_SAMPLES-1);
    signal sig_arr_Q2  : t_sig_arr_Q(0 to NUM_SAMPLES-1);
    signal sig_arr_Q3  : t_sig_arr_Q(0 to NUM_SAMPLES-1);                       
    
    signal s_axis_data_tdata_I0 : std_logic_vector (15 downto 0) := (others => '0'); 
    signal s_axis_data_tdata_Q0 : std_logic_vector (15 downto 0) := (others => '0'); 
    
    signal s_axis_data_tdata_I1 : std_logic_vector (15 downto 0) := (others => '0'); 
    signal s_axis_data_tdata_Q1 : std_logic_vector (15 downto 0) := (others => '0'); 
    
    signal s_axis_data_tdata_I2 : std_logic_vector (15 downto 0) := (others => '0'); 
    signal s_axis_data_tdata_Q2 : std_logic_vector (15 downto 0) := (others => '0'); 
    
    signal s_axis_data_tdata_I3 : std_logic_vector (15 downto 0) := (others => '0'); 
    signal s_axis_data_tdata_Q3 : std_logic_vector (15 downto 0) := (others => '0'); 

begin

    DUT: your_design
        PORT MAP(
                 aclk                     => aclk                     ,
                 aresetn                  => aresetn                  ,
                 aSel                     => aSel                     ,
                 ch_0_m_axis_data_tready  => ch_0_m_axis_data_tready  ,
                 ch_1_m_axis_data_tready  => ch_1_m_axis_data_tready  ,
                 ch_2_m_axis_data_tready  => ch_2_m_axis_data_tready  ,
                 ch_3_m_axis_data_tready  => ch_3_m_axis_data_tready  ,
                 ch_0_s_axis_data_tvalid  => ch_0_s_axis_data_tvalid  ,
                 ch_1_s_axis_data_tvalid  => ch_1_s_axis_data_tvalid  ,
                 ch_2_s_axis_data_tvalid  => ch_2_s_axis_data_tvalid  ,
                 ch_3_s_axis_data_tvalid  => ch_3_s_axis_data_tvalid  ,
                 ch_0_s_axis_data_tdata   => ch_0_s_axis_data_tdata   ,
                 ch_1_s_axis_data_tdata   => ch_1_s_axis_data_tdata   ,
                 ch_2_s_axis_data_tdata   => ch_2_s_axis_data_tdata   ,
                 ch_3_s_axis_data_tdata   => ch_3_s_axis_data_tdata   ,
                 ch_0_m_axis_data_tdata   => ch_0_m_axis_data_tdata   ,
                 ch_1_m_axis_data_tdata   => ch_1_m_axis_data_tdata   ,
                 ch_2_m_axis_data_tdata   => ch_2_m_axis_data_tdata   ,
                 ch_3_m_axis_data_tdata   => ch_3_m_axis_data_tdata   ,
                 ch_0_m_axis_data_tvalid  => ch_0_m_axis_data_tvalid  ,
                 ch_1_m_axis_data_tvalid  => ch_1_m_axis_data_tvalid  ,
                 ch_2_m_axis_data_tvalid  => ch_2_m_axis_data_tvalid  ,
                 ch_3_m_axis_data_tvalid  => ch_3_m_axis_data_tvalid  
                 );
                 
                 
      clock_gen : process
         begin
             aclk <= '0';
             wait for CLOCK_PERIOD;
             loop
               aclk <= '0';
               wait for CLOCK_PERIOD/2;
               aclk <= '1';
               wait for CLOCK_PERIOD/2;
             end loop;
       end process clock_gen;  
       
       start_proc: process
        begin
        wait for 5 ns;
        start_I<='1';
        start_Q<='1';

    end process;             

    read_file_I: process (start_I) IS
      file file_in_I0 : t_char_file_I open read_mode is "<path_to_your_bin_file_to_read_from_matlab>/your_bin_file_I0.bin";
      file file_in_I1 : t_char_file_I open read_mode is "<path_to_your_bin_file_to_read_from_matlab>/your_bin_file_I1.bin";
      file file_in_I2 : t_char_file_I open read_mode is "<path_to_your_bin_file_to_read_from_matlab>/your_bin_file_I2.bin";
      file file_in_I3 : t_char_file_I open read_mode is "<path_to_your_bin_file_to_read_from_matlab>/your_bin_file_I3.bin";  -- open the frame file for reading
      variable char_buffer_I0 : character;
      variable char_buffer_I1 : character;
      variable char_buffer_I2 : character;
      variable char_buffer_I3 : character;
      
        begin
          IF start_I'event and start_I = '1' then
            for i in read_arr_byte_I0'range loop
              read(file_in_I0, char_buffer_I0);
              read_arr_byte_I0(i) <= std_logic_vector(to_unsigned(character'POS(char_buffer_I0), 8));
              read(file_in_I1, char_buffer_I1);
              read_arr_byte_I1(i) <= std_logic_vector(to_unsigned(character'POS(char_buffer_I1), 8));
              read(file_in_I2, char_buffer_I2);
              read_arr_byte_I2(i) <= std_logic_vector(to_unsigned(character'POS(char_buffer_I2), 8));
              read(file_in_I3, char_buffer_I3);
              read_arr_byte_I3(i) <= std_logic_vector(to_unsigned(character'POS(char_buffer_I3), 8));
            end loop;  -- i
            file_close(file_in_I0); 
            file_close(file_in_I1); 
            file_close(file_in_I2); 
            file_close(file_in_I3); 
            read_complete_I <= '1';
          end if;
        end process read_file_I;
        
    read_file_Q: process (start_Q) IS
      file file_in_Q0 : t_char_file_Q open read_mode is "<path_to_your_bin_file_to_read_from_matlab>/your_bin_file_Q0.bin";  -- open the frame file for reading
      file file_in_Q1 : t_char_file_Q open read_mode is "<path_to_your_bin_file_to_read_from_matlab>/your_bin_file_Q1.bin";
      file file_in_Q2 : t_char_file_Q open read_mode is "<path_to_your_bin_file_to_read_from_matlab>/your_bin_file_Q2.bin";
      file file_in_Q3 : t_char_file_Q open read_mode is "<path_to_your_bin_file_to_read_from_matlab>/your_bin_file_Q3.bin";
      variable char_buffer_Q0 : character;
      variable char_buffer_Q1 : character;
      variable char_buffer_Q2 : character;
      variable char_buffer_Q3 : character;
      
        begin
          IF start_Q'event and start_Q = '1' then
            for i in read_arr_byte_Q0'range loop
              read(file_in_Q0, char_buffer_Q0);
              read_arr_byte_Q0(i) <= std_logic_vector(to_unsigned(character'POS(char_buffer_Q0), 8));
              read(file_in_Q1, char_buffer_Q1);
              read_arr_byte_Q1(i) <= std_logic_vector(to_unsigned(character'POS(char_buffer_Q1), 8));
              read(file_in_Q2, char_buffer_Q2);
              read_arr_byte_Q2(i) <= std_logic_vector(to_unsigned(character'POS(char_buffer_Q2), 8));
              read(file_in_Q3, char_buffer_Q3);
              read_arr_byte_Q3(i) <= std_logic_vector(to_unsigned(character'POS(char_buffer_Q3), 8));
            end loop;  -- i
            file_close(file_in_Q0); 
            file_close(file_in_Q1);
            file_close(file_in_Q2);
            file_close(file_in_Q3);
            read_complete_Q <= '1';
          end if;
        end process read_file_Q;   
        
  
  
   output_I: process (read_complete_I) IS
    variable idx_I  : integer := 0;
        begin
            IF read_complete_I'event and read_complete_I = '1' then
               for j in sig_arr_I0'range loop
                sig_arr_I0(j)(15 downto 8) <= read_arr_byte_I0(idx_I)(7 downto 0);
                sig_arr_I0(j)(7 downto 0)  <= read_arr_byte_I0(idx_I +1)(7 downto 0);
                sig_arr_I1(j)(15 downto 8) <= read_arr_byte_I1(idx_I)(7 downto 0);
                sig_arr_I1(j)(7 downto 0)  <= read_arr_byte_I1(idx_I +1)(7 downto 0);
                sig_arr_I2(j)(15 downto 8) <= read_arr_byte_I2(idx_I)(7 downto 0);
                sig_arr_I2(j)(7 downto 0)  <= read_arr_byte_I2(idx_I +1)(7 downto 0);
                sig_arr_I3(j)(15 downto 8) <= read_arr_byte_I3(idx_I)(7 downto 0);
                sig_arr_I3(j)(7 downto 0)  <= read_arr_byte_I3(idx_I +1)(7 downto 0);
                idx_I := idx_I + 2;
            end loop;    
            array_complete_I <= '1'; 
        end if;
          
    end process;
    
    
  output_Q: process (read_complete_Q) IS
    variable idx_Q  : integer := 0;
        begin
            IF read_complete_Q'event and read_complete_Q = '1' then
               for j in sig_arr_Q0'range loop
                sig_arr_Q0(j)(15 downto 8) <= read_arr_byte_Q0(idx_Q)(7 downto 0);
                sig_arr_Q0(j)(7 downto 0)  <= read_arr_byte_Q0(idx_Q +1)(7 downto 0);
                sig_arr_Q1(j)(15 downto 8) <= read_arr_byte_Q1(idx_Q)(7 downto 0);
                sig_arr_Q1(j)(7 downto 0)  <= read_arr_byte_Q1(idx_Q +1)(7 downto 0);
                sig_arr_Q2(j)(15 downto 8) <= read_arr_byte_Q2(idx_Q)(7 downto 0);
                sig_arr_Q2(j)(7 downto 0)  <= read_arr_byte_Q2(idx_Q +1)(7 downto 0);
                sig_arr_Q3(j)(15 downto 8) <= read_arr_byte_Q3(idx_Q)(7 downto 0);
                sig_arr_Q3(j)(7 downto 0)  <= read_arr_byte_Q3(idx_Q +1)(7 downto 0);
                idx_Q := idx_Q + 2;
            end loop;    
            array_complete_Q <= '1'; 
        end if;

    end process;
    
    
  dsp_proc: process(aclk)
    variable idx : integer := 0;
    begin
    if (rising_edge(aclk)) then
        if array_complete_I = '1' then
            if idx < NUM_SAMPLES-1 then
                 ch_0_s_axis_data_tvalid <= '1';
                 ch_1_s_axis_data_tvalid <= '1';
                 ch_2_s_axis_data_tvalid <= '1';
                 ch_3_s_axis_data_tvalid <= '1';
                s_axis_data_tdata_I0 <= sig_arr_I0(idx);
                s_axis_data_tdata_Q0 <= sig_arr_Q0(idx);
                s_axis_data_tdata_I1 <= sig_arr_I1(idx);
                s_axis_data_tdata_Q1 <= sig_arr_Q2(idx);
                s_axis_data_tdata_I2 <= sig_arr_I2(idx);
                s_axis_data_tdata_Q2 <= sig_arr_Q2(idx);
                s_axis_data_tdata_I3 <= sig_arr_I3(idx);
                s_axis_data_tdata_Q3 <= sig_arr_Q3(idx);

                idx := idx + 1;
            end if;
        end if;
    
    end if;
    
    end process;
    
    
    
 Ch_0_s_axis_data_tdata <= s_axis_data_tdata_I0 & s_axis_data_tdata_Q0 ;
 Ch_1_s_axis_data_tdata <= s_axis_data_tdata_I1 & s_axis_data_tdata_Q1 ;
 Ch_2_s_axis_data_tdata <= s_axis_data_tdata_I2 & s_axis_data_tdata_Q2 ;
 Ch_3_s_axis_data_tdata <= s_axis_data_tdata_I3 & s_axis_data_tdata_Q3 ;   
    
  
end Behavioral;
