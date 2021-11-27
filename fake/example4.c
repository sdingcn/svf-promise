#include "fthread.h"
#include "fpromise.h"

fpromise fp1, fp2;
fpromise *p1;
fpromise *p2;
int a;

void thread_func_1(void) {
	fput(p1);
    fget(p2);
}

void thread_func_2(void) {
    fget(p1);
	fput(p2);
}

//no deadlock
int main(void) {
    p1 = &fp1;
    p2 = &fp2;
	start_fthread(thread_func_1);
	start_fthread(thread_func_2);
    fget(p1);
    fget(p2);
	return 0;
}