/* Assembly to compute the key powers
   Author: Kaushik Nath
*/
        
        .p2align 4
        .globl poly256_keypowers
        
poly256_keypowers:

        vmovdqa  0(%rsi),%xmm3
        vmovdqa  16(%rsi),%xmm4
        vmovdqa  %xmm3,0(%rdi)
        vmovdqa  %xmm4,16(%rdi)

        ret
