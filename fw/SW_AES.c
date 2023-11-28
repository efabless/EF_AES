#ifndef SW_AES_C
#define SW_AES_C

#include <SW_AES.h>

void SW_AES_writeKey(uint32_t aes_base, int *keys, bool is128){

    SW_AES_TYPE* aes = (SW_AES_TYPE*)aes_base;
    SW_AES_writeIs128Key(aes_base , is128);
    if (is128 == false){
        aes->KEY0 = keys[7];
        aes->KEY1 = keys[6];
        aes->KEY2 = keys[5];
        aes->KEY3 = keys[4];
    }
    aes->KEY4 = keys[3];
    aes->KEY5 = keys[2];
    aes->KEY6 = keys[1];
    aes->KEY7 = keys[0];
}

void SW_AES_writeBlock(uint32_t aes_base, int *block){

    SW_AES_TYPE* aes = (SW_AES_TYPE*)aes_base;
    aes->BLOCK0 = block[3];
    aes->BLOCK1 = block[2];
    aes->BLOCK2 = block[1];
    aes->BLOCK3 = block[0];
}

int SW_AES_ready(uint32_t aes_base){

    SW_AES_TYPE* aes = (SW_AES_TYPE*)aes_base;
    return (aes->STATUS & 0x2) >> 1;
}

void SW_AES_waitReady(uint32_t aes_base){

    SW_AES_TYPE* aes = (SW_AES_TYPE*)aes_base;
    while(!SW_AES_ready(aes_base));
}

int SW_AES_resultValid(uint32_t aes_base){

    SW_AES_TYPE* aes = (SW_AES_TYPE*)aes_base;
    return (aes->STATUS & 0x1);
}

void SW_AES_waitResultValid(uint32_t aes_base){

    while(!SW_AES_resultValid(aes_base));
}

int SW_AES_readControl(uint32_t aes_base){
    
    SW_AES_TYPE* aes = (SW_AES_TYPE*)aes_base;
    return (aes->CTRL);
}

void SW_AES_writeControl(uint32_t aes_base, int control){

    SW_AES_TYPE* aes = (SW_AES_TYPE*)aes_base;
    aes->CTRL = control;
}

void SW_AES_writeIs128Key(uint32_t aes_base, bool is128){

    int control = SW_AES_readControl(aes_base);
    if (is128 == true)
        control &= ~(0x8);
    else
        control |= 0x8;
    SW_AES_writeControl(aes_base, control);
}

void SW_AES_writeIsEncrypt(uint32_t aes_base, bool isEncrypt){

    int control = SW_AES_readControl(aes_base);
    if (isEncrypt == true)
        control |= 0x4;
    else
        control &= ~(0x4);
    SW_AES_writeControl(aes_base, control);
}

void SW_AES_sendInit(uint32_t aes_base){

    int control = SW_AES_readControl(aes_base);
    control |= 0x1;
    control &= ~(0x2);
    SW_AES_writeControl(aes_base, control);

}

void SW_AES_sendNext(uint32_t aes_base){

    int control = SW_AES_readControl(aes_base);
    control |= 0x2;
    control &= ~(0x1);
    SW_AES_writeControl(aes_base, control);
}

void SW_AES_readResult(uint32_t aes_base, int *result){

    SW_AES_TYPE* aes = (SW_AES_TYPE*)aes_base;
    result[3] = aes->RESULT0;
    result[2] = aes->RESULT1;
    result[1] = aes->RESULT2;
    result[0] = aes->RESULT3;
}

void SW_AES_sendBlockWithKey(uint32_t aes_base, int *keys, bool is128, int *blocks, bool isEncrypt){

    SW_AES_writeControl(aes_base, 0x0);
    SW_AES_writeKey(aes_base, keys, is128);
    SW_AES_writeIsEncrypt(aes_base, isEncrypt);
    SW_AES_sendInit(aes_base);
    SW_AES_waitReady(aes_base);
    SW_AES_writeBlock(aes_base, blocks);
    SW_AES_sendNext(aes_base);
}

void SW_AES_sendBlock(uint32_t aes_base, int *blocks, bool isEncrypt){

    SW_AES_writeIsEncrypt(aes_base, isEncrypt);
    SW_AES_sendInit(aes_base);
    SW_AES_waitReady(aes_base);
    SW_AES_writeBlock(aes_base, blocks);
    SW_AES_sendNext(aes_base);
}

void SW_AES_waitGetResult(uint32_t aes_base, int *result){

    SW_AES_waitResultValid(aes_base);
    SW_AES_readResult(aes_base, result);
}

void SW_AES_setInterruptMask(uint32_t aes_base, int mask){

    SW_AES_TYPE* aes = (SW_AES_TYPE*)aes_base;
    // bit 0: result valid
    // bit 1: ready
    aes->im = mask;
}

#endif //SW_AES_C