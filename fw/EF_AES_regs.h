/*
	Copyright 2024 Efabless Corp.

	Author: Efabless Corp. (ip_admin@efabless.com)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/

#ifndef EF_AESREGS_H
#define EF_AESREGS_H

#ifndef IO_TYPES
#define IO_TYPES
#define   __R     volatile const unsigned int
#define   __W     volatile       unsigned int
#define   __RW    volatile       unsigned int
#endif

#define EF_AES_STATUS_REG_READY_REG_BIT	6
#define EF_AES_STATUS_REG_READY_REG_MASK	0x40
#define EF_AES_STATUS_REG_VALID_REG_BIT	7
#define EF_AES_STATUS_REG_VALID_REG_MASK	0x80
#define EF_AES_CTRL_REG_INIT_REG_BIT	0
#define EF_AES_CTRL_REG_INIT_REG_MASK	0x1
#define EF_AES_CTRL_REG_NEXT_REG_BIT	1
#define EF_AES_CTRL_REG_NEXT_REG_MASK	0x2
#define EF_AES_CTRL_REG_ENCDEC_REG_BIT	2
#define EF_AES_CTRL_REG_ENCDEC_REG_MASK	0x4
#define EF_AES_CTRL_REG_KEYLEN_REG_BIT	3
#define EF_AES_CTRL_REG_KEYLEN_REG_MASK	0x8

#define EF_AES_VALID_FLAG	0x1
#define EF_AES_READY_FLAG	0x2

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

#endif

