#ifndef SW_AES
#define SW_AES

#include <stdint.h>
#include <stdbool.h>
#include <SW_AES_regs.h>

void SW_AES_writeKey(uint32_t aes_base, int *keys, bool is128);

void SW_AES_writeBlock(uint32_t aes_base, int *block);

int SW_AES_ready(uint32_t aes_base);

void SW_AES_waitReady(uint32_t aes_base);

int SW_AES_resultValid(uint32_t aes_base);

void SW_AES_waitResultValid(uint32_t aes_base);

int SW_AES_readControl(uint32_t aes_base);

void SW_AES_writeControl(uint32_t aes_base, int control);

void SW_AES_writeIs128Key(uint32_t aes_base, bool is128);

void SW_AES_writeIsEncrypt(uint32_t aes_base, bool isEncrypt);

void SW_AES_sendInit(uint32_t aes_base);

void SW_AES_sendNext(uint32_t aes_base);

void SW_AES_readResult(uint32_t aes_base, int *result);

void SW_AES_sendBlockWithKey(uint32_t aes_base, int *keys, bool is128, int *blocks, bool isEncrypt);

void SW_AES_sendBlock(uint32_t aes_base, int *blocks, bool isEncrypt);

void SW_AES_waitGetResult(uint32_t aes_base, int *result);

void SW_AES_setInterruptMask(uint32_t aes_base, int mask);

#endif