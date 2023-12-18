#ifndef AOCK_RV64_MEM_H_
#define AOCK_RV64_MEM_H_

#define RV_PAGESIZE 0x1000
#define RV_MAXVA ((void*)(1L << (9 + 9 + 9 + 12 - 1)))

#define RV_TRAMPOLINE (RV_MAXVA - RV_PAGESIZE)
#define RV_TRAMPFRAME (RV_TRAMPOLINE - RV_PAGESIZE)

#endif // AOCK_RV64_MEM_H_
