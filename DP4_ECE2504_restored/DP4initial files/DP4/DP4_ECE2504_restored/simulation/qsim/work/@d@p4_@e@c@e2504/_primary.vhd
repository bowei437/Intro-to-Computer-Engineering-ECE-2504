library verilog;
use verilog.vl_types.all;
entity DP4_ECE2504 is
    port(
        CLOCK_50        : in     vl_logic;
        LED             : out    vl_logic_vector(7 downto 0);
        KEY             : in     vl_logic_vector(1 downto 0);
        SW              : in     vl_logic_vector(3 downto 0)
    );
end DP4_ECE2504;
