.thumb
@�X�e�[�^�X�r�b�g4�� 0x80 �r�b�g���Z�b�g
ldrb r1, [r0, #0xF] @ramunit->status4
mov  r2,#0x80
orr  r1,r2
strb r1, [r0, #0xF] @ramunit->status4 |= 0x8

@�󂷃R�[�h���đ�
mov r4 ,r0
mov r1, #0x0
mov r3, #0x3
add r0, #0x2b

ldr r2,=0x0807D28C+1
bx r2
