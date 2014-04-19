#ifndef _VGA_LED_H
#define _VGA_LED_H

#include <linux/ioctl.h>

typedef struct {
  unsigned char msg[38];
} vga_led_arg_t;

#define VGA_LED_MAGIC 'q'

/* ioctls and their arguments */
#define VGA_LED_WRITE_MESSAGE _IOW(VGA_LED_MAGIC, 1, vga_led_arg_t *)
#define VGA_LED_READ_MESSAGE  _IOR(VGA_LED_MAGIC, 2, vga_led_arg_t *)

#endif
