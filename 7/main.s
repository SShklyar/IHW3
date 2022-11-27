	.file	"main.c"
	.intel_syntax noprefix

.ch:
         movsd   xmm3, QWORD PTR .LC0[rip]          #double t, k, p, eps = 1;
         movapd  xmm2, xmm3                         #p = 1
         movapd  xmm1, xmm3                         #k = 1
         movapd  xmm5, xmm3                         #t = 1
         mov     eax, 1                             #int i = 1
         movsd   xmm6, QWORD PTR .LC1[rip]
         jmp     .L3                                #заход в цикл while
 .L2:
         add     eax, 1                             #i++
         comisd  xmm3, xmm6
         jbe     .L5                                #выход из цикла
 .L3:
         mulsd   xmm2, xmm0                         #p = p * x
         pxor    xmm4, xmm4                         #k *= i
         cvtsi2sd        xmm4, eax
         mulsd   xmm1, xmm4
         test    al, 1                              #if (i % 2 == 0)
         jne     .L2
         movapd  xmm3, xmm2                         #eps = (p / k)
         divsd   xmm3, xmm1
         addsd   xmm5, xmm3                         #t += eps
         jmp     .L2
 .L5:                                               #выход из цикла
         movapd  xmm0, xmm5
         ret
 .LC2:
         .string "Invalid number of arguments!"
 .LC3:
         .string "r"
 .LC4:
         .string "Error opening input file!"
 .LC5:
         .string "w"
 .LC6:
         .string "Error opening output file!"
 .LC7:
         .string "%lf"
 main:
         push    rbx                                #пролог
         sub     rsp, 16
         mov     rbx, rsi
         cmp     edi, 3                             #if (argc != 3)
         jne     .L11
 .L7:                                               #if (freopen(argv[1], "r", stdin) == NULL)
         mov     rdi, QWORD PTR [rbx+8]
         mov     rdx, QWORD PTR stdin[rip]
         mov     esi, OFFSET FLAT:.LC3
         call    freopen
         test    rax, rax
         je      .L12
 .L8:                                               #if (freopen(argv[2], "w", stdout) == NULL)
         mov     rdi, QWORD PTR [rbx+16]
         mov     rdx, QWORD PTR stdout[rip]
         mov     esi, OFFSET FLAT:.LC5
         call    freopen
         test    rax, rax
         je      .L13
 .L9:
         lea     rsi, [rsp+8]                       #scanf("%lf", &x)
         mov     edi, OFFSET FLAT:.LC7
         mov     eax, 0
         call    __isoc99_scanf
         movsd   xmm0, QWORD PTR [rsp+8]            #printf("%lf", ch(x))
         call    ch
         mov     edi, OFFSET FLAT:.LC7
         mov     eax, 1
         call    printf
         mov     eax, 0                             #выход из main
         add     rsp, 16
         pop     rbx
         ret
 .L11:                                              #fprintf(stdout, "Invalid number of arguments!")
         mov     rcx, QWORD PTR stdout[rip]
         mov     edx, 28
         mov     esi, 1
         mov     edi, OFFSET FLAT:.LC2
         call    fwrite
         jmp     .L7
 .L12:                                              #fprintf(stdout, "Error opening input file!")
         mov     rcx, QWORD PTR stdout[rip]
         mov     edx, 25
         mov     esi, 1
         mov     edi, OFFSET FLAT:.LC4
         call    fwrite
         jmp     .L8
 .L13:                                              #fprintf(stdout, "Error opening output file!")
         mov     rcx, QWORD PTR stdout[rip]
         mov     edx, 26
         mov     esi, 1
         mov     edi, OFFSET FLAT:.LC6
         call    fwrite
         jmp     .L9
 .LC0:
         .long   0
         .long   1072693248
 .LC1:
         .long   1202590843
         .long   1064598241