; ModuleID = 'hclib_basic.ll'
source_filename = "hclib_basic.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.anon = type { i8 }
%struct.hclib_task_t = type { void (i8*)*, i8*, %struct.finish_t*, [4 x %struct._hclib_future_t*], %struct._hclib_future_t**, i32, %struct._hclib_locale_t*, i32, %struct.hclib_task_t* }
%struct.finish_t = type opaque
%struct._hclib_future_t = type { %struct.hclib_promise_st* }
%struct.hclib_promise_st = type { %struct._hclib_future_t, i32, i8*, %struct.hclib_task_t* }
%struct._hclib_locale_t = type { i32, i32, i8*, i8*, i8*, void ()**, i32, i32, %struct._hclib_deque_t* }
%struct._hclib_deque_t = type opaque
%"struct.hclib::promise_t" = type { %struct.hclib_promise_st }
%struct._hclib_worker_state = type { %struct.hclib_context*, %struct._hclib_worker_paths*, i64, %struct.finish_t*, %struct.LiteCtxStruct*, %struct.LiteCtxStruct*, i32, i32, i8*, i32, i32, i8*, [48 x i8] }
%struct.hclib_context = type opaque
%struct._hclib_worker_paths = type { %struct._hclib_locality_path*, %struct._hclib_locality_path*, i32 }
%struct._hclib_locality_path = type { %struct._hclib_locale_t**, i32 }
%struct.LiteCtxStruct = type { %struct.LiteCtxStruct*, i8*, i8*, %struct.fcontext_t, [0 x i8] }
%struct.fcontext_t = type { i8* }
%class.anon.0 = type { %"struct.hclib::promise_t"** }
%class.anon.1 = type { %"struct.hclib::promise_t"** }
%"struct.hclib::future_t" = type { %struct._hclib_future_t }
%class.anon.2 = type { %"struct.hclib::promise_t"** }
%class.anon.4 = type { %"struct.hclib::promise_t"** }

@.str = private unnamed_addr constant [7 x i8] c"system\00", align 1
@.str.1 = private unnamed_addr constant [15 x i8] c"lambda_on_heap\00", align 1
@.str.2 = private unnamed_addr constant [61 x i8] c"/home/fjin/hclib_vanilla/hclib-install/include/hclib-async.h\00", align 1
@"__PRETTY_FUNCTION__._ZN5hclib15_allocate_asyncIZ4mainE3$_0EEP12hclib_task_tPT_" = private unnamed_addr constant [82 x i8] c"hclib_task_t *hclib::_allocate_async(T *) [T = (lambda at hclib_basic.cpp:12:26)]\00", align 1
@.str.3 = private unnamed_addr constant [20 x i8] c"t && lambda_on_heap\00", align 1
@"__PRETTY_FUNCTION__._ZN5hclib15initialize_taskIPFvPZ4mainE3$_0ES1_EEP12hclib_task_tT_PT0_" = private unnamed_addr constant [152 x i8] c"hclib_task_t *hclib::initialize_task(Function, T1 *) [Function = void (*)((lambda at hclib_basic.cpp:12:26) *), T1 = (lambda at hclib_basic.cpp:12:26)]\00", align 1
@.str.4 = private unnamed_addr constant [15 x i8] c"result is %d \0A\00", align 1
@"__PRETTY_FUNCTION__._ZN5hclib15initialize_taskIPFvPZZ4mainENK3$_0clEvEUlvE_ES2_EEP12hclib_task_tT_PT0_" = private unnamed_addr constant [152 x i8] c"hclib_task_t *hclib::initialize_task(Function, T1 *) [Function = void (*)((lambda at hclib_basic.cpp:16:18) *), T1 = (lambda at hclib_basic.cpp:16:18)]\00", align 1
@"__PRETTY_FUNCTION__._ZN5hclib15initialize_taskIPFvPZZZ4mainENK3$_0clEvENKUlvE_clEvEUlvE_ES3_EEP12hclib_task_tT_PT0_" = private unnamed_addr constant [152 x i8] c"hclib_task_t *hclib::initialize_task(Function, T1 *) [Function = void (*)((lambda at hclib_basic.cpp:21:20) *), T1 = (lambda at hclib_basic.cpp:21:20)]\00", align 1
@"__PRETTY_FUNCTION__._ZN5hclib15initialize_taskIPFvPZZ4mainENK3$_0clEvEUlvE0_ES2_EEP12hclib_task_tT_PT0_" = private unnamed_addr constant [152 x i8] c"hclib_task_t *hclib::initialize_task(Function, T1 *) [Function = void (*)((lambda at hclib_basic.cpp:29:17) *), T1 = (lambda at hclib_basic.cpp:29:17)]\00", align 1
@"__PRETTY_FUNCTION__._ZN5hclib15initialize_taskIPFvPZZ4mainENK3$_0clEvEUlvE1_ES2_EEP12hclib_task_tT_PT0_" = private unnamed_addr constant [152 x i8] c"hclib_task_t *hclib::initialize_task(Function, T1 *) [Function = void (*)((lambda at hclib_basic.cpp:36:17) *), T1 = (lambda at hclib_basic.cpp:36:17)]\00", align 1
@str = private unnamed_addr constant [7 x i8] c"hello \00", align 1
@str.9 = private unnamed_addr constant [19 x i8] c"hello from async2 \00", align 1
@str.10 = private unnamed_addr constant [19 x i8] c"hello from async3 \00", align 1
@str.11 = private unnamed_addr constant [19 x i8] c"hello from async4 \00", align 1

; Function Attrs: norecurse uwtable
define dso_local i32 @main(i32 %argc, i8** nocapture readnone %argv) local_unnamed_addr #0 personality i32 (...)* @__gxx_personality_v0 {
entry:
  %deps = alloca [1 x i8*], align 8
  %0 = bitcast [1 x i8*]* %deps to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %0) #12
  %1 = bitcast [1 x i8*]* %deps to i64*
  store i64 ptrtoint ([7 x i8]* @.str to i64), i64* %1, align 8
  %call.i.i = tail call noalias dereferenceable_or_null(1) i8* @malloc(i64 1) #12
  %tobool.not.i.i = icmp eq i8* %call.i.i, null
  br i1 %tobool.not.i.i, label %cond.false.i.i, label %cond.end.i.i

cond.false.i.i:                                   ; preds = %entry
  tail call void @__assert_fail(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.2, i64 0, i64 0), i32 144, i8* getelementptr inbounds ([82 x i8], [82 x i8]* @"__PRETTY_FUNCTION__._ZN5hclib15_allocate_asyncIZ4mainE3$_0EEP12hclib_task_tPT_", i64 0, i64 0)) #13
  unreachable

cond.end.i.i:                                     ; preds = %entry
  %call.i.i.i = tail call noalias dereferenceable_or_null(96) i8* @calloc(i64 1, i64 96) #12
  %tobool.i.not.i.i = icmp eq i8* %call.i.i.i, null
  br i1 %tobool.i.not.i.i, label %cond.false.i.i.i, label %"_ZN5hclib6launchIZ4mainE3$_0EEvPPKciOT_.exit"

cond.false.i.i.i:                                 ; preds = %cond.end.i.i
  tail call void @__assert_fail(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.3, i64 0, i64 0), i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.2, i64 0, i64 0), i32 128, i8* getelementptr inbounds ([152 x i8], [152 x i8]* @"__PRETTY_FUNCTION__._ZN5hclib15initialize_taskIPFvPZ4mainE3$_0ES1_EEP12hclib_task_tT_PT0_", i64 0, i64 0)) #13
  unreachable

"_ZN5hclib6launchIZ4mainE3$_0EEvPPKciOT_.exit":   ; preds = %cond.end.i.i
  %arraydecay = getelementptr inbounds [1 x i8*], [1 x i8*]* %deps, i64 0, i64 0
  %call2.i.i.i = tail call noalias nonnull dereferenceable(16) i8* @_Znwm(i64 16) #14
  %lambda_caller.i.i.i.i = bitcast i8* %call2.i.i.i to void (%class.anon*)**
  store void (%class.anon*)* @"_ZN5hclib11call_lambdaIZ4mainE3$_0EEvPT_", void (%class.anon*)** %lambda_caller.i.i.i.i, align 8, !tbaa !2
  %lambda_on_heap.i.i.i.i = getelementptr inbounds i8, i8* %call2.i.i.i, i64 8
  %2 = bitcast i8* %lambda_on_heap.i.i.i.i to i8**
  store i8* %call.i.i, i8** %2, align 8, !tbaa !7
  %_fp.i.i.i = bitcast i8* %call.i.i.i to void (i8*)**
  store void (i8*)* @"_ZN5hclib14lambda_wrapperIPFvPZ4mainE3$_0ES1_EEvPv", void (i8*)** %_fp.i.i.i, align 8, !tbaa !8
  %args3.i.i.i = getelementptr inbounds i8, i8* %call.i.i.i, i64 8
  %3 = bitcast i8* %args3.i.i.i to i8**
  store i8* %call2.i.i.i, i8** %3, align 8, !tbaa !11
  call void @hclib_launch(void (i8*)* bitcast (void (%struct.hclib_task_t*)* @spawn to void (i8*)*), i8* nonnull %call.i.i.i, i8** nonnull %arraydecay, i32 1)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %0) #12
  ret i32 0
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nobuiltin nofree allocsize(0)
declare dso_local nonnull i8* @_Znwm(i64) local_unnamed_addr #2

declare dso_local void @hclib_launch(void (i8*)*, i8*, i8**, i32) local_unnamed_addr #3

declare dso_local void @spawn(%struct.hclib_task_t*) #3

; Function Attrs: inaccessiblememonly nofree nounwind willreturn
declare dso_local noalias noundef i8* @malloc(i64) local_unnamed_addr #4

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) local_unnamed_addr #5

; Function Attrs: inlinehint uwtable
define internal void @"_ZN5hclib11call_lambdaIZ4mainE3$_0EEvPT_"(%class.anon* %lambda) #6 personality i32 (...)* @__gxx_personality_v0 {
entry:
  %p.i = alloca %"struct.hclib::promise_t"*, align 8
  %t.i = alloca %"struct.hclib::promise_t"*, align 8
  %x.i = alloca %"struct.hclib::promise_t"*, align 8
  %call = tail call %struct._hclib_worker_state* @current_ws()
  %id = getelementptr inbounds %struct._hclib_worker_state, %struct._hclib_worker_state* %call, i64 0, i32 6
  %0 = load i32, i32* %id, align 16, !tbaa !12
  tail call void @hclib_set_state(i32 %0, i32 0)
  %1 = bitcast %"struct.hclib::promise_t"** %p.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %1) #12
  %call.i = tail call noalias nonnull dereferenceable(32) i8* @_Znwm(i64 32) #14
  %2 = bitcast i8* %call.i to %struct.hclib_promise_st*
  invoke void @hclib_promise_init(%struct.hclib_promise_st* nonnull %2)
          to label %invoke.cont.i unwind label %lpad.i

invoke.cont.i:                                    ; preds = %entry
  %3 = bitcast %"struct.hclib::promise_t"** %p.i to i8**
  store i8* %call.i, i8** %3, align 8, !tbaa !15
  %call.i.i = tail call %struct._hclib_worker_state* @current_ws()
  %id.i.i = getelementptr inbounds %struct._hclib_worker_state, %struct._hclib_worker_state* %call.i.i, i64 0, i32 6
  %4 = load i32, i32* %id.i.i, align 16, !tbaa !12
  tail call void @hclib_set_state(i32 %4, i32 2)
  %call1.i.i = tail call noalias nonnull dereferenceable(8) i8* @_Znwm(i64 8) #14
  %5 = bitcast i8* %call1.i.i to i64*
  %6 = ptrtoint %"struct.hclib::promise_t"** %p.i to i64
  store i64 %6, i64* %5, align 8, !tbaa !15
  %call.i.i.i = call noalias dereferenceable_or_null(96) i8* @calloc(i64 1, i64 96) #12
  %tobool.i.not.i.i = icmp eq i8* %call.i.i.i, null
  br i1 %tobool.i.not.i.i, label %cond.false.i.i.i, label %"_ZN5hclib5asyncIZZ4mainENK3$_0clEvEUlvE_EEvOT_.exit.i"

cond.false.i.i.i:                                 ; preds = %invoke.cont.i
  call void @__assert_fail(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.3, i64 0, i64 0), i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.2, i64 0, i64 0), i32 128, i8* getelementptr inbounds ([152 x i8], [152 x i8]* @"__PRETTY_FUNCTION__._ZN5hclib15initialize_taskIPFvPZZ4mainENK3$_0clEvEUlvE_ES2_EEP12hclib_task_tT_PT0_", i64 0, i64 0)) #13
  unreachable

"_ZN5hclib5asyncIZZ4mainENK3$_0clEvEUlvE_EEvOT_.exit.i": ; preds = %invoke.cont.i
  %7 = bitcast i8* %call.i.i.i to %struct.hclib_task_t*
  %call2.i.i.i = call noalias nonnull dereferenceable(16) i8* @_Znwm(i64 16) #14
  %lambda_caller.i.i.i.i = bitcast i8* %call2.i.i.i to void (%class.anon.0*)**
  store void (%class.anon.0*)* @"_ZN5hclib11call_lambdaIZZ4mainENK3$_0clEvEUlvE_EEvPT_", void (%class.anon.0*)** %lambda_caller.i.i.i.i, align 8, !tbaa !16
  %lambda_on_heap.i.i.i.i = getelementptr inbounds i8, i8* %call2.i.i.i, i64 8
  %8 = bitcast i8* %lambda_on_heap.i.i.i.i to i8**
  store i8* %call1.i.i, i8** %8, align 8, !tbaa !18
  %_fp.i.i.i = bitcast i8* %call.i.i.i to void (i8*)**
  store void (i8*)* @"_ZN5hclib14lambda_wrapperIPFvPZZ4mainENK3$_0clEvEUlvE_ES2_EEvPv", void (i8*)** %_fp.i.i.i, align 8, !tbaa !8
  %args3.i.i.i = getelementptr inbounds i8, i8* %call.i.i.i, i64 8
  %9 = bitcast i8* %args3.i.i.i to i8**
  store i8* %call2.i.i.i, i8** %9, align 8, !tbaa !11
  call void @spawn(%struct.hclib_task_t* nonnull %7)
  %10 = bitcast %"struct.hclib::promise_t"** %t.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %10) #12
  %call2.i = call noalias nonnull dereferenceable(32) i8* @_Znwm(i64 32) #14
  %11 = bitcast i8* %call2.i to %struct.hclib_promise_st*
  invoke void @hclib_promise_init(%struct.hclib_promise_st* nonnull %11)
          to label %invoke.cont4.i unwind label %lpad3.i

invoke.cont4.i:                                   ; preds = %"_ZN5hclib5asyncIZZ4mainENK3$_0clEvEUlvE_EEvOT_.exit.i"
  %12 = bitcast %"struct.hclib::promise_t"** %t.i to i8**
  store i8* %call2.i, i8** %12, align 8, !tbaa !15
  %call.i4.i = call %struct._hclib_worker_state* @current_ws()
  %id.i5.i = getelementptr inbounds %struct._hclib_worker_state, %struct._hclib_worker_state* %call.i4.i, i64 0, i32 6
  %13 = load i32, i32* %id.i5.i, align 16, !tbaa !12
  call void @hclib_set_state(i32 %13, i32 2)
  %call1.i6.i = call noalias nonnull dereferenceable(8) i8* @_Znwm(i64 8) #14
  %14 = bitcast i8* %call1.i6.i to i64*
  %15 = ptrtoint %"struct.hclib::promise_t"** %t.i to i64
  store i64 %15, i64* %14, align 8, !tbaa !15
  %call.i.i7.i = call noalias dereferenceable_or_null(96) i8* @calloc(i64 1, i64 96) #12
  %tobool.i.not.i8.i = icmp eq i8* %call.i.i7.i, null
  br i1 %tobool.i.not.i8.i, label %cond.false.i.i9.i, label %"_ZN5hclib5asyncIZZ4mainENK3$_0clEvEUlvE0_EEvOT_.exit.i"

cond.false.i.i9.i:                                ; preds = %invoke.cont4.i
  call void @__assert_fail(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.3, i64 0, i64 0), i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.2, i64 0, i64 0), i32 128, i8* getelementptr inbounds ([152 x i8], [152 x i8]* @"__PRETTY_FUNCTION__._ZN5hclib15initialize_taskIPFvPZZ4mainENK3$_0clEvEUlvE0_ES2_EEP12hclib_task_tT_PT0_", i64 0, i64 0)) #13
  unreachable

"_ZN5hclib5asyncIZZ4mainENK3$_0clEvEUlvE0_EEvOT_.exit.i": ; preds = %invoke.cont4.i
  %16 = bitcast i8* %call.i.i7.i to %struct.hclib_task_t*
  %call2.i.i10.i = call noalias nonnull dereferenceable(16) i8* @_Znwm(i64 16) #14
  %lambda_caller.i.i.i11.i = bitcast i8* %call2.i.i10.i to void (%class.anon.1*)**
  store void (%class.anon.1*)* @"_ZN5hclib11call_lambdaIZZ4mainENK3$_0clEvEUlvE0_EEvPT_", void (%class.anon.1*)** %lambda_caller.i.i.i11.i, align 8, !tbaa !19
  %lambda_on_heap.i.i.i12.i = getelementptr inbounds i8, i8* %call2.i.i10.i, i64 8
  %17 = bitcast i8* %lambda_on_heap.i.i.i12.i to i8**
  store i8* %call1.i6.i, i8** %17, align 8, !tbaa !21
  %_fp.i.i13.i = bitcast i8* %call.i.i7.i to void (i8*)**
  store void (i8*)* @"_ZN5hclib14lambda_wrapperIPFvPZZ4mainENK3$_0clEvEUlvE0_ES2_EEvPv", void (i8*)** %_fp.i.i13.i, align 8, !tbaa !8
  %args3.i.i14.i = getelementptr inbounds i8, i8* %call.i.i7.i, i64 8
  %18 = bitcast i8* %args3.i.i14.i to i8**
  store i8* %call2.i.i10.i, i8** %18, align 8, !tbaa !11
  call void @spawn(%struct.hclib_task_t* nonnull %16)
  %19 = bitcast %"struct.hclib::promise_t"** %t.i to %"struct.hclib::future_t"**
  %20 = load %"struct.hclib::future_t"*, %"struct.hclib::future_t"** %19, align 8, !tbaa !15
  %21 = getelementptr inbounds %"struct.hclib::future_t", %"struct.hclib::future_t"* %20, i64 0, i32 0
  %call.i15.i = call i8* @hclib_future_wait(%struct._hclib_future_t* nonnull %21)
  %22 = bitcast %"struct.hclib::promise_t"** %x.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %22) #12
  %call8.i = call noalias nonnull dereferenceable(32) i8* @_Znwm(i64 32) #14
  %23 = bitcast i8* %call8.i to %struct.hclib_promise_st*
  invoke void @hclib_promise_init(%struct.hclib_promise_st* nonnull %23)
          to label %invoke.cont10.i unwind label %lpad9.i

invoke.cont10.i:                                  ; preds = %"_ZN5hclib5asyncIZZ4mainENK3$_0clEvEUlvE0_EEvOT_.exit.i"
  %24 = bitcast %"struct.hclib::promise_t"** %x.i to i8**
  store i8* %call8.i, i8** %24, align 8, !tbaa !15
  %call.i17.i = call %struct._hclib_worker_state* @current_ws()
  %id.i18.i = getelementptr inbounds %struct._hclib_worker_state, %struct._hclib_worker_state* %call.i17.i, i64 0, i32 6
  %25 = load i32, i32* %id.i18.i, align 16, !tbaa !12
  call void @hclib_set_state(i32 %25, i32 2)
  %call1.i19.i = call noalias nonnull dereferenceable(8) i8* @_Znwm(i64 8) #14
  %26 = bitcast i8* %call1.i19.i to i64*
  %27 = ptrtoint %"struct.hclib::promise_t"** %x.i to i64
  store i64 %27, i64* %26, align 8, !tbaa !15
  %call.i.i20.i = call noalias dereferenceable_or_null(96) i8* @calloc(i64 1, i64 96) #12
  %tobool.i.not.i21.i = icmp eq i8* %call.i.i20.i, null
  br i1 %tobool.i.not.i21.i, label %cond.false.i.i22.i, label %"_ZZ4mainENK3$_0clEv.exit"

cond.false.i.i22.i:                               ; preds = %invoke.cont10.i
  call void @__assert_fail(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.3, i64 0, i64 0), i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.2, i64 0, i64 0), i32 128, i8* getelementptr inbounds ([152 x i8], [152 x i8]* @"__PRETTY_FUNCTION__._ZN5hclib15initialize_taskIPFvPZZ4mainENK3$_0clEvEUlvE1_ES2_EEP12hclib_task_tT_PT0_", i64 0, i64 0)) #13
  unreachable

lpad.i:                                           ; preds = %entry
  %28 = landingpad { i8*, i32 }
          cleanup
  tail call void @_ZdlPv(i8* nonnull %call.i) #15
  br label %ehcleanup15.i

lpad3.i:                                          ; preds = %"_ZN5hclib5asyncIZZ4mainENK3$_0clEvEUlvE_EEvOT_.exit.i"
  %29 = landingpad { i8*, i32 }
          cleanup
  call void @_ZdlPv(i8* nonnull %call2.i) #15
  br label %ehcleanup.i

lpad9.i:                                          ; preds = %"_ZN5hclib5asyncIZZ4mainENK3$_0clEvEUlvE0_EEvOT_.exit.i"
  %30 = landingpad { i8*, i32 }
          cleanup
  call void @_ZdlPv(i8* nonnull %call8.i) #15
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %22) #12
  br label %ehcleanup.i

ehcleanup.i:                                      ; preds = %lpad9.i, %lpad3.i
  %.pn.i = phi { i8*, i32 } [ %30, %lpad9.i ], [ %29, %lpad3.i ]
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %10) #12
  br label %ehcleanup15.i

ehcleanup15.i:                                    ; preds = %ehcleanup.i, %lpad.i
  %.pn.pn.i = phi { i8*, i32 } [ %.pn.i, %ehcleanup.i ], [ %28, %lpad.i ]
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %1) #12
  resume { i8*, i32 } %.pn.pn.i

"_ZZ4mainENK3$_0clEv.exit":                       ; preds = %invoke.cont10.i
  %31 = bitcast i8* %call.i.i20.i to %struct.hclib_task_t*
  %call2.i.i23.i = call noalias nonnull dereferenceable(16) i8* @_Znwm(i64 16) #14
  %lambda_caller.i.i.i24.i = bitcast i8* %call2.i.i23.i to void (%class.anon.2*)**
  store void (%class.anon.2*)* @"_ZN5hclib11call_lambdaIZZ4mainENK3$_0clEvEUlvE1_EEvPT_", void (%class.anon.2*)** %lambda_caller.i.i.i24.i, align 8, !tbaa !22
  %lambda_on_heap.i.i.i25.i = getelementptr inbounds i8, i8* %call2.i.i23.i, i64 8
  %32 = bitcast i8* %lambda_on_heap.i.i.i25.i to i8**
  store i8* %call1.i19.i, i8** %32, align 8, !tbaa !24
  %_fp.i.i26.i = bitcast i8* %call.i.i20.i to void (i8*)**
  store void (i8*)* @"_ZN5hclib14lambda_wrapperIPFvPZZ4mainENK3$_0clEvEUlvE1_ES2_EEvPv", void (i8*)** %_fp.i.i26.i, align 8, !tbaa !8
  %args3.i.i27.i = getelementptr inbounds i8, i8* %call.i.i20.i, i64 8
  %33 = bitcast i8* %args3.i.i27.i to i8**
  store i8* %call2.i.i23.i, i8** %33, align 8, !tbaa !11
  call void @spawn(%struct.hclib_task_t* nonnull %31)
  %34 = bitcast %"struct.hclib::promise_t"** %p.i to %"struct.hclib::future_t"**
  %35 = load %"struct.hclib::future_t"*, %"struct.hclib::future_t"** %34, align 8, !tbaa !15
  %36 = getelementptr inbounds %"struct.hclib::future_t", %"struct.hclib::future_t"* %35, i64 0, i32 0
  %call.i28.i = call i8* @hclib_future_wait(%struct._hclib_future_t* nonnull %36)
  %37 = ptrtoint i8* %call.i28.i to i64
  %tmp.sroa.0.0.extract.trunc.i29.i = trunc i64 %37 to i32
  %call14.i = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([15 x i8], [15 x i8]* @.str.4, i64 0, i64 0), i32 %tmp.sroa.0.0.extract.trunc.i29.i)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %22) #12
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %10) #12
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %1) #12
  %38 = getelementptr %class.anon, %class.anon* %lambda, i64 0, i32 0
  call void @_ZdlPv(i8* %38) #15
  call void @hclib_set_state(i32 %0, i32 2)
  ret void
}

; Function Attrs: inaccessiblememonly nofree nounwind willreturn
declare dso_local noalias noundef i8* @calloc(i64, i64) local_unnamed_addr #4

declare dso_local i32 @__gxx_personality_v0(...)

; Function Attrs: nobuiltin nounwind
declare dso_local void @_ZdlPv(i8*) local_unnamed_addr #7

; Function Attrs: uwtable mustprogress
define internal void @"_ZN5hclib14lambda_wrapperIPFvPZ4mainE3$_0ES1_EEvPv"(i8* nocapture readonly %args) #8 {
entry:
  %lambda_caller = bitcast i8* %args to void (%class.anon*)**
  %0 = load void (%class.anon*)*, void (%class.anon*)** %lambda_caller, align 8, !tbaa !2
  %lambda_on_heap = getelementptr inbounds i8, i8* %args, i64 8
  %1 = bitcast i8* %lambda_on_heap to %class.anon**
  %2 = load %class.anon*, %class.anon** %1, align 8, !tbaa !7
  tail call void %0(%class.anon* %2)
  ret void
}

declare dso_local %struct._hclib_worker_state* @current_ws() local_unnamed_addr #3

declare dso_local void @hclib_set_state(i32, i32) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #9

declare dso_local void @hclib_promise_init(%struct.hclib_promise_st*) local_unnamed_addr #3

; Function Attrs: inlinehint uwtable
define internal void @"_ZN5hclib11call_lambdaIZZ4mainENK3$_0clEvEUlvE_EEvPT_"(%class.anon.0* %lambda) #6 personality i32 (...)* @__gxx_personality_v0 {
entry:
  %q.i = alloca %"struct.hclib::promise_t"*, align 8
  %call = tail call %struct._hclib_worker_state* @current_ws()
  %id = getelementptr inbounds %struct._hclib_worker_state, %struct._hclib_worker_state* %call, i64 0, i32 6
  %0 = load i32, i32* %id, align 16, !tbaa !12
  tail call void @hclib_set_state(i32 %0, i32 0)
  %lambda.idx = getelementptr %class.anon.0, %class.anon.0* %lambda, i64 0, i32 0
  %lambda.idx.val = load %"struct.hclib::promise_t"**, %"struct.hclib::promise_t"*** %lambda.idx, align 8, !tbaa !25
  %lambda.idx.val.val = load %"struct.hclib::promise_t"*, %"struct.hclib::promise_t"** %lambda.idx.val, align 8, !tbaa !15
  %1 = getelementptr inbounds %"struct.hclib::promise_t", %"struct.hclib::promise_t"* %lambda.idx.val.val, i64 0, i32 0
  tail call void @hclib_promise_put(%struct.hclib_promise_st* nonnull %1, i8* nonnull inttoptr (i64 10 to i8*))
  %puts.i = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([7 x i8], [7 x i8]* @str, i64 0, i64 0))
  %2 = bitcast %"struct.hclib::promise_t"** %q.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2) #12
  %call2.i = tail call noalias nonnull dereferenceable(32) i8* @_Znwm(i64 32) #14
  %3 = bitcast i8* %call2.i to %struct.hclib_promise_st*
  invoke void @hclib_promise_init(%struct.hclib_promise_st* nonnull %3)
          to label %invoke.cont.i unwind label %lpad.i

invoke.cont.i:                                    ; preds = %entry
  %4 = bitcast %"struct.hclib::promise_t"** %q.i to i8**
  store i8* %call2.i, i8** %4, align 8, !tbaa !15
  %call.i.i = tail call %struct._hclib_worker_state* @current_ws()
  %id.i.i = getelementptr inbounds %struct._hclib_worker_state, %struct._hclib_worker_state* %call.i.i, i64 0, i32 6
  %5 = load i32, i32* %id.i.i, align 16, !tbaa !12
  tail call void @hclib_set_state(i32 %5, i32 2)
  %call1.i.i = tail call noalias nonnull dereferenceable(8) i8* @_Znwm(i64 8) #14
  %6 = bitcast i8* %call1.i.i to i64*
  %7 = ptrtoint %"struct.hclib::promise_t"** %q.i to i64
  store i64 %7, i64* %6, align 8, !tbaa !15
  %call.i.i.i = call noalias dereferenceable_or_null(96) i8* @calloc(i64 1, i64 96) #12
  %tobool.i.not.i.i = icmp eq i8* %call.i.i.i, null
  br i1 %tobool.i.not.i.i, label %cond.false.i.i.i, label %"_ZZZ4mainENK3$_0clEvENKUlvE_clEv.exit"

cond.false.i.i.i:                                 ; preds = %invoke.cont.i
  call void @__assert_fail(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.3, i64 0, i64 0), i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.2, i64 0, i64 0), i32 128, i8* getelementptr inbounds ([152 x i8], [152 x i8]* @"__PRETTY_FUNCTION__._ZN5hclib15initialize_taskIPFvPZZZ4mainENK3$_0clEvENKUlvE_clEvEUlvE_ES3_EEP12hclib_task_tT_PT0_", i64 0, i64 0)) #13
  unreachable

lpad.i:                                           ; preds = %entry
  %8 = landingpad { i8*, i32 }
          cleanup
  tail call void @_ZdlPv(i8* nonnull %call2.i) #15
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2) #12
  resume { i8*, i32 } %8

"_ZZZ4mainENK3$_0clEvENKUlvE_clEv.exit":          ; preds = %invoke.cont.i
  %9 = bitcast i8* %call.i.i.i to %struct.hclib_task_t*
  %call2.i.i.i = call noalias nonnull dereferenceable(16) i8* @_Znwm(i64 16) #14
  %lambda_caller.i.i.i.i = bitcast i8* %call2.i.i.i to void (%class.anon.4*)**
  store void (%class.anon.4*)* @"_ZN5hclib11call_lambdaIZZZ4mainENK3$_0clEvENKUlvE_clEvEUlvE_EEvPT_", void (%class.anon.4*)** %lambda_caller.i.i.i.i, align 8, !tbaa !27
  %lambda_on_heap.i.i.i.i = getelementptr inbounds i8, i8* %call2.i.i.i, i64 8
  %10 = bitcast i8* %lambda_on_heap.i.i.i.i to i8**
  store i8* %call1.i.i, i8** %10, align 8, !tbaa !29
  %_fp.i.i.i = bitcast i8* %call.i.i.i to void (i8*)**
  store void (i8*)* @"_ZN5hclib14lambda_wrapperIPFvPZZZ4mainENK3$_0clEvENKUlvE_clEvEUlvE_ES3_EEvPv", void (i8*)** %_fp.i.i.i, align 8, !tbaa !8
  %args3.i.i.i = getelementptr inbounds i8, i8* %call.i.i.i, i64 8
  %11 = bitcast i8* %args3.i.i.i to i8**
  store i8* %call2.i.i.i, i8** %11, align 8, !tbaa !11
  call void @spawn(%struct.hclib_task_t* nonnull %9)
  %12 = bitcast %"struct.hclib::promise_t"** %q.i to %"struct.hclib::future_t"**
  %13 = load %"struct.hclib::future_t"*, %"struct.hclib::future_t"** %12, align 8, !tbaa !15
  %14 = getelementptr inbounds %"struct.hclib::future_t", %"struct.hclib::future_t"* %13, i64 0, i32 0
  %call.i6.i = call i8* @hclib_future_wait(%struct._hclib_future_t* nonnull %14)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2) #12
  %15 = bitcast %class.anon.0* %lambda to i8*
  call void @_ZdlPv(i8* %15) #15
  call void @hclib_set_state(i32 %0, i32 2)
  ret void
}

; Function Attrs: uwtable mustprogress
define internal void @"_ZN5hclib14lambda_wrapperIPFvPZZ4mainENK3$_0clEvEUlvE_ES2_EEvPv"(i8* nocapture readonly %args) #8 {
entry:
  %lambda_caller = bitcast i8* %args to void (%class.anon.0*)**
  %0 = load void (%class.anon.0*)*, void (%class.anon.0*)** %lambda_caller, align 8, !tbaa !16
  %lambda_on_heap = getelementptr inbounds i8, i8* %args, i64 8
  %1 = bitcast i8* %lambda_on_heap to %class.anon.0**
  %2 = load %class.anon.0*, %class.anon.0** %1, align 8, !tbaa !18
  tail call void %0(%class.anon.0* %2)
  ret void
}

declare dso_local void @hclib_promise_put(%struct.hclib_promise_st*, i8*) local_unnamed_addr #3

; Function Attrs: inlinehint uwtable mustprogress
define internal void @"_ZN5hclib11call_lambdaIZZZ4mainENK3$_0clEvENKUlvE_clEvEUlvE_EEvPT_"(%class.anon.4* %lambda) #10 {
entry:
  %call = tail call %struct._hclib_worker_state* @current_ws()
  %id = getelementptr inbounds %struct._hclib_worker_state, %struct._hclib_worker_state* %call, i64 0, i32 6
  %0 = load i32, i32* %id, align 16, !tbaa !12
  tail call void @hclib_set_state(i32 %0, i32 0)
  %lambda.idx = getelementptr %class.anon.4, %class.anon.4* %lambda, i64 0, i32 0
  %lambda.idx.val = load %"struct.hclib::promise_t"**, %"struct.hclib::promise_t"*** %lambda.idx, align 8, !tbaa !30
  %lambda.idx.val.val = load %"struct.hclib::promise_t"*, %"struct.hclib::promise_t"** %lambda.idx.val, align 8, !tbaa !15
  %1 = getelementptr inbounds %"struct.hclib::promise_t", %"struct.hclib::promise_t"* %lambda.idx.val.val, i64 0, i32 0
  tail call void @hclib_promise_put(%struct.hclib_promise_st* nonnull %1, i8* nonnull inttoptr (i64 20 to i8*))
  %puts.i = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @str.9, i64 0, i64 0))
  %2 = bitcast %class.anon.4* %lambda to i8*
  tail call void @_ZdlPv(i8* %2) #15
  tail call void @hclib_set_state(i32 %0, i32 2)
  ret void
}

; Function Attrs: uwtable mustprogress
define internal void @"_ZN5hclib14lambda_wrapperIPFvPZZZ4mainENK3$_0clEvENKUlvE_clEvEUlvE_ES3_EEvPv"(i8* nocapture readonly %args) #8 {
entry:
  %lambda_caller = bitcast i8* %args to void (%class.anon.4*)**
  %0 = load void (%class.anon.4*)*, void (%class.anon.4*)** %lambda_caller, align 8, !tbaa !27
  %lambda_on_heap = getelementptr inbounds i8, i8* %args, i64 8
  %1 = bitcast i8* %lambda_on_heap to %class.anon.4**
  %2 = load %class.anon.4*, %class.anon.4** %1, align 8, !tbaa !29
  tail call void %0(%class.anon.4* %2)
  ret void
}

; Function Attrs: inlinehint uwtable mustprogress
define internal void @"_ZN5hclib11call_lambdaIZZ4mainENK3$_0clEvEUlvE0_EEvPT_"(%class.anon.1* %lambda) #10 {
entry:
  %call = tail call %struct._hclib_worker_state* @current_ws()
  %id = getelementptr inbounds %struct._hclib_worker_state, %struct._hclib_worker_state* %call, i64 0, i32 6
  %0 = load i32, i32* %id, align 16, !tbaa !12
  tail call void @hclib_set_state(i32 %0, i32 0)
  %lambda.idx = getelementptr %class.anon.1, %class.anon.1* %lambda, i64 0, i32 0
  %lambda.idx.val = load %"struct.hclib::promise_t"**, %"struct.hclib::promise_t"*** %lambda.idx, align 8, !tbaa !32
  %lambda.idx.val.val = load %"struct.hclib::promise_t"*, %"struct.hclib::promise_t"** %lambda.idx.val, align 8, !tbaa !15
  %1 = getelementptr inbounds %"struct.hclib::promise_t", %"struct.hclib::promise_t"* %lambda.idx.val.val, i64 0, i32 0
  tail call void @hclib_promise_put(%struct.hclib_promise_st* nonnull %1, i8* nonnull inttoptr (i64 30 to i8*))
  %puts.i = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @str.10, i64 0, i64 0))
  %2 = bitcast %class.anon.1* %lambda to i8*
  tail call void @_ZdlPv(i8* %2) #15
  tail call void @hclib_set_state(i32 %0, i32 2)
  ret void
}

; Function Attrs: uwtable mustprogress
define internal void @"_ZN5hclib14lambda_wrapperIPFvPZZ4mainENK3$_0clEvEUlvE0_ES2_EEvPv"(i8* nocapture readonly %args) #8 {
entry:
  %lambda_caller = bitcast i8* %args to void (%class.anon.1*)**
  %0 = load void (%class.anon.1*)*, void (%class.anon.1*)** %lambda_caller, align 8, !tbaa !19
  %lambda_on_heap = getelementptr inbounds i8, i8* %args, i64 8
  %1 = bitcast i8* %lambda_on_heap to %class.anon.1**
  %2 = load %class.anon.1*, %class.anon.1** %1, align 8, !tbaa !21
  tail call void %0(%class.anon.1* %2)
  ret void
}

declare dso_local i8* @hclib_future_wait(%struct._hclib_future_t*) local_unnamed_addr #3

; Function Attrs: inlinehint uwtable mustprogress
define internal void @"_ZN5hclib11call_lambdaIZZ4mainENK3$_0clEvEUlvE1_EEvPT_"(%class.anon.2* %lambda) #10 {
entry:
  %call = tail call %struct._hclib_worker_state* @current_ws()
  %id = getelementptr inbounds %struct._hclib_worker_state, %struct._hclib_worker_state* %call, i64 0, i32 6
  %0 = load i32, i32* %id, align 16, !tbaa !12
  tail call void @hclib_set_state(i32 %0, i32 0)
  %lambda.idx = getelementptr %class.anon.2, %class.anon.2* %lambda, i64 0, i32 0
  %lambda.idx.val = load %"struct.hclib::promise_t"**, %"struct.hclib::promise_t"*** %lambda.idx, align 8, !tbaa !34
  %lambda.idx.val.val = load %"struct.hclib::promise_t"*, %"struct.hclib::promise_t"** %lambda.idx.val, align 8, !tbaa !15
  %1 = getelementptr inbounds %"struct.hclib::promise_t", %"struct.hclib::promise_t"* %lambda.idx.val.val, i64 0, i32 0
  tail call void @hclib_promise_put(%struct.hclib_promise_st* nonnull %1, i8* nonnull inttoptr (i64 40 to i8*))
  %puts.i = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @str.11, i64 0, i64 0))
  %2 = bitcast %class.anon.2* %lambda to i8*
  tail call void @_ZdlPv(i8* %2) #15
  tail call void @hclib_set_state(i32 %0, i32 2)
  ret void
}

; Function Attrs: uwtable mustprogress
define internal void @"_ZN5hclib14lambda_wrapperIPFvPZZ4mainENK3$_0clEvEUlvE1_ES2_EEvPv"(i8* nocapture readonly %args) #8 {
entry:
  %lambda_caller = bitcast i8* %args to void (%class.anon.2*)**
  %0 = load void (%class.anon.2*)*, void (%class.anon.2*)** %lambda_caller, align 8, !tbaa !22
  %lambda_on_heap = getelementptr inbounds i8, i8* %args, i64 8
  %1 = bitcast i8* %lambda_on_heap to %class.anon.2**
  %2 = load %class.anon.2*, %class.anon.2** %1, align 8, !tbaa !24
  tail call void %0(%class.anon.2* %2)
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @puts(i8* nocapture noundef readonly) local_unnamed_addr #11

attributes #0 = { norecurse uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { nobuiltin nofree allocsize(0) "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { inaccessiblememonly nofree nounwind willreturn "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { inlinehint uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nobuiltin nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { uwtable mustprogress "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { nofree nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { inlinehint uwtable mustprogress "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #11 = { nofree nounwind }
attributes #12 = { nounwind }
attributes #13 = { noreturn nounwind }
attributes #14 = { builtin allocsize(0) }
attributes #15 = { builtin nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0"}
!2 = !{!3, !4, i64 0}
!3 = !{!"_ZTSN5hclib15async_argumentsIPFvPZ4mainE3$_0ES1_EE", !4, i64 0, !4, i64 8}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{!3, !4, i64 8}
!8 = !{!9, !4, i64 0}
!9 = !{!"_ZTS12hclib_task_t", !4, i64 0, !4, i64 8, !4, i64 16, !5, i64 24, !4, i64 56, !10, i64 64, !4, i64 72, !10, i64 80, !4, i64 88}
!10 = !{!"int", !5, i64 0}
!11 = !{!9, !4, i64 8}
!12 = !{!13, !10, i64 48}
!13 = !{!"_ZTS19_hclib_worker_state", !4, i64 0, !4, i64 8, !14, i64 16, !4, i64 24, !4, i64 32, !4, i64 40, !10, i64 48, !10, i64 52, !4, i64 56, !10, i64 64, !10, i64 68, !4, i64 72}
!14 = !{!"long", !5, i64 0}
!15 = !{!4, !4, i64 0}
!16 = !{!17, !4, i64 0}
!17 = !{!"_ZTSN5hclib15async_argumentsIPFvPZZ4mainENK3$_0clEvEUlvE_ES2_EE", !4, i64 0, !4, i64 8}
!18 = !{!17, !4, i64 8}
!19 = !{!20, !4, i64 0}
!20 = !{!"_ZTSN5hclib15async_argumentsIPFvPZZ4mainENK3$_0clEvEUlvE0_ES2_EE", !4, i64 0, !4, i64 8}
!21 = !{!20, !4, i64 8}
!22 = !{!23, !4, i64 0}
!23 = !{!"_ZTSN5hclib15async_argumentsIPFvPZZ4mainENK3$_0clEvEUlvE1_ES2_EE", !4, i64 0, !4, i64 8}
!24 = !{!23, !4, i64 8}
!25 = !{!26, !4, i64 0}
!26 = !{!"_ZTSZZ4mainENK3$_0clEvEUlvE_", !4, i64 0}
!27 = !{!28, !4, i64 0}
!28 = !{!"_ZTSN5hclib15async_argumentsIPFvPZZZ4mainENK3$_0clEvENKUlvE_clEvEUlvE_ES3_EE", !4, i64 0, !4, i64 8}
!29 = !{!28, !4, i64 8}
!30 = !{!31, !4, i64 0}
!31 = !{!"_ZTSZZZ4mainENK3$_0clEvENKUlvE_clEvEUlvE_", !4, i64 0}
!32 = !{!33, !4, i64 0}
!33 = !{!"_ZTSZZ4mainENK3$_0clEvEUlvE0_", !4, i64 0}
!34 = !{!35, !4, i64 0}
!35 = !{!"_ZTSZZ4mainENK3$_0clEvEUlvE1_", !4, i64 0}
