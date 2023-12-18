#ifndef AOCK_PM_H_
#define AOCK_PM_H_
#include "mstdc.h"
#include "aock/core.h"

void pm_init(phys_ptr base);
phys_ptr pm_alloc_page();
void pm_dealloc_page(phys_ptr page);

#endif // AOCK_PM_H_
