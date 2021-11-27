#include "fthread.h"
#include "fpromise.h"

fpromise fp1, fp2, fp3;
int a;

void thread_func_1(void) {
	fpromise *p1;
	fpromise *p2;
	if(a < 0){
		p1 = &fp1;
		p2 = &fp2;
	}
	else{
		p1 = &fp2;
		p2 = &fp1;
	}

	fget(p1);
	fput(p2);
}

void thread_func_2(void) {
	fpromise *p1 = &fp1;
	fpromise *p2 = &fp2;
	fget(p2);
	fput(p1);
}

void child_thread_func(void) {
	fpromise *p = &fp1;
	fget(p);
}

void thread_func_3(void) {
	fpromise *p3 = &fp3;
	fput(p3);
	fpromise *p = &fp1;
	p = &fp3;
	fget(p);
	fpromise *p1 = &fp1;
	fget(p1);
	start_fthread(child_thread_func);
}

int main(void) {
	start_fthread(thread_func_1);
	start_fthread(thread_func_2);
	start_fthread(thread_func_3);
	return 0;
}