/* Assembly to compute the key powers
   Author: Kaushik Nath
*/
        
        .p2align 4
        .globl poly512_keypowers
        
poly512_keypowers:

        vmovdqa  0(%rsi),%xmm3
        vmovdqa  16(%rsi),%xmm4
        vmovdqa  32(%rsi),%xmm5
        vmovdqa  48(%rsi),%xmm6
        
        vmovdqa  %xmm3,0(%rdi)
        vmovdqa  %xmm4,16(%rdi)
        vmovdqa  %xmm5,32(%rdi)
        vmovdqa  %xmm6,48(%rdi)

        ret
