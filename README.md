# SW_AES
Bus wrappers for verilog implementation of the symmetric block cipher AES (Advanced Encryption Standard) as specified in NIST FIPS 197. This implementation supports 128 and 256 bit keys. The AES rtl is based on [this repo](https://github.com/secworks/aes/tree/master) 

## I/O Registers
Offset | Size |  Register          | Description |
| -----| -----| -------------------|-------------|
0x00   |  8   | Status Register    |0: result is valid 1: ready |
0x04   |  8   | Control Register   | bit 0: Initial bit (init)  <br> bit 1: Next bit <br> bit 2: Encipher/Decipher control; <br> “0” means Decipher <br> “1” means Encipher <br> bit 3: Key length control; <br> “0” means 128 bit key length <br> “1” means 256 bit key length |
0x08   |  32  | Key Register 0     | Contains the bits 31-0 of the input key value     |
0x0C   |  32  | Key Register 1     | Contains the bits 63-32 of the input key value    |
0x10   |  32  | Key Register 2     | Contains the bits 95-64 of the input key value    |
0x14   |  32  | Key Register 3     | Contains the bits 127-96 of the input key value   |
0x18   |  32  | Key Register 4     | Contains the bits 159-128 of the input key value  |
0x1C   |  32  | Key Register 5     | Contains the bits 191-160 of the input key value  |
0x20   |  32  | Key Register 6     | Contains the bits 223-192 of the input key value  |
0x24   |  32  | Key Register 7     | Contains the bits 255-224 of the input key value  |
0x28   |  32  | Block Register 0   | Contains the bits 31-0 of the input block value   |
0x2C   |  32  | Block Register 1   | Contains the bits 63-32 of the input block value  |
0x30   |  32  | Block Register 2   | Contains the bits 95-64 of the input block value  |
0x34   |  32  | Block Register 3   | Contains the bits 127-96 of the input block value |
0x38   |  32  | Result Register 0  | Contains the bits 31-0 of the input result value  |
0x3C   |  32  | Result Register 1  | Contains the bits 63-32 of the input result value |
0x40   |  32  | Result Register 2  | Contains the bits 95-64 of the input result value |
0x44   |  32  | Result Register 3  | Contains the bits 127-96 of the input result value|
0xF00  |  2   |Interrupt Clear (IC) Register | It is used to clear an interrupt flag in RIS as well as MIS registers; it is required to write ‘1’ to the corresponding bit in the IC register.|
0xF04  |  2   | Raw Interrupts Status (RIS) Register | Contains the interrupt flags status before masking.|
0xF08  |  2   | Interrupts Mask (IM) Register | Disabling/Enabling an interrupt source.|
0xF0C  |  2   | Masked Interrupts Status (MIS) Register | Contains the interrupt flags status after masking.|

## Interrupt flags 

The following table gives the bit definitions for the IC, RIS, IM and MIS registers
| Bit | Meaning |
|-----|---------|
0 |Result is valid |
1 |Ready to start |

