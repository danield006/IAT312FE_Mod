.thumb
.org 0x0

add		r0,r1,r2
strb	r0,[r6,#0x1D]
mov		r1,r5
add		r1,#0x39
ldrb	r1,[r1]
ldrb	r2,[r4,#0x9]
add		r1,r1,r2
mov		r0,r6
add		r0,#0x39
strb	r1,[r0]
ldrb	r1,[r5,#0x1A]
ldrb	r4,[r4,#0x8]
add		r0,r1,r4
strb	r0,[r6,#0x1A]
mov		r0,r6
bx		r14
