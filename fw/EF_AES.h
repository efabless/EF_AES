#ifndef EF_AES_H
#define EF_AES_H

#include <stdint.h>
#include <stdbool.h>
#include <EF_AES_regs.h>

void EF_AES_writeKey(uint32_t aes_base, int *keys, bool is128);

void EF_AES_writeBlock(uint32_t aes_base, int *block);

int EF_AES_ready(uint32_t aes_base);

void EF_AES_waitReady(uint32_t aes_base);

int EF_AES_resultValid(uint32_t aes_base);

void EF_AES_waitResultValid(uint32_t aes_base);

int EF_AES_readControl(uint32_t aes_base);

void EF_AES_writeControl(uint32_t aes_base, int control);

void EF_AES_writeIs128Key(uint32_t aes_base, bool is128);

void EF_AES_writeIsEncrypt(uint32_t aes_base, bool isEncrypt);

void EF_AES_sendInit(uint32_t aes_base);

void EF_AES_sendNext(uint32_t aes_base);

void EF_AES_readResult(uint32_t aes_base, int *result);

void EF_AES_sendBlockWithKey(uint32_t aes_base, int *keys, bool is128, int *blocks, bool isEncrypt);

void EF_AES_sendBlock(uint32_t aes_base, int *blocks, bool isEncrypt);

void EF_AES_waitGetResult(uint32_t aes_base, int *result);

void EF_AES_setInterruptMask(uint32_t aes_base, int mask);

#endif