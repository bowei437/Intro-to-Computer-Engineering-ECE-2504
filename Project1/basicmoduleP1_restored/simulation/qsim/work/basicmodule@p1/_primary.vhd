library verilog;
use verilog.vl_types.all;
entity basicmoduleP1 is
    port(
        gate_t          : out    vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic;
        c               : in     vl_logic;
        d               : in     vl_logic;
        gate_u          : out    vl_logic;
        gate_v          : out    vl_logic;
        gate_w          : out    vl_logic;
        gate_x          : out    vl_logic;
        gate_y          : out    vl_logic;
        gate_z          : out    vl_logic;
        chip_w          : out    vl_logic;
        S3              : in     vl_logic;
        S2              : in     vl_logic;
        S1              : in     vl_logic;
        S0              : in     vl_logic;
        chip_x          : out    vl_logic;
        chip_t          : out    vl_logic;
        chip_dummy_led_output: out    vl_logic_vector(3 downto 0);
        gate_dummy_led_output: out    vl_logic_vector(3 downto 0)
    );
end basicmoduleP1;
