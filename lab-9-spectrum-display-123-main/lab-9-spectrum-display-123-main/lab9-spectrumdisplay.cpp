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


// adc voltage channel 0
double adc_vc0(XadcCore *adc_p) {
	return adc_p->read_adc_in(0);
}

void uart_notice(double num) {
	uart.disp("analog channel/voltage: ");
	uart.disp(0);
	uart.disp(" / ");
	uart.disp(num);
	uart.disp("\n\r");
}

// display adc_vc0 on 7seg display
void sseg_disp(SsegCore *sseg_p) {
	int adc_voltage, adc_v1s, adc_v10s, adc_v100s, adc_v1000s;

	// multiple adc_vc0 by 1000
	adc_voltage = adc_vc0(&adc) * 1000;

	// separate voltage digits
	adc_v1s = adc_voltage % 10;
	adc_v10s = (adc_voltage / 10) % 10;
	adc_v100s = (adc_voltage / 100) % 10;
	adc_v1000s = (adc_voltage / 1000) % 10;

	// write each digit to a seven seg display
	sseg_p->write_1ptn(sseg_p->h2s(adc_v1s), 0);
	sseg_p->write_1ptn(sseg_p->h2s(adc_v10s), 1);
	sseg_p->write_1ptn(sseg_p->h2s(adc_v100s), 2);
	sseg_p->write_1ptn(sseg_p->h2s(adc_v1000s), 3);

	// set decimal point on sseg4
	sseg_p->set_dp(8);	// 8 = 0000 1000
}

// ardunio map function
double map(double z, double x1, double x2, double y1, double y2) {
	return (z - x1) * (y2 - y1) / (x2 - x1) + y1;
}

// duty's of red, green, blue for 3 color led
void spectrum_duty(double adc_v, double& duty_red, double& duty_green, double& duty_blue) {
	double bright = 0.04;
	double off = 0;

	// 0.0 v
	if (adc_v <= 0.01) {
		duty_red = bright;
		duty_green = off;
		duty_blue = off;
	}
	// 0.0 v - 1/6 v
	else if (adc_v > 0.01 && adc_v < (1.0/6.0)) {
		duty_red = bright;
		duty_green = map(adc_v, 0.01, 1.0/6.0, off, bright);
		duty_blue = off;
	}
	// 1/6 v
	else if (adc_v == (1.0/6.0)) {
		duty_red = bright;
		duty_green = bright;
		duty_blue = off;
	}
	// 1/6 v - 2/6 v
	else if (adc_v > (1.0/6.0) && adc_v < (2.0/6.0)) {
		duty_red = map(adc_v, 1.0/6.0, 2.0/6.0, bright, off);
		duty_green = bright;
		duty_blue = off;
	}
	// 2/6 v
	else if (adc_v == (2.0/6.0)) {
		duty_red = off;
		duty_green = bright;
		duty_blue = off;
	}
	// 2/6 v - 0.5 v
	else if (adc_v > (2.0/6.0) && adc_v < 0.5) {
		duty_red = off;
		duty_green = bright;
		duty_blue = map(adc_v, 2.0/6.0, 0.5, off, bright);
	}
	// 0.5 v
	else if (adc_v == 0.5) {
		duty_red = off;
		duty_green = bright;
		duty_blue = bright;
	}
	// 0.5 v - 4/6 v
	else if (adc_v > 0.5 && adc_v < (4.0/6.0)) {
		duty_red = off;
		duty_green = map(adc_v, 0.5, 4.0/6.0, bright, off);
		duty_blue = bright;
	}
	// 4/6 v
	else if (adc_v == (4.0/6.0)) {
		duty_red = off;
		duty_green = off;
		duty_blue = bright;
	}
	// 4/6 v - 5/6 v
	else if (adc_v > (4.0/6.0) && adc_v < (5.0/6.0)) {
		duty_red = map(adc_v, 4.0/6.0, 5.0/6.0, off, bright);
		duty_green = off;
		duty_blue = bright;
	}
	// 5/6 v
	else if (adc_v == (5.0/6.0)) {
		duty_red = bright;
		duty_green = off;
		duty_blue = bright;
	}
	// 5/6 v - 1 v
	else if (adc_v > (5.0/6.0) && adc_v < 0.999) {
		duty_red = bright;
		duty_green = off;
		duty_blue = map(adc_v, 5.0/6.0, 0.999, bright, off);
	}
	// 1 v
	else if (adc_v >= 0.999) {
		duty_red = bright;
		duty_green = off;
		duty_blue = off;
	}
}

void pwm_3color_led(PwmCore *pwm_p) {
	double red, green, blue;

	spectrum_duty(adc_vc0(&adc), red, green, blue);

	// set_duty(brightness, color)
	pwm_p->set_duty(red, 2);	// left red
	pwm_p->set_duty(green, 1);	// left green
	pwm_p->set_duty(blue, 0);	// left blue

	pwm_p->set_duty(red, 5);	// right red
	pwm_p->set_duty(green, 4);	// right green
	pwm_p->set_duty(blue, 3);	// right blue
}

int main() {
	while (1) {
//		uart_notice(adc_vc0(&adc));
		sseg_disp(&sseg);
		pwm_3color_led(&pwm);
		sleep_ms(100);
	}
}
