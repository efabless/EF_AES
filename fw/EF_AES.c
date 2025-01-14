#ifndef EF_AES_C
#define EF_AES_C

#include <EF_AES.h>

void EF_AES_writeKey(uint32_t aes_base, int *keys, bool is128){

    EF_AES_TYPE* aes = (EF_AES_TYPE*)aes_base;
    EF_AES_writeIs128Key(aes_base , is128);
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

void EF_AES_writeBlock(uint32_t aes_base, int *block){

    EF_AES_TYPE* aes = (EF_AES_TYPE*)aes_base;
    aes->BLOCK0 = block[3];
    aes->BLOCK1 = block[2];
    aes->BLOCK2 = block[1];
    aes->BLOCK3 = block[0];
}

int EF_AES_ready(uint32_t aes_base){

    EF_AES_TYPE* aes = (EF_AES_TYPE*)aes_base;
    return (aes->STATUS & 0x2) >> 1;
}

void EF_AES_waitReady(uint32_t aes_base){

    EF_AES_TYPE* aes = (EF_AES_TYPE*)aes_base;
    while(!EF_AES_ready(aes_base));
}

int EF_AES_resultValid(uint32_t aes_base){

    EF_AES_TYPE* aes = (EF_AES_TYPE*)aes_base;
    return (aes->STATUS & 0x1);
}

void EF_AES_waitResultValid(uint32_t aes_base){

    while(!EF_AES_resultValid(aes_base));
}

int EF_AES_readControl(uint32_t aes_base){
    
    EF_AES_TYPE* aes = (EF_AES_TYPE*)aes_base;
    return (aes->CTRL);
}

void EF_AES_writeControl(uint32_t aes_base, int control){

    EF_AES_TYPE* aes = (EF_AES_TYPE*)aes_base;
    aes->CTRL = control;
}

void EF_AES_writeIs128Key(uint32_t aes_base, bool is128){

    int control = EF_AES_readControl(aes_base);
    if (is128 == true)
        control &= ~(0x8);
    else
        control |= 0x8;
    EF_AES_writeControl(aes_base, control);
}

void EF_AES_writeIsEncrypt(uint32_t aes_base, bool isEncrypt){

    int control = EF_AES_readControl(aes_base);
    if (isEncrypt == true)
        control |= 0x4;
    else
        control &= ~(0x4);
    EF_AES_writeControl(aes_base, control);
}

void EF_AES_sendInit(uint32_t aes_base){

    int control = EF_AES_readControl(aes_base);
    control |= 0x1;
    control &= ~(0x2);
    EF_AES_writeControl(aes_base, control);

}

void EF_AES_sendNext(uint32_t aes_base){

    int control = EF_AES_readControl(aes_base);
    control |= 0x2;
    control &= ~(0x1);
    EF_AES_writeControl(aes_base, control);
}

void EF_AES_readResult(uint32_t aes_base, int *result){

    EF_AES_TYPE* aes = (EF_AES_TYPE*)aes_base;
    result[3] = aes->RESULT0;
    result[2] = aes->RESULT1;
    result[1] = aes->RESULT2;
    result[0] = aes->RESULT3;
}

void EF_AES_sendBlockWithKey(uint32_t aes_base, int *keys, bool is128, int *blocks, bool isEncrypt){

    EF_AES_writeControl(aes_base, 0x0);
    EF_AES_writeKey(aes_base, keys, is128);
    EF_AES_writeIsEncrypt(aes_base, isEncrypt);
    EF_AES_sendInit(aes_base);
    EF_AES_waitReady(aes_base);
    EF_AES_writeBlock(aes_base, blocks);
    EF_AES_sendNext(aes_base);
}

void EF_AES_sendBlock(uint32_t aes_base, int *blocks, bool isEncrypt){

    EF_AES_writeIsEncrypt(aes_base, isEncrypt);
    EF_AES_sendInit(aes_base);
    EF_AES_waitReady(aes_base);
    EF_AES_writeBlock(aes_base, blocks);
    EF_AES_sendNext(aes_base);
}

void EF_AES_waitGetResult(uint32_t aes_base, int *result){

    EF_AES_waitResultValid(aes_base);
    EF_AES_readResult(aes_base, result);
}

void EF_AES_setInterruptMask(uint32_t aes_base, int mask){

    EF_AES_TYPE* aes = (EF_AES_TYPE*)aes_base;
    // bit 0: result valid
    // bit 1: ready
    aes->IM = mask;
}

#endif //EF_AES_C