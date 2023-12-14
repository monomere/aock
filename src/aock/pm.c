#include "pm.h"

enum {
	bitmap_count_ = 256
};

[[gnu::aligned(16)]]
static u64 page_bitmaps_[bitmap_count_];

static usize next_check_index_ = 0;
static rv_physptr page_base_ = 0;

static usize find_next_free_(usize count) {
	for (usize i = next_check_index_; i < bitmap_count_; ++i) {
		if (cpopu64(~page_bitmaps_[i]) < count) continue;
		usize t1s = ctzu64(~page_bitmaps_[i]);
		page_bitmaps_[i] |= ((~(u64)0) >> (64 - count)) << t1s;
		return i * 64 + t1s;
	}

	if (next_check_index_ > 0) {
		LOG(
			"retrying find_next_free_ with zero next_check_index_ (old={usz})\n",
			next_check_index_
		);
		return find_next_free_(count);
	} else {
		PANIC("out of memory, could not find {usz} pages!", count);
	}
}

rv_physptr aock_alloc_pages(usize count) {
	usize next_free = find_next_free_(count);
	return page_base_ + 4096 * next_free;
}

void aock_dealloc_pages(rv_physptr page) {
	// next_check_index_ = 
}

void aock_init(rv_physptr base) {
	page_base_ = base;
}
