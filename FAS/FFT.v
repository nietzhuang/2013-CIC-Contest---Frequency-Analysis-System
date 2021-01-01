`include "FFT2.v"

module FFT(
  input clk,
  input rst,
  input [15:0] fir_d_para0, // int[15:8], fra[7:0]
  input [15:0] fir_d_para1,
  input [15:0] fir_d_para2,
  input [15:0] fir_d_para3,
  input [15:0] fir_d_para4,
  input [15:0] fir_d_para5,
  input [15:0] fir_d_para6,
  input [15:0] fir_d_para7,
  input [15:0] fir_d_para8,
  input [15:0] fir_d_para9,
  input [15:0] fir_d_para10,
  input [15:0] fir_d_para11,
  input [15:0] fir_d_para12,
  input [15:0] fir_d_para13,
  input [15:0] fir_d_para14,
  input [15:0] fir_d_para15,
  input fir_para_valid,
  
  output [31:0] fft_d0, fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7, 
  output [31:0] fft_d8, fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15,
  output fft_valid
);
  
  reg [4:0] cnt;
  reg [2:0] cnt_valid;

  wire  [31:0] y[15:0];
  wire  [31:0] a_re[15:0], a_im[15:0];
  wire  [31:0] b_re[15:0], b_im[15:0];
  wire  [31:0] c_re[15:0], c_im[15:0];
  wire  [31:0] fft_d0_re, fft_d1_re, fft_d2_re, fft_d3_re, fft_d4_re, fft_d5_re, fft_d6_re, fft_d7_re, fft_d8_re, fft_d9_re, fft_d10_re,
              fft_d11_re, fft_d12_re, fft_d13_re, fft_d14_re, fft_d15_re;
  wire  [31:0] fft_d0_im, fft_d1_im, fft_d2_im, fft_d3_im, fft_d4_im, fft_d5_im, fft_d6_im, fft_d7_im, fft_d8_im, fft_d9_im, fft_d10_im,
              fft_d11_im, fft_d12_im, fft_d13_im, fft_d14_im, fft_d15_im;                           
              
  assign y[0] = {{8{fir_d_para0[15]}} ,fir_d_para0, 8'd0}; // int[31:16], fra[15:0]
  assign y[1] = {{8{fir_d_para1[15]}} ,fir_d_para1, 8'd0};
  assign y[2] = {{8{fir_d_para2[15]}} ,fir_d_para2, 8'd0};
  assign y[3] = {{8{fir_d_para3[15]}} ,fir_d_para3, 8'd0};
  assign y[4] = {{8{fir_d_para4[15]}} ,fir_d_para4, 8'd0};
  assign y[5] = {{8{fir_d_para5[15]}} ,fir_d_para5, 8'd0};
  assign y[6] = {{8{fir_d_para6[15]}} ,fir_d_para6, 8'd0};
  assign y[7] = {{8{fir_d_para7[15]}} ,fir_d_para7, 8'd0};
  assign y[8] = {{8{fir_d_para8[15]}} ,fir_d_para8, 8'd0};
  assign y[9] = {{8{fir_d_para9[15]}} ,fir_d_para9, 8'd0};
  assign y[10] = {{8{fir_d_para10[15]}} ,fir_d_para10, 8'd0};
  assign y[11] = {{8{fir_d_para11[15]}} ,fir_d_para11, 8'd0};
  assign y[12] = {{8{fir_d_para12[15]}} ,fir_d_para12, 8'd0};
  assign y[13] = {{8{fir_d_para13[15]}} ,fir_d_para13, 8'd0};
  assign y[14] = {{8{fir_d_para14[15]}} ,fir_d_para14, 8'd0};
  assign y[15] = {{8{fir_d_para15[15]}} ,fir_d_para15, 8'd0};

  assign fft_d0 = {fft_d0_re[23:8], fft_d0_im[23:8]}; // int_re[7:0], fra_re[7:0], int_im[7:0], fra_im[7:0]
  assign fft_d1 = {fft_d1_re[23:8], fft_d1_im[23:8]};
  assign fft_d2 = {fft_d2_re[23:8], fft_d2_im[23:8]};
  assign fft_d3 = {fft_d3_re[23:8], fft_d3_im[23:8]};
  assign fft_d4 = {fft_d4_re[23:8], fft_d4_im[23:8]};
  assign fft_d5 = {fft_d5_re[23:8], fft_d5_im[23:8]};
  assign fft_d6 = {fft_d6_re[23:8], fft_d6_im[23:8]};
  assign fft_d7 = {fft_d7_re[23:8], fft_d7_im[23:8]};
  assign fft_d8 = {fft_d8_re[23:8], fft_d8_im[23:8]};
  assign fft_d9 = {fft_d9_re[23:8], fft_d9_im[23:8]};
  assign fft_d10 = {fft_d10_re[23:8], fft_d10_im[23:8]};
  assign fft_d11 = {fft_d11_re[23:8], fft_d11_im[23:8]};
  assign fft_d12 = {fft_d12_re[23:8], fft_d12_im[23:8]};
  assign fft_d13 = {fft_d13_re[23:8], fft_d13_im[23:8]};
  assign fft_d14 = {fft_d14_re[23:8], fft_d14_im[23:8]};
  assign fft_d15 = {fft_d15_re[23:8], fft_d15_im[23:8]};
   
  

  //assign fft_valid = ((cnt == 5'd0)&&fir_para_valid);
  assign fft_valid = (cnt_valid == 3'd4);
  
  always@(posedge clk)begin
    if(rst||(cnt == 5'd15))
      cnt <= 5'd0;
    else if(fir_para_valid)
      cnt <= cnt + 1;
  end 

  always@(posedge clk)begin
    if(rst||(cnt_valid == 3'd4))
      cnt_valid <= 3'd0;
    else if(((cnt == 5'd0)&&fir_para_valid)||(cnt_valid != 3'd0))
      cnt_valid <= cnt_valid + 1;
  end  
  
  FFT2 fft1_0( 
    .clk(clk),
    .rst(rst),
    .x_re(y[0]),
    .x_im(32'h0),
    .y_re(y[8]),
    .y_im(32'h0),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(a_re[0]),
    .fft_a_im(a_im[0]),
    .fft_b_re(a_re[8]),
    .fft_b_im(a_im[8])
    ); 
  FFT2 fft1_1( 
    .clk(clk),
    .rst(rst),
    .x_re(y[1]),
    .x_im(32'h0),
    .y_re(y[9]),
    .y_im(32'h0),
    .w_re(32'h0000EC83),
    .w_im(32'hFFFF9E09),
    
    .fft_a_re(a_re[1]),
    .fft_a_im(a_im[1]),
    .fft_b_re(a_re[9]),
    .fft_b_im(a_im[9])
    ); 
  FFT2 fft1_2( 
    .clk(clk),
    .rst(rst),
    .x_re(y[2]),
    .x_im(32'h0),
    .y_re(y[10]),
    .y_im(32'h0),
    .w_re(32'h0000B504),
    .w_im(32'hFFFF4AFC),
    
    .fft_a_re(a_re[2]),
    .fft_a_im(a_im[2]),
    .fft_b_re(a_re[10]),
    .fft_b_im(a_im[10])
    ); 
  FFT2 fft1_3( 
    .clk(clk),
    .rst(rst),
    .x_re(y[3]),
    .x_im(32'h0),
    .y_re(y[11]),
    .y_im(32'h0),
    .w_re(32'h000061F7),
    .w_im(32'hFFFF137D),
    
    .fft_a_re(a_re[3]),
    .fft_a_im(a_im[3]),
    .fft_b_re(a_re[11]),
    .fft_b_im(a_im[11])
    ); 
  FFT2 fft1_4( 
    .clk(clk),
    .rst(rst),
    .x_re(y[4]),
    .x_im(32'h0),
    .y_re(y[12]),
    .y_im(32'h0),
    .w_re(32'h00000000),
    .w_im(32'hFFFF0000),
    
    .fft_a_re(a_re[4]),
    .fft_a_im(a_im[4]),
    .fft_b_re(a_re[12]),
    .fft_b_im(a_im[12])
    );
  FFT2 fft1_5( 
    .clk(clk),
    .rst(rst),
    .x_re(y[5]),
    .x_im(32'h0),
    .y_re(y[13]),
    .y_im(32'h0),
    .w_re(32'hFFFF9E09),
    .w_im(32'hFFFF137D),
    
    .fft_a_re(a_re[5]),
    .fft_a_im(a_im[5]),
    .fft_b_re(a_re[13]),
    .fft_b_im(a_im[13])
    ); 
  FFT2 fft1_6( 
    .clk(clk),
    .rst(rst),
    .x_re(y[6]),
    .x_im(32'h0),
    .y_re(y[14]),
    .y_im(32'h0),
    .w_re(32'hFFFF4AFC),
    .w_im(32'hFFFF4AFC),
    
    .fft_a_re(a_re[6]),
    .fft_a_im(a_im[6]),
    .fft_b_re(a_re[14]),
    .fft_b_im(a_im[14])
    );
  FFT2 fft1_7( 
    .clk(clk),
    .rst(rst),
    .x_re(y[7]),
    .x_im(32'h0),
    .y_re(y[15]),
    .y_im(32'h0),
    .w_re(32'hFFFF137D),
    .w_im(32'hFFFF9E09),
    
    .fft_a_re(a_re[7]),
    .fft_a_im(a_im[7]),
    .fft_b_re(a_re[15]),
    .fft_b_im(a_im[15])
    );
  FFT2 fft2_0(
    .clk(clk),
    .rst(rst),
    .x_re(a_re[0]),
    .x_im(a_im[0]),
    .y_re(a_re[4]),
    .y_im(a_im[4]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(b_re[0]),
    .fft_a_im(b_im[0]),
    .fft_b_re(b_re[4]),
    .fft_b_im(b_im[4])
    );
  FFT2 fft2_1(
    .clk(clk),
    .rst(rst),
    .x_re(a_re[1]),
    .x_im(a_im[1]),
    .y_re(a_re[5]),
    .y_im(a_im[5]),
    .w_re(32'h0000B504),
    .w_im(32'hFFFF4AFC),
    
    .fft_a_re(b_re[1]),
    .fft_a_im(b_im[1]),
    .fft_b_re(b_re[5]),
    .fft_b_im(b_im[5])
    );
  FFT2 fft2_2(
    .clk(clk),
    .rst(rst),
    .x_re(a_re[2]),
    .x_im(a_im[2]),
    .y_re(a_re[6]),
    .y_im(a_im[6]),
    .w_re(32'h00000000),
    .w_im(32'hFFFF0000),
    
    .fft_a_re(b_re[2]),
    .fft_a_im(b_im[2]),
    .fft_b_re(b_re[6]),
    .fft_b_im(b_im[6])
    );
  FFT2 fft2_3(
    .clk(clk),
    .rst(rst),
    .x_re(a_re[3]),
    .x_im(a_im[3]),
    .y_re(a_re[7]),
    .y_im(a_im[7]),
    .w_re(32'hFFFF4AFC),
    .w_im(32'hFFFF4AFC),
    
    .fft_a_re(b_re[3]),
    .fft_a_im(b_im[3]),
    .fft_b_re(b_re[7]),
    .fft_b_im(b_im[7])
    );
  FFT2 fft2_4(
    .clk(clk),
    .rst(rst),
    .x_re(a_re[8]),
    .x_im(a_im[8]),
    .y_re(a_re[12]),
    .y_im(a_im[12]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(b_re[8]),
    .fft_a_im(b_im[8]),
    .fft_b_re(b_re[12]),
    .fft_b_im(b_im[12])
    );
  FFT2 fft2_5(
    .clk(clk),
    .rst(rst),
    .x_re(a_re[9]),
    .x_im(a_im[9]),
    .y_re(a_re[13]),
    .y_im(a_im[13]),
    .w_re(32'h0000B504),
    .w_im(32'hFFFF4AFC),
    
    .fft_a_re(b_re[9]),
    .fft_a_im(b_im[9]),
    .fft_b_re(b_re[13]),
    .fft_b_im(b_im[13])
    );
  FFT2 fft2_6(
    .clk(clk),
    .rst(rst),
    .x_re(a_re[10]),
    .x_im(a_im[10]),
    .y_re(a_re[14]),
    .y_im(a_im[14]),
    .w_re(32'h00000000),
    .w_im(32'hFFFF0000),
    
    .fft_a_re(b_re[10]),
    .fft_a_im(b_im[10]),
    .fft_b_re(b_re[14]),
    .fft_b_im(b_im[14])
    );
  FFT2 fft2_7(
    .clk(clk),
    .rst(rst),
    .x_re(a_re[11]),
    .x_im(a_im[11]),
    .y_re(a_re[15]),
    .y_im(a_im[15]),
    .w_re(32'hFFFF4AFC),
    .w_im(32'hFFFF4AFC),
    
    .fft_a_re(b_re[11]),
    .fft_a_im(b_im[11]),
    .fft_b_re(b_re[15]),
    .fft_b_im(b_im[15])
    );
  FFT2 fft3_0(
    .clk(clk),
    .rst(rst),
    .x_re(b_re[0]),
    .x_im(b_im[0]),
    .y_re(b_re[2]),
    .y_im(b_im[2]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(c_re[0]),
    .fft_a_im(c_im[0]),
    .fft_b_re(c_re[2]),
    .fft_b_im(c_im[2])
    );
  FFT2 fft3_1(
    .clk(clk),
    .rst(rst),
    .x_re(b_re[1]),
    .x_im(b_im[1]),
    .y_re(b_re[3]),
    .y_im(b_im[3]),
    .w_re(32'h00000000),
    .w_im(32'hFFFF0000),
    
    .fft_a_re(c_re[1]),
    .fft_a_im(c_im[1]),
    .fft_b_re(c_re[3]),
    .fft_b_im(c_im[3])
    );
  FFT2 fft3_2(
    .clk(clk),
    .rst(rst),
    .x_re(b_re[4]),
    .x_im(b_im[4]),
    .y_re(b_re[6]),
    .y_im(b_im[6]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(c_re[4]),
    .fft_a_im(c_im[4]),
    .fft_b_re(c_re[6]),
    .fft_b_im(c_im[6])
    );
  FFT2 fft3_3(
    .clk(clk),
    .rst(rst),
    .x_re(b_re[5]),
    .x_im(b_im[5]),
    .y_re(b_re[7]),
    .y_im(b_im[7]),
    .w_re(32'h00000000),
    .w_im(32'hFFFF0000),
    
    .fft_a_re(c_re[5]),
    .fft_a_im(c_im[5]),
    .fft_b_re(c_re[7]),
    .fft_b_im(c_im[7])
    );
  FFT2 fft3_4(
    .clk(clk),
    .rst(rst),
    .x_re(b_re[8]),
    .x_im(b_im[8]),
    .y_re(b_re[10]),
    .y_im(b_im[10]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(c_re[8]),
    .fft_a_im(c_im[8]),
    .fft_b_re(c_re[10]),
    .fft_b_im(c_im[10])
    );
  FFT2 fft3_5(
    .clk(clk),
    .rst(rst),
    .x_re(b_re[9]),
    .x_im(b_im[9]),
    .y_re(b_re[11]),
    .y_im(b_im[11]),
    .w_re(32'h00000000),
    .w_im(32'hFFFF0000),
    
    .fft_a_re(c_re[9]),
    .fft_a_im(c_im[9]),
    .fft_b_re(c_re[11]),
    .fft_b_im(c_im[11])
    );
  FFT2 fft3_6(
    .clk(clk),
    .rst(rst),
    .x_re(b_re[12]),
    .x_im(b_im[12]),
    .y_re(b_re[14]),
    .y_im(b_im[14]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(c_re[12]),
    .fft_a_im(c_im[12]),
    .fft_b_re(c_re[14]),
    .fft_b_im(c_im[14])
    );
  FFT2 fft3_7(
    .clk(clk),
    .rst(rst),
    .x_re(b_re[13]),
    .x_im(b_im[13]),
    .y_re(b_re[15]),
    .y_im(b_im[15]),
    .w_re(32'h00000000),
    .w_im(32'hFFFF0000),
    
    .fft_a_re(c_re[13]),
    .fft_a_im(c_im[13]),
    .fft_b_re(c_re[15]),
    .fft_b_im(c_im[15])
    );
  FFT2 fft4_0(
    .clk(clk),
    .rst(rst),
    .x_re(c_re[0]),
    .x_im(c_im[0]),
    .y_re(c_re[1]),
    .y_im(c_im[1]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(fft_d0_re),
    .fft_a_im(fft_d0_im),
    .fft_b_re(fft_d8_re),
    .fft_b_im(fft_d8_im)
    );
  FFT2 fft4_1(
    .clk(clk),
    .rst(rst),
    .x_re(c_re[2]),
    .x_im(c_im[2]),
    .y_re(c_re[3]),
    .y_im(c_im[3]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(fft_d4_re),
    .fft_a_im(fft_d4_im),
    .fft_b_re(fft_d12_re),
    .fft_b_im(fft_d12_im)
    );
  FFT2 fft4_2(
    .clk(clk),
    .rst(rst),
    .x_re(c_re[4]),
    .x_im(c_im[4]),
    .y_re(c_re[5]),
    .y_im(c_im[5]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(fft_d2_re),
    .fft_a_im(fft_d2_im),
    .fft_b_re(fft_d10_re),
    .fft_b_im(fft_d10_im)
    );
  FFT2 fft4_3(
    .clk(clk),
    .rst(rst),
    .x_re(c_re[6]),
    .x_im(c_im[6]),
    .y_re(c_re[7]),
    .y_im(c_im[7]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(fft_d6_re),
    .fft_a_im(fft_d6_im),
    .fft_b_re(fft_d14_re),
    .fft_b_im(fft_d14_im)
    ); 
  FFT2 fft4_4(
    .clk(clk),
    .rst(rst),
    .x_re(c_re[8]),
    .x_im(c_im[8]),
    .y_re(c_re[9]),
    .y_im(c_im[9]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(fft_d1_re),
    .fft_a_im(fft_d1_im),
    .fft_b_re(fft_d9_re),
    .fft_b_im(fft_d9_im)
    );
  FFT2 fft4_5(
    .clk(clk),
    .rst(rst),
    .x_re(c_re[10]),
    .x_im(c_im[10]),
    .y_re(c_re[11]),
    .y_im(c_im[11]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(fft_d5_re),
    .fft_a_im(fft_d5_im),
    .fft_b_re(fft_d13_re),
    .fft_b_im(fft_d13_im)
    );
  FFT2 fft4_6(
    .clk(clk),
    .rst(rst),
    .x_re(c_re[12]),
    .x_im(c_im[12]),
    .y_re(c_re[13]),
    .y_im(c_im[13]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(fft_d3_re),
    .fft_a_im(fft_d3_im),
    .fft_b_re(fft_d11_re),
    .fft_b_im(fft_d11_im)
    );
  FFT2 fft4_7(
    .clk(clk),
    .rst(rst),
    .x_re(c_re[14]),
    .x_im(c_im[14]),
    .y_re(c_re[15]),
    .y_im(c_im[15]),
    .w_re(32'h00010000),
    .w_im(32'h00000000),
    
    .fft_a_re(fft_d7_re),
    .fft_a_im(fft_d7_im),
    .fft_b_re(fft_d15_re),
    .fft_b_im(fft_d15_im)
    );

endmodule