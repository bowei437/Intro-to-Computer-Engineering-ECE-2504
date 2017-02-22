library verilog;
use verilog.vl_types.all;
entity DP2_Spring2015 is
    port(
        LED             : out    vl_logic_vector(7 downto 0);
        CLOCK_50        : in     vl_logic;
        KEY             : in     vl_logic_vector(1 downto 0);
        SW              : in     vl_logic_vector(3 downto 0)
    );
end DP2_Spring2015;
