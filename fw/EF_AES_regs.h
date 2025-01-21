/*
	Copyright 2024 Efabless Corp.

	Author: Efabless Corp. (ip_admin@efabless.com)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/

#ifndef EF_AESREGS_H
#define EF_AESREGS_H

 
/******************************************************************************
* Includes
******************************************************************************/
#include <stdint.h>

/******************************************************************************
* Macros and Constants
******************************************************************************/

#ifndef IO_TYPES
#define IO_TYPES
#define   __R     volatile const uint32_t
#define   __W     volatile       uint32_t
#define   __RW    volatile       uint32_t
#endif

#define EF_AES_STATUS_REG_READY_REG_BIT	((uint32_t)6)
#define EF_AES_STATUS_REG_READY_REG_MASK	((uint32_t)0x40)
#define EF_AES_STATUS_REG_VALID_REG_BIT	((uint32_t)7)
#define EF_AES_STATUS_REG_VALID_REG_MASK	((uint32_t)0x80)
#define EF_AES_STATUS_REG_MAX_VALUE	((uint32_t)0xFF)

#define EF_AES_CTRL_REG_INIT_REG_BIT	((uint32_t)0)
#define EF_AES_CTRL_REG_INIT_REG_MASK	((uint32_t)0x1)
#define EF_AES_CTRL_REG_NEXT_REG_BIT	((uint32_t)1)
#define EF_AES_CTRL_REG_NEXT_REG_MASK	((uint32_t)0x2)
#define EF_AES_CTRL_REG_ENCDEC_REG_BIT	((uint32_t)2)
#define EF_AES_CTRL_REG_ENCDEC_REG_MASK	((uint32_t)0x4)
#define EF_AES_CTRL_REG_KEYLEN_REG_BIT	((uint32_t)3)
#define EF_AES_CTRL_REG_KEYLEN_REG_MASK	((uint32_t)0x8)
#define EF_AES_CTRL_REG_MAX_VALUE	((uint32_t)0xFF)

#define EF_AES_KEY0_REG_KEY0_BIT	((uint32_t)0)
#define EF_AES_KEY0_REG_KEY0_MASK	((uint32_t)0xffffffff)
#define EF_AES_KEY0_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_KEY1_REG_KEY1_BIT	((uint32_t)0)
#define EF_AES_KEY1_REG_KEY1_MASK	((uint32_t)0xffffffff)
#define EF_AES_KEY1_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_KEY2_REG_KEY2_BIT	((uint32_t)0)
#define EF_AES_KEY2_REG_KEY2_MASK	((uint32_t)0xffffffff)
#define EF_AES_KEY2_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_KEY3_REG_KEY3_BIT	((uint32_t)0)
#define EF_AES_KEY3_REG_KEY3_MASK	((uint32_t)0xffffffff)
#define EF_AES_KEY3_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_KEY4_REG_KEY4_BIT	((uint32_t)0)
#define EF_AES_KEY4_REG_KEY4_MASK	((uint32_t)0xffffffff)
#define EF_AES_KEY4_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_KEY5_REG_KEY5_BIT	((uint32_t)0)
#define EF_AES_KEY5_REG_KEY5_MASK	((uint32_t)0xffffffff)
#define EF_AES_KEY5_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_KEY6_REG_KEY6_BIT	((uint32_t)0)
#define EF_AES_KEY6_REG_KEY6_MASK	((uint32_t)0xffffffff)
#define EF_AES_KEY6_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_KEY7_REG_KEY7_BIT	((uint32_t)0)
#define EF_AES_KEY7_REG_KEY7_MASK	((uint32_t)0xffffffff)
#define EF_AES_KEY7_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_BLOCK0_REG_BLOCK0_BIT	((uint32_t)0)
#define EF_AES_BLOCK0_REG_BLOCK0_MASK	((uint32_t)0xffffffff)
#define EF_AES_BLOCK0_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_BLOCK1_REG_BLOCK1_BIT	((uint32_t)0)
#define EF_AES_BLOCK1_REG_BLOCK1_MASK	((uint32_t)0xffffffff)
#define EF_AES_BLOCK1_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_BLOCK2_REG_BLOCK2_BIT	((uint32_t)0)
#define EF_AES_BLOCK2_REG_BLOCK2_MASK	((uint32_t)0xffffffff)
#define EF_AES_BLOCK2_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_BLOCK3_REG_BLOCK3_BIT	((uint32_t)0)
#define EF_AES_BLOCK3_REG_BLOCK3_MASK	((uint32_t)0xffffffff)
#define EF_AES_BLOCK3_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_RESULT0_REG_RESULT0_BIT	((uint32_t)0)
#define EF_AES_RESULT0_REG_RESULT0_MASK	((uint32_t)0xffffffff)
#define EF_AES_RESULT0_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_RESULT1_REG_RESULT1_BIT	((uint32_t)0)
#define EF_AES_RESULT1_REG_RESULT1_MASK	((uint32_t)0xffffffff)
#define EF_AES_RESULT1_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_RESULT2_REG_RESULT2_BIT	((uint32_t)0)
#define EF_AES_RESULT2_REG_RESULT2_MASK	((uint32_t)0xffffffff)
#define EF_AES_RESULT2_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_AES_RESULT3_REG_RESULT3_BIT	((uint32_t)0)
#define EF_AES_RESULT3_REG_RESULT3_MASK	((uint32_t)0xffffffff)
#define EF_AES_RESULT3_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)


#define EF_AES_VALID_FLAG	((uint32_t)0x1)
#define EF_AES_READY_FLAG	((uint32_t)0x2)


          
/******************************************************************************
* Typedefs and Enums
******************************************************************************/
          
typedef struct _EF_AES_TYPE_ {
	__R 	STATUS;
	__W 	CTRL;
	__W 	KEY0;
	__W 	KEY1;
	__W 	KEY2;
	__W 	KEY3;
	__W 	KEY4;
	__W 	KEY5;
	__W 	KEY6;
	__W 	KEY7;
	__W 	BLOCK0;
	__W 	BLOCK1;
	__W 	BLOCK2;
	__W 	BLOCK3;
	__W 	RESULT0;
	__W 	RESULT1;
	__W 	RESULT2;
	__W 	RESULT3;
	__R 	reserved_0[16302];
	__RW	IM;
	__R 	MIS;
	__R 	RIS;
	__W 	IC;
	__W 	GCLK;
} EF_AES_TYPE;

typedef struct _EF_AES_TYPE_ *EF_AES_TYPE_PTR;     // Pointer to the register structure

  
/******************************************************************************
* Function Prototypes
******************************************************************************/



/******************************************************************************
* External Variables
******************************************************************************/




#endif

/******************************************************************************
* End of File
******************************************************************************/
          
          
