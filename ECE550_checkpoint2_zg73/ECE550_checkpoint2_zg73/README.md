name: Zixu Geng
netid: zg73
Description: In this project, I implemented functions: isLessThan, and IsEqual in 32bit subtraction. What's more, I also implemented bitwise and, bitwise or, which is & | in Verilog. At last, I wrote about the logical right shift and the Arithmetic left shift. 

For isLessThan, I use one xor gate to have the result with xor(isLessThan, data_result[31], overflow), where data_result is the result of subtraction and overflow is the value that I wrote last time.

For IsEqual, I use 4 or gate to find whether there is 1 in the subtraction result, if yes, A and B are not equal, otherwise are equal.

For bitwise and, bitwise or, I use generate for, and gate, or gate for each bit of the input value, and return the output.

For logical right shift, I used 5 layers of shift, which will shift 1 bit, 2 bits, 4 bits, 8 bits, and 16 bits, which is controlled by ctrl_shiftamt. There will be a wire with the const value 0, which is used for bringing in 0s. 

For the Arithmetic left shift, the structure is similar to the logical right shift except the value of the wire is the sign bit, which is used to bring in value at left.