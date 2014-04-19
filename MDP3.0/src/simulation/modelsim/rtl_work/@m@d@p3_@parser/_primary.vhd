library verilog;
use verilog.vl_types.all;
entity MDP3_Parser is
    port(
        clk             : in     vl_logic;
        done            : in     vl_logic;
        MESSAGE         : in     vl_logic_vector(63 downto 0);
        NUM_ORDERS      : out    vl_logic_vector(7 downto 0);
        QUANTITY        : out    vl_logic_vector(15 downto 0);
        PRICE           : out    vl_logic_vector(63 downto 0);
        ACTION          : out    vl_logic_vector(1 downto 0);
        ENTRY_TYPE      : out    vl_logic_vector(1 downto 0);
        message_ready   : out    vl_logic
    );
end MDP3_Parser;
