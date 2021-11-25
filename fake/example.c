#include "fthread.h"
#include "fpromise.h"

fpromise fp1, fp2, fp3;

void thread_func_1(void) {
	fpromise *p1 = &fp1;
	fpromise *p2 = &fp2;
	fget(p1);
	fput(p2);
}

void thread_func_2(void) {
	fpromise *p1 = &fp1;
	fpromise *p2 = &fp2;
	fget(p2);
	fput(p1);
}

void thread_func_3(void) {
	fpromise *p3 = &fp3;
	fput(p3);
	fpromise *p = &fp1;
	p = &fp3;
	fget(p);
	fpromise *p1 = &fp1;
	fpromise *p2 = &fp2;
	fput(p1);
	fput(p2);
}

int main(void) {
	start_fthread(thread_func_1);
	start_fthread(thread_func_2);
	start_fthread(thread_func_3);
	return 0;
}
