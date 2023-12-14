#ifndef AOCK_PM_H_
#define AOCK_PM_H_
#include "mstdc.h"
#include "riscv.h"

void aock_init(rv_physptr base);
rv_physptr aock_alloc_pages(usize count);
void aock_dealloc_pages(rv_physptr page);

#endif // AOCK_PM_H_
