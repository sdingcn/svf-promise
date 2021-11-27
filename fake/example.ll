; ModuleID = 'fake/example.ll'
source_filename = "fake/example.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.fpromise = type {}

@fp1 = dso_local global %struct.fpromise zeroinitializer, align 1
@fp2 = dso_local global %struct.fpromise zeroinitializer, align 1
@fp3 = dso_local global %struct.fpromise zeroinitializer, align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @thread_func_1() #0 {
entry:
  call void @fget(%struct.fpromise* @fp1)
  call void @fput(%struct.fpromise* @fp2)
  ret void
}

declare dso_local void @fget(%struct.fpromise*) #1

declare dso_local void @fput(%struct.fpromise*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local void @thread_func_2() #0 {
entry:
  call void @fget(%struct.fpromise* @fp2)
  call void @fput(%struct.fpromise* @fp1)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @child_thread_func() #0 {
entry:
  call void @fget(%struct.fpromise* @fp1)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @thread_func_3() #0 {
entry:
  call void @fput(%struct.fpromise* @fp3)
  call void @fget(%struct.fpromise* @fp3)
  call void @fput(%struct.fpromise* @fp1)
  call void @start_fthread(void ()* @child_thread_func)
  ret void
}

declare dso_local void @start_fthread(void ()*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  call void @start_fthread(void ()* @thread_func_1)
  call void @start_fthread(void ()* @thread_func_2)
  call void @start_fthread(void ()* @thread_func_3)
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 11.0.0-++20200427091409+1956a8a7cb7-1~exp1~20200427072009.1648 "}
