.data
str:     .byte 77, 67, 77, 88, 67, 73, 86 #MCMXCIV
#s0 = str addr
#s1 = str[s0], str data bit from s0
#a3 = sum = return value from [romantoInt], it is result to whole program
#a2 = return value from [transInt]
#s3 = n_size, how many elements in str 
#t0 is alaways i
.text
main:
    la    s0, str #"la" is psedo inst. to load 1st addr of str
    jal   ra, romantoInt
    addi  a0, a3, 0
    addi  a7, x0, 1
    ecall 
    addi  a7, x0, 10
    ecall
romantoInt:
    add   t6, ra, x0
    jal   ra, strSize
    addi  s3, t0, 0  #store n_size t0 to s3
    #in [Loop] of [Compare], I call another function [transInt], than ra would be covered by line 51
    #so i use s7 store return address of line 25.
    jal   s7, Compare 
    add   ra, t6, x0
    ret
strSize:
    addi  t0, t0, 0  #initialize i, t0 = i = 0
 for:
    lb    s1, 0(s0) 
    beq   s1, x0, zero #if s1 is zero, go to [zero] and return
    addi  s0, s0, 1 #(t1 = n_size), n_size++
    addi  t0, t0, 1 #n_size++
    jal   x0, for
 zero:
    ret #return value is t0. return to line 21.
Compare: 
    #t2 = cur / t3 = pre / t0 = i / sum = a3
    #do sum = transINT(s[n_size-1]);
    addi  s0, s0, -1    #through process [strSize], s0 = (str addr + n_size), s0 has to go back to (str addr + n_size - 1)
    lb    s1, 0(s0)     #s1 = str[s0] = str[str addr + n_size - 1]
    jal   ra, transInt
    addi  a3, a2, 0     #a3 = sum, a2 = return value from [transINT]
    addi  t2, a2, 0     #t2 = cur
    addi  t0, s3, -1    #initialize i, i = n_size - 1
Loop:
    addi  t0, t0, -1    #i--
    addi  s0, s0, -1
    lb    s1, 0(s0)     #s1 = str[n_size - i]
    jal   ra, transInt
    addi  t3, a2, 0     #t3 = pre
    blt   t3, t2, PreLessthanCur #if pre < cur
    add   a3, a3, t3    #else, sum += pre;
    addi  t2, t3, 0     #cur = pre
    bne   t0, x0, Loop  #if i != 0, go to [Loop]
    add   ra, s7, x0
    ret #return to line 25. return value is a3
PreLessthanCur:
    sub   a3, a3, t3    #if pre < cur,sum -= pre;
    addi  t2, t3, 0     #cur = pre
    bne   t0, x0, Loop  #if i != 0, go to [Loop]
    add   ra, s7, x0
    ret #return to line 25. return value is a3
transInt: #return = a2 / t1 = temp
    add   t5, ra, x0
    addi  t1, x0, 73 #I = 73
    beq   s1, t1, I
    addi  t1, x0, 86 #V = 86
    beq   s1, t1, V
    addi  t1, x0, 88 #X = 88
    beq   s1, t1, X
    addi  t1, x0, 76 #L = 76
    beq   s1, t1, L
    addi  t1, x0, 67 #C = 67
    beq   s1, t1, C
    addi  t1, x0, 68 #D = 68
    beq   s1, t1, D
 M: addi  a2, x0, 1000 #else M
    add   ra, t5, x0
    ret #return value is a2. return to line 43 or 51. 
 I: addi  a2, x0, 1
    add   ra, t5, x0
    ret #return value is a2. return to line 43 or 51. 
 V: addi  a2, x0, 5
    add   ra, t5, x0
    ret #return value is a2. return to line 43 or 51. 
 X: addi  a2, x0, 10
    add   ra, t5, x0
    ret #return value is a2. return to line 43 or 51. 
 L: addi  a2, x0, 50
    add   ra, t5, x0
    ret #return value is a2. return to line 43 or 51. 
 C: addi  a2, x0, 100
    add   ra, t5, x0
    ret #return value is a2. return to line 43 or 51. 
 D: addi  a2, x0, 500
    add   ra, t5, x0
    ret #return value is a2. return to line 43 or 51. 
