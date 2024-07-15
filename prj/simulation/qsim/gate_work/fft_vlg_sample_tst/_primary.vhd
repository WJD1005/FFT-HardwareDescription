library verilog;
use verilog.vl_types.all;
entity fft_vlg_sample_tst is
    port(
        CLK             : in     vl_logic;
        EN              : in     vl_logic;
        I0_imag         : in     vl_logic_vector(15 downto 0);
        I0_real         : in     vl_logic_vector(15 downto 0);
        I1_imag         : in     vl_logic_vector(15 downto 0);
        I1_real         : in     vl_logic_vector(15 downto 0);
        I2_imag         : in     vl_logic_vector(15 downto 0);
        I2_real         : in     vl_logic_vector(15 downto 0);
        I3_imag         : in     vl_logic_vector(15 downto 0);
        I3_real         : in     vl_logic_vector(15 downto 0);
        I4_imag         : in     vl_logic_vector(15 downto 0);
        I4_real         : in     vl_logic_vector(15 downto 0);
        I5_imag         : in     vl_logic_vector(15 downto 0);
        I5_real         : in     vl_logic_vector(15 downto 0);
        I6_imag         : in     vl_logic_vector(15 downto 0);
        I6_real         : in     vl_logic_vector(15 downto 0);
        I7_imag         : in     vl_logic_vector(15 downto 0);
        I7_real         : in     vl_logic_vector(15 downto 0);
        INV             : in     vl_logic;
        RESET           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end fft_vlg_sample_tst;
