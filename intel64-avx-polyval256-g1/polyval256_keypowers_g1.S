/* Assembly to compute the key powers
   Author: Kaushik Nath
*/
        
        .p2align 5
        .globl polyval256_keypowers
        
polyval256_keypowers:

        vmovdqa  0(%rsi),%xmm3
        vmovdqa  16(%rsi),%xmm4
        vmovdqa  %xmm3,0(%rdi)
        vmovdqa  %xmm4,16(%rdi)

        ret
