library verilog;
use verilog.vl_types.all;
entity basicmoduleP1_vlg_check_tst is
    port(
        chip_dummy_led_output: in     vl_logic_vector(3 downto 0);
        chip_t          : in     vl_logic;
        chip_w          : in     vl_logic;
        chip_x          : in     vl_logic;
        gate_dummy_led_output: in     vl_logic_vector(3 downto 0);
        gate_t          : in     vl_logic;
        gate_u          : in     vl_logic;
        gate_v          : in     vl_logic;
        gate_w          : in     vl_logic;
        gate_x          : in     vl_logic;
        gate_y          : in     vl_logic;
        gate_z          : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end basicmoduleP1_vlg_check_tst;
