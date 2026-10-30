/* Assembly to compute the key powers
   Author: Kaushik Nath
*/
        
        .p2align 4
        .globl poly128_keypowers
        
poly128_keypowers:

        vmovdqa  0(%rsi),%xmm3
        vmovdqa  %xmm3,0(%rdi)

        ret
