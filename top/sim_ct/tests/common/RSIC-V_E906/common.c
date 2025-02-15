#include <stdint.h>
//#include "cm0ikmcu.h"
//#include "core_cm0.h"
    #define EXPECTED_NUMIRQ         32
    #define BASE_ADDR               0x20000000
void print_t(const char *s) {
    int i=0;
    while(s[i]!=0)
        *(volatile unsigned int *)(BASE_ADDR) = s[i++];
}

void print_data(unsigned int data) {
    *(unsigned long *)(BASE_ADDR + 4) = data;
}

void delay(long n) {
    long i, j;
    for(j=0;j<n;j++)
        for(i=0;i<4500;i++) ;
}

void passed()
{
    print_t("$$$$");
    while(1);
}
void failed()
{
    print_t("@@@@");
    while(1);
}
void time()
{
    print_t("#");
}

void eot()
{


    int *addr = (int *)0x20005fc0;
    *(addr) = 0x87654321; 
}

//void NVIC_Init(void)
//{
//    uint32_t count;
//    uint32_t value;
//    uint32_t numirq;
//
//    NVIC->ICER[0] = 0xFFFFFFFF;
//    NVIC->ISPR[0] = 0xFFFFFFFF;
//    value = NVIC->ISPR[0];
//
//    numirq = 0;
//    while(value)
//    {
//      numirq++;
//      value = value >> 1;
//    }
//    NVIC->ICPR[0] = 0xFFFFFFFF;
//    //if(numirq != EXPECTED_NUMIRQ)
//    //{
//    //  print("Found interrupts != expected \n");
//    //}
//    //IntTaken = 0;
//    //CheckIntTaken();
//    //__enable_irq();
//    NVIC->ISER[0] = 0xFFFFFFFF;
//
//
//}


