#include "chu_init.h"
#include "gpio_cores.h"
#include "xadc_core.h"
#include "sseg_core.h"
#include "spi_core.h"
#include "i2c_core.h"
#include "ps2_core.h"
#include "ddfs_core.h"
#include "adsr_core.h"

GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
GpiCore sw(get_slot_addr(BRIDGE_BASE, S3_SW));
XadcCore adc(get_slot_addr(BRIDGE_BASE, S5_XDAC));
PwmCore pwm(get_slot_addr(BRIDGE_BASE, S6_PWM));
DebounceCore btn(get_slot_addr(BRIDGE_BASE, S7_BTN));
SsegCore sseg(get_slot_addr(BRIDGE_BASE, S8_SSEG));
SpiCore spi(get_slot_addr(BRIDGE_BASE, S9_SPI));
I2cCore adt7420(get_slot_addr(BRIDGE_BASE, S10_I2C));
Ps2Core ps2(get_slot_addr(BRIDGE_BASE, S11_PS2));
DdfsCore ddfs(get_slot_addr(BRIDGE_BASE, S12_DDFS));
AdsrCore adsr(get_slot_addr(BRIDGE_BASE, S13_ADSR), &ddfs);


int adc_speed(XadcCore *adc_p) {
	double adc_vc0;

	// adc voltage of channel 0
	adc_vc0 = adc_p->read_adc_in(0);

	return adc_vc0 * 1000;
}

void uart_notice(int delay) {
	uart.disp("current delay: ");
	uart.disp(delay);
	uart.disp(" ms\n\r");
}

// function implementing chasing LED
void chasing_led(GpoCore *led_p) {
	int delay;                // store delay timing
	int delay_last = 0;
    int led_loc = 0x0001;		// starting led
    int direction = 0;			// 0 = left, 1 = right

    // continuous loop for chasing LED
    while (1) {
        // store delay
        delay = adc_speed(&adc);

        if (delay != delay_last) {
        	uart_notice(delay);
        	delay_last = delay;
        }

        // write LED location
        led_p->write(led_loc);

        // shift LED left or right
        if (direction == 0)
            led_loc <<= 1;  // shift LED to the left
        else
            led_loc >>= 1;  // shift LED to the right

        // direction change
        if (led_loc == 0x0001)          // shift direction at rightmost LED
            direction = 0;
        else if (led_loc == 0x8000)     // shift direction at the leftmost LED
            direction = 1;

        // LED delay
        sleep_ms(delay);
    }
}

int main() {
    chasing_led(&led);
}
