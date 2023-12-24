#pragma once
#include <cstdint>
#include <string_view>

namespace driver {
	struct filehandle {
		std::intptr_t id;

		void write(char c);
		void write(std::string_view s);
	};

	extern filehandle fstderr, fstdout;

	[[noreturn]] void fail(const char *why);
}
