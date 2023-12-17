#ifndef AOCK_PM_H_
#define AOCK_PM_H_
#include "mstdc.h"
#include "riscv.h"

void aock_pm_init(rv_physptr base);
rv_physptr aock_pm_alloc_page();
void aock_pm_dealloc_page(rv_physptr page);

#endif // AOCK_PM_H_
