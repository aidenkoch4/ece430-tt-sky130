`default_nettype none

module tt_um_aidenkochhmwk07 (
    input  wire [7:0] ui_in,    // inputs
    output wire [7:0] uo_out,   // outputs
    input  wire [7:0] uio_in,   // bidir in
    output wire [7:0] uio_out,  // bidir out
    output wire [7:0] uio_oe,   // bidir enable
    input  wire       clk,
    input  wire       rst_n
);

    wire rst = ~rst_n;

    // Internal signals
    wire [63:0] p;
    wire done;

    // Registers to hold operands (very simple loading scheme)
    reg [31:0] mc;
    reg [31:0] mp;

    // Simple demo behavior:
    // load values when start asserted
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mc <= 0;
            mp <= 0;
        end else if (ui_in[2]) begin
            // pack input repeatedly (not realistic, but works for sim)
            mc <= {mc[23:0], ui_in};
            mp <= {mp[23:0], ui_in};
        end
    end

    // Instantiate your multiplier
    pm32 uut (
        .clk(clk),
        .rst(rst),
        .start(ui_in[2]),
        .mc(mc),
        .mp(mp),
        .p(p),
        .done(done)
    );

    // Output:
    assign uo_out = done ? p[7:0] : 8'h00;

    // No bidirectional usage
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule
