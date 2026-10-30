/* Assembly to compute the key powers
   Author: Kaushik Nath
*/
        
        .p2align 4
        .globl polyval_keypowers
        
polyval_keypowers:

        vmovdqa  0(%rsi),%xmm3
        vmovdqa  %xmm3,0(%rdi)

        ret
