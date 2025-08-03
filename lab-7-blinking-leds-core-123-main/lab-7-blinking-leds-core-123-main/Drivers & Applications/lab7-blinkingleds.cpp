#include "led_core.h"

LedCore ledcore(get_slot_addr(BRIDGE_BASE, S4_USER));

int main() {
	ledcore.write(1000, ledcore.LED0);	// delay of x
	ledcore.write(500, ledcore.LED1);	// delay of x/2
	ledcore.write(250, ledcore.LED2);	// delay of x/4
	ledcore.write(125, ledcore.LED3);	// delay of x/8
}
