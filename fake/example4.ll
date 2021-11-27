; ModuleID = 'example4.ll'
source_filename = "example4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.fpromise = type {}

@p1 = dso_local global %struct.fpromise* null, align 8, !dbg !0
@p2 = dso_local global %struct.fpromise* null, align 8, !dbg !13
@fp1 = dso_local global %struct.fpromise zeroinitializer, align 1, !dbg !6
@fp2 = dso_local global %struct.fpromise zeroinitializer, align 1, !dbg !11
@a = dso_local global i32 0, align 4, !dbg !16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @thread_func_1() #0 !dbg !23 {
entry:
  %0 = load %struct.fpromise*, %struct.fpromise** @p1, align 8, !dbg !26
  call void @fput(%struct.fpromise* %0), !dbg !27
  %1 = load %struct.fpromise*, %struct.fpromise** @p2, align 8, !dbg !28
  call void @fget(%struct.fpromise* %1), !dbg !29
  ret void, !dbg !30
}

declare dso_local void @fput(%struct.fpromise*) #1

declare dso_local void @fget(%struct.fpromise*) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @thread_func_2() #0 !dbg !31 {
entry:
  %0 = load %struct.fpromise*, %struct.fpromise** @p1, align 8, !dbg !32
  call void @fget(%struct.fpromise* %0), !dbg !33
  %1 = load %struct.fpromise*, %struct.fpromise** @p2, align 8, !dbg !34
  call void @fput(%struct.fpromise* %1), !dbg !35
  ret void, !dbg !36
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !37 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store %struct.fpromise* @fp1, %struct.fpromise** @p1, align 8, !dbg !40
  store %struct.fpromise* @fp2, %struct.fpromise** @p2, align 8, !dbg !41
  call void @start_fthread(void ()* @thread_func_1), !dbg !42
  call void @start_fthread(void ()* @thread_func_2), !dbg !43
  %0 = load %struct.fpromise*, %struct.fpromise** @p1, align 8, !dbg !44
  call void @fget(%struct.fpromise* %0), !dbg !45
  %1 = load %struct.fpromise*, %struct.fpromise** @p2, align 8, !dbg !46
  call void @fget(%struct.fpromise* %1), !dbg !47
  ret i32 0, !dbg !48
}

declare dso_local void @start_fthread(void ()*) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!19, !20, !21}
!llvm.ident = !{!22}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "p1", scope: !2, file: !3, line: 5, type: !15, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 11.0.0-++20200427091409+1956a8a7cb7-1~exp1~20200427072009.1648 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "example4.c", directory: "/home/jerry/F2021/6340/svf-promise/fake")
!4 = !{}
!5 = !{!6, !11, !0, !13, !16}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "fp1", scope: !2, file: !3, line: 4, type: !8, isLocal: false, isDefinition: true)
!8 = !DIDerivedType(tag: DW_TAG_typedef, name: "fpromise", file: !9, line: 4, baseType: !10)
!9 = !DIFile(filename: "./fpromise.h", directory: "/home/jerry/F2021/6340/svf-promise/fake")
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !9, line: 4, elements: !4)
!11 = !DIGlobalVariableExpression(var: !12, expr: !DIExpression())
!12 = distinct !DIGlobalVariable(name: "fp2", scope: !2, file: !3, line: 4, type: !8, isLocal: false, isDefinition: true)
!13 = !DIGlobalVariableExpression(var: !14, expr: !DIExpression())
!14 = distinct !DIGlobalVariable(name: "p2", scope: !2, file: !3, line: 6, type: !15, isLocal: false, isDefinition: true)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!16 = !DIGlobalVariableExpression(var: !17, expr: !DIExpression())
!17 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 7, type: !18, isLocal: false, isDefinition: true)
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !{i32 7, !"Dwarf Version", i32 4}
!20 = !{i32 2, !"Debug Info Version", i32 3}
!21 = !{i32 1, !"wchar_size", i32 4}
!22 = !{!"clang version 11.0.0-++20200427091409+1956a8a7cb7-1~exp1~20200427072009.1648 "}
!23 = distinct !DISubprogram(name: "thread_func_1", scope: !3, file: !3, line: 9, type: !24, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!24 = !DISubroutineType(types: !25)
!25 = !{null}
!26 = !DILocation(line: 10, column: 7, scope: !23)
!27 = !DILocation(line: 10, column: 2, scope: !23)
!28 = !DILocation(line: 11, column: 10, scope: !23)
!29 = !DILocation(line: 11, column: 5, scope: !23)
!30 = !DILocation(line: 12, column: 1, scope: !23)
!31 = distinct !DISubprogram(name: "thread_func_2", scope: !3, file: !3, line: 14, type: !24, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!32 = !DILocation(line: 15, column: 10, scope: !31)
!33 = !DILocation(line: 15, column: 5, scope: !31)
!34 = !DILocation(line: 16, column: 7, scope: !31)
!35 = !DILocation(line: 16, column: 2, scope: !31)
!36 = !DILocation(line: 17, column: 1, scope: !31)
!37 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 20, type: !38, scopeLine: 20, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!38 = !DISubroutineType(types: !39)
!39 = !{!18}
!40 = !DILocation(line: 21, column: 8, scope: !37)
!41 = !DILocation(line: 22, column: 8, scope: !37)
!42 = !DILocation(line: 23, column: 2, scope: !37)
!43 = !DILocation(line: 24, column: 2, scope: !37)
!44 = !DILocation(line: 25, column: 10, scope: !37)
!45 = !DILocation(line: 25, column: 5, scope: !37)
!46 = !DILocation(line: 26, column: 10, scope: !37)
!47 = !DILocation(line: 26, column: 5, scope: !37)
!48 = !DILocation(line: 27, column: 2, scope: !37)
