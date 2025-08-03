#ifndef _GPIO_H_INCLUDED
#define _GPIO_H_INCLUDED

#include "chu_init.h"

class LedCore {
public:
   /* register map */
   enum {
      LED0 = 0,
      LED1 = 1,
      LED2 = 2,
      LED3 = 3
   };

   LedCore(uint32_t core_base_addr);	// constructor
   ~LedCore();                         // destructor, not used

   void write(int delay, int led_reg);	// delay (ms) = rate of led blinking,	led_reg = led#

private:
   uint32_t base_addr;
   uint32_t wr_data;		// data reg for each LED_REG
};

#endif  // _GPIO_H_INCLUDED
