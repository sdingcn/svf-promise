#include "fthread.h"
#include "fpromise.h"

fpromise fp1, fp2;
fpromise *p1;
fpromise *p2;
int a;
int b;

void thread_func_1(void) {
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
    if(b < 0){
        p1 = &fp2;
		p2 = &fp1;
    }
    else{
        p1 = &fp1;
		p2 = &fp2;
    }
	fput(p1);
    fget(p2);
}

int main(void) {
    p1 = &fp1;
    p2 = &fp2;
	start_fthread(thread_func_1);
	start_fthread(thread_func_2);
    if(a+b > 5){
        p1 = &fp1;
		p2 = &fp2;
    }
    else{
        p1 = &fp2;
		p2 = &fp1;
    }
    fget(p1);
    fget(p2);
	return 0;
}