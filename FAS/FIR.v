module FIR(
  input clk,
  input rst,
  input [15:0] data,
  input data_valid,
 
  output [15:0] fir_d,
  output fir_valid
);

`include "./dat/FIR_coefficient.dat"

  reg signed [15:0] mem[31:0];
  reg [5:0] cnt;
  
  wire signed [35:0] w[31:0];
  wire signed [35:0] sum;
  
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
      mem[16] <= 16'd0;
      mem[17] <= 16'd0;
      mem[18] <= 16'd0;
      mem[19] <= 16'd0;
      mem[20] <= 16'd0;
      mem[21] <= 16'd0;
      mem[22] <= 16'd0;
      mem[23] <= 16'd0;
      mem[24] <= 16'd0;
      mem[25] <= 16'd0;
      mem[26] <= 16'd0;
      mem[27] <= 16'd0;
      mem[28] <= 16'd0;
      mem[29] <= 16'd0;
      mem[30] <= 16'd0;
      mem[31] <= 16'd0;
    end
    else if(data_valid)begin
      mem[0] <= data;
      mem[1] <= mem[0];
      mem[2] <= mem[1];
      mem[3] <= mem[2];
      mem[4] <= mem[3];
      mem[5] <= mem[4];
      mem[6] <= mem[5];
      mem[7] <= mem[6];
      mem[8] <= mem[7];
      mem[9] <= mem[8];
      mem[10] <= mem[9];
      mem[11] <= mem[10];
      mem[12] <= mem[11];
      mem[13] <= mem[12];
      mem[14] <= mem[13];
      mem[15] <= mem[14];
      mem[16] <= mem[15];
      mem[17] <= mem[16];
      mem[18] <= mem[17];
      mem[19] <= mem[18];
      mem[20] <= mem[19];
      mem[21] <= mem[20];
      mem[22] <= mem[21];
      mem[23] <= mem[22];
      mem[24] <= mem[23];
      mem[25] <= mem[24];
      mem[26] <= mem[25];
      mem[27] <= mem[26];
      mem[28] <= mem[27];
      mem[29] <= mem[28];
      mem[30] <= mem[29];
      mem[31] <= mem[30];
   end
  end
  
  always@(posedge clk)begin // cnt
    if(rst)
      cnt <= 6'd0;
    else if(cnt == 6'd33)
      cnt <= cnt;
    else
      cnt <= cnt + 1;    
  end
 
  assign fir_valid = ( cnt > 6'd32 );
  
  assign w[0] = mem[0] * FIR_C00;
  assign w[1] = mem[1] * FIR_C01;
  assign w[2] = mem[2] * FIR_C02;
  assign w[3] = mem[3] * FIR_C03;
  assign w[4] = mem[4] * FIR_C04;
  assign w[5] = mem[5] * FIR_C05;
  assign w[6] = mem[6] * FIR_C06;
  assign w[7] = mem[7] * FIR_C07;
  assign w[8] = mem[8] * FIR_C08;
  assign w[9] = mem[9] * FIR_C09;
  assign w[10] = mem[10] * FIR_C10;
  assign w[11] = mem[11] * FIR_C11;
  assign w[12] = mem[12] * FIR_C12;
  assign w[13] = mem[13] * FIR_C13;
  assign w[14] = mem[14] * FIR_C14;
  assign w[15] = mem[15] * FIR_C15;
  assign w[16] = mem[16] * FIR_C16;
  assign w[17] = mem[17] * FIR_C17;
  assign w[18] = mem[18] * FIR_C18;
  assign w[19] = mem[19] * FIR_C19;
  assign w[20] = mem[20] * FIR_C20;
  assign w[21] = mem[21] * FIR_C21;
  assign w[22] = mem[22] * FIR_C22;
  assign w[23] = mem[23] * FIR_C23;
  assign w[24] = mem[24] * FIR_C24;
  assign w[25] = mem[25] * FIR_C25;
  assign w[26] = mem[26] * FIR_C26;
  assign w[27] = mem[27] * FIR_C27;
  assign w[28] = mem[28] * FIR_C28;
  assign w[29] = mem[29] * FIR_C29;
  assign w[30] = mem[30] * FIR_C30;
  assign w[31] = mem[31] * FIR_C31;

  assign sum = ((((w[ 0] + w[ 1]) + (w[ 2] + w[ 3])) + ((w[ 4] + w[ 5]) + (w[ 6] + w[ 7]))) + (((w[ 8] + w[ 9]) + (w[10] + w[11])) + ((w[12] + w[13]) + (w[14] + w[15]))))+
               ((((w[16] + w[17]) + (w[18] + w[19])) + ((w[20] + w[21]) + (w[22] + w[23]))) + (((w[24] + w[25]) + (w[26] + w[27])) + ((w[28] + w[29]) + (w[30] + w[31]))));              
           
  assign fir_d = (sum[35])? {sum[35], sum[30:24], sum[23:16]}+ 16'd1/*why add 1*/ : {sum[34], sum[30:24], sum[23:16]}; //{sum[31:24],sum[23:16]};

endmodule