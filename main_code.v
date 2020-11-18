`timescale 1ns / 1ps
module main_code(mult,in1,in2,clk,rst);

input clk, rst;
input [7:0] in1,in2;
output [15:0] mult;

wire [7:0] x,y; //inputs after register
wire [15:0] prod; //output before register
wire [7:0] w1,w2,w3,w4,w5,w6,w7,w8; //for AND or NAND gates
wire [7:0] h; // for outputs of HA
wire [7:0] f1,f2,f3,f4,f5,f6; //for outputs of FA
wire [7:0] c1; //carrys of HA
wire [7:0] fc1,fc2,fc3,fc4,fc5,fc6,ff; //carrys of FA

reg8 r1(x,in1,clk,rst); //register operations for i/p
reg8 r2(y,in2,clk,rst);

assign prod[0] = x[0] & y[0];
assign w1[0] = x[1] & y[0]; //row 1
assign w1[1] = x[2] & y[0];
assign w1[2] = x[3] & y[0];
assign w1[3] = x[4] & y[0];
assign w1[4] = x[5] & y[0];
assign w1[5] = x[6] & y[0];
assign w1[6] = ~(x[7] & y[0]);

assign w2[0] = x[0] & y[1]; //row 2
assign w2[1] = x[1] & y[1];
assign w2[2] = x[2] & y[1];
assign w2[3] = x[3] & y[1];
assign w2[4] = x[4] & y[1];
assign w2[5] = x[5] & y[1];
assign w2[6] = x[6] & y[1];
assign w2[7] = ~(x[7] & y[1]);

HA a1(prod[1],c1[0],w1[0],w2[0]); //row 3
HA a2(h[0],c1[1],w1[1],w2[1]);
HA a3(h[1],c1[2],w1[2],w2[2]);
HA a4(h[2],c1[3],w1[3],w2[3]);
HA a5(h[3],c1[4],w1[4],w2[4]);
HA a6(h[4],c1[5],w1[5],w2[5]);
HA a7(h[5],c1[6],w1[6],w2[6]);

assign w3[0] = x[0] & y[2]; //row 4
assign w3[1] = x[1] & y[2];
assign w3[2] = x[2] & y[2];
assign w3[3] = x[3] & y[2];
assign w3[4] = x[4] & y[2];
assign w3[5] = x[5] & y[2];
assign w3[6] = x[6] & y[2];
assign w3[7] = ~(x[7] & y[2]);

FA b1(prod[2],fc1[0],w3[0],c1[0],h[0]);
FA b2(f1[1],fc1[1],w3[1],c1[1],h[1]); //row5
FA b3(f1[2],fc1[2],w3[2],c1[2],h[2]);
FA b4(f1[3],fc1[3],w3[3],c1[3],h[3]);
FA b5(f1[4],fc1[4],w3[4],c1[4],h[4]);
FA b6(f1[5],fc1[5],w3[5],c1[5],h[5]);
FA b7(f1[6],fc1[6],w3[6],c1[6],w2[7]);

assign w4[0] = x[0] & y[3]; //row6
assign w4[1] = x[1] & y[3];
assign w4[2] = x[2] & y[3];
assign w4[3] = x[3] & y[3];
assign w4[4] = x[4] & y[3];
assign w4[5] = x[5] & y[3];
assign w4[6] = x[6] & y[3];
assign w4[7] = ~(x[7] & y[3]);

FA ac1(prod[3],fc2[0],w4[0],fc1[0],f1[1]);
FA ac2(f2[1],fc2[1],w4[1],fc1[1],f1[2]); //row7
FA ac3(f2[2],fc2[2],w4[2],fc1[2],f1[3]);
FA ac4(f2[3],fc2[3],w4[3],fc1[3],f1[4]);
FA ac5(f2[4],fc2[4],w4[4],fc1[4],f1[5]);
FA ac6(f2[5],fc2[5],w4[5],fc1[5],f1[6]);
FA ac7(f2[6],fc2[6],w4[6],fc1[6],w3[7]);

assign w5[0] = x[0] & y[4]; //row8
assign w5[1] = x[1] & y[4];
assign w5[2] = x[2] & y[4];
assign w5[3] = x[3] & y[4];
assign w5[4] = x[4] & y[4];
assign w5[5] = x[5] & y[4];
assign w5[6] = x[6] & y[4];
assign w5[7] = ~(x[7] & y[4]);

FA d1(prod[4],fc3[0],w5[0],fc2[0],f2[1]);
FA d2(f3[1],fc3[1],w5[1],fc2[1],f2[2]); //row9
FA d3(f3[2],fc3[2],w5[2],fc2[2],f2[3]);
FA d4(f3[3],fc3[3],w5[3],fc2[3],f2[4]);
FA d5(f3[4],fc3[4],w5[4],fc2[4],f2[5]);
FA d6(f3[5],fc3[5],w5[5],fc2[5],f2[6]);
FA d7(f3[6],fc3[6],w5[6],fc2[6],w4[7]);

assign w6[0] = x[0] & y[5]; //row10
assign w6[1] = x[1] & y[5];
assign w6[2] = x[2] & y[5];
assign w6[3] = x[3] & y[5];
assign w6[4] = x[4] & y[5];
assign w6[5] = x[5] & y[5];
assign w6[6] = x[6] & y[5];
assign w6[7] = ~(x[7] & y[5]);

FA e1(prod[5],fc4[0],w6[0],fc3[0],f3[1]);
FA e2(f4[1],fc4[1],w6[1],fc3[1],f3[2]); //row11
FA e3(f4[2],fc4[2],w6[2],fc3[2],f3[3]);
FA e4(f4[3],fc4[3],w6[3],fc3[3],f3[4]);
FA e5(f4[4],fc4[4],w6[4],fc3[4],f3[5]);
FA e6(f4[5],fc4[5],w6[5],fc3[5],f3[6]);
FA e7(f4[6],fc4[6],w6[6],fc3[6],w5[7]);

assign w7[0] = x[0] & y[6]; //row12
assign w7[1] = x[1] & y[6];
assign w7[2] = x[2] & y[6];
assign w7[3] = x[3] & y[6];
assign w7[4] = x[4] & y[6];
assign w7[5] = x[5] & y[6];
assign w7[6] = x[6] & y[6];
assign w7[7] = ~(x[7] & y[6]);

FA cc1(prod[6],fc5[0],w7[0],fc4[0],f4[1]);
FA cc2(f5[1],fc5[1],w7[1],fc4[1],f4[2]); //row13
FA cc3(f5[2],fc5[2],w7[2],fc4[2],f4[3]);
FA cc4(f5[3],fc5[3],w7[3],fc4[3],f4[4]);
FA cc5(f5[4],fc5[4],w7[4],fc4[4],f4[5]);
FA cc6(f5[5],fc5[5],w7[5],fc4[5],f4[6]);
FA cc7(f5[6],fc5[6],w7[6],fc4[6],w5[7]);

assign w8[0] = ~(x[0] & y[7]); //row14
assign w8[1] = ~(x[1] & y[7]);
assign w8[2] = ~(x[2] & y[7]);
assign w8[3] = ~(x[3] & y[7]);
assign w8[4] = ~(x[4] & y[7]);
assign w8[5] = ~(x[5] & y[7]);
assign w8[6] = ~(x[6] & y[7]);
assign w8[7] = x[7] & y[7];

FA g1(prod[7],fc6[0],w8[0],fc5[0],f5[1]);
FA g2(f6[1],fc6[1],w8[1],fc5[1],f5[2]); //row15
FA g3(f6[2],fc6[2],w8[2],fc5[2],f5[3]);
FA g4(f6[3],fc6[3],w8[3],fc5[3],f5[4]);
FA g5(f6[4],fc6[4],w8[4],fc5[4],f5[5]);
FA g6(f6[5],fc6[5],w8[5],fc5[5],f5[6]);
FA g7(f6[6],fc6[6],w8[6],fc5[6],w6[7]);


FA aa1(prod[8], ff[0], 1'b1, fc6[0], f6[1]); //row16
FA aa2(prod[9], ff[1], ff[0], fc6[1], f6[2]);
FA aa3(prod[10], ff[2], ff[1], fc6[2], f6[3]);
FA aa4(prod[11], ff[3], ff[2], fc6[3], f6[4]);
FA aa5(prod[12], ff[4], ff[3], fc6[4], f6[5]);
FA aa6(prod[13], ff[5], ff[4], fc6[5], f6[6]);
FA aa7(prod[14], ff[6], ff[5], fc6[6], w8[7]);
HA aa8(prod[15], ff[7], ff[6], 1'b1);

reg16 r3(mult,prod,clk,rst); //register operations for o/p

endmodule


module d_ff(q,d,clk,rst);

input d,clk,rst;
output reg q;

always @(posedge clk)
begin
 if(rst==1'b1)
  q <= 1'b0;
 else
  q <= d;
end

endmodule


module HA(s,c,a,b);

input a,b;
output s,c;

assign s = a^b;
assign c = a&b;

endmodule



module FA(sum,car,a,b,c);

input a,b,c;
output sum,car;

assign sum = (a^b^c);
assign car = ((a&b)|(b&c)|(c&a));

endmodule


module reg8(out,in,clk,rst);

input [7:0] in;
input clk, rst;
output [7:0] out;

d_ff a0(out[0],in[0],clk,rst);
d_ff a1(out[1],in[1],clk,rst);
d_ff a2(out[2],in[2],clk,rst);
d_ff a3(out[3],in[3],clk,rst);
d_ff a4(out[4],in[4],clk,rst);
d_ff a5(out[5],in[5],clk,rst);
d_ff a6(out[6],in[6],clk,rst);
d_ff a7(out[7],in[7],clk,rst);

//module d_ff(q,d,clk,rst);

endmodule


module reg16(out,in,clk,rst);

input [15:0] in;
input clk, rst;
output [15:0] out;

d_ff a0(out[0],in[0],clk,rst);
d_ff a1(out[1],in[1],clk,rst);
d_ff a2(out[2],in[2],clk,rst);
d_ff a3(out[3],in[3],clk,rst);
d_ff a4(out[4],in[4],clk,rst);
d_ff a5(out[5],in[5],clk,rst);
d_ff a6(out[6],in[6],clk,rst);
d_ff a7(out[7],in[7],clk,rst);
d_ff a8(out[8],in[8],clk,rst);
d_ff a9(out[9],in[9],clk,rst);
d_ff a10(out[10],in[10],clk,rst);
d_ff a11(out[11],in[11],clk,rst);
d_ff a12(out[12],in[12],clk,rst);
d_ff a13(out[13],in[13],clk,rst);
d_ff a14(out[14],in[14],clk,rst);
d_ff a15(out[15],in[15],clk,rst);

//module d_ff(q,d,clk,rst);

endmodule
