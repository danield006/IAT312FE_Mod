@瞬間移動(REPOS)
@
@[SVALB] 40 0D [X] [Y] [ASM+1]
@[SVALB] 41 0D [X] [Y] [ASM+1]  移動先が塞がれていたらNG
@
@Author 7743
@
.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
@
@
.thumb
	push	{r4,lr}

	ldr  r4, [r0, #0x38]      @イベント命令にアクセスらしい [r0,#0x38] でイベント命令が書いてあるアドレスの場所へ

	ldrb r0, [r4, #0x0]       @引数0 [FLAG]
	mov  r1,#0x1
	and  r0,r1

	cmp  r0,#0x0
	beq  SelectUnit

CheckIfBlocked:
	@
	@[1] と [3] の命令コードの場合、塞がれていら移動させないのでチェックする.
	@
@	ldr  r0,=0x0202E4D4       @gMapUnit //*gMapUnit[y][x] = 部隊表ID	{J}
	ldr  r0,=0x0202e4d8       @gMapUnit //*gMapUnit[y][x] = 部隊表ID	{U}
	ldr  r0,[r0]

	ldrb r1, [r4, #0x2]       @引数1 [X]
	ldrb r2, [r4, #0x3]       @引数2 [Y]
	
	lsl  r2,r2,#0x2           @ y << 2
	ldr  r0,[r0,r2]           @gMapUnit[y]
	ldrb r0,[r0,r1]           @gMapUnit[y][x]

	cmp  r0,#0x00             @ワープ先に誰かいるか?
	bne  Term                 @誰かいる場合は、移動させない.

SelectUnit:
	ldr  r0,=#0xFFFFFFFE
@	blh  0x0800bf3c           @UNITIDの解決	{J}
	blh  0x0800bc50           @GetUnitStructFromEventParameter	{U}
	                          @RAM UNIT POINTERの取得
	cmp  r0,#0x00
	beq  Term                 @取得できなかったら終了

Change:
	ldrb r1, [r4, #0x2]       @引数1 [X]
	ldrb r2, [r4, #0x3]       @引数2 [Y]

	strb r1,[r0,#0x10]        @Unit@10	byte	X	座標
	strb r2,[r0,#0x11]        @Unit@11	byte	Y	座標

@	blh  0x08019ecc   @RefreshFogAndUnitMaps    {J}
@	blh  0x08027144   @SMS_UpdateFromGameData   {J}
@	blh  0x08019914   @UpdateGameTilesGraphics  {J}
	blh  0x0801a1f4   @RefreshFogAndUnitMaps    {U}
	blh  0x080271a0   @SMS_UpdateFromGameData   {U}
	blh  0x08019c3c   @UpdateGameTilesGraphics  {U}

Term:
	mov	r0, #0
	pop {pc,r4}
