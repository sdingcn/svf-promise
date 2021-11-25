#include "fthread.h"
#include "fpromise.h"

fpromise fp1;
fpromise fp2;

void thread_func_1() {
	fget(&fp1);
	fput(&fp2);
}

void thread_func_2() {
	fget(&fp2);
	fput(&fp1);
}

int main() {
	start_fthread(thread_func_1);
	start_fthread(thread_func_2);
}
