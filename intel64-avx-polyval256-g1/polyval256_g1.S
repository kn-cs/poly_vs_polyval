/* Assembly to compute polyval256        
   Author: Kaushik Nath
*/

#define REDUCE_OPT

        .p2align 4
        .globl polyval256_asm

polyval256_asm:
        
        vmovdqa 0(%rsi),%xmm4
        vmovdqa 16(%rsi),%xmm5
        vmovdqa 0(%rdx),%xmm6
        vmovdqa 16(%rdx),%xmm7
        
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
        
        // reduce
        #ifdef REDUCE_OPT
        vpclmulqdq $16,POLY(%rip),%xmm0,%xmm5
        vpslldq    $8,%xmm0,%xmm11
        vpxor      %xmm5,%xmm11,%xmm11

        vpsrldq    $8,%xmm0,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm5
        vmovdqa    %xmm10,%xmm8
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm8,%xmm11
        vpxor      %xmm11,%xmm5,%xmm11

        vpand      mask(%rip),%xmm1,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm5
        vmovdqa    %xmm10,%xmm8
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm8,%xmm11
        vpxor      %xmm11,%xmm5,%xmm11

        vpsrldq    $8,%xmm1,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm5
        vmovdqa    %xmm10,%xmm8
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm8,%xmm11
        vpxor      %xmm11,%xmm5,%xmm11
        #endif
        
        #ifdef REDUCE_GEN
        vpxor      %xmm10,%xmm10,%xmm10
        vpxor      %xmm11,%xmm11,%xmm11
        
        vpand      mask(%rip),%xmm0,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm9,%xmm11
        vpxor      %xmm8,%xmm11,%xmm11
        
        vpsrldq    $8,%xmm0,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm9,%xmm11
        vpxor      %xmm8,%xmm11,%xmm11
        
        vpand      mask(%rip),%xmm1,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm9,%xmm11
        vpxor      %xmm8,%xmm11,%xmm11
        
        vpsrldq    $8,%xmm1,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm9,%xmm11
        vpxor      %xmm8,%xmm11,%xmm11
        #endif

        vpxor      %xmm2,%xmm10,%xmm4
        vpxor      %xmm3,%xmm11,%xmm5
        
        addq	$32,%rsi
        vpxor   0(%rsi),%xmm4,%xmm4
        vpxor   16(%rsi),%xmm5,%xmm5
        
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
        
        // reduce
        #ifdef REDUCE_OPT
        vpclmulqdq $16,POLY(%rip),%xmm0,%xmm5
        vpslldq    $8,%xmm0,%xmm11
        vpxor      %xmm5,%xmm11,%xmm11

        vpsrldq    $8,%xmm0,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm5
        vmovdqa    %xmm10,%xmm8
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm8,%xmm11
        vpxor      %xmm11,%xmm5,%xmm11

        vpand      mask(%rip),%xmm1,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm5
        vmovdqa    %xmm10,%xmm8
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm8,%xmm11
        vpxor      %xmm11,%xmm5,%xmm11

        vpsrldq    $8,%xmm1,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm5
        vmovdqa    %xmm10,%xmm8
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm8,%xmm11
        vpxor      %xmm11,%xmm5,%xmm11
        #endif
        
        #ifdef REDUCE_GEN
        vpxor      %xmm10,%xmm10,%xmm10
        vpxor      %xmm11,%xmm11,%xmm11
        
        vpand      mask(%rip),%xmm0,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10
        
        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm9,%xmm11
        vpxor      %xmm8,%xmm11,%xmm11
        
        vpsrldq    $8,%xmm0,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm9,%xmm11
        vpxor      %xmm8,%xmm11,%xmm11
        
        vpand      mask(%rip),%xmm1,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm9,%xmm11
        vpxor      %xmm8,%xmm11,%xmm11
        
        vpsrldq    $8,%xmm1,%xmm9
        vpxor      %xmm9,%xmm10,%xmm10

        vpclmulqdq $16,POLY(%rip),%xmm10,%xmm8
        vmovdqa    %xmm10,%xmm9
        shufpd     $1,%xmm11,%xmm10
        shufpd     $1,%xmm9,%xmm11
        vpxor      %xmm8,%xmm11,%xmm11
        #endif
        
        vpxor      %xmm2,%xmm10,%xmm4
        vpxor      %xmm3,%xmm11,%xmm5
        
        
        vmovdqa    %xmm4,0(%rdi)
        vmovdqa    %xmm5,16(%rdi)

        ret
