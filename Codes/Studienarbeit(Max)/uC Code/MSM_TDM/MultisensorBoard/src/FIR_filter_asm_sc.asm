; FIR_filter_asm_sc.asm
; =====================
;
; Description : 
;
; C-called fast function to implement FIR filters in short int
; ============================================================
;
; This version is for short ints (delays and coefficients). It allows to
; scale down the output of the filter by SHIFTer. SHIFTer is usually 15.
;
; This version does also the update of T[N-1] = x[n]
; h[n] run BACKWARDS, dly[n] run BACKWARDS
;
; Interface description:
; ======================
; A4 : ptr to delays, short *
; B4 : ptr to coeffs, short *
; A6 : number of delays, int
; B6 : input sample x(n),	short
; A8 : SHIFTer, RIGHT_SCALER, default is 15 ! ( >>15 ), int
;
; Example with return value : short y_n, x_n !!
; y_n = FIR_filter_sc(	H_filt_50_delays,				, short *
;						b_filt_b0_b5_usw,				, short *
;						N_delays_H_filt_50_delays,		, int
;						x_n,							, short
;						SHIFT15);						, int
;
; resources : prolog 9, loop N*7, epilog 6
; total cycles 15 + N*7 plus overhead from stack handling for 5 variables
; example : N=138 
;        via formula   981, 
;        via profiling 1011
;
; prototype:
; ==========
;                      delays[] coefs[]   NCOE    x_n  SHIFTer
; short FIR_filter_sc( short *, short *, int,   short, int     );
;
;----------------------------------------------------------------------------------
; US 29-Jul-06, layout changed 9-Aug-08
;----------------------------------------------------------------------------------
; Important remark:
; =================
; When x(k) = x(k+1) is carried out, the LAST element of the delay array is ALWAYS
; copied from an address OUTSIDE the array. However, this does NOT matter, since
; the NEXT x(n) is placed EXACTLY ad the address of the LAST element of the array, 
; thus the wrong value is overwritten
;----------------------------------------------------------------------------------
;
; Changes:
; ========
; 28-Aug-09 : EXTENDED, default scaler " >>15 " can now be passed as Parameter
; optimized version of filter_asm.asm (NOPs were removed !)
; 10-Sep-09 : one nop saved in prolog because input sample is now written later
;             to memory dly[N-1]
; 30-Nov-11 : DO NOT USE registers A10, A12
;             (A complete CRASH happened if the module was used together with cfftr2.asm)
;             If we use A10, A12, they must be stored on the stack, as done in bitrev.sa !
;             Instead of A12, now A9 is used, instead of A10 now A5 is used.
;
;
;
; used registers: a1, b3, a4, b4, a6, a7, b6, a8, a5, a9
; remark : a10 and a12 are NOT used any more. problems with cfftr2.asm !!
		.def	_FIR_filter_sc
_FIR_filter_sc:			    ; ASM function called from C
; prolog (warm up)
		mv		a6,a1      	; setup loop count 
  ||	mpy   	a6,2,a6	    ; since dly buffer data as byte
	 	zero  	a5         ; init a5 for accumulation	
		add   	a6,b4,b4    ; since coeff buffer data as byte
		sub   	b4,1,b4     ; B4=bottom coeff array h[N-1] 
		add   	a4,a6,a9	; point to end of (delay_array+1)
		sub   	a9,1,a9	; correct by 1

; pre-load ONLY first delay/coeff (done again at the end of "b loop;" below !!
		ldh 	*a4++,a2	; A2=x[n-(N-1)+i] i=0,1,...,N-1
   ||	ldh 	*b4--,b2	; B2=h[N-1-i] i=0,1,...,N-1
		ldh 	*a4,a7      ; A7=x[(n-(N-1)+i+1]update delays
		sth   	b6,*a9		; instead store x(n) NOW in last delay element, dly[N-1]
							; NO NOP needed any more, but: wait here for a2, b2 values (4 cycles)

; loop kernel (cycle)
loop:					    ; start of FIR loop  
		sub 	a1,1,a1		; decrement loop count

  [A1]	b   	loop		; branch to loop if count # 0
 		mpy 	a2,b2,a6	; A6=x[n-(N-1)+i]*h[N-1-i] 
		sth 	a7,*-a4[1]	; -->x[(n-(N-1)+i] update sample
 		ldh 	*a4++,a2	; A2=x[n-(N-1)+i] i=0,1,...,N-1
   ||	ldh 	*b4--,b2	; B2=h[N-1-i] i=0,1,...,N-1
		ldh 	*a4,a7      ; A7=x[(n-(N-1)+i+1]update delays
 		add 	a6,a5,a5	; accumlate in a5 		
 		
; epilog (cool-off)
		b   	b3			; return addr to calling routine
		shr .s1 a5,a8,a4	; A8=15 is default, scale down by A8, result returned in A4
		nop	4

				
