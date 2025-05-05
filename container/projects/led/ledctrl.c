#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int
main(int argc, char** argv)
{
  if (argc < 3) {
    fprintf(stderr, "usage: %s <led> <1|0>\n", argv[0]);
    return 1;
  }

  int fd = open(argv[1], O_WRONLY);
  if (fd < 0) {
    perror("open");
    return 1;
  }

  if (write(fd, argv[2], 1) < 0) {
    perror("write");
    close(fd);
    return 1;
  }

  close(fd);
  return 0;
}