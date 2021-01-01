module FFT2(
  input clk,
  input rst,
  input signed [31:0] x_re,
  input signed [31:0] x_im,
  input signed [31:0] y_re,
  input signed [31:0] y_im,
  input signed [31:0] w_re,
  input signed [31:0] w_im,
  
  output reg signed [31:0] fft_a_re,
  output reg signed [31:0] fft_a_im,
  output reg signed [31:0] fft_b_re,
  output reg signed [31:0] fft_b_im
);
  wire signed [63:0] temp_re, temp_im;

  assign temp_re = (x_re - y_re)*w_re + (y_im - x_im)*w_im;
  assign temp_im = (x_re - y_re)*w_im + (x_im - y_im)*w_re;
  
  always@(posedge clk)begin
    fft_a_re <= x_re + y_re;
    fft_a_im <= x_im + y_im;    
    fft_b_re <= {temp_re[47:32], temp_re[31:16]};
    fft_b_im <= {temp_im[47:32], temp_im[31:16]};
  end
endmodule