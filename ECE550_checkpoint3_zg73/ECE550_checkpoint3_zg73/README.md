name: Zixu Geng
netid: zg73
Description: In this project, I implemented functions: one register file that contains 32 32-bit register, one write port that accept ctrl_writeReg, ctrl_wrtie_Enable as inputs, two read ports that output data in register based on ctrl_readReg.

Write port: Write port contains a 5-32 decoder and 32 and gates to control whether write in the corresponding register.

Register File: register file contains 32 32bits register, and the inputs are data_writeReg, write_info from write_port and clock, 

Read Port: Similar with write port, read port also contains a 5-32 decoder, and use tristate buffer to determine which register's output will be read.

