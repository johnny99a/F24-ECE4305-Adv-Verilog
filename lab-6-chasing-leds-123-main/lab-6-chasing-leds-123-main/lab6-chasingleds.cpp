#include "chu_init.h"
#include "gpio_cores.h"

// instantiate switch, led
GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
GpiCore sw(get_slot_addr(BRIDGE_BASE, S3_SW));

// function to determine the delay
int chase_speed(GpiCore *sw_p)
{
	// max delay of 850 ms
    return (100 + 50 * sw_p->read(1) +      	// 150 ms delay if sw1
		  100 * sw_p->read(2) +      	// 200 ms delay if sw2
		  150 * sw_p->read(3) +      	// 250 ms delay if sw3
		  200 * sw_p->read(4) +			// 300 ms delay if sw4
		  250 * sw_p->read(5));			// 350 ms delay if sw5
}

// function sending info to uart
void uart_notice(int delay)    // takes delay as an input
{
    uart.disp("current delay: ");
    uart.disp(delay);
    uart.disp(" ms\n\r");
}

// function implementing chasing LED
void chasing_led(GpoCore *led_p, GpiCore *sw_p)
{
    int delay;                 	// store delay timing
    int delay_last = 100;      	// stores last delay in ms
    int led_loc = 0x0000;	// starting led
    int direction = 0;		// 0 = left, 1 = right

    // initial delay sent to uart
    uart_notice(delay_last);

    // continuous loop for chasing LED
    while (1)
    {
        // store delay
        delay = chase_speed(&sw);

        // send delay to uart only if changed
        if (delay != delay_last)
        {
            uart_notice(delay);
            delay_last = delay;
        }

        // sw0 lights up rightmost LED
        if (sw_p->read(0) == 1)
            led_loc = 0x0001;

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

int main()
{
    chasing_led(&led, &sw);
}
