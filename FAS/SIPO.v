module SIPO(
  input clk,
  input rst,
  input [15:0] fir_d,
  input fir_valid,
  
  output reg [15:0] fir_d_para0,
  output reg [15:0] fir_d_para1,
  output reg [15:0] fir_d_para2,
  output reg [15:0] fir_d_para3,
  output reg [15:0] fir_d_para4,
  output reg [15:0] fir_d_para5,
  output reg [15:0] fir_d_para6,
  output reg [15:0] fir_d_para7,
  output reg [15:0] fir_d_para8,
  output reg [15:0] fir_d_para9,
  output reg [15:0] fir_d_para10,
  output reg [15:0] fir_d_para11,
  output reg [15:0] fir_d_para12,
  output reg [15:0] fir_d_para13,
  output reg [15:0] fir_d_para14,
  output reg [15:0] fir_d_para15,
  output fir_para_valid
);

  reg [15:0] mem[15:0];
  reg [4:0] cnt;
  
  
  assign fir_para_valid = (cnt == 5'd16);
  
  always@(posedge clk)begin
    if(rst)
      cnt <= 'd0;
    else if(cnt >= 5'd16)
      cnt <= cnt;
    else if(fir_valid)
      cnt <= cnt + 1;
   
  end

  always@(posedge clk)begin
    if(rst)begin
      mem[0] <= 16'd0;
      mem[1] <= 16'd0;
      mem[2] <= 16'd0;
      mem[3] <= 16'd0;
      mem[4] <= 16'd0;
      mem[5] <= 16'd0;
      mem[6] <= 16'd0;
      mem[7] <= 16'd0;
      mem[8] <= 16'd0;
      mem[9] <= 16'd0;
      mem[10] <= 16'd0;
      mem[11] <= 16'd0;
      mem[12] <= 16'd0;
      mem[13] <= 16'd0;
      mem[14] <= 16'd0;
      mem[15] <= 16'd0;
    end
    else if(fir_valid)begin     
      mem[15] <= fir_d;
      mem[14] <= mem[15];
      mem[13] <= mem[14];
      mem[12] <= mem[13];
      mem[11] <= mem[12];
      mem[10] <= mem[11];
      mem[9] <= mem[10];
      mem[8] <= mem[9];
      mem[7] <= mem[8];
      mem[6] <= mem[7];
      mem[5] <= mem[6];
      mem[4] <= mem[5];
      mem[3] <= mem[4];
      mem[2] <= mem[3];
      mem[1] <= mem[2];
      mem[0] <= mem[1];
    end
  end
  
  always@*begin
    fir_d_para0 = mem[0];
    fir_d_para1 = mem[1];
    fir_d_para2 = mem[2];
    fir_d_para3 = mem[3];
    fir_d_para4 = mem[4];
    fir_d_para5 = mem[5];
    fir_d_para6 = mem[6];
    fir_d_para7 = mem[7];
    fir_d_para8 = mem[8];
    fir_d_para9 = mem[9];
    fir_d_para10 = mem[10];
    fir_d_para11 = mem[11];
    fir_d_para12 = mem[12];
    fir_d_para13 = mem[13];
    fir_d_para14 = mem[14];
    fir_d_para15 = mem[15];
  end

endmodule