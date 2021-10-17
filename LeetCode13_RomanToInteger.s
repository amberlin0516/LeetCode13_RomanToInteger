.data
str:     .byte 77, 67, 77, 88, 67, 73, 86 #MCMXCIV
#s0 = addr of str
#s1 = str data bit
#a3 = sum
#s3 = n_size, how many elements in str 
#t0 is alaways i
.text
main:
    la s0, str 
    jal ra, romantoInt
    addi a0, a3, 0
    addi  a7, x0, 1
    ecall 
    addi  a7, x0, 10
    ecall
romantoInt:
    add t6, ra, x0
    jal ra, strSize
    addi s3, t0, 0 #store n_size:t0 to s3
    jal s7, Compare
    add ra, t6, x0
    ret
strSize:
    addi t0, t0, 0  #(t0 = n_size) initialize t0
 for:
    lb   s1, 0(s0) 
    beq  s1, x0, zero #if s1 is zero, go to [zero]
    addi s0, s0, 1 #(t1 = n_size), n_size++
    addi t0, t0, 1 #n_size++
    jal x0, for
 zero:
    ret
Compare: #t2 = cur #t3 = pre #t0 = i
    #sum = transINT(s[n_size-1]);
    addi s0, s0, -1 #n_size -1
    lb s1, 0(s0)    #s1 = s[n_size-1]
    jal ra, transInt
    addi a3, a2, 0 #a3 = sum, a2 = return value from transINT
    addi t2, a2, 0 #t2 = cur
    addi t0, s3, -1 #i = n_size - 1
Loop:
    addi t0, t0, -1    #i--
    addi s0, s0, -1
    lb s1, 0(s0)
    jal ra, transInt
    addi t3, a2, 0 #t3 = pre
    blt t3, t2, PreLessthanCur #if pre<cur
    add a3, a3, t3 #else, sum += pre;
    addi t2, t3, 0 #cur = pre
    bne t0, x0, Loop #if i != 0, go to [Loop]
    add ra, s7, x0
    ret
PreLessthanCur:
    sub a3, a3, t3 #if pre<cur,sum -= pre;
    addi t2, t3, 0 #cur = pre
    bne t0, x0, Loop #if i != 0, go to [Loop]
    add ra, s7, x0
    ret
transInt: #return = a2 #t1 = temp
    add t5, ra, x0
    addi t1, x0, 73 #I = 73
    beq  s1, t1, I
    addi t1, x0, 86 #V = 86
    beq  s1, t1, V
    addi t1, x0, 88 #X = 88
    beq  s1, t1, X
    addi t1, x0, 76 #L = 76
    beq  s1, t1, L
    addi t1, x0, 67 #C = 67
    beq  s1, t1, C
    addi t1, x0, 68 #D = 68
    beq  s1, t1, D
    addi a2, x0, 1000 #M
    add ra, t5, x0
    ret
 I: addi a2, x0, 1
    add ra, t5, x0
    ret
 V: addi a2, x0, 5
    add ra, t5, x0
    ret
 X: addi a2, x0, 10
    add ra, t5, x0
    ret  
 L: addi a2, x0, 50
    add ra, t5, x0
    ret
 C: addi a2, x0, 100
    add ra, t5, x0
    ret
 D: addi a2, x0, 500
    add ra, t5, x0
    ret