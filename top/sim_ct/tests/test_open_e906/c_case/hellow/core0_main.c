/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.

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
#include <stdio.h>
#include <string.h>
#include <stdint.h>

#define BASE_ADDR 0x60000000

//sys_mem range:0x6000_0000~0x6001_ffff(128KB)
//Attr:100,strong order,no cacheable,no bufferable
void passed() {
*(volatile unsigned int *)(BASE_ADDR) = 0x24;
*(volatile unsigned int *)(BASE_ADDR) = 0x24;
*(volatile unsigned int *)(BASE_ADDR) = 0x24;
*(volatile unsigned int *)(BASE_ADDR) = 0x24;

}

void failed() {
*(volatile unsigned int *)(BASE_ADDR) = 0x40;
*(volatile unsigned int *)(BASE_ADDR) = 0x40;
*(volatile unsigned int *)(BASE_ADDR) = 0x40;
*(volatile unsigned int *)(BASE_ADDR) = 0x40;

}

void print_u(char *s) {
    int i=0;
    while(s[i]!=0)
        *(unsigned long *)(BASE_ADDR) = s[i++];
}




int main (void)
{

volatile int *w_addr = (int *)0x60000100;
volatile int *r_addr = (int *)0x60000100;

//printf("\n///////////////////////////////////\n//C:start to test core0\n///////////////////////////////////\n");
print_u("\n///////////////////////////////////\n//C:print_u start to test core0\n///////////////////////////////////\n");

*(w_addr) = 0x77886688;

if(0x77886688 == *r_addr) {
    passed(); 
}
else {
    failed();
}

while(1) {}

return 0;

}


