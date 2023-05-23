module datapath(input clk, rst, ld, sh_en, eng_start, ui_reg_ld ,
                input [4:0] V, input [1:0] U,
                output eng_done, output [20:0] wr_data);

        wire [15:0] eng_x , fracpart;
        wire [1:0] shift_numb;
        wire [1:0] intpart;
    
        // reg [17:0] exp_eng_out;
        // assign exp_eng_out  = {intpart,fracpart};
        shiftRegister shift_reg( .clk(clk), .rst(rst), .zero(1'b0), .init(1'b0), .ld(ld),
                        .sh_en(sh_en), .r_in({3'b0,V, 8'b0}), .r_out(eng_x));

        register2 ui_reg( .clk(clk), .rst(rst), .ld(ui_reg_ld), .r_in(U), .r_out(shift_numb));

        shiftComb shift_comb(.in({intpart,fracpart}), .shiftNumb(shift_numb),.wrData(wr_data));

        exponential exp_eng(.clk(clk), .rst(rst), .start(eng_start), .x(eng_x),
                        .done(eng_done),.intpart(intpart), .fracpart(fracpart));
        
endmodule 