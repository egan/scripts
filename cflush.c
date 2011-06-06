#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>

int main(void)
{
	const char *str = "3";
	FILE *fp;

	if (setuid(0))
	{
		fprintf(stderr, "Error: Failed setuid()\n");
		exit(EPERM);
	}


	fp = fopen("/proc/sys/vm/drop_caches","w");
	if (fp == NULL) {
		fprintf(stderr, "Error: Null file handle\n");
		exit(EBADF);
	}
	sync();
	fwrite(str, 1, 1, fp);
	fclose(fp);
	
	return 0;
}
