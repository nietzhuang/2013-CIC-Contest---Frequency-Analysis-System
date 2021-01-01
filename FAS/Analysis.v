module Analysis(
  input clk, 
  input rst,
  input  [31:0] fft_d0, fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7, fft_d8,
  input  [31:0] fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15, 
  input fft_valid,
  
  output done,
  output reg [3:0] freq
);
  wire [31:0] square_sum[15:0];
  wire [31:0] comp01, comp23, comp45, comp67, comp89, comp1011, comp1213, comp1415;
  wire [31:0] comp0_3, comp4_7, comp8_11, comp12_15;
  wire [31:0] comp0_7, comp8_15;
  wire [31:0] comp_final;
  wire [15:0] re[15:0], im[15:0];
 
  reg [5:0] cnt;
  
  always@(posedge clk)begin
    if(rst)
      cnt <= 6'd0;
    else if(fft_valid)
      cnt <= cnt + 6'd1;
  end
 
  assign done = (cnt < 7'd63)? fft_valid : 1'b0;
 
  assign re[0] = (fft_d0[31])? (fft_d0[31:16]^16'hffff) + 16'd1 : fft_d0[31:16];
  assign re[1] = (fft_d1[31])? (fft_d1[31:16]^16'hffff) + 16'd1 : fft_d1[31:16];
  assign re[2] = (fft_d2[31])? (fft_d2[31:16]^16'hffff) + 16'd1 : fft_d2[31:16];
  assign re[3] = (fft_d3[31])? (fft_d3[31:16]^16'hffff) + 16'd1 : fft_d3[31:16];
  assign re[4] = (fft_d4[31])? (fft_d4[31:16]^16'hffff) + 16'd1 : fft_d4[31:16];
  assign re[5] = (fft_d5[31])? (fft_d5[31:16]^16'hffff) + 16'd1 : fft_d5[31:16];
  assign re[6] = (fft_d6[31])? (fft_d6[31:16]^16'hffff) + 16'd1 : fft_d6[31:16];
  assign re[7] = (fft_d7[31])? (fft_d7[31:16]^16'hffff) + 16'd1 : fft_d7[31:16];
  assign re[8] = (fft_d8[31])? (fft_d8[31:16]^16'hffff) + 16'd1 : fft_d8[31:16];
  assign re[9] = (fft_d9[31])? (fft_d9[31:16]^16'hffff) + 16'd1 : fft_d9[31:16];
  assign re[10] = (fft_d10[31])? (fft_d10[31:16]^16'hffff) + 16'd1 : fft_d10[31:16];
  assign re[11] = (fft_d11[31])? (fft_d11[31:16]^16'hffff) + 16'd1 : fft_d11[31:16];
  assign re[12] = (fft_d12[31])? (fft_d12[31:16]^16'hffff) + 16'd1 : fft_d12[31:16];
  assign re[13] = (fft_d13[31])? (fft_d13[31:16]^16'hffff) + 16'd1 : fft_d13[31:16];
  assign re[14] = (fft_d14[31])? (fft_d14[31:16]^16'hffff) + 16'd1 : fft_d14[31:16];
  assign re[15] = (fft_d15[31])? (fft_d15[31:16]^16'hffff) + 16'd1 : fft_d15[31:16];
  assign im[0] = (fft_d0[15])? (fft_d0[15:0]^16'hffff) + 16'd1 : fft_d0[15:0];
  assign im[1] = (fft_d1[15])? (fft_d1[15:0]^16'hffff) + 16'd1 : fft_d1[15:0];
  assign im[2] = (fft_d2[15])? (fft_d2[15:0]^16'hffff) + 16'd1 : fft_d2[15:0];
  assign im[3] = (fft_d3[15])? (fft_d3[15:0]^16'hffff) + 16'd1 : fft_d3[15:0];
  assign im[4] = (fft_d4[15])? (fft_d4[15:0]^16'hffff) + 16'd1 : fft_d4[15:0];
  assign im[5] = (fft_d5[15])? (fft_d5[15:0]^16'hffff) + 16'd1 : fft_d5[15:0];
  assign im[6] = (fft_d6[15])? (fft_d6[15:0]^16'hffff) + 16'd1 : fft_d6[15:0];
  assign im[7] = (fft_d7[15])? (fft_d7[15:0]^16'hffff) + 16'd1 : fft_d7[15:0];
  assign im[8] = (fft_d8[15])? (fft_d8[15:0]^16'hffff) + 16'd1 : fft_d8[15:0];
  assign im[9] = (fft_d9[15])? (fft_d9[15:0]^16'hffff) + 16'd1 : fft_d9[15:0];
  assign im[10] = (fft_d10[15])? (fft_d10[15:0]^16'hffff) + 16'd1 : fft_d10[15:0];
  assign im[11] = (fft_d11[15])? (fft_d11[15:0]^16'hffff) + 16'd1 : fft_d11[15:0];
  assign im[12] = (fft_d12[15])? (fft_d12[15:0]^16'hffff) + 16'd1 : fft_d12[15:0];
  assign im[13] = (fft_d13[15])? (fft_d13[15:0]^16'hffff) + 16'd1 : fft_d13[15:0];
  assign im[14] = (fft_d14[15])? (fft_d14[15:0]^16'hffff) + 16'd1 : fft_d14[15:0];
  assign im[15] = (fft_d15[15])? (fft_d15[15:0]^16'hffff) + 16'd1 : fft_d15[15:0];

  assign square_sum[0] = re[0][14:0]*re[0][14:0] + im[0][14:0]*im[0][14:0]; 
  assign square_sum[1] = re[1][14:0]*re[1][14:0] + im[1][14:0]*im[1][14:0];
  assign square_sum[2] = re[2][14:0]*re[2][14:0] + im[2][14:0]*im[2][14:0];
  assign square_sum[3] = re[3][14:0]*re[3][14:0] + im[3][14:0]*im[3][14:0];
  assign square_sum[4] = re[4][14:0]*re[4][14:0] + im[4][14:0]*im[4][14:0];
  assign square_sum[5] = re[5][14:0]*re[5][14:0] + im[5][14:0]*im[5][14:0];
  assign square_sum[6] = re[6][14:0]*re[6][14:0] + im[6][14:0]*im[6][14:0];
  assign square_sum[7] = re[7][14:0]*re[7][14:0] + im[7][14:0]*im[7][14:0];
  assign square_sum[8] = re[8][14:0]*re[8][14:0] + im[8][14:0]*im[8][14:0];
  assign square_sum[9] = re[9][14:0]*re[9][14:0] + im[9][14:0]*im[9][14:0];
  assign square_sum[10] = re[10][14:0]*re[10][14:0] + im[10][14:0]*im[10][14:0];
  assign square_sum[11] = re[11][14:0]*re[11][14:0] + im[11][14:0]*im[11][14:0];
  assign square_sum[12] = re[12][14:0]*re[12][14:0] + im[12][14:0]*im[12][14:0];
  assign square_sum[13] = re[13][14:0]*re[13][14:0] + im[13][14:0]*im[13][14:0];
  assign square_sum[14] = re[14][14:0]*re[14][14:0] + im[14][14:0]*im[14][14:0];
  assign square_sum[15] = re[15][14:0]*re[15][14:0] + im[15][14:0]*im[15][14:0];
  
  assign comp01 = (square_sum[0] > square_sum[1])? square_sum[0] : square_sum[1];
  assign comp23 = (square_sum[2] > square_sum[3])? square_sum[2] : square_sum[3];
  assign comp45 = (square_sum[4] > square_sum[5])? square_sum[4] : square_sum[5];
  assign comp67 = (square_sum[6] > square_sum[7])? square_sum[6] : square_sum[7]; 
  assign comp89 = (square_sum[8] > square_sum[9])? square_sum[8] : square_sum[9];
  assign comp1011 = (square_sum[10] > square_sum[11])? square_sum[10] : square_sum[11];
  assign comp1213 = (square_sum[12] > square_sum[13])? square_sum[12] : square_sum[13];
  assign comp1415 = (square_sum[14] > square_sum[15])? square_sum[14] : square_sum[15];
  assign comp0_3 = (comp01 > comp23)? comp01 : comp23;
  assign comp4_7 = (comp45 > comp67)? comp45 : comp67;
  assign comp8_11 = (comp89 > comp1011)? comp89 : comp1011;
  assign comp12_15 = (comp1213 > comp1415)? comp1213 : comp1415;
  assign comp0_7 = (comp0_3 > comp4_7)? comp0_3 : comp4_7;
  assign comp8_15 = (comp8_11 > comp12_15)? comp8_11 : comp12_15;
  assign comp_final = (comp0_7 > comp8_15)? comp0_7 : comp8_15;

  always@*begin
    case(comp_final)
      square_sum[0]:freq = 4'b0000;
      square_sum[1]:freq = 4'b0001;
      square_sum[2]:freq = 4'b0010;
      square_sum[3]:freq = 4'b0011;
      square_sum[4]:freq = 4'b0100;
      square_sum[5]:freq = 4'b0101;
      square_sum[6]:freq = 4'b0110;
      square_sum[7]:freq = 4'b0111;
      square_sum[8]:freq = 4'b1000;
      square_sum[9]:freq = 4'b1001;
      square_sum[10]:freq = 4'b1010;
      square_sum[11]:freq = 4'b1011;
      square_sum[12]:freq = 4'b1100;
      square_sum[13]:freq = 4'b1101;
      square_sum[14]:freq = 4'b1110;
      square_sum[15]:freq = 4'b1111;
      default:freq = 4'b0000;
    endcase
    
  end
endmodule