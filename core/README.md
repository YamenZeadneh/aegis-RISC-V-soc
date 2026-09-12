# ISA green card
## R (work with Registers only)
|   | 31:29 | 28:24 | 23:19 | 18:14  | 13:4 |3:0|
| :---: | :---: | :---: | :---:  | :---: | :---: | :---:|
| **R** | opcode | rs | rt | rd  | nop | function code|

- opcode = 000

| instruction    | DESCRIPTION            | function code |
| :---:          | :---:                  | :---:| 
| add rd,rs,rt   | [rd] = [rs] + [rt]     | 0000 | 
| sub rd,rs,rt   | [rd] = [rs] + ~[rt] + 1| 0001 | 
| or  rd,rs,rt   | [rd]=[rs]or[rt]        | 0010 | 
| shl rd,rs,rt   | [rd]=[rs]<<rt[5:0]     | 0011 | 
| shr rd,rs,rt   | [rd]=[rs]>>rt[5:0]     | 0100 |
| sar rd,rs,rt   | [rd]=[rs]>>>rt[5:0]    | 0101 | 
| xor  rd,rs,rt  | [rd]=[rs]^[rt]         | 0110 | 
| and  rd,rs,rt  | [rd]=[rs]&[rt]         | 0111 | 
| nand  rd,rs,rt | [rd]=~([rs]&[rt])      | 1000 | 
| nor  rd,rs,rt  | [rd]=~([rs]or[rt])     | 1001 | 
| nxor  rd,rs,rt | [rd]=~([rs]^[rt])      | 1010 | 

- you may noticed there's no `set less than` instruction or simmeller code , this is because we work with  flags   for comparing,  check the `C-type`instruction 

## I (work with one Register (rs) and Imm value  then store the resulte on the rt Register)
|   | 31:29 | 28:24 | 23:19 | 18:4  | 3:0 |
| :---: | :---: | :---: | :---:  | :---: | :---: |
| **I** | opcode | rs | rt | Imm(15-bit)  | function |

- opcode = 001

| instruction     | DESCRIPTION   | function code |
|          :---:  | :---:         | :---: |
| addi  rt,rs,Imm | [rt]=[rs]+Imm | 0000 |
| subi  rt,rs,Imm | [rt]=[rs]+~Imm+1 | 0001 | 
| ori   rt,rs,Imm | [rt]=[rs]orImm | 0010 | 
| shli  rt,rs,Imm | [rt]=[rs]<<Imm[5:0] | 0011 | 
| shri  rt,rs,Imm | [rt]=[rs]>>Imm[5:0] | 0100 |
| sari  rt,rs,Imm | [rt]=[rs]>>>Imm[5:0] | 0101 | 
| xori  rt,rs,Imm | [rt]=[rs]^Imm | 0110 | 
| andi  rt,rs,Imm | [rt]=[rs]&Imm | 0111 | 
| nandi rt,rs,Imm | [rt]=~([rs]&Imm) | 1000 | 
| nori  rt,rs,Imm | [rt]=~([rs]orImm) | 1001 | 
| nxori rt,rs,Imm | [rt]=~([rs]^Imm) | 1010 | 

- Imm is Singed value and will be extended to 64-bit
## IB (work with one or tow Register and Imm value to updata the PC value)
|   | 31:29 | 28:24 | 23:19 | 18:4  | 3:0 |
| :---: | :---: | :---: | :---:  | :---: | :---: |
| **IB** | opcode | rs | rt | Imm(15-bit)  | function |

- opcode = 010

| instruction    | DESCRIPTION   | function code |
|          :---: | :---:         | :---: |
| beq  rt,rs,Imm | if [rt] == [rs] : Pc+=(Imm<<2)+4 | 0000 |
| bneq rt,rs,Imm | if [rt] != [rs] : Pc+=(Imm<<2)+4 | 0001 |
| blt  rt,rs,Imm | if [rt] <  [rs] : Pc+=(Imm<<2)+4 | 0010 |
| ble  rt,rs,Imm | if [rt] <= [rs] : Pc+=(Imm<<2)+4 | 0011 |
| bltu rt,rs,Imm | if [rt] <  [rs] : Pc+=(Imm<<2)+4 | 0100 |
| bleu rt,rs,Imm | if [rt] <= [rs] : Pc+=(Imm<<2)+4 | 0101 |

- last tow work with Register as if it has unsigned value
- Imm is Singed value and will be extended to 64-bit
## M (take rt+Imm value as memory addres to store rs or load to rs)
|   | 31:29 | 28:24 | 23:19 | 18:4  | 3:0 |
| :---: | :---: | :---: | :---:  | :---: | :---: |
| **M** | opcode | rs | rt | Imm(15-bit)  | function |

- opcode = 011


| instruction    | DESCRIPTION   | function code |
|          :---: | :---:         | :---: |
| load  rt,Imm(rs) | [rt] = Memory[[rs]+Imm..[rs]+Imm + 7] | 0000 |
| stor  rt,Imm(rs) | Memory[[rs]+Imm..[rs]+Imm + 7] = [rt] | 0000 |

- Imm%4 should be 0 other wise the assembler will make it for example `load r5 , 19(r4)` will become `load r5 , 16(r4)`

## J (update PC value to the Imm value directly)

|   | 31:29 | 28:24 | 23:19 | 18:4  | 3:0 |
| :---: | :---: | :---: | :---:  | :---: | :---: |
| **J** | opcode | rs | rt | Imm(15-bit)  | function |

- opcode = 100


| instruction        | DESCRIPTION            | function code |
|          :---:     | :---:                  | :---: |
|  jal rs , Imm      | [rs] = PC+4 ; PC+=(Imm<<2)+4 | 0000 |
| jalr rs , rt , Imm | [rt] = PC+4 ;PC = [rs] + (Imm<<2)+4 | 0001 |

## C (compare tow register using the ALU and store the resulte on flags )


|   | 31:29 | 28:24 | 23:19 | 18:4  | 3:0 |
| :---: | :---: | :---: | :---:  | :---: | :---: |
| **C** | opcode | rs | rt | Imm(15-bit)  | function |

- opcode = 101

|  flag | flag name                      |  
| :---: | :---:                          |
| L     | is less than ? 1 : 0           |
| E     | is equal ? 1 : 0               |
| B     | is less or equal than ? 1 :  0 |

| instruction  | DESCRIPTION                   | function code |
|        :---: | :---:                            | :---:|
| cmp  rs , rt | L = ([rs]<[rt])?  1 : 0 ;<br> E = ([rs]==[rt])? 1 : 0   ;<br> B = ([rs]<=[rt])? 1 : 0 ;     | 0001 |
| cmpu  rs , rt| L = ([rs]<[rt])?  1 : 0 ;<br> E = ([rs]==[rt])? 1 : 0   ;<br> B = ([rs]<=[rt])? 1 : 0 ;     | 0010 |
| skl  Imm     | PC = (L)? PC+(Imm<<2)+4 : PC+4   | 1000 |
| ske  Imm     | PC = (E)? PC+(Imm<<2)+4 : PC+4   | 1001 |
| skb  Imm     | PC = (B)? PC+(Imm<<2)+4 : PC+4   | 1010 |
 
- for skl , ske and skb if no Imm value specified  will be read as 1 from the assembler  
- cmpu work with unsigned([rs]) & unsigned([rt])