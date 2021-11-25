#ifndef FPROMISE_H
#define FPROMISE_H

typedef struct {} fpromise;

void fput(fpromise *p);

void fget(fpromise *p);

#endif
