title: Computer Organization and Structures
date: 2016-02-01 10:23:01 
tags: [Summary]
---

Data Representation
===
Data Coding
---
1. Conversion
	
	Decimal to Binary: 730.8125 -- 1011011010.1101
	Integer part: Divide by radix, get the remainder, from bottom to top;
	Floating part: Mulitiply by radix, get the integer part, from top to bottom.
	
2. True form
	* Definition: <b>Sign bit + Value bit</b>
	* Details: 
		* Fixed-point decimal
			
				if(-1 < X <= 0){
					A = 1 + |X|;			
				}
				else if(0 <= X < 1){
					A = X;
				}
			
		* Integer
			
				if(0 <= X < 2^(n-1)){
					A = X;
				}
				else if(-2^(n-1) < X <= 0){
					A = 2^(n-1) + X;
				}
			
	* Examples:	
		
		The word length of machine code is 8:
		+35 = 00100011
		-35 = 10100011
		+0.8125 = 0.1101000
		-0.8125 = 1.1101000
		0 = 00000000 <b>OR</b> 10000000
		
3. Complement
	* Definition: <b>A + B = M</b>
	* Details:
		* Fixed-point decimal
	    		
				if(0 <= X < 1){
					A = X;
				}
				else if(-1 <= X < 0){
					A = 2 - |X|;
				}
			
		* Integer
	    			
				if(0 <= X < 2 ^ (n - 1)){
					A = X;
				}
				else if(-2 ^ (n - 1) <= X < 0){
					A = 2 ^ n  - |X|;
				}
			
	* Example
		
		The word length of machine code is 8:
		+35 = 00100011
		-35 = 11011101
		+0.8125 = 0.1101000
		-0.8125 = 1.0011000
		0 = 00000000 
		-1 = 11111111
		-128 = 10000000
		
4. Base minus one complement
	* Definition:
	* Details:
		* Fixed-point decimal
	    		
				if(0 <= X < 1){
					A = X;
				}
				else if(-1 < X <= 0){
					A = 2 - 2 ^ (1 - n) - |X|;
				}
			
		* Integer
	    		
				if(0 <= X < 2 ^ (n - 1)){
					A = X;
				}
				else if(-2 ^ (n - 1) < X <= 0){
					A = 2 ^ n - 1  - |X|;
				}
			
	* Example
		
		The word length of machine code is 8:
		+35 = 00100011
		-35 = 11011100
		+0.8125 = 0.1101000
		-0.8125 = 1.0010111
		0 = 00000000 <b>OR</b> 11111111
		-1 = 11111110
		
5. Shift code
	* Definition
	* Details
		* Fixed-point decimal
	    		
				A = 1 + X;
			
		* Integer
			
				A = 2 ^ (n - 1) + X;
			
	* Example
		
		The word length of machine code is 8:
		+35 = 10100011
		-35 = 01011100
		+0.8125 = 1.1101000
		-0.8125 = 0.0011000
		0 = 10000000
		-1 = 00000000
		
5. BCD(Binary-Coded Decimal)
	* 8421
	* Excess-3 code: 8421 + 0011

Non-numeric data Coding
--- 
1. ASCII
2. Chinese characters

Error Correcting
---
1. Parity check code
2. Hamming code
3. CRC(Cyclic Redundancy Check code)

Operational method and ALU
===
Fixed point arithmetic
---
Arithmetic and Logical Unit
---
Floating point arithmetic
---

Memory System
===
Main Memory
---
Cache
---
Virtual Memory
---
External Memory
---

Instruction System
===
Structure shelf Definition
---
Design
---
Addressing mode
---
CISC & RISC
---

CPU
===
Structure
---
Hard wired Controller design
---
Microprogram Controller design
---

Pipeline and ILP(Instruction-Level Parallelism)
===
Pipeline processing
---
Floating point operation pipeline
---
Instruction pipeline
---

---
Bus & IO
===
Bus
---
1. A <b>bus</b> is a communication system that trasfers data between components inside a computer, or between computers.	
2. Bus types
	1. Control bus
	2. Address bus
	3. Data bus
3. Bus control(arbitration)
	* Centralized arbitration
		1. Daisy chain
		2. Polling
		3. Independent 
	* Distributed arbitration
		SCSI
Interface of IO
---
IO Technique
---
1. Programmed IO
2. Interruption
3. DMA(Direct Memory Access)
4. IO Channel
