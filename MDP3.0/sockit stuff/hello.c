/*
 * Userspace program that communicates with the led_vga device driver
 * primarily through ioctls
 *
 * Stephen A. Edwards
 * Columbia University
 */

#include <stdio.h>
#include "vga_led.h"
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>

int vga_led_fd;

/* Read and print the coordinate values */
void print_message() {
  vga_led_arg_t vla;
  int i;
  if (ioctl(vga_led_fd, VGA_LED_READ_MESSAGE, &vla)) { // vga_led_fd: open file desc.;
    // VGA_LED_READ_COORDINATES: macro see vga_led.h
    // vla pointer to struct to be sent/ where to recieve
    perror("ioctl(VGA_LED_READ_MESSAGE) failed");
    return;
  }
  char* temp = vla.msg;
  int j = 0;
  while(j++<38)
    printf("%02x ", (unsigned int) *(temp++));
  printf("\n");
}

/* Write the contents of the array to the display */
void write_message(const unsigned char msg[38])
{
  vga_led_arg_t vla;
  int i;
  memcpy(vla.msg, msg, 38);
  if (ioctl(vga_led_fd, VGA_LED_WRITE_MESSAGE, &vla)) {
    perror("ioctl(VGA_LED_WRITE_MESSAGE) failed");
    return;
  }
}
// 0000000100000000
// 0000000000000001
// 0000000011111111
int main()
{
  vga_led_arg_t vla;
  int i;
  static const char filename[] = "/dev/vga_led";


  printf("VGA LED Userspace program started\n");

  if ( (vga_led_fd = open(filename, O_RDWR)) == -1) {
    fprintf(stderr, "could not open %s\n", filename);
    return -1;
  }
  unsigned char test[38] =  {0xC0,0xC2,0x1C,0x02,0x3D,0x02,0x00,
			     0x00,0x68,0x03,0x80,0x02,0x00,0x00,
			     0x7B,0x00,0x00,0x00,0x0C,0x00,0x00,
			     0x00,0xA0,0x47,0x5F,0x3B,0x00,0x00,
			     0x00,0x00,0x0F,0x00,0x07,0xC9,0x00,
			     0x00,0x00};
  printf("initial state:\n");
  print_message();
  printf("writing message\n");
  write_message(test);
  printf("new state:\n");
  print_message();

/*   printf("current state: "); */
/*   print_coordinates_info(); */

/*   for (i = 0 ; i < 24 ; i++) { */
/*     unsigned char c0 = message[0]; */
/*     memmove(message, message+1, VGA_LED_DIGITS - 1); */
/*     message[VGA_LED_DIGITS - 1] = c0; */
/*     write_segments(message); */
/*     usleep(400000); */
/*   } */
  
  printf("VGA LED Userspace program terminating\n");
  return 0;
}
