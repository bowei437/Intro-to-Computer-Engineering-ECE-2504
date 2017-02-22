library verilog;
use verilog.vl_types.all;
entity DP3_Spring2015 is
    port(
        altera_reserved_tms: in     vl_logic;
        altera_reserved_tck: in     vl_logic;
        altera_reserved_tdi: in     vl_logic;
        altera_reserved_tdo: out    vl_logic;
        CLOCK_50        : in     vl_logic;
        LED             : out    vl_logic_vector(7 downto 0);
        KEY             : in     vl_logic_vector(1 downto 0);
        SW              : in     vl_logic_vector(3 downto 0)
    );
end DP3_Spring2015;
