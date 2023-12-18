#include "aock/pm.h"
#include "aock/arch/rv64/core.h"

enum {
	bitmap_count_ = 256,
	alloc_count_ = 64,
};

[[gnu::aligned(16)]]
static u64 page_bitmaps_[bitmap_count_];

static usize next_check_index_ = 0;
static rv_physptr page_base_ = 0;

static usize alloc_bit_() {
	for (usize i = next_check_index_; i < bitmap_count_; ++i) {
		if (~page_bitmaps_[i] != 0) {
			usize t1s = ctzu64(~page_bitmaps_[i]);
			page_bitmaps_[i] |= (u64)1 << t1s;
			return i * 64 + t1s;
		}
	}

	if (next_check_index_ > 0) {
		LOG(
			"retrying find_next_free_ with zero next_check_index_ (old={usz})\n",
			next_check_index_
		);
		return alloc_bit_();
	} else {
		PANIC("out of memory, could not find a free page!");
	}
}

phys_ptr pm_alloc_page() {
	usize next_free = alloc_bit_();
	return page_base_ + RV_PAGESIZE * next_free;
}

void pm_dealloc_page(phys_ptr page) {
	usize p = (page - page_base_) / RV_PAGESIZE;
	usize i = p / 64;
	page_bitmaps_[i] &= ~(1 << (p - i * 64));
}

void pm_init(phys_ptr base) {
	page_base_ = base;
}
