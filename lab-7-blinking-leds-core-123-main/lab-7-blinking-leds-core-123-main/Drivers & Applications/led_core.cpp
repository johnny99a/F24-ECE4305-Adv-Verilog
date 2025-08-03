#include "led_core.h"

LedCore::LedCore(uint32_t core_base_addr) {
   base_addr = core_base_addr;
   wr_data = 0;						// all leds off
}

LedCore::~LedCore() {
}

void LedCore::write(int delay, int led_reg) {
	// write delay into led_reg 0-3
	io_write(base_addr, led_reg, delay);
}
