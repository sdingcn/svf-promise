#include "fthread.h"
#include "fpromise.h"

fpromise fp1, fp2;
fpromise *p1;
fpromise *p2;
int a;

void thread_func_1(void) {
	if(a < 0){
		p1 = &fp1;
		p2 = &fp2;
	}
	else{
		p1 = &fp2;
		p2 = &fp1;
	}

	fget(p1); // deadlock
	fput(p2);
}

void thread_func_2(void) {
	fpromise *p3 = &fp1;
	fpromise *p4 = &fp2;
	fget(p3); // deadlock
	fput(p4);
}

int main(void) {
    p1 = &fp1;
    p2 = &fp2;
	start_fthread(thread_func_1);
	start_fthread(thread_func_2);
    fget(p1);
    fget(p2);
	return 0;
}