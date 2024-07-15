library verilog;
use verilog.vl_types.all;
entity fft_vlg_check_tst is
    port(
        O0_imag         : in     vl_logic_vector(15 downto 0);
        O0_real         : in     vl_logic_vector(15 downto 0);
        O1_imag         : in     vl_logic_vector(15 downto 0);
        O1_real         : in     vl_logic_vector(15 downto 0);
        O2_imag         : in     vl_logic_vector(15 downto 0);
        O2_real         : in     vl_logic_vector(15 downto 0);
        O3_imag         : in     vl_logic_vector(15 downto 0);
        O3_real         : in     vl_logic_vector(15 downto 0);
        O4_imag         : in     vl_logic_vector(15 downto 0);
        O4_real         : in     vl_logic_vector(15 downto 0);
        O5_imag         : in     vl_logic_vector(15 downto 0);
        O5_real         : in     vl_logic_vector(15 downto 0);
        O6_imag         : in     vl_logic_vector(15 downto 0);
        O6_real         : in     vl_logic_vector(15 downto 0);
        O7_imag         : in     vl_logic_vector(15 downto 0);
        O7_real         : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end fft_vlg_check_tst;
