#ifndef FPROMISE_H
#define FPROMISE_H

typedef struct {} fpromise;

void fput(fpromise *fp);

void fget(fpromise *fp);

#endif
