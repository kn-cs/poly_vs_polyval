/* Assembly to compute polyval512
   Author: Kaushik Nath
*/

#define REDUCE2

        .p2align 4
        .globl polyval512_asm

polyval512_asm:

        movq    %rsp,%r11
        andq 	$-16,%rsp
        subq 	$192,%rsp

        movq 	%r11,0(%rsp)
        movq 	%r12,8(%rsp)
        movq 	%r13,16(%rsp)
        movq 	%r14,24(%rsp)
        movq 	%r15,32(%rsp)
        movq 	%rbx,40(%rsp)
        movq 	%rbp,48(%rsp)

        vzeroall
        
        vmovdqa 0(%rsi),%xmm4
        vmovdqa 16(%rsi),%xmm5
        vmovdqa 32(%rsi),%xmm8
        vmovdqa 48(%rsi),%xmm9
        
        vmovdqa 0(%rdx),%xmm6
        vmovdqa 16(%rdx),%xmm7
        vmovdqa 32(%rdx),%xmm10
        vmovdqa 48(%rdx),%xmm11
        
        cmpq    $1,%rcx
        je      .L1

.L0:
        vpclmulqdq $0,%xmm4,%xmm6,%xmm0
        vpclmulqdq $17,%xmm4,%xmm6,%xmm1
        vpclmulqdq $1,%xmm4,%xmm6,%xmm12
        vpclmulqdq $16,%xmm4,%xmm6,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm0,%xmm0
        vpxor      %xmm13,%xmm1,%xmm1

        vpclmulqdq $0,%xmm5,%xmm7,%xmm2
        vpclmulqdq $17,%xmm5,%xmm7,%xmm3
        vpclmulqdq $1,%xmm5,%xmm7,%xmm12
        vpclmulqdq $16,%xmm5,%xmm7,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm2,%xmm2
        vpxor      %xmm13,%xmm3,%xmm3

        vpxor      %xmm4,%xmm5,%xmm4
        vpxor      %xmm6,%xmm7,%xmm5

        vpclmulqdq $0,%xmm4,%xmm5,%xmm14
        vpclmulqdq $17,%xmm4,%xmm5,%xmm15
        vpclmulqdq $1,%xmm4,%xmm5,%xmm12
        vpclmulqdq $16,%xmm4,%xmm5,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm14,%xmm14
        vpxor      %xmm13,%xmm15,%xmm15

        vpxor      %xmm14,%xmm0,%xmm14
        vpxor      %xmm15,%xmm1,%xmm15
        vpxor      %xmm14,%xmm2,%xmm14
        vpxor      %xmm15,%xmm3,%xmm15

        vpxor      %xmm14,%xmm1,%xmm1
        vpxor      %xmm15,%xmm2,%xmm2
        
        vmovdqa %xmm0,64(%rsp)
        vmovdqa %xmm1,80(%rsp)
        vmovdqa %xmm2,96(%rsp)
        vmovdqa %xmm3,112(%rsp)

        //
        vpclmulqdq $0,%xmm8,%xmm10,%xmm0
        vpclmulqdq $17,%xmm8,%xmm10,%xmm1
        vpclmulqdq $1,%xmm8,%xmm10,%xmm12
        vpclmulqdq $16,%xmm8,%xmm10,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm0,%xmm0
        vpxor      %xmm13,%xmm1,%xmm1

        vpclmulqdq $0,%xmm9,%xmm11,%xmm2
        vpclmulqdq $17,%xmm9,%xmm11,%xmm3
        vpclmulqdq $1,%xmm9,%xmm11,%xmm12
        vpclmulqdq $16,%xmm9,%xmm11,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm2,%xmm2
        vpxor      %xmm13,%xmm3,%xmm3

        vpxor      %xmm8,%xmm9,%xmm8
        vpxor      %xmm10,%xmm11,%xmm9

        vpclmulqdq $0,%xmm8,%xmm9,%xmm14
        vpclmulqdq $17,%xmm8,%xmm9,%xmm15
        vpclmulqdq $1,%xmm8,%xmm9,%xmm12
        vpclmulqdq $16,%xmm8,%xmm9,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm14,%xmm14
        vpxor      %xmm13,%xmm15,%xmm15

        vpxor      %xmm14,%xmm0,%xmm14
        vpxor      %xmm15,%xmm1,%xmm15
        vpxor      %xmm14,%xmm2,%xmm14
        vpxor      %xmm15,%xmm3,%xmm15

        vpxor      %xmm14,%xmm1,%xmm1
        vpxor      %xmm15,%xmm2,%xmm2
        
        vmovdqa %xmm0,128(%rsp)
        vmovdqa %xmm1,144(%rsp)
        vmovdqa %xmm2,160(%rsp)
        vmovdqa %xmm3,176(%rsp)

        vmovdqa 0(%rsi),%xmm4
        vmovdqa 16(%rsi),%xmm5
        vmovdqa 32(%rsi),%xmm8
        vmovdqa 48(%rsi),%xmm9
        
        vpxor %xmm4,%xmm8,%xmm4
        vpxor %xmm5,%xmm9,%xmm5
        vpxor %xmm6,%xmm10,%xmm6
        vpxor %xmm7,%xmm11,%xmm7
        
        //
        vpclmulqdq $0,%xmm4,%xmm6,%xmm0
        vpclmulqdq $17,%xmm4,%xmm6,%xmm1
        vpclmulqdq $1,%xmm4,%xmm6,%xmm12
        vpclmulqdq $16,%xmm4,%xmm6,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm0,%xmm0
        vpxor      %xmm13,%xmm1,%xmm1

        vpclmulqdq $0,%xmm5,%xmm7,%xmm2
        vpclmulqdq $17,%xmm5,%xmm7,%xmm3
        vpclmulqdq $1,%xmm5,%xmm7,%xmm12
        vpclmulqdq $16,%xmm5,%xmm7,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm2,%xmm2
        vpxor      %xmm13,%xmm3,%xmm3

        vpxor      %xmm4,%xmm5,%xmm4
        vpxor      %xmm6,%xmm7,%xmm5

        vpclmulqdq $0,%xmm4,%xmm5,%xmm14
        vpclmulqdq $17,%xmm4,%xmm5,%xmm15
        vpclmulqdq $1,%xmm4,%xmm5,%xmm12
        vpclmulqdq $16,%xmm4,%xmm5,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm14,%xmm14
        vpxor      %xmm13,%xmm15,%xmm15

        vpxor      %xmm14,%xmm0,%xmm14
        vpxor      %xmm15,%xmm1,%xmm15
        vpxor      %xmm14,%xmm2,%xmm14
        vpxor      %xmm15,%xmm3,%xmm15

        vpxor      %xmm14,%xmm1,%xmm1
        vpxor      %xmm15,%xmm2,%xmm2
        
        //
        vpxor 64(%rsp),%xmm0,%xmm0
        vpxor 80(%rsp),%xmm1,%xmm1
        vpxor 96(%rsp),%xmm2,%xmm2
        vpxor 112(%rsp),%xmm3,%xmm3

        vpxor 128(%rsp),%xmm0,%xmm0
        vpxor 144(%rsp),%xmm1,%xmm1
        vpxor 160(%rsp),%xmm2,%xmm2
        vpxor 176(%rsp),%xmm3,%xmm3

        vpxor 128(%rsp),%xmm2,%xmm4
        vpxor 144(%rsp),%xmm3,%xmm5
        vpxor 96(%rsp),%xmm0,%xmm2
        vpxor 112(%rsp),%xmm1,%xmm3
        
        vmovdqa 64(%rsp),%xmm0
        vmovdqa 80(%rsp),%xmm1
        vmovdqa 160(%rsp),%xmm6
        vmovdqa 176(%rsp),%xmm7

        // reduce
        #ifdef REDUCE1
        vpxor %xmm10,%xmm10,%xmm10
        vpxor %xmm11,%xmm11,%xmm11
        vpxor %xmm12,%xmm12,%xmm12
        vpxor %xmm13,%xmm13,%xmm13
        
        vpand      mask(%rip),%xmm0,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13

        vpsrldq    $8,%xmm0,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpand      mask(%rip),%xmm1,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpsrldq    $8,%xmm1,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13

        vpand      mask(%rip),%xmm2,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpsrldq    $8,%xmm2,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpand      mask(%rip),%xmm3,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpsrldq    $8,%xmm3,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        #endif
                
        #ifdef REDUCE2
        vpclmulqdq $16,POLY(%rip),%xmm0,%xmm8
        vpslldq    $8,%xmm0,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13

        vpsrldq    $8,%xmm0,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vpslldq    $8,%xmm13,%xmm12
        shufpd     $1,%xmm10,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpand      mask(%rip),%xmm1,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm10,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpsrldq    $8,%xmm1,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vpslldq    $8,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm10,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13

        vpand      mask(%rip),%xmm2,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm10,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpsrldq    $8,%xmm2,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpand      mask(%rip),%xmm3,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpsrldq    $8,%xmm3,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        #endif

        vpxor      %xmm10,%xmm4,%xmm4
        vpxor      %xmm11,%xmm5,%xmm5
        vpxor      %xmm12,%xmm6,%xmm8
        vpxor      %xmm13,%xmm7,%xmm9
        
        addq	$64,%rsi
        vpxor 0(%rsi),%xmm4,%xmm4
        vpxor 16(%rsi),%xmm5,%xmm5
        vpxor 32(%rsi),%xmm8,%xmm8
        vpxor 48(%rsi),%xmm9,%xmm9
        
        vmovdqa %xmm4,0(%rsi)
        vmovdqa %xmm5,16(%rsi)
        vmovdqa %xmm8,32(%rsi)
        vmovdqa %xmm9,48(%rsi)
        
        vmovdqa 0(%rdx),%xmm6
        vmovdqa 16(%rdx),%xmm7
        vmovdqa 32(%rdx),%xmm10
        vmovdqa 48(%rdx),%xmm11
        
        subq    $1,%rcx
        cmpq    $1,%rcx
        jg      .L0
        
.L1:
        vpclmulqdq $0,%xmm4,%xmm6,%xmm0
        vpclmulqdq $17,%xmm4,%xmm6,%xmm1
        vpclmulqdq $1,%xmm4,%xmm6,%xmm12
        vpclmulqdq $16,%xmm4,%xmm6,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm0,%xmm0
        vpxor      %xmm13,%xmm1,%xmm1

        vpclmulqdq $0,%xmm5,%xmm7,%xmm2
        vpclmulqdq $17,%xmm5,%xmm7,%xmm3
        vpclmulqdq $1,%xmm5,%xmm7,%xmm12
        vpclmulqdq $16,%xmm5,%xmm7,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm2,%xmm2
        vpxor      %xmm13,%xmm3,%xmm3

        vpxor      %xmm4,%xmm5,%xmm4
        vpxor      %xmm6,%xmm7,%xmm5

        vpclmulqdq $0,%xmm4,%xmm5,%xmm14
        vpclmulqdq $17,%xmm4,%xmm5,%xmm15
        vpclmulqdq $1,%xmm4,%xmm5,%xmm12
        vpclmulqdq $16,%xmm4,%xmm5,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm14,%xmm14
        vpxor      %xmm13,%xmm15,%xmm15

        vpxor      %xmm14,%xmm0,%xmm14
        vpxor      %xmm15,%xmm1,%xmm15
        vpxor      %xmm14,%xmm2,%xmm14
        vpxor      %xmm15,%xmm3,%xmm15

        vpxor      %xmm14,%xmm1,%xmm1
        vpxor      %xmm15,%xmm2,%xmm2
        
        vmovdqa %xmm0,64(%rsp)
        vmovdqa %xmm1,80(%rsp)
        vmovdqa %xmm2,96(%rsp)
        vmovdqa %xmm3,112(%rsp)

        vpclmulqdq $0,%xmm8,%xmm10,%xmm0
        vpclmulqdq $17,%xmm8,%xmm10,%xmm1
        vpclmulqdq $1,%xmm8,%xmm10,%xmm12
        vpclmulqdq $16,%xmm8,%xmm10,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm0,%xmm0
        vpxor      %xmm13,%xmm1,%xmm1

        vpclmulqdq $0,%xmm9,%xmm11,%xmm2
        vpclmulqdq $17,%xmm9,%xmm11,%xmm3
        vpclmulqdq $1,%xmm9,%xmm11,%xmm12
        vpclmulqdq $16,%xmm9,%xmm11,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm2,%xmm2
        vpxor      %xmm13,%xmm3,%xmm3

        vpxor      %xmm8,%xmm9,%xmm8
        vpxor      %xmm10,%xmm11,%xmm9

        vpclmulqdq $0,%xmm8,%xmm9,%xmm14
        vpclmulqdq $17,%xmm8,%xmm9,%xmm15
        vpclmulqdq $1,%xmm8,%xmm9,%xmm12
        vpclmulqdq $16,%xmm8,%xmm9,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm14,%xmm14
        vpxor      %xmm13,%xmm15,%xmm15

        vpxor      %xmm14,%xmm0,%xmm14
        vpxor      %xmm15,%xmm1,%xmm15
        vpxor      %xmm14,%xmm2,%xmm14
        vpxor      %xmm15,%xmm3,%xmm15

        vpxor      %xmm14,%xmm1,%xmm1
        vpxor      %xmm15,%xmm2,%xmm2
        
        vmovdqa %xmm0,128(%rsp)
        vmovdqa %xmm1,144(%rsp)
        vmovdqa %xmm2,160(%rsp)
        vmovdqa %xmm3,176(%rsp)
        
        vmovdqa 0(%rsi),%xmm4
        vmovdqa 16(%rsi),%xmm5
        vmovdqa 32(%rsi),%xmm8
        vmovdqa 48(%rsi),%xmm9
        
        vpxor      %xmm4,%xmm8,%xmm4
        vpxor      %xmm5,%xmm9,%xmm5
        vpxor      %xmm6,%xmm10,%xmm6
        vpxor      %xmm7,%xmm11,%xmm7
        
        //
        vpclmulqdq $0,%xmm4,%xmm6,%xmm0
        vpclmulqdq $17,%xmm4,%xmm6,%xmm1
        vpclmulqdq $1,%xmm4,%xmm6,%xmm12
        vpclmulqdq $16,%xmm4,%xmm6,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm0,%xmm0
        vpxor      %xmm13,%xmm1,%xmm1

        vpclmulqdq $0,%xmm5,%xmm7,%xmm2
        vpclmulqdq $17,%xmm5,%xmm7,%xmm3
        vpclmulqdq $1,%xmm5,%xmm7,%xmm12
        vpclmulqdq $16,%xmm5,%xmm7,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm2,%xmm2
        vpxor      %xmm13,%xmm3,%xmm3

        vpxor      %xmm4,%xmm5,%xmm4
        vpxor      %xmm6,%xmm7,%xmm5

        vpclmulqdq $0,%xmm4,%xmm5,%xmm14
        vpclmulqdq $17,%xmm4,%xmm5,%xmm15
        vpclmulqdq $1,%xmm4,%xmm5,%xmm12
        vpclmulqdq $16,%xmm4,%xmm5,%xmm13
        vpxor      %xmm12,%xmm13,%xmm13
        vpslldq    $8,%xmm13,%xmm12
        vpsrldq    $8,%xmm13,%xmm13
        vpxor      %xmm12,%xmm14,%xmm14
        vpxor      %xmm13,%xmm15,%xmm15

        vpxor      %xmm14,%xmm0,%xmm14
        vpxor      %xmm15,%xmm1,%xmm15
        vpxor      %xmm14,%xmm2,%xmm14
        vpxor      %xmm15,%xmm3,%xmm15

        vpxor      %xmm14,%xmm1,%xmm1
        vpxor      %xmm15,%xmm2,%xmm2
        
        //
        vpxor 64(%rsp),%xmm0,%xmm0
        vpxor 80(%rsp),%xmm1,%xmm1
        vpxor 96(%rsp),%xmm2,%xmm2
        vpxor 112(%rsp),%xmm3,%xmm3

        vpxor 128(%rsp),%xmm0,%xmm0
        vpxor 144(%rsp),%xmm1,%xmm1
        vpxor 160(%rsp),%xmm2,%xmm2
        vpxor 176(%rsp),%xmm3,%xmm3

        vpxor 128(%rsp),%xmm2,%xmm4
        vpxor 144(%rsp),%xmm3,%xmm5
        vpxor 96(%rsp),%xmm0,%xmm2
        vpxor 112(%rsp),%xmm1,%xmm3
        
        vmovdqa 64(%rsp),%xmm0
        vmovdqa 80(%rsp),%xmm1
        vmovdqa 160(%rsp),%xmm6
        vmovdqa 176(%rsp),%xmm7
        
        // reduce
        vpclmulqdq $16,POLY(%rip),%xmm0,%xmm8
        vpslldq    $8,%xmm0,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13

        vpsrldq    $8,%xmm0,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vpslldq    $8,%xmm13,%xmm12
        shufpd     $1,%xmm10,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpand      mask(%rip),%xmm1,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm10,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpsrldq    $8,%xmm1,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vpslldq    $8,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm10,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13

        vpand      mask(%rip),%xmm2,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm10,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpsrldq    $8,%xmm2,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpand      mask(%rip),%xmm3,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpsrldq    $8,%xmm3,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm12,%xmm11
        shufpd     $1,%xmm13,%xmm12
        shufpd     $1,%xmm9,%xmm13
        vpxor      %xmm8,%xmm13,%xmm13
        
        vpxor      %xmm10,%xmm4,%xmm4
        vpxor      %xmm11,%xmm5,%xmm5
        vpxor      %xmm12,%xmm6,%xmm8
        vpxor      %xmm13,%xmm7,%xmm9
        
        vmovdqa    %xmm4,0(%rdi)
        vmovdqa    %xmm5,16(%rdi)
        vmovdqa    %xmm8,32(%rdi)
        vmovdqa    %xmm9,48(%rdi)

        movq 	0(%rsp),%r11
        movq 	8(%rsp),%r12
        movq 	16(%rsp),%r13
        movq 	24(%rsp),%r14
        movq 	32(%rsp),%r15
        movq 	40(%rsp),%rbx
        movq 	48(%rsp),%rbp

        movq 	%r11,%rsp

        ret
