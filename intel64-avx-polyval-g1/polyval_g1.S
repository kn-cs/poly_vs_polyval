/* Assembly to compute polyval        
   Author: Kaushik Nath
*/

        .p2align 4
        .globl polyval_asm

polyval_asm:
        
        vmovdqa 0(%rsi),%xmm3
        vmovdqa 0(%rdx),%xmm4
        
        cmpq    $1,%rcx
        je      .L1

.L0:
        vpclmulqdq $0,%xmm3,%xmm4,%xmm0
        vpclmulqdq $17,%xmm3,%xmm4,%xmm2
        vpclmulqdq $1,%xmm3,%xmm4,%xmm5
        vpclmulqdq $16,%xmm3,%xmm4,%xmm6
        vpxor      %xmm5,%xmm6,%xmm1
        vpslldq    $8,%xmm1,%xmm5
        vpsrldq    $8,%xmm1,%xmm6
        vpxor      %xmm5,%xmm0,%xmm0
        vpxor      %xmm6,%xmm2,%xmm2
        
        vpclmulqdq $16,POLY(%rip),%xmm0,%xmm5
        vpshufd    $78,%xmm0,%xmm6
        vpxor      %xmm5,%xmm6,%xmm6
        
        vpclmulqdq $16,POLY(%rip),%xmm6,%xmm7
        vpshufd    $78,%xmm6,%xmm6
        vpxor      %xmm7,%xmm6,%xmm6
        
        vpxor      %xmm6,%xmm2,%xmm3
        
        addq	   $16,%rsi
        vpxor      0(%rsi),%xmm3,%xmm3
        
        subq    $1,%rcx
        cmpq    $1,%rcx
        jg      .L0

.L1:
        vpclmulqdq $0,%xmm3,%xmm4,%xmm0
        vpclmulqdq $17,%xmm3,%xmm4,%xmm2
        vpclmulqdq $1,%xmm3,%xmm4,%xmm5
        vpclmulqdq $16,%xmm3,%xmm4,%xmm6
        
        vpxor      %xmm5,%xmm6,%xmm1
        
        vpslldq    $8,%xmm1,%xmm5
        vpsrldq    $8,%xmm1,%xmm6
        vpxor      %xmm5,%xmm0,%xmm0
        vpxor      %xmm6,%xmm2,%xmm2
        
        vpclmulqdq $16,POLY(%rip),%xmm0,%xmm5
        vpshufd    $78,%xmm0,%xmm6
        vpxor      %xmm5,%xmm6,%xmm6
        
        vpclmulqdq $16,POLY(%rip),%xmm6,%xmm7
        vpshufd    $78,%xmm6,%xmm6
        vpxor      %xmm7,%xmm6,%xmm6
        
        vpxor      %xmm6,%xmm2,%xmm3
        vmovdqa    %xmm3,0(%rdi)

        ret
