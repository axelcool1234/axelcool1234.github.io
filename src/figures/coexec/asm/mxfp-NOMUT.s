	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx1250"
	.amdhsa_code_object_version 5
	.text
	.globl	mxgemm_tdm_pipelined_kernel     ; -- Begin function mxgemm_tdm_pipelined_kernel
	.p2align	8
	.type	mxgemm_tdm_pipelined_kernel,@function
mxgemm_tdm_pipelined_kernel:            ; @mxgemm_tdm_pipelined_kernel
.Lfunc_begin0:
	.file	1 "/var/asorenso/triton-mi450-internal/third_party/amd/python/examples/gluon" "mxfp_gemm_gfx1250.py"
	.loc	1 1415 0                        ; mxfp_gemm_gfx1250.py:1415:0
	.cfi_sections .debug_frame
	.cfi_startproc
; %bb.0:                                ; %.lr.ph
	.cfi_escape 0x0f, 0x04, 0x30, 0x36, 0xe9, 0x02 ; CFA is 0 in private_wave aspace
	.cfi_undefined 16
	s_setreg_imm32_b32 hwreg(HW_REG_WAVE_MODE, 25, 1), 1 ;  msbs: dst=0 src0=0 src1=0 src2=0
	s_mov_b32 s1, s11
	s_mov_b32 s0, s12
	s_mov_b32 s12, s13
	s_mov_b32 s34, s15
.Ltmp0:
	.loc	1 892 13 prologue_end           ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_and_b32_e32 v2, 15, v0
	v_dual_mov_b32 v12, 0 :: v_dual_bitop2_b32 v20, 16, v0 bitop3:0x40
	v_and_b32_e32 v1, 31, v0
.Ltmp1:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_lshrrev_b32_e32 v0, 1, v0
	scratch_store_b32 off, v2, off offset:1612 nv ; 4-byte Folded Spill
.Ltmp2:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_lshlrev_b32_e32 v10, 8, v2
.Ltmp3:
	.file	2 "/var/asorenso/triton-mi450-internal/python/triton/language" "standard.py"
	.loc	2 43 13                         ; standard.py:43:13 @[ mxfp_gemm_gfx1250.py:1449:17 ]
	s_addk_co_i32 s11, 0xff
	v_dual_mov_b32 v13, v12 :: v_dual_mov_b32 v14, v12
	v_dual_mov_b32 v15, v12 :: v_dual_mov_b32 v16, v12
	v_dual_mov_b32 v17, v12 :: v_dual_mov_b32 v18, v12
	s_wait_xcnt 0x0
	v_dual_mov_b32 v19, v12 :: v_dual_mov_b32 v2, v12
	v_dual_mov_b32 v3, v12 :: v_dual_mov_b32 v4, v12
	v_dual_mov_b32 v5, v12 :: v_dual_mov_b32 v6, v12
	v_dual_mov_b32 v7, v12 :: v_dual_mov_b32 v8, v12
	v_mov_b32_e32 v9, v12
	s_clause 0x33                           ; 832-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:832 nv
	scratch_store_b128 off, v[6:9], off offset:848 nv
	scratch_store_b128 off, v[2:5], off offset:800 nv
	scratch_store_b128 off, v[6:9], off offset:816 nv
	scratch_store_b128 off, v[2:5], off offset:768 nv
	scratch_store_b128 off, v[6:9], off offset:784 nv
	scratch_store_b128 off, v[2:5], off offset:736 nv
	scratch_store_b128 off, v[6:9], off offset:752 nv
	scratch_store_b128 off, v[2:5], off offset:704 nv
	scratch_store_b128 off, v[6:9], off offset:720 nv
	scratch_store_b128 off, v[2:5], off offset:672 nv
	scratch_store_b128 off, v[6:9], off offset:688 nv
	scratch_store_b128 off, v[2:5], off offset:640 nv
	scratch_store_b128 off, v[6:9], off offset:656 nv
	scratch_store_b128 off, v[2:5], off offset:608 nv
	scratch_store_b128 off, v[6:9], off offset:624 nv
	scratch_store_b128 off, v[2:5], off offset:576 nv
	scratch_store_b128 off, v[6:9], off offset:592 nv
	scratch_store_b128 off, v[2:5], off offset:544 nv
	scratch_store_b128 off, v[6:9], off offset:560 nv
	scratch_store_b128 off, v[2:5], off offset:512 nv
	scratch_store_b128 off, v[6:9], off offset:528 nv
	scratch_store_b128 off, v[2:5], off offset:480 nv
	scratch_store_b128 off, v[6:9], off offset:496 nv
	scratch_store_b128 off, v[2:5], off offset:448 nv
	scratch_store_b128 off, v[6:9], off offset:464 nv
	scratch_store_b128 off, v[2:5], off offset:416 nv
	scratch_store_b128 off, v[6:9], off offset:432 nv
	scratch_store_b128 off, v[2:5], off offset:384 nv
	scratch_store_b128 off, v[6:9], off offset:400 nv
	scratch_store_b128 off, v[2:5], off offset:352 nv
	scratch_store_b128 off, v[6:9], off offset:368 nv
	scratch_store_b128 off, v[2:5], off offset:320 nv
	scratch_store_b128 off, v[6:9], off offset:336 nv
	scratch_store_b128 off, v[2:5], off offset:288 nv
	scratch_store_b128 off, v[6:9], off offset:304 nv
	scratch_store_b128 off, v[2:5], off offset:256 nv
	scratch_store_b128 off, v[6:9], off offset:272 nv
	scratch_store_b128 off, v[2:5], off offset:224 nv
	scratch_store_b128 off, v[6:9], off offset:240 nv
	scratch_store_b128 off, v[2:5], off offset:192 nv
	scratch_store_b128 off, v[6:9], off offset:208 nv
	scratch_store_b128 off, v[2:5], off offset:160 nv
	scratch_store_b128 off, v[6:9], off offset:176 nv
	scratch_store_b128 off, v[2:5], off offset:128 nv
	scratch_store_b128 off, v[6:9], off offset:144 nv
	scratch_store_b128 off, v[2:5], off offset:96 nv
	scratch_store_b128 off, v[6:9], off offset:112 nv
	scratch_store_b128 off, v[2:5], off offset:64 nv
	scratch_store_b128 off, v[6:9], off offset:80 nv
	scratch_store_b128 off, v[2:5], off offset:32 nv
	scratch_store_b128 off, v[6:9], off offset:48 nv
	s_set_vgpr_msb 0x80                     ;  msbs: dst=2 src0=0 src1=0 src2=0
	v_dual_mov_b32 v40 /*v552*/, v12 :: v_dual_mov_b32 v41 /*v553*/, v12
	v_dual_mov_b32 v42 /*v554*/, v12 :: v_dual_mov_b32 v43 /*v555*/, v12
	v_dual_mov_b32 v44 /*v556*/, v12 :: v_dual_mov_b32 v45 /*v557*/, v12
	v_dual_mov_b32 v46 /*v558*/, v12 :: v_dual_mov_b32 v47 /*v559*/, v12
	v_dual_mov_b32 v32 /*v544*/, v12 :: v_dual_mov_b32 v33 /*v545*/, v12
	v_dual_mov_b32 v34 /*v546*/, v12 :: v_dual_mov_b32 v35 /*v547*/, v12
	v_dual_mov_b32 v36 /*v548*/, v12 :: v_dual_mov_b32 v37 /*v549*/, v12
	v_dual_mov_b32 v38 /*v550*/, v12 :: v_dual_mov_b32 v39 /*v551*/, v12
	v_dual_mov_b32 v24 /*v536*/, v12 :: v_dual_mov_b32 v25 /*v537*/, v12
	v_dual_mov_b32 v26 /*v538*/, v12 :: v_dual_mov_b32 v27 /*v539*/, v12
	v_dual_mov_b32 v28 /*v540*/, v12 :: v_dual_mov_b32 v29 /*v541*/, v12
	v_dual_mov_b32 v30 /*v542*/, v12 :: v_dual_mov_b32 v31 /*v543*/, v12
	s_set_vgpr_msb 0x8040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
	v_dual_mov_b32 v208 /*v464*/, v12 :: v_dual_mov_b32 v209 /*v465*/, v12
	v_dual_mov_b32 v210 /*v466*/, v12 :: v_dual_mov_b32 v211 /*v467*/, v12
	v_dual_mov_b32 v212 /*v468*/, v12 :: v_dual_mov_b32 v213 /*v469*/, v12
	v_dual_mov_b32 v214 /*v470*/, v12 :: v_dual_mov_b32 v215 /*v471*/, v12
	s_set_vgpr_msb 0x40c0                   ;  msbs: dst=3 src0=0 src1=0 src2=0
	v_dual_mov_b32 v248 /*v1016*/, v12 :: v_dual_mov_b32 v249 /*v1017*/, v12
	v_dual_mov_b32 v250 /*v1018*/, v12 :: v_dual_mov_b32 v251 /*v1019*/, v12
	v_dual_mov_b32 v252 /*v1020*/, v12 :: v_dual_mov_b32 v253 /*v1021*/, v12
	v_dual_mov_b32 v254 /*v1022*/, v12 :: v_dual_mov_b32 v255 /*v1023*/, v12
	v_dual_mov_b32 v200 /*v968*/, v12 :: v_dual_mov_b32 v201 /*v969*/, v12
	v_dual_mov_b32 v202 /*v970*/, v12 :: v_dual_mov_b32 v203 /*v971*/, v12
	v_dual_mov_b32 v204 /*v972*/, v12 :: v_dual_mov_b32 v205 /*v973*/, v12
	v_dual_mov_b32 v206 /*v974*/, v12 :: v_dual_mov_b32 v207 /*v975*/, v12
	v_dual_mov_b32 v192 /*v960*/, v12 :: v_dual_mov_b32 v193 /*v961*/, v12
	v_dual_mov_b32 v194 /*v962*/, v12 :: v_dual_mov_b32 v195 /*v963*/, v12
	v_dual_mov_b32 v196 /*v964*/, v12 :: v_dual_mov_b32 v197 /*v965*/, v12
	v_dual_mov_b32 v198 /*v966*/, v12 :: v_dual_mov_b32 v199 /*v967*/, v12
	v_mov_b32_e32 v112 /*v880*/, v12
	.loc	2 43 12 is_stmt 0               ; standard.py:43:12 @[ mxfp_gemm_gfx1250.py:1449:17 ]
	s_ashr_i32 s13, s11, 31
	v_mov_b32_e32 v113 /*v881*/, v12
	s_lshr_b32 s13, s13, 24
	v_mov_b32_e32 v114 /*v882*/, v12
	s_add_co_i32 s11, s11, s13
	v_mov_b32_e32 v115 /*v883*/, v12
	s_ashr_i32 s13, s11, 8
	v_mov_b32_e32 v116 /*v884*/, v12
.Ltmp4:
	.loc	1 1450 24 is_stmt 1             ; mxfp_gemm_gfx1250.py:1450:24
	s_lshl_b32 s13, s13, 3
	v_mov_b32_e32 v117 /*v885*/, v12
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_abs_i32 s15, s13
	v_mov_b32_e32 v118 /*v886*/, v12
	s_cvt_f32_u32 s17, s15
	v_mov_b32_e32 v119 /*v887*/, v12
.Ltmp5:
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_bfe_u32 s35, ttmp8, 0x50019
	v_mov_b32_e32 v224 /*v992*/, v12
.Ltmp6:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	v_s_rcp_f32 s17, s17
	v_dual_mov_b32 v225 /*v993*/, v12 :: v_dual_mov_b32 v226 /*v994*/, v12
	v_dual_mov_b32 v227 /*v995*/, v12 :: v_dual_mov_b32 v228 /*v996*/, v12
	v_dual_mov_b32 v229 /*v997*/, v12 :: v_dual_mov_b32 v230 /*v998*/, v12
	v_dual_mov_b32 v231 /*v999*/, v12 :: v_dual_mov_b32 v216 /*v984*/, v12
	v_dual_mov_b32 v217 /*v985*/, v12 :: v_dual_mov_b32 v218 /*v986*/, v12
	v_dual_mov_b32 v219 /*v987*/, v12 :: v_dual_mov_b32 v220 /*v988*/, v12
	v_dual_mov_b32 v221 /*v989*/, v12 :: v_dual_mov_b32 v222 /*v990*/, v12
	v_dual_mov_b32 v223 /*v991*/, v12 :: v_dual_mov_b32 v208 /*v976*/, v12
	s_ashr_i32 s18, ttmp9, 31
	s_abs_i32 s19, ttmp9
.Ltmp7:
	.loc	2 43 13                         ; standard.py:43:13 @[ mxfp_gemm_gfx1250.py:1448:17 ]
	s_add_co_i32 s20, s10, 0xff
.Ltmp8:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_ashr_i32 s11, s11, 31
.Ltmp9:
	.loc	2 43 12                         ; standard.py:43:12 @[ mxfp_gemm_gfx1250.py:1448:17 ]
	s_ashr_i32 s21, s20, 31
.Ltmp10:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_xor_b32 s11, s18, s11
.Ltmp11:
	.loc	2 43 12                         ; standard.py:43:12 @[ mxfp_gemm_gfx1250.py:1448:17 ]
	s_lshr_b32 s21, s21, 24
.Ltmp12:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_mul_f32 s17, s17, 0x4f7ffffe
.Ltmp13:
	.loc	2 43 12                         ; standard.py:43:12 @[ mxfp_gemm_gfx1250.py:1448:17 ]
	s_add_co_i32 s20, s20, s21
.Ltmp14:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_sub_co_i32 s21, 0, s15
.Ltmp15:
	.loc	2 43 12                         ; standard.py:43:12 @[ mxfp_gemm_gfx1250.py:1448:17 ]
	s_ashr_i32 s22, s20, 8
.Ltmp16:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_cvt_u32_f32 s17, s17
	s_mov_b32 s27, 0
	s_mov_b32 s28, 1
.Ltmp17:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1017:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s20, 0x3500000
.Ltmp18:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_mul_i32 s21, s21, s17
.Ltmp19:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1017:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s23, s27
	v_mov_b32_e32 v209 /*v977*/, v12
.Ltmp20:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_mul_hi_u32 s21, s17, s21
	v_mov_b32_e32 v210 /*v978*/, v12
	s_add_co_i32 s17, s17, s21
	v_mov_b32_e32 v211 /*v979*/, v12
	s_mul_hi_u32 s17, s19, s17
	v_mov_b32_e32 v212 /*v980*/, v12
	s_mul_i32 s21, s17, s15
	v_mov_b32_e32 v213 /*v981*/, v12
	s_sub_co_i32 s21, s19, s21
	v_mov_b32_e32 v214 /*v982*/, v12
	s_add_co_i32 s24, s17, 1
	v_mov_b32_e32 v215 /*v983*/, v12
	s_sub_co_i32 s25, s21, s15
	v_mov_b32_e32 v232 /*v1000*/, v12
	s_cmp_ge_u32 s21, s15
	v_mov_b32_e32 v233 /*v1001*/, v12
	s_cselect_b32 s17, s24, s17
	v_mov_b32_e32 v234 /*v1002*/, v12
	s_cselect_b32 s21, s25, s21
	v_mov_b32_e32 v235 /*v1003*/, v12
	s_add_co_i32 s24, s17, 1
	v_mov_b32_e32 v236 /*v1004*/, v12
	s_cmp_ge_u32 s21, s15
	v_mov_b32_e32 v237 /*v1005*/, v12
	s_cselect_b32 s15, s24, s17
	v_mov_b32_e32 v238 /*v1006*/, v12
	s_xor_b32 s15, s15, s11
	v_mov_b32_e32 v239 /*v1007*/, v12
	s_sub_co_i32 s11, s15, s11
	v_mov_b32_e32 v240 /*v1008*/, v12
	.loc	1 1452 19                       ; mxfp_gemm_gfx1250.py:1452:19
	s_lshl_b32 s15, s11, 3
	v_mov_b32_e32 v241 /*v1009*/, v12
	.loc	1 1453 24                       ; mxfp_gemm_gfx1250.py:1453:24
	s_sub_co_i32 s17, s22, s15
	v_mov_b32_e32 v242 /*v1010*/, v12
	.loc	1 1453 20 is_stmt 0             ; mxfp_gemm_gfx1250.py:1453:20
	s_min_i32 s17, s17, 8
	v_mov_b32_e32 v243 /*v1011*/, v12
	.loc	1 1454 28 is_stmt 1             ; mxfp_gemm_gfx1250.py:1454:28
	s_abs_i32 s21, s17
	v_mov_b32_e32 v244 /*v1012*/, v12
	s_cvt_f32_u32 s22, s21
	v_mov_b32_e32 v245 /*v1013*/, v12
	s_sub_co_i32 s26, 0, s21
	v_mov_b32_e32 v246 /*v1014*/, v12
	v_s_rcp_f32 s22, s22
	v_mov_b32_e32 v247 /*v1015*/, v12
	s_set_vgpr_msb 0xc040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
	v_dual_mov_b32 v240 /*v496*/, v12 :: v_dual_mov_b32 v241 /*v497*/, v12
	v_dual_mov_b32 v242 /*v498*/, v12 :: v_dual_mov_b32 v243 /*v499*/, v12
	v_dual_mov_b32 v244 /*v500*/, v12 :: v_dual_mov_b32 v245 /*v501*/, v12
	v_dual_mov_b32 v246 /*v502*/, v12 :: v_dual_mov_b32 v247 /*v503*/, v12
	s_set_vgpr_msb 0x40c0                   ;  msbs: dst=3 src0=0 src1=0 src2=0
	v_dual_mov_b32 v104 /*v872*/, v12 :: v_dual_mov_b32 v105 /*v873*/, v12
	v_dual_mov_b32 v106 /*v874*/, v12 :: v_dual_mov_b32 v107 /*v875*/, v12
	v_dual_mov_b32 v108 /*v876*/, v12 :: v_dual_mov_b32 v109 /*v877*/, v12
	v_mov_b32_e32 v110 /*v878*/, v12
	s_mul_f32 s22, s22, 0x4f7ffffe
	.loc	1 1455 14                       ; mxfp_gemm_gfx1250.py:1455:14
	s_mul_i32 s11, s11, s13
.Ltmp21:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1017:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s24, s28
	s_mov_b32 s25, s16
.Ltmp22:
	.loc	1 1454 28                       ; mxfp_gemm_gfx1250.py:1454:28
	s_cvt_u32_f32 s13, s22
	s_mov_b32 s40, 64
.Ltmp23:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s36, 0x7500000
	s_mov_b32 s61, s27
.Ltmp24:
	.loc	1 1454 28                       ; mxfp_gemm_gfx1250.py:1454:28
	s_mul_i32 s26, s26, s13
.Ltmp25:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s43, s27
.Ltmp26:
	.loc	1 1454 28                       ; mxfp_gemm_gfx1250.py:1454:28
	s_mul_hi_u32 s22, s13, s26
.Ltmp27:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s41, s12
.Ltmp28:
	.loc	1 1454 28                       ; mxfp_gemm_gfx1250.py:1454:28
	s_add_co_i32 s13, s13, s22
	s_mul_hi_u32 s22, s19, s13
	s_mul_i32 s22, s22, s21
	v_mov_b32_e32 v111 /*v879*/, v12
	s_sub_co_i32 s19, s19, s22
	s_sub_co_i32 s22, s19, s21
	s_cmp_ge_u32 s19, s21
	s_cselect_b32 s19, s22, s19
	s_sub_co_i32 s22, s19, s21
	s_cmp_ge_u32 s19, s21
	s_cselect_b32 s19, s22, s19
	s_xor_b32 s19, s19, s18
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:1280 nv
	scratch_store_b128 off, v[6:9], off offset:1296 nv
	s_sub_co_i32 s18, s19, s18
	.loc	1 1454 13 is_stmt 0             ; mxfp_gemm_gfx1250.py:1454:13
	s_add_co_i32 s15, s15, s18
	.loc	1 1455 14 is_stmt 1             ; mxfp_gemm_gfx1250.py:1455:14
	s_sub_co_i32 s11, ttmp9, s11
	.loc	1 1455 13 is_stmt 0             ; mxfp_gemm_gfx1250.py:1455:13
	s_xor_b32 s17, s11, s17
	s_ashr_i32 s17, s17, 31
	s_abs_i32 s11, s11
	s_mul_hi_u32 s13, s11, s13
	s_mul_i32 s18, s13, s21
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:1312 nv
	scratch_store_b128 off, v[6:9], off offset:1328 nv
	s_sub_co_i32 s11, s11, s18
	s_add_co_i32 s18, s13, 1
	s_sub_co_i32 s19, s11, s21
	s_cmp_ge_u32 s11, s21
	s_cselect_b32 s13, s18, s13
	s_cselect_b32 s11, s19, s11
	s_add_co_i32 s18, s13, 1
	s_cmp_ge_u32 s11, s21
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:1344 nv
	scratch_store_b128 off, v[6:9], off offset:1360 nv
	s_cselect_b32 s11, s18, s13
	s_xor_b32 s11, s11, s17
	s_sub_co_i32 s44, s11, s17
	.loc	1 1460 20 is_stmt 1             ; mxfp_gemm_gfx1250.py:1460:20
	s_mul_i32 s11, s16, s44
	s_lshl_b32 s18, s11, 1
.Ltmp29:
	.loc	1 1405 18                       ; mxfp_gemm_gfx1250.py:1405:18 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s19, s18, 31
	s_add_nc_u64 s[18:19], s[8:9], s[18:19]
	.loc	1 1406 20                       ; mxfp_gemm_gfx1250.py:1406:20 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s8, s1, 31
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:1376 nv
	scratch_store_b128 off, v[6:9], off offset:1392 nv
	s_lshr_b32 s8, s8, 25
	s_add_co_i32 s8, s1, s8
	s_ashr_i32 s11, s8, 7
	.loc	1 1406 44 is_stmt 0             ; mxfp_gemm_gfx1250.py:1406:44 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s8, s0, 31
	s_lshr_b32 s8, s8, 27
	s_add_co_i32 s8, s0, s8
	s_ashr_i32 s9, s8, 5
	.loc	1 1404 24 is_stmt 1             ; mxfp_gemm_gfx1250.py:1404:24 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s8, s16, 31
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:1408 nv
	scratch_store_b128 off, v[6:9], off offset:1424 nv
	s_and_b32 s17, s8, 0xffff
	s_bitset1_b32 s19, 31
	s_lshl_b32 s8, s9, 23
	s_lshr_b32 s9, s9, 9
.Ltmp30:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1017:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_max_i32 s31, s11, 0
	s_lshr_b64 s[8:9], s[8:9], 16
	s_max_i32 s30, s8, 0
	s_lshr_b64 s[8:9], s[30:31], 16
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:1440 nv
	scratch_store_b128 off, v[6:9], off offset:1456 nv
	s_and_b32 s13, s30, 0xff80
	s_lshl_b32 s21, s8, 16
	s_lshr_b32 s30, s8, 16
	s_and_b32 s31, s31, 0xff0000
	s_and_b32 s26, s35, 1
	s_lshl_b32 s8, s35, 8
	s_and_b32 s22, s8, 0x200
	s_mul_u64 s[8:9], s[16:17], s[26:27]
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:992 nv
	scratch_store_b128 off, v[6:9], off offset:1008 nv
	s_add_nc_u64 s[8:9], s[8:9], s[22:23]
	s_and_b32 s33, s35, 3
	s_brev_b32 s11, s33
	s_lshr_b32 s16, s11, 21
	s_lshr_b32 s11, s11, 26
	s_or_b32 s11, s11, s16
	s_add_co_i32 s29, s11, 0x43fe0
	s_sub_co_i32 s16, s31, s26
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:1024 nv
	scratch_store_b128 off, v[6:9], off offset:1040 nv
	s_add_co_i32 s16, s16, s30
	s_max_i32 s39, s16, 0
	s_sub_co_i32 s13, s13, s22
	s_add_co_i32 s13, s13, s21
	s_max_i32 s38, s13, 0
	s_add_nc_u64 s[30:31], s[18:19], s[8:9]
	s_lshl_b32 s21, s38, 16
	s_lshr_b64 s[22:23], s[38:39], 16
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:1056 nv
	scratch_store_b128 off, v[6:9], off offset:1072 nv
	s_lshr_b32 s13, s39, 16
	s_or_b32 s23, s13, 0x2000000
	s_mov_b32 s26, s17
	tensor_load_to_lds s[28:31], s[20:27]
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:1120 nv
	scratch_store_b128 off, v[6:9], off offset:1136 nv
.Ltmp31:
	.loc	1 1457 14                       ; mxfp_gemm_gfx1250.py:1457:14
	s_lshl_b32 s62, s15, 8
.Ltmp32:
	.loc	1 1363 14                       ; mxfp_gemm_gfx1250.py:1363:14 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s13, s12, 31
.Ltmp33:
	.loc	1 1457 14                       ; mxfp_gemm_gfx1250.py:1457:14
	s_mul_i32 s16, s62, s12
.Ltmp34:
	.loc	1 1363 14                       ; mxfp_gemm_gfx1250.py:1363:14 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_and_b32 s13, s13, 0xffff
	.loc	1 1363 61 is_stmt 0             ; mxfp_gemm_gfx1250.py:1363:61 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s17, s16, 31
.Ltmp35:
	.loc	1 963 9 is_stmt 1               ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_max_i32 s59, s10, 0
.Ltmp36:
	.loc	1 1363 61                       ; mxfp_gemm_gfx1250.py:1363:61 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_add_nc_u64 s[54:55], s[2:3], s[16:17]
.Ltmp37:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_max_i32 s58, s0, 0
.Ltmp38:
	.loc	1 1363 14                       ; mxfp_gemm_gfx1250.py:1363:14 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_bitset1_b32 s55, 31
.Ltmp39:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshr_b64 s[2:3], s[58:59], 16
	s_and_b32 s3, s2, 0x7fff
	s_lshr_b32 s2, s2, 16
	s_and_b32 s15, s59, 0x7fff0000
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:1088 nv
	scratch_store_b128 off, v[6:9], off offset:1104 nv
	s_lshl_b32 s60, s33, 6
	s_mul_u64 s[64:65], s[12:13], s[60:61]
	s_mul_i32 s29, s33, 0x4400
	s_sub_co_i32 s53, s15, s60
	s_add_co_i32 s2, s53, s2
	s_max_i32 s2, s2, 0
	s_add_nc_u64 s[30:31], s[54:55], s[64:65]
	s_lshl_b32 s37, s58, 16
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:1152 nv
	scratch_store_b128 off, v[6:9], off offset:1168 nv
	s_lshl_b32 s15, s2, 16
	s_or_b32 s38, s15, s3
	s_lshr_b32 s2, s2, 16
	s_or_b32 s39, s2, 0x1000000
	s_mov_b32 s42, s13
	tensor_load_to_lds s[28:31], s[36:43]
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:1184 nv
	scratch_store_b128 off, v[6:9], off offset:1200 nv
.Ltmp40:
	.loc	1 1458 14                       ; mxfp_gemm_gfx1250.py:1458:14
	s_lshl_b32 s2, s44, 8
.Ltmp41:
	.loc	1 1370 18                       ; mxfp_gemm_gfx1250.py:1370:18 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s3, s14, 31
.Ltmp42:
	.loc	1 1458 14                       ; mxfp_gemm_gfx1250.py:1458:14
	s_mul_i32 s16, s2, s14
.Ltmp43:
	.loc	1 1370 18                       ; mxfp_gemm_gfx1250.py:1370:18 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_and_b32 s15, s3, 0xffff
	.loc	1 1370 65 is_stmt 0             ; mxfp_gemm_gfx1250.py:1370:65 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s17, s16, 31
                                        ; kill: def $sgpr30 killed $sgpr66
	s_add_nc_u64 s[66:67], s[4:5], s[16:17]
                                        ; kill: def $sgpr31 killed $sgpr67
	.loc	1 1370 18                       ; mxfp_gemm_gfx1250.py:1370:18 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_bitset1_b32 s67, 31
.Ltmp44:
	.loc	1 985 9 is_stmt 1               ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1019:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_max_i32 s5, s1, 0
	s_mov_b32 s4, s58
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:1216 nv
	scratch_store_b128 off, v[6:9], off offset:1232 nv
	s_lshr_b64 s[16:17], s[4:5], 16
	s_and_b32 s17, s16, 0x7fff
	s_lshr_b32 s16, s16, 16
	s_and_b32 s44, s5, 0x7fff0000
	s_mul_u64 s[4:5], s[14:15], s[60:61]
	s_add_co_i32 s3, s29, 0x21ff0
	s_sub_co_i32 s44, s44, s60
	s_add_co_i32 s44, s44, s16
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:864 nv
	scratch_store_b128 off, v[6:9], off offset:880 nv
	s_max_i32 s16, s44, 0
	s_mov_b64 s[70:71], s[30:31]
	s_mov_b64 s[68:69], s[28:29]
	s_mov_b32 s69, s3
	s_add_nc_u64 s[70:71], s[66:67], s[4:5]
	s_lshl_b32 s30, s16, 16
	s_or_b32 s30, s30, s17
	s_lshr_b32 s16, s16, 16
	s_bitset1_b32 s16, 24
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:896 nv
	scratch_store_b128 off, v[6:9], off offset:912 nv
	s_mov_b64 s[50:51], s[42:43]
	s_mov_b64 s[48:49], s[40:41]
	s_mov_b64 s[46:47], s[38:39]
	s_mov_b64 s[44:45], s[36:37]
	s_mov_b32 s46, s30
	s_mov_b32 s47, s16
	s_mov_b32 s49, s14
	s_mov_b32 s50, s15
	tensor_load_to_lds s[68:71], s[44:51]
	s_set_vgpr_msb 0xc000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp45:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_dual_lshlrev_b32 v11, 4, v1 :: v_dual_bitop2_b32 v0, 8, v0 bitop3:0x40
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:928 nv
	scratch_store_b128 off, v[6:9], off offset:944 nv
.Ltmp46:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshl_b32 s30, s35, 5
.Ltmp47:
	.loc	1 977 28                        ; mxfp_gemm_gfx1250.py:977:28 @[ mxfp_gemm_gfx1250.py:1017:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[68:69], s[18:19], 0x400
.Ltmp48:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_and_b32 s35, s30, 64
.Ltmp49:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_and_b32 s61, s30, 32
.Ltmp50:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1028:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s17, s11, 0x44820
.Ltmp51:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshr_b32 s31, s61, 3
.Ltmp52:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1028:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[18:19], s[68:69], s[8:9]
	s_mov_b32 s16, s28
.Ltmp53:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_lshl_or_b32 v10, s35, 7, v10
	v_or_b32_e32 v1, s30, v1
.Ltmp54:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_xcnt 0x0
	v_or3_b32 v6, s31, v11, v0
	scratch_store_b32 off, v6, off offset:1600 nv ; 4-byte Folded Spill
.Ltmp55:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_dual_lshrrev_b32 v10, 4, v10 :: v_dual_bitop2_b32 v0, v10, v20 bitop3:0x54
.Ltmp56:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_lshlrev_b32_e32 v1, 8, v1
	s_wait_xcnt 0x0
	v_dual_mov_b32 v6, v12 :: v_dual_add_nc_u32 v11, 0x43fe0, v6
.Ltmp57:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1029:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s56, s28
.Ltmp58:
	.loc	1 985 9                         ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1030:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s52, s28
	s_mov_b32 s70, s27
.Ltmp59:
	.loc	2 43 13                         ; standard.py:43:13 @[ mxfp_gemm_gfx1250.py:1036:19 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s28, s0, 0xff
.Ltmp60:
	.loc	1 985 9                         ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1070:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_and_b32 s57, s1, 0xffff0000
.Ltmp61:
	.loc	1 1370 18                       ; mxfp_gemm_gfx1250.py:1370:18 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_lshr_b64 s[30:31], s[0:1], 16
.Ltmp62:
	.loc	2 43 12                         ; standard.py:43:12 @[ mxfp_gemm_gfx1250.py:1036:19 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshr_b32 s28, s28, 8
	s_mov_b32 s58, s0
	s_lshr_b32 s63, s30, 16
.Ltmp63:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add3_u32 v10, v0, v10, 0
	s_and_b32 s72, s30, 0x7fff
.Ltmp64:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_and_b32_e32 v0, 0x2f00, v1
	s_lshr_b64 s[30:31], s[58:59], 16
	s_or_b32 s31, s63, s57
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off offset:960 nv
	scratch_store_b128 off, v[6:9], off offset:976 nv
.Ltmp65:
	.loc	1 1039 9                        ; mxfp_gemm_gfx1250.py:1039:9 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_sub_co_i32 s63, 2, s28
	scratch_store_b32 off, v20, off offset:1616 nv ; 4-byte Folded Spill
.Ltmp66:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_or_b32_e32 v1, v0, v20
	s_and_b32 s71, s30, 0x7fff
	v_lshrrev_b32_e32 v0, 4, v0
	s_lshr_b32 s30, s30, 16
	s_wait_xcnt 0x0
	v_mov_b32_e32 v20, v12
	s_max_i32 s31, s31, 0
	v_mov_b32_e32 v21, v12
	s_add_co_i32 s53, s53, s30
	v_add3_u32 v0, v1, v0, 0x21ff0
	s_sub_co_i32 s57, s31, s60
	v_mov_b32_e32 v22, v12
.Ltmp67:
	.loc	1 966 16                        ; mxfp_gemm_gfx1250.py:966:16 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[30:31], s[54:55], 0x100
	v_mov_b32_e32 v23, v12
	s_max_i32 s53, s53, 0
	v_mov_b32_e32 v24, v12
	s_max_i32 s54, s57, 0
	v_mov_b32_e32 v25, v12
.Ltmp68:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1029:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[58:59], s[30:31], s[64:65]
	v_mov_b32_e32 v26, v12
	.loc	1 966 16                        ; mxfp_gemm_gfx1250.py:966:16 @[ mxfp_gemm_gfx1250.py:1029:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[30:31], s[30:31], 0x100
	v_mov_b32_e32 v27, v12
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[20:23], off offset:1248 nv
	scratch_store_b128 off, v[24:27], off offset:1264 nv
	s_lshl_b32 s74, s53, 16
	s_lshr_b32 s75, s53, 16
	s_lshl_b32 s53, s54, 16
	s_lshr_b32 s73, s54, 16
	s_or_b32 s72, s53, s72
	s_bitset1_b32 s73, 24
.Ltmp69:
	.loc	1 989 22                        ; mxfp_gemm_gfx1250.py:989:22 @[ mxfp_gemm_gfx1250.py:1019:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[66:67], s[66:67], 0x100
.Ltmp70:
	.loc	1 985 9                         ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1030:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[54:55], s[66:67], s[4:5]
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[20:23], off offset:1472 nv
	scratch_store_b128 off, v[24:27], off offset:1488 nv
	.loc	1 989 22                        ; mxfp_gemm_gfx1250.py:989:22 @[ mxfp_gemm_gfx1250.py:1030:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[66:67], s[66:67], 0x100
.Ltmp71:
	.loc	1 977 28                        ; mxfp_gemm_gfx1250.py:977:28 @[ mxfp_gemm_gfx1250.py:1028:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[68:69], s[68:69], 0x400
.Ltmp72:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1029:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s57, s29, 0x11000
.Ltmp73:
	.loc	1 985 9                         ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1030:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s53, s29, 0x32ff0
	s_clause 0x5                            ; 96-byte Folded Spill
	scratch_store_b128 off, v[20:23], off offset:1536 nv
	scratch_store_b128 off, v[24:27], off offset:1552 nv
	scratch_store_b128 off, v[12:15], off nv
	scratch_store_b128 off, v[16:19], off offset:16 nv
	scratch_store_b128 off, v[20:23], off offset:1504 nv
	scratch_store_b128 off, v[24:27], off offset:1520 nv
.Ltmp74:
	.loc	1 1001 13                       ; mxfp_gemm_gfx1250.py:1001:13 @[ mxfp_gemm_gfx1250.py:1022:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_tensorcnt 0x0
	s_set_vgpr_msb 0x80                     ;  msbs: dst=2 src0=0 src1=0 src2=0
	s_barrier_signal -1
	s_barrier_wait -1
.Ltmp75:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[0:3] /*v[512:515]*/, v10
	ds_load_b128 v[4:7] /*v[516:519]*/, v10 offset:32
	ds_load_b128 v[8:11] /*v[520:523]*/, v10 offset:64
	ds_load_b128 v[12:15] /*v[524:527]*/, v10 offset:96
	s_set_vgpr_msb 0x8000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	ds_load_b128 v[16:19], v10 offset:4352
	ds_load_b128 v[20:23], v10 offset:4384
	ds_load_b128 v[24:27], v10 offset:4416
	ds_load_b128 v[28:31], v10 offset:4448
	ds_load_b128 v[80:83], v10 offset:17408
	ds_load_b128 v[84:87], v10 offset:17440
	ds_load_b128 v[88:91], v10 offset:17472
	ds_load_b128 v[92:95], v10 offset:17504
	ds_load_b128 v[64:67], v10 offset:21760
	ds_load_b128 v[68:71], v10 offset:21792
	ds_load_b128 v[72:75], v10 offset:21824
	ds_load_b128 v[76:79], v10 offset:21856
	ds_load_b128 v[112:115], v10 offset:34816
	ds_load_b128 v[116:119], v10 offset:34848
	ds_load_b128 v[120:123], v10 offset:34880
	ds_load_b128 v[124:127], v10 offset:34912
	ds_load_b128 v[96:99], v10 offset:39168
	ds_load_b128 v[100:103], v10 offset:39200
	ds_load_b128 v[104:107], v10 offset:39232
	ds_load_b128 v[108:111], v10 offset:39264
	ds_load_b128 v[48:51], v10 offset:52224
	ds_load_b128 v[52:55], v10 offset:52256
	ds_load_b128 v[56:59], v10 offset:52288
	ds_load_b128 v[60:63], v10 offset:52320
	ds_load_b128 v[32:35], v10 offset:56576
	ds_load_b128 v[36:39], v10 offset:56608
	ds_load_b128 v[40:43], v10 offset:56640
	scratch_store_b32 off, v10, off offset:1604 nv ; 4-byte Folded Spill
	ds_load_b128 v[44:47], v10 offset:56672
.Ltmp76:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[128:131], v0
	ds_load_b128 v[132:135], v0 offset:32
	ds_load_b128 v[136:139], v0 offset:64
	ds_load_b128 v[140:143], v0 offset:96
	ds_load_b128 v[144:147], v0 offset:4352
	ds_load_b128 v[148:151], v0 offset:4384
	ds_load_b128 v[152:155], v0 offset:4416
	ds_load_b128 v[156:159], v0 offset:4448
	ds_load_b128 v[176:179], v0 offset:17408
	ds_load_b128 v[180:183], v0 offset:17440
	ds_load_b128 v[184:187], v0 offset:17472
	ds_load_b128 v[188:191], v0 offset:17504
	ds_load_b128 v[160:163], v0 offset:21760
	ds_load_b128 v[164:167], v0 offset:21792
	ds_load_b128 v[168:171], v0 offset:21824
	scratch_store_b32 off, v0, off offset:1608 nv ; 4-byte Folded Spill
	ds_load_b128 v[172:175], v0 offset:21856
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_xcnt 0x0
	ds_load_2addr_b32 v[0:1], v11 offset1:2
.Ltmp77:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1028:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	tensor_load_to_lds s[16:19], s[20:27]
.Ltmp78:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1029:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	tensor_load_to_lds s[56:59], s[36:43]
.Ltmp79:
	.loc	1 985 9                         ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1030:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	tensor_load_to_lds s[52:55], s[44:51]
	s_lshl_b32 s37, s0, 16
	s_or_b32 s38, s74, s71
	s_or_b32 s39, s75, 0x1000000
	s_mov_b64 s[50:51], s[42:43]
	s_mov_b64 s[48:49], s[40:41]
	s_mov_b64 s[46:47], s[38:39]
	s_mov_b64 s[44:45], s[36:37]
	s_mov_b32 s46, s72
	s_mov_b32 s47, s73
	s_mov_b32 s49, s14
	s_mov_b32 s50, s15
	s_wait_dscnt 0x0
.Ltmp80:
.LBB0_1:                                ; =>This Inner Loop Header: Depth=1
	.loc	1 0 9 is_stmt 0                 ; mxfp_gemm_gfx1250.py:0:9
	s_set_vgpr_msb 0xf8                     ;  msbs: dst=3 src0=0 src1=2 src2=3
.Ltmp81:
	.loc	1 924 17 is_stmt 1              ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_barrier_signal -1
.Ltmp82:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x28
	v_wmma_scale_f32_16x16x128_f8f6f4 v[200:207] /*v[968:975]*/, v[128:143], v[0:15] /*v[512:527]*/, v[200:207] /*v[968:975]*/, v0, 0
.Ltmp83:
	.loc	1 924 32                        ; mxfp_gemm_gfx1250.py:924:32 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_and_b32 s0, s70, 1
.Ltmp84:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[14:15], s[68:69], s[8:9]
.Ltmp85:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mul_i32 s12, s0, 0x11000
.Ltmp86:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_add_co_i32 s13, s70, 2
	.loc	1 1064 26                       ; mxfp_gemm_gfx1250.py:1064:26 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_add_co_i32 s16, s63, s70
	s_set_vgpr_msb 0xf800                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	scratch_load_b32 v3, off, off offset:1608 nv ; 4-byte Folded Reload
.Ltmp87:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_loadcnt 0x0
	v_nop
	v_nop
	v_nop
	v_nop
	v_nop
	v_nop
	v_nop
	s_set_vgpr_msb 64                       ;  msbs: dst=1 src0=0 src1=0 src2=0
	v_add_nc_u32_e32 v124 /*v380*/, s12, v3
	s_set_vgpr_msb 0x40f8                   ;  msbs: dst=3 src0=0 src1=2 src2=3
.Ltmp88:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x24
	v_wmma_scale_f32_16x16x128_f8f6f4 v[192:199] /*v[960:967]*/, v[144:159], v[0:15] /*v[512:527]*/, v[192:199] /*v[960:967]*/, v0, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf800                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	scratch_load_b32 v2, off, off offset:1604 nv ; 4-byte Folded Reload
.Ltmp89:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_loadcnt 0x0
	v_add_nc_u32_e32 v12, s12, v2
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
.Ltmp90:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x20
	v_wmma_scale_f32_16x16x128_f8f6f4 v[112:119] /*v[880:887]*/, v[128:143], v[16:31], v[112:119] /*v[880:887]*/, v0, 0 matrix_b_scale:MATRIX_SCALE_ROW1
.Ltmp91:
	.loc	1 932 32                        ; mxfp_gemm_gfx1250.py:932:32 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshl_b32 s12, s0, 11
	s_lshl_b32 s0, s0, 6
.Ltmp92:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[224:231] /*v[992:999]*/, v[144:159], v[16:31], v[224:231] /*v[992:999]*/, v0, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
.Ltmp93:
	.loc	1 932 32                        ; mxfp_gemm_gfx1250.py:932:32 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s17, s12, 0x43fe0
.Ltmp94:
	.loc	1 1064 26                       ; mxfp_gemm_gfx1250.py:1064:26 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_lshr_b32 s12, s16, 31
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	scratch_load_b32 v4, off, off offset:1600 nv ; 4-byte Folded Reload
.Ltmp95:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_loadcnt 0x0
	v_add3_u32 v10, s17, s0, v4
	s_set_vgpr_msb 0xf8                     ;  msbs: dst=3 src0=0 src1=2 src2=3
.Ltmp96:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x1c
	v_wmma_scale_f32_16x16x128_f8f6f4 v[216:223] /*v[984:991]*/, v[176:191], v[0:15] /*v[512:527]*/, v[216:223] /*v[984:991]*/, v1, 0
	s_set_vgpr_msb 0xf800                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp97:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v13, 0x400, v10
.Ltmp98:
	.loc	1 971 58                        ; mxfp_gemm_gfx1250.py:971:58 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_and_b32 s16, s13, 1
	s_set_vgpr_msb 0xf8                     ;  msbs: dst=3 src0=0 src1=2 src2=3
.Ltmp99:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_barrier_wait -1
.Ltmp100:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x18
	v_wmma_scale_f32_16x16x128_f8f6f4 v[208:215] /*v[976:983]*/, v[160:175], v[0:15] /*v[512:527]*/, v[208:215] /*v[976:983]*/, v1, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf881                   ;  msbs: dst=2 src0=1 src1=0 src2=0
	v_mov_b64_e32 v[22:23] /*v[534:535]*/, v[214:215] /*v[470:471]*/
	v_mov_b64_e32 v[20:21] /*v[532:533]*/, v[212:213] /*v[468:469]*/
	v_mov_b64_e32 v[18:19] /*v[530:531]*/, v[210:211] /*v[466:467]*/
	v_mov_b64_e32 v[16:17] /*v[528:529]*/, v[208:209] /*v[464:465]*/
	s_set_vgpr_msb 0x8141                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp101:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[208:211] /*v[464:467]*/, v124 /*v380*/ offset:34816
.Ltmp102:
	.loc	1 971 32                        ; mxfp_gemm_gfx1250.py:971:32 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshl_b32 s0, s16, 11
.Ltmp103:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[212:215] /*v[468:471]*/, v124 /*v380*/ offset:34848
	ds_load_b128 v[216:219] /*v[472:475]*/, v124 /*v380*/ offset:34880
.Ltmp104:
	.loc	1 971 32                        ; mxfp_gemm_gfx1250.py:971:32 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshl_b32 s13, s16, 6
	s_add_co_i32 s0, s0, 0x43fe0
	s_set_vgpr_msb 0x41f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
.Ltmp105:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[232:239] /*v[1000:1007]*/, v[176:191], v[16:31], v[232:239] /*v[1000:1007]*/, v1, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf041                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp106:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[220:223] /*v[476:479]*/, v124 /*v380*/ offset:34912
.Ltmp107:
	.loc	1 971 32                        ; mxfp_gemm_gfx1250.py:971:32 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s0, s0, s13
.Ltmp108:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[224:227] /*v[480:483]*/, v124 /*v380*/ offset:39168
	ds_load_b128 v[228:231] /*v[484:487]*/, v124 /*v380*/ offset:39200
.Ltmp109:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s13, s0, s11
.Ltmp110:
	.loc	1 1059 13                       ; mxfp_gemm_gfx1250.py:1059:13 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_add_co_i32 s0, s70, 1
	s_set_vgpr_msb 0x41f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[240:247] /*v[1008:1015]*/, v[160:175], v[16:31], v[240:247] /*v[1008:1015]*/, v1, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf041                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp111:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[232:235] /*v[488:491]*/, v124 /*v380*/ offset:39232
.Ltmp112:
	.loc	1 892 28                        ; mxfp_gemm_gfx1250.py:892:28 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_and_b32 s17, s0, 1
.Ltmp113:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[236:239] /*v[492:495]*/, v124 /*v380*/ offset:39264
	ds_load_b128 v[192:195] /*v[448:451]*/, v124 /*v380*/ offset:52224
.Ltmp114:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mul_i32 s18, s17, 0x11000
.Ltmp115:
	.loc	1 977 28                        ; mxfp_gemm_gfx1250.py:977:28 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[68:69], s[68:69], 0x400
	s_set_vgpr_msb 0x4150                   ;  msbs: dst=1 src0=0 src1=0 src2=1
.Ltmp116:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x1d
	v_wmma_scale_f32_16x16x128_f8f6f4 v[240:247] /*v[496:503]*/, v[128:143], v[80:95], v[240:247] /*v[496:503]*/, v0, 0
	s_set_vgpr_msb 0x5045                   ;  msbs: dst=1 src0=1 src1=1 src2=0
.Ltmp117:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[240:243] /*v[496:499]*/, off offset:1568 nv
	scratch_store_b128 off, v[244:247] /*v[500:503]*/, off offset:1584 nv
	ds_load_b128 v[196:199] /*v[452:455]*/, v124 /*v380*/ offset:52256
	s_set_vgpr_msb 0x4500                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp118:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v2, s18, v2
.Ltmp119:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_2addr_b32 v[14:15], v13 offset0:8 offset1:10
.Ltmp120:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v3, s18, v3
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
.Ltmp121:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[104:111] /*v[872:879]*/, v[144:159], v[80:95], v[104:111] /*v[872:879]*/, v0, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf041                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp122:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[200:203] /*v[456:459]*/, v124 /*v380*/ offset:52288
	ds_load_b128 v[204:207] /*v[460:463]*/, v124 /*v380*/ offset:52320
	ds_load_b128 v[240:243] /*v[496:499]*/, v124 /*v380*/ offset:56576
	ds_load_b128 v[244:247] /*v[500:503]*/, v124 /*v380*/ offset:56608
	ds_load_b128 v[248:251] /*v[504:507]*/, v124 /*v380*/ offset:56640
	s_set_vgpr_msb 0x41f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[120:123] /*v[888:891]*/, off, off offset:1280 th:TH_LOAD_LU nv
	scratch_load_b128 v[124:127] /*v[892:895]*/, off, off offset:1296 th:TH_LOAD_LU nv
.Ltmp123:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt_dscnt 0x20
	v_wmma_scale_f32_16x16x128_f8f6f4 v[120:127] /*v[888:895]*/, v[128:143], v[64:79], v[120:127] /*v[888:895]*/, v0, 0 matrix_b_scale:MATRIX_SCALE_ROW1
.Ltmp124:
	.loc	1 932 32                        ; mxfp_gemm_gfx1250.py:932:32 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshl_b32 s18, s17, 11
	s_lshl_b32 s17, s17, 6
	s_add_co_i32 s18, s18, 0x43fe0
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add3_u32 v4, s18, s17, v4
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[128:131] /*v[896:899]*/, off, off offset:1312 th:TH_LOAD_LU nv
	scratch_load_b128 v[132:135] /*v[900:903]*/, off, off offset:1328 th:TH_LOAD_LU nv
.Ltmp125:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[128:135] /*v[896:903]*/, v[144:159], v[64:79], v[128:135] /*v[896:903]*/, v0, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[136:139] /*v[904:907]*/, off, off offset:1344 th:TH_LOAD_LU nv
	scratch_load_b128 v[140:143] /*v[908:911]*/, off, off offset:1360 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[136:143] /*v[904:911]*/, v[176:191], v[80:95], v[136:143] /*v[904:911]*/, v1, 0
	s_mov_b32 s70, s0
.Ltmp126:
	.loc	1 964 39                        ; mxfp_gemm_gfx1250.py:964:39 @[ mxfp_gemm_gfx1250.py:1069:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mul_i32 s16, s16, 0x11000
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[144:147] /*v[912:915]*/, off, off offset:1376 th:TH_LOAD_LU nv
	scratch_load_b128 v[148:151] /*v[916:919]*/, off, off offset:1392 th:TH_LOAD_LU nv
.Ltmp127:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[144:151] /*v[912:919]*/, v[160:175], v[80:95], v[144:151] /*v[912:919]*/, v1, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf041                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp128:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[252:255] /*v[508:511]*/, v124 /*v380*/ offset:56672
	s_set_vgpr_msb 0x41f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[152:155] /*v[920:923]*/, off, off offset:1408 th:TH_LOAD_LU nv
	scratch_load_b128 v[156:159] /*v[924:927]*/, off, off offset:1424 th:TH_LOAD_LU nv
.Ltmp129:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[152:159] /*v[920:927]*/, v[176:191], v[64:79], v[152:159] /*v[920:927]*/, v1, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp130:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[192:195], v12 offset:128
	ds_load_b128 v[196:199], v12 offset:160
	ds_load_b128 v[200:203], v12 offset:192
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[160:163] /*v[928:931]*/, off, off offset:1440 th:TH_LOAD_LU nv
	scratch_load_b128 v[164:167] /*v[932:935]*/, off, off offset:1456 th:TH_LOAD_LU nv
.Ltmp131:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[160:167] /*v[928:935]*/, v[160:175], v[64:79], v[160:167] /*v[928:935]*/, v1, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp132:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[204:207], v12 offset:224
	s_set_vgpr_msb 0x41                     ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp133:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[96:99] /*v[352:355]*/, v124 /*v380*/ offset:128
	ds_load_b128 v[100:103] /*v[356:359]*/, v124 /*v380*/ offset:160
	s_set_vgpr_msb 0x41f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[32:35] /*v[800:803]*/, off, off offset:992 th:TH_LOAD_LU nv
	scratch_load_b128 v[36:39] /*v[804:807]*/, off, off offset:1008 th:TH_LOAD_LU nv
.Ltmp134:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt_dscnt 0x23
	v_wmma_scale_f32_16x16x128_f8f6f4 v[32:39] /*v[800:807]*/, v[128:143], v[112:127], v[32:39] /*v[800:807]*/, v0, 0
	s_set_vgpr_msb 0xf041                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp135:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[104:107] /*v[360:363]*/, v124 /*v380*/ offset:192
	ds_load_b128 v[108:111] /*v[364:367]*/, v124 /*v380*/ offset:224
	s_set_vgpr_msb 0x4100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_2addr_b32 v[10:11], v10 offset0:132 offset1:134
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[40:43] /*v[808:811]*/, off, off offset:1024 th:TH_LOAD_LU nv
	scratch_load_b128 v[44:47] /*v[812:815]*/, off, off offset:1040 th:TH_LOAD_LU nv
.Ltmp136:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[40:47] /*v[808:815]*/, v[144:159], v[112:127], v[40:47] /*v[808:815]*/, v0, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf041                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp137:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[128:131] /*v[384:387]*/, v124 /*v380*/ offset:4480
	ds_load_b128 v[132:135] /*v[388:391]*/, v124 /*v380*/ offset:4512
	ds_load_b128 v[136:139] /*v[392:395]*/, v124 /*v380*/ offset:4544
	s_set_vgpr_msb 0x41f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[48:51] /*v[816:819]*/, off, off offset:1056 th:TH_LOAD_LU nv
	scratch_load_b128 v[52:55] /*v[820:823]*/, off, off offset:1072 th:TH_LOAD_LU nv
.Ltmp138:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt_dscnt 0x25
	v_wmma_scale_f32_16x16x128_f8f6f4 v[48:55] /*v[816:823]*/, v[128:143], v[96:111], v[48:55] /*v[816:823]*/, v0, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf041                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp139:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[140:143] /*v[396:399]*/, v124 /*v380*/ offset:4576
	s_set_vgpr_msb 0x4100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp140:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[208:211], v12 offset:4480
	ds_load_b128 v[212:215], v12 offset:4512
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[64:67] /*v[832:835]*/, off, off offset:1120 th:TH_LOAD_LU nv
	scratch_load_b128 v[68:71] /*v[836:839]*/, off, off offset:1136 th:TH_LOAD_LU nv
.Ltmp141:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[64:71] /*v[832:839]*/, v[144:159], v[96:111], v[64:71] /*v[832:839]*/, v0, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[56:59] /*v[824:827]*/, off, off offset:1088 th:TH_LOAD_LU nv
	scratch_load_b128 v[60:63] /*v[828:831]*/, off, off offset:1104 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[56:63] /*v[824:831]*/, v[176:191], v[112:127], v[56:63] /*v[824:831]*/, v1, 0
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[72:75] /*v[840:843]*/, off, off offset:1152 th:TH_LOAD_LU nv
	scratch_load_b128 v[76:79] /*v[844:847]*/, off, off offset:1168 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[72:79] /*v[840:847]*/, v[160:175], v[112:127], v[72:79] /*v[840:847]*/, v1, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp142:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[216:219], v12 offset:4544
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[80:83] /*v[848:851]*/, off, off offset:1184 th:TH_LOAD_LU nv
	scratch_load_b128 v[84:87] /*v[852:855]*/, off, off offset:1200 th:TH_LOAD_LU nv
.Ltmp143:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[80:87] /*v[848:855]*/, v[176:191], v[96:111], v[80:87] /*v[848:855]*/, v1, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp144:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[220:223], v12 offset:4576
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[88:91] /*v[856:859]*/, off, off offset:1216 th:TH_LOAD_LU nv
	scratch_load_b128 v[92:95] /*v[860:863]*/, off, off offset:1232 th:TH_LOAD_LU nv
.Ltmp145:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[88:95] /*v[856:863]*/, v[160:175], v[96:111], v[88:95] /*v[856:863]*/, v1, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf041                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp146:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[176:179] /*v[432:435]*/, v124 /*v380*/ offset:17536
	ds_load_b128 v[180:183] /*v[436:439]*/, v124 /*v380*/ offset:17568
	ds_load_b128 v[184:187] /*v[440:443]*/, v124 /*v380*/ offset:17600
	ds_load_b128 v[188:191] /*v[444:447]*/, v124 /*v380*/ offset:17632
	s_set_vgpr_msb 0x41f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[0:3] /*v[768:771]*/, off, off offset:864 th:TH_LOAD_LU nv
	scratch_load_b128 v[4:7] /*v[772:775]*/, off, off offset:880 th:TH_LOAD_LU nv
.Ltmp147:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt_dscnt 0x2a
	v_wmma_scale_f32_16x16x128_f8f6f4 v[0:7] /*v[768:775]*/, v[128:143], v[48:63], v[0:7] /*v[768:775]*/, v0, 0
	s_set_vgpr_msb 0xf041                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp148:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[160:163] /*v[416:419]*/, v124 /*v380*/ offset:21888
	ds_load_b128 v[164:167] /*v[420:423]*/, v124 /*v380*/ offset:21920
	ds_load_b128 v[168:171] /*v[424:427]*/, v124 /*v380*/ offset:21952
	s_set_vgpr_msb 0x41f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[8:11] /*v[776:779]*/, off, off offset:896 th:TH_LOAD_LU nv
	scratch_load_b128 v[12:15] /*v[780:783]*/, off, off offset:912 th:TH_LOAD_LU nv
.Ltmp149:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[8:15] /*v[776:783]*/, v[144:159], v[48:63], v[8:15] /*v[776:783]*/, v0, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf041                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp150:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[172:175] /*v[428:431]*/, v124 /*v380*/ offset:21984
	s_set_vgpr_msb 0x4100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp151:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[224:227], v12 offset:17536
	ds_load_b128 v[228:231], v12 offset:17568
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[16:19] /*v[784:787]*/, off, off offset:928 th:TH_LOAD_LU nv
	scratch_load_b128 v[20:23] /*v[788:791]*/, off, off offset:944 th:TH_LOAD_LU nv
.Ltmp152:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt_dscnt 0x2c
	v_wmma_scale_f32_16x16x128_f8f6f4 v[16:23] /*v[784:791]*/, v[128:143], v[32:47], v[16:23] /*v[784:791]*/, v0, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp153:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[232:235], v12 offset:17600
	ds_load_b128 v[236:239], v12 offset:17632
	s_set_vgpr_msb 64                       ;  msbs: dst=1 src0=0 src1=0 src2=0
	ds_load_b128 v[0:3] /*v[256:259]*/, v12 offset:21888
	s_set_vgpr_msb 0x40f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[24:27] /*v[792:795]*/, off, off offset:960 th:TH_LOAD_LU nv
	scratch_load_b128 v[28:31] /*v[796:799]*/, off, off offset:976 th:TH_LOAD_LU nv
.Ltmp154:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[24:31] /*v[792:799]*/, v[144:159], v[32:47], v[24:31] /*v[792:799]*/, v0, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp155:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[4:7] /*v[260:263]*/, v12 offset:21920
	s_set_vgpr_msb 0x40f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[96:99] /*v[864:867]*/, off, off offset:1248 th:TH_LOAD_LU nv
	scratch_load_b128 v[100:103] /*v[868:871]*/, off, off offset:1264 th:TH_LOAD_LU nv
.Ltmp156:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[96:103] /*v[864:871]*/, v[176:191], v[48:63], v[96:103] /*v[864:871]*/, v1, 0
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[168:171] /*v[936:939]*/, off, off offset:1472 th:TH_LOAD_LU nv
	scratch_load_b128 v[172:175] /*v[940:943]*/, off, off offset:1488 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[168:175] /*v[936:943]*/, v[160:175], v[48:63], v[168:175] /*v[936:943]*/, v1, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp157:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[8:11] /*v[264:267]*/, v12 offset:21952
	s_set_vgpr_msb 0x40f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[184:187] /*v[952:955]*/, off, off offset:1536 th:TH_LOAD_LU nv
	scratch_load_b128 v[188:191] /*v[956:959]*/, off, off offset:1552 th:TH_LOAD_LU nv
.Ltmp158:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[184:191] /*v[952:959]*/, v[176:191], v[32:47], v[184:191] /*v[952:959]*/, v1, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp159:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[12:15] /*v[268:271]*/, v12 offset:21984
	s_set_vgpr_msb 0x40f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[176:179] /*v[944:947]*/, off, off offset:1504 th:TH_LOAD_LU nv
	scratch_load_b128 v[180:183] /*v[948:951]*/, off, off offset:1520 th:TH_LOAD_LU nv
.Ltmp160:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[176:183] /*v[944:951]*/, v[160:175], v[32:47], v[176:183] /*v[944:951]*/, v1, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp161:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[240:243], v12 offset:34944
.Ltmp162:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[128:131], off, off nv
	scratch_load_b128 v[132:135], off, off offset:16 nv
	s_set_vgpr_msb 9                        ;  msbs: dst=0 src0=1 src1=2 src2=0
	s_wait_loadcnt_dscnt 0x28
	v_wmma_scale_f32_16x16x128_f8f6f4 v[128:135], v[208:223] /*v[464:479]*/, v[0:15] /*v[512:527]*/, v[128:135], v14, 0
	s_set_vgpr_msb 0x900                    ;  msbs: dst=0 src0=0 src1=0 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[128:131], off nv
	scratch_store_b128 off, v[132:135], off offset:16 nv
.Ltmp163:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[244:247], v12 offset:34976
	ds_load_b128 v[248:251], v12 offset:35008
	ds_load_b128 v[252:255], v12 offset:35040
	s_set_vgpr_msb 64                       ;  msbs: dst=1 src0=0 src1=0 src2=0
	ds_load_b128 v[48:51] /*v[304:307]*/, v12 offset:39296
	s_set_vgpr_msb 0x40a9                   ;  msbs: dst=2 src0=1 src1=2 src2=2
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[248:251] /*v[760:763]*/, off, off offset:832 th:TH_LOAD_LU nv
	scratch_load_b128 v[252:255] /*v[764:767]*/, off, off offset:848 th:TH_LOAD_LU nv
.Ltmp164:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[248:255] /*v[760:767]*/, v[224:239] /*v[480:495]*/, v[0:15] /*v[512:527]*/, v[248:255] /*v[760:767]*/, v14, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa940                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp165:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[52:55] /*v[308:311]*/, v12 offset:39328
	ds_load_b128 v[56:59] /*v[312:315]*/, v12 offset:39360
	ds_load_b128 v[60:63] /*v[316:319]*/, v12 offset:39392
	ds_load_b128 v[16:19] /*v[272:275]*/, v12 offset:52352
	s_set_vgpr_msb 0x40a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[240:243] /*v[752:755]*/, off, off offset:800 th:TH_LOAD_LU nv
	scratch_load_b128 v[244:247] /*v[756:759]*/, off, off offset:816 th:TH_LOAD_LU nv
.Ltmp166:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[240:247] /*v[752:759]*/, v[208:223] /*v[464:479]*/, v[16:31], v[240:247] /*v[752:759]*/, v14, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa140                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp167:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[20:23] /*v[276:279]*/, v12 offset:52384
	ds_load_b128 v[24:27] /*v[280:283]*/, v12 offset:52416
	ds_load_b128 v[28:31] /*v[284:287]*/, v12 offset:52448
	s_set_vgpr_msb 0x40a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[232:235] /*v[744:747]*/, off, off offset:768 th:TH_LOAD_LU nv
	scratch_load_b128 v[236:239] /*v[748:751]*/, off, off offset:784 th:TH_LOAD_LU nv
.Ltmp168:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[232:239] /*v[744:751]*/, v[224:239] /*v[480:495]*/, v[16:31], v[232:239] /*v[744:751]*/, v14, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa140                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp169:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[32:35] /*v[288:291]*/, v12 offset:56704
	ds_load_b128 v[36:39] /*v[292:295]*/, v12 offset:56736
	s_set_vgpr_msb 0x40a9                   ;  msbs: dst=2 src0=1 src1=2 src2=2
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[224:227] /*v[736:739]*/, off, off offset:736 th:TH_LOAD_LU nv
	scratch_load_b128 v[228:231] /*v[740:743]*/, off, off offset:752 th:TH_LOAD_LU nv
.Ltmp170:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt_dscnt 0x33
	v_wmma_scale_f32_16x16x128_f8f6f4 v[224:231] /*v[736:743]*/, v[192:207] /*v[448:463]*/, v[0:15] /*v[512:527]*/, v[224:231] /*v[736:743]*/, v15, 0
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[216:219] /*v[728:731]*/, off, off offset:704 th:TH_LOAD_LU nv
	scratch_load_b128 v[220:223] /*v[732:735]*/, off, off offset:720 th:TH_LOAD_LU nv
	s_wait_loadcnt_dscnt 0x2f
	v_wmma_scale_f32_16x16x128_f8f6f4 v[216:223] /*v[728:735]*/, v[240:255] /*v[496:511]*/, v[0:15] /*v[512:527]*/, v[216:223] /*v[728:735]*/, v15, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa940                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp171:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[40:43] /*v[296:299]*/, v12 offset:56768
	s_set_vgpr_msb 0x40a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[208:211] /*v[720:723]*/, off, off offset:672 th:TH_LOAD_LU nv
	scratch_load_b128 v[212:215] /*v[724:727]*/, off, off offset:688 th:TH_LOAD_LU nv
.Ltmp172:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[208:215] /*v[720:727]*/, v[192:207] /*v[448:463]*/, v[16:31], v[208:215] /*v[720:727]*/, v15, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa140                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp173:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[44:47] /*v[300:303]*/, v12 offset:56800
	s_set_vgpr_msb 0x40a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[200:203] /*v[712:715]*/, off, off offset:640 th:TH_LOAD_LU nv
	scratch_load_b128 v[204:207] /*v[716:719]*/, off, off offset:656 th:TH_LOAD_LU nv
.Ltmp174:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[200:207] /*v[712:719]*/, v[240:255] /*v[496:511]*/, v[16:31], v[200:207] /*v[712:719]*/, v15, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa141                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp175:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[80:83] /*v[336:339]*/, v124 /*v380*/ offset:34944
	s_set_vgpr_msb 0x41a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[192:195] /*v[704:707]*/, off, off offset:608 th:TH_LOAD_LU nv
	scratch_load_b128 v[196:199] /*v[708:711]*/, off, off offset:624 th:TH_LOAD_LU nv
.Ltmp176:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[192:199] /*v[704:711]*/, v[208:223] /*v[464:479]*/, v[80:95], v[192:199] /*v[704:711]*/, v14, 0
	s_set_vgpr_msb 0xa141                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp177:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[84:87] /*v[340:343]*/, v124 /*v380*/ offset:34976
	s_set_vgpr_msb 0x41a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[184:187] /*v[696:699]*/, off, off offset:576 th:TH_LOAD_LU nv
	scratch_load_b128 v[188:191] /*v[700:703]*/, off, off offset:592 th:TH_LOAD_LU nv
.Ltmp178:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[184:191] /*v[696:703]*/, v[224:239] /*v[480:495]*/, v[80:95], v[184:191] /*v[696:703]*/, v14, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa141                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp179:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[88:91] /*v[344:347]*/, v124 /*v380*/ offset:35008
	ds_load_b128 v[92:95] /*v[348:351]*/, v124 /*v380*/ offset:35040
	s_set_vgpr_msb 0x4100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_2addr_b32 v[12:13], v13 offset0:140 offset1:142
	s_set_vgpr_msb 0x41                     ;  msbs: dst=1 src0=1 src1=0 src2=0
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[144:147] /*v[400:403]*/, v124 /*v380*/ offset:39296
	s_set_vgpr_msb 0x41a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[176:179] /*v[688:691]*/, off, off offset:544 th:TH_LOAD_LU nv
	scratch_load_b128 v[180:183] /*v[692:695]*/, off, off offset:560 th:TH_LOAD_LU nv
.Ltmp180:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[176:183] /*v[688:695]*/, v[208:223] /*v[464:479]*/, v[64:79], v[176:183] /*v[688:695]*/, v14, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa141                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp181:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[148:151] /*v[404:407]*/, v124 /*v380*/ offset:39328
	ds_load_b128 v[152:155] /*v[408:411]*/, v124 /*v380*/ offset:39360
	ds_load_b128 v[156:159] /*v[412:415]*/, v124 /*v380*/ offset:39392
	ds_load_b128 v[64:67] /*v[320:323]*/, v124 /*v380*/ offset:52352
	s_set_vgpr_msb 0x41a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[168:171] /*v[680:683]*/, off, off offset:512 th:TH_LOAD_LU nv
	scratch_load_b128 v[172:175] /*v[684:687]*/, off, off offset:528 th:TH_LOAD_LU nv
.Ltmp182:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[168:175] /*v[680:687]*/, v[224:239] /*v[480:495]*/, v[64:79], v[168:175] /*v[680:687]*/, v14, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa141                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp183:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[68:71] /*v[324:327]*/, v124 /*v380*/ offset:52384
	s_set_vgpr_msb 0x41a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[160:163] /*v[672:675]*/, off, off offset:480 th:TH_LOAD_LU nv
	scratch_load_b128 v[164:167] /*v[676:679]*/, off, off offset:496 th:TH_LOAD_LU nv
.Ltmp184:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[160:167] /*v[672:679]*/, v[192:207] /*v[448:463]*/, v[80:95], v[160:167] /*v[672:679]*/, v15, 0
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[152:155] /*v[664:667]*/, off, off offset:448 th:TH_LOAD_LU nv
	scratch_load_b128 v[156:159] /*v[668:671]*/, off, off offset:464 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[152:159] /*v[664:671]*/, v[240:255] /*v[496:511]*/, v[80:95], v[152:159] /*v[664:671]*/, v15, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa141                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp185:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[72:75] /*v[328:331]*/, v124 /*v380*/ offset:52416
	ds_load_b128 v[76:79] /*v[332:335]*/, v124 /*v380*/ offset:52448
	ds_load_b128 v[112:115] /*v[368:371]*/, v124 /*v380*/ offset:56704
	ds_load_b128 v[116:119] /*v[372:375]*/, v124 /*v380*/ offset:56736
	s_set_vgpr_msb 0x41a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[144:147] /*v[656:659]*/, off, off offset:416 th:TH_LOAD_LU nv
	scratch_load_b128 v[148:151] /*v[660:663]*/, off, off offset:432 th:TH_LOAD_LU nv
.Ltmp186:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[144:151] /*v[656:663]*/, v[192:207] /*v[448:463]*/, v[64:79], v[144:151] /*v[656:663]*/, v15, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[136:139] /*v[648:651]*/, off, off offset:384 th:TH_LOAD_LU nv
	scratch_load_b128 v[140:143] /*v[652:655]*/, off, off offset:400 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[136:143] /*v[648:655]*/, v[240:255] /*v[496:511]*/, v[64:79], v[136:143] /*v[648:655]*/, v15, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa141                   ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp187:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[120:123] /*v[376:379]*/, v124 /*v380*/ offset:56768
	ds_load_b128 v[124:127] /*v[380:383]*/, v124 /*v380*/ offset:56800
	s_set_vgpr_msb 0x41a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[128:131] /*v[640:643]*/, off, off offset:352 th:TH_LOAD_LU nv
	scratch_load_b128 v[132:135] /*v[644:647]*/, off, off offset:368 th:TH_LOAD_LU nv
.Ltmp188:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[128:135] /*v[640:647]*/, v[208:223] /*v[464:479]*/, v[112:127], v[128:135] /*v[640:647]*/, v14, 0
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[120:123] /*v[632:635]*/, off, off offset:320 th:TH_LOAD_LU nv
	scratch_load_b128 v[124:127] /*v[636:639]*/, off, off offset:336 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[120:127] /*v[632:639]*/, v[224:239] /*v[480:495]*/, v[112:127], v[120:127] /*v[632:639]*/, v14, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[112:115] /*v[624:627]*/, off, off offset:288 th:TH_LOAD_LU nv
	scratch_load_b128 v[116:119] /*v[628:631]*/, off, off offset:304 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[112:119] /*v[624:631]*/, v[208:223] /*v[464:479]*/, v[96:111], v[112:119] /*v[624:631]*/, v14, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[104:107] /*v[616:619]*/, off, off offset:256 th:TH_LOAD_LU nv
	scratch_load_b128 v[108:111] /*v[620:623]*/, off, off offset:272 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[104:111] /*v[616:623]*/, v[224:239] /*v[480:495]*/, v[96:111], v[104:111] /*v[616:623]*/, v14, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[96:99] /*v[608:611]*/, off, off offset:224 th:TH_LOAD_LU nv
	scratch_load_b128 v[100:103] /*v[612:615]*/, off, off offset:240 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[96:103] /*v[608:615]*/, v[192:207] /*v[448:463]*/, v[112:127], v[96:103] /*v[608:615]*/, v15, 0
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[88:91] /*v[600:603]*/, off, off offset:192 th:TH_LOAD_LU nv
	scratch_load_b128 v[92:95] /*v[604:607]*/, off, off offset:208 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[88:95] /*v[600:607]*/, v[240:255] /*v[496:511]*/, v[112:127], v[88:95] /*v[600:607]*/, v15, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[80:83] /*v[592:595]*/, off, off offset:160 th:TH_LOAD_LU nv
	scratch_load_b128 v[84:87] /*v[596:599]*/, off, off offset:176 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[80:87] /*v[592:599]*/, v[192:207] /*v[448:463]*/, v[96:111], v[80:87] /*v[592:599]*/, v15, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[72:75] /*v[584:587]*/, off, off offset:128 th:TH_LOAD_LU nv
	scratch_load_b128 v[76:79] /*v[588:591]*/, off, off offset:144 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[72:79] /*v[584:591]*/, v[240:255] /*v[496:511]*/, v[96:111], v[72:79] /*v[584:591]*/, v15, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
.Ltmp189:
	.loc	1 1001 13                       ; mxfp_gemm_gfx1250.py:1001:13 @[ mxfp_gemm_gfx1250.py:1065:13 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_tensorcnt 0x0
	s_wait_dscnt 0x0
	s_barrier_signal -1
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[64:67] /*v[576:579]*/, off, off offset:96 th:TH_LOAD_LU nv
	scratch_load_b128 v[68:71] /*v[580:583]*/, off, off offset:112 th:TH_LOAD_LU nv
.Ltmp190:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[64:71] /*v[576:583]*/, v[208:223] /*v[464:479]*/, v[48:63], v[64:71] /*v[576:583]*/, v14, 0
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[56:59] /*v[568:571]*/, off, off offset:64 th:TH_LOAD_LU nv
	scratch_load_b128 v[60:63] /*v[572:575]*/, off, off offset:80 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[56:63] /*v[568:575]*/, v[224:239] /*v[480:495]*/, v[48:63], v[56:63] /*v[568:575]*/, v14, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[48:51] /*v[560:563]*/, off, off offset:32 th:TH_LOAD_LU nv
	scratch_load_b128 v[52:55] /*v[564:567]*/, off, off offset:48 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[48:55] /*v[560:567]*/, v[208:223] /*v[464:479]*/, v[32:47], v[48:55] /*v[560:567]*/, v14, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_nop
	v_nop
	v_nop
	v_nop
	v_nop
	v_nop
	v_nop
	v_nop
	s_set_vgpr_msb 0xa142                   ;  msbs: dst=1 src0=2 src1=0 src2=0
	v_mov_b64_e32 v[208:209] /*v[464:465]*/, v[16:17] /*v[528:529]*/
	v_mov_b64_e32 v[210:211] /*v[466:467]*/, v[18:19] /*v[530:531]*/
	v_mov_b64_e32 v[212:213] /*v[468:469]*/, v[20:21] /*v[532:533]*/
	v_mov_b64_e32 v[214:215] /*v[470:471]*/, v[22:23] /*v[534:535]*/
	s_set_vgpr_msb 0x42a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[40:47] /*v[552:559]*/, v[224:239] /*v[480:495]*/, v[32:47], v[40:47] /*v[552:559]*/, v14, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[32:39] /*v[544:551]*/, v[192:207] /*v[448:463]*/, v[48:63], v[32:39] /*v[544:551]*/, v15, 0
.Ltmp191:
	.loc	1 1001 13                       ; mxfp_gemm_gfx1250.py:1001:13 @[ mxfp_gemm_gfx1250.py:1065:13 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_barrier_wait -1
.Ltmp192:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	tensor_load_to_lds s[12:15], s[20:27]
.Ltmp193:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[24:31] /*v[536:543]*/, v[240:255] /*v[496:511]*/, v[48:63], v[24:31] /*v[536:543]*/, v15, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa151                   ;  msbs: dst=1 src0=1 src1=0 src2=1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[208:215] /*v[464:471]*/, v[192:207] /*v[448:463]*/, v[32:47], v[208:215] /*v[464:471]*/, v15, 0 matrix_b_scale:MATRIX_SCALE_ROW1
.Ltmp194:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1069:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[14:15], s[30:31], s[64:65]
	s_add_co_i32 s13, s29, s16
	.loc	1 966 16                        ; mxfp_gemm_gfx1250.py:966:16 @[ mxfp_gemm_gfx1250.py:1069:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[30:31], s[30:31], 0x100
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1069:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	tensor_load_to_lds s[12:15], s[36:43]
	s_set_vgpr_msb 0x51f1                   ;  msbs: dst=3 src0=1 src1=0 src2=3
.Ltmp195:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[248:255] /*v[1016:1023]*/, v[240:255] /*v[496:511]*/, v[32:47], v[248:255] /*v[1016:1023]*/, v15, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf140                   ;  msbs: dst=1 src0=0 src1=0 src2=0
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[240:243] /*v[496:499]*/, off, off offset:1568 th:TH_LOAD_LU nv
	scratch_load_b128 v[244:247] /*v[500:503]*/, off, off offset:1584 th:TH_LOAD_LU nv
	s_set_vgpr_msb 0x40f1                   ;  msbs: dst=3 src0=1 src1=0 src2=3
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[200:207] /*v[968:975]*/, v[96:111] /*v[352:367]*/, v[192:207], v[200:207] /*v[968:975]*/, v10, 0
.Ltmp196:
	.loc	1 985 9                         ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1070:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[14:15], s[66:67], s[4:5]
	s_add_co_i32 s13, s3, s16
	.loc	1 989 22                        ; mxfp_gemm_gfx1250.py:989:22 @[ mxfp_gemm_gfx1250.py:1070:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[66:67], s[66:67], 0x100
.Ltmp197:
	.loc	1 1039 9                        ; mxfp_gemm_gfx1250.py:1039:9 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_cmp_lg_u32 s28, s0
.Ltmp198:
	.loc	1 985 9                         ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1070:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	tensor_load_to_lds s[12:15], s[44:51]
.Ltmp199:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[192:199] /*v[960:967]*/, v[128:143] /*v[384:399]*/, v[192:207], v[192:199] /*v[960:967]*/, v10, 0 matrix_a_scale:MATRIX_SCALE_ROW1
.Ltmp200:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_barrier_signal -1
.Ltmp201:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[112:119] /*v[880:887]*/, v[96:111] /*v[352:367]*/, v[208:223], v[112:119] /*v[880:887]*/, v10, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[224:231] /*v[992:999]*/, v[128:143] /*v[384:399]*/, v[208:223], v[224:231] /*v[992:999]*/, v10, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[216:223] /*v[984:991]*/, v[176:191] /*v[432:447]*/, v[192:207], v[216:223] /*v[984:991]*/, v11, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[208:215] /*v[976:983]*/, v[160:175] /*v[416:431]*/, v[192:207], v[208:215] /*v[976:983]*/, v11, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[232:239] /*v[1000:1007]*/, v[176:191] /*v[432:447]*/, v[208:223], v[232:239] /*v[1000:1007]*/, v11, 0 matrix_b_scale:MATRIX_SCALE_ROW1
.Ltmp202:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_barrier_wait -1
.Ltmp203:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[240:247] /*v[1008:1015]*/, v[160:175] /*v[416:431]*/, v[208:223], v[240:247] /*v[1008:1015]*/, v11, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf180                   ;  msbs: dst=2 src0=0 src1=0 src2=0
.Ltmp204:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[0:3] /*v[512:515]*/, v2
	ds_load_b128 v[4:7] /*v[516:519]*/, v2 offset:32
	ds_load_b128 v[8:11] /*v[520:523]*/, v2 offset:64
	ds_load_b128 v[12:15] /*v[524:527]*/, v2 offset:96
	s_set_vgpr_msb 0x8000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp205:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[128:131], v3
	s_set_vgpr_msb 0x51                     ;  msbs: dst=1 src0=1 src1=0 src2=1
.Ltmp206:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[240:247] /*v[496:503]*/, v[96:111] /*v[352:367]*/, v[224:239], v[240:247] /*v[496:503]*/, v10, 0
	s_set_vgpr_msb 0x5100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp207:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[132:135], v3 offset:32
	ds_load_b128 v[136:139], v3 offset:64
	ds_load_b128 v[140:143], v3 offset:96
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_2addr_b32 v[0:1], v4 offset1:2
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[144:147], v3 offset:4352
	s_set_vgpr_msb 0xf1                     ;  msbs: dst=3 src0=1 src1=0 src2=3
.Ltmp208:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[104:111] /*v[872:879]*/, v[128:143] /*v[384:399]*/, v[224:239], v[104:111] /*v[872:879]*/, v10, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp209:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[148:151], v3 offset:4384
	ds_load_b128 v[152:155], v3 offset:4416
	ds_load_b128 v[156:159], v3 offset:4448
.Ltmp210:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[16:19], v2 offset:4352
	ds_load_b128 v[20:23], v2 offset:4384
	s_set_vgpr_msb 0xf5                     ;  msbs: dst=3 src0=1 src1=1 src2=3
.Ltmp211:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[120:127] /*v[888:895]*/, v[96:111] /*v[352:367]*/, v[0:15] /*v[256:271]*/, v[120:127] /*v[888:895]*/, v10, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[120:123] /*v[888:891]*/, off offset:1280 nv
	scratch_store_b128 off, v[124:127] /*v[892:895]*/, off offset:1296 nv
.Ltmp212:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[24:27], v2 offset:4416
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
.Ltmp213:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[128:135] /*v[896:903]*/, v[128:143] /*v[384:399]*/, v[0:15] /*v[256:271]*/, v[128:135] /*v[896:903]*/, v10, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[128:131] /*v[896:899]*/, off offset:1312 nv
	scratch_store_b128 off, v[132:135] /*v[900:903]*/, off offset:1328 nv
	s_set_vgpr_msb 0xcf1                    ;  msbs: dst=3 src0=1 src1=0 src2=3
	v_wmma_scale_f32_16x16x128_f8f6f4 v[136:143] /*v[904:911]*/, v[176:191] /*v[432:447]*/, v[224:239], v[136:143] /*v[904:911]*/, v11, 0
	s_set_vgpr_msb 0xf10c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[136:139] /*v[904:907]*/, off offset:1344 nv
	scratch_store_b128 off, v[140:143] /*v[908:911]*/, off offset:1360 nv
	s_set_vgpr_msb 0xcf1                    ;  msbs: dst=3 src0=1 src1=0 src2=3
	v_wmma_scale_f32_16x16x128_f8f6f4 v[144:151] /*v[912:919]*/, v[160:175] /*v[416:431]*/, v[224:239], v[144:151] /*v[912:919]*/, v11, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf10c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[144:147] /*v[912:915]*/, off offset:1376 nv
	scratch_store_b128 off, v[148:151] /*v[916:919]*/, off offset:1392 nv
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
	v_wmma_scale_f32_16x16x128_f8f6f4 v[152:159] /*v[920:927]*/, v[176:191] /*v[432:447]*/, v[0:15] /*v[256:271]*/, v[152:159] /*v[920:927]*/, v11, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[152:155] /*v[920:923]*/, off offset:1408 nv
	scratch_store_b128 off, v[156:159] /*v[924:927]*/, off offset:1424 nv
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
	v_wmma_scale_f32_16x16x128_f8f6f4 v[160:167] /*v[928:935]*/, v[160:175] /*v[416:431]*/, v[0:15] /*v[256:271]*/, v[160:167] /*v[928:935]*/, v11, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[160:163] /*v[928:931]*/, off offset:1440 nv
	scratch_store_b128 off, v[164:167] /*v[932:935]*/, off offset:1456 nv
.Ltmp214:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[28:31], v2 offset:4448
	s_set_vgpr_msb 0xcf1                    ;  msbs: dst=3 src0=1 src1=0 src2=3
.Ltmp215:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[32:39] /*v[800:807]*/, v[96:111] /*v[352:367]*/, v[240:255], v[32:39] /*v[800:807]*/, v10, 0
	s_set_vgpr_msb 0xf10c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[32:35] /*v[800:803]*/, off offset:992 nv
	scratch_store_b128 off, v[36:39] /*v[804:807]*/, off offset:1008 nv
.Ltmp216:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[176:179], v3 offset:17408
	ds_load_b128 v[180:183], v3 offset:17440
	ds_load_b128 v[184:187], v3 offset:17472
	ds_load_b128 v[188:191], v3 offset:17504
	ds_load_b128 v[160:163], v3 offset:21760
	s_set_vgpr_msb 0xcf1                    ;  msbs: dst=3 src0=1 src1=0 src2=3
.Ltmp217:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[40:47] /*v[808:815]*/, v[128:143] /*v[384:399]*/, v[240:255], v[40:47] /*v[808:815]*/, v10, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf10c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[40:43] /*v[808:811]*/, off offset:1024 nv
	scratch_store_b128 off, v[44:47] /*v[812:815]*/, off offset:1040 nv
.Ltmp218:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[164:167], v3 offset:21792
	ds_load_b128 v[168:171], v3 offset:21824
	ds_load_b128 v[172:175], v3 offset:21856
.Ltmp219:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[80:83], v2 offset:17408
	ds_load_b128 v[84:87], v2 offset:17440
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
.Ltmp220:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[48:55] /*v[816:823]*/, v[96:111] /*v[352:367]*/, v[48:63] /*v[304:319]*/, v[48:55] /*v[816:823]*/, v10, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[48:51] /*v[816:819]*/, off offset:1056 nv
	scratch_store_b128 off, v[52:55] /*v[820:823]*/, off offset:1072 nv
.Ltmp221:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[88:91], v2 offset:17472
	ds_load_b128 v[92:95], v2 offset:17504
	ds_load_b128 v[64:67], v2 offset:21760
	ds_load_b128 v[68:71], v2 offset:21792
	ds_load_b128 v[72:75], v2 offset:21824
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
.Ltmp222:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[64:71] /*v[832:839]*/, v[128:143] /*v[384:399]*/, v[48:63] /*v[304:319]*/, v[64:71] /*v[832:839]*/, v10, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[64:67] /*v[832:835]*/, off offset:1120 nv
	scratch_store_b128 off, v[68:71] /*v[836:839]*/, off offset:1136 nv
	s_set_vgpr_msb 0xcf1                    ;  msbs: dst=3 src0=1 src1=0 src2=3
	v_wmma_scale_f32_16x16x128_f8f6f4 v[56:63] /*v[824:831]*/, v[176:191] /*v[432:447]*/, v[240:255], v[56:63] /*v[824:831]*/, v11, 0
	s_set_vgpr_msb 0xf10c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[56:59] /*v[824:827]*/, off offset:1088 nv
	scratch_store_b128 off, v[60:63] /*v[828:831]*/, off offset:1104 nv
	s_set_vgpr_msb 0xcf1                    ;  msbs: dst=3 src0=1 src1=0 src2=3
	v_wmma_scale_f32_16x16x128_f8f6f4 v[72:79] /*v[840:847]*/, v[160:175] /*v[416:431]*/, v[240:255], v[72:79] /*v[840:847]*/, v11, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf10c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[72:75] /*v[840:843]*/, off offset:1152 nv
	scratch_store_b128 off, v[76:79] /*v[844:847]*/, off offset:1168 nv
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
	v_wmma_scale_f32_16x16x128_f8f6f4 v[80:87] /*v[848:855]*/, v[176:191] /*v[432:447]*/, v[48:63] /*v[304:319]*/, v[80:87] /*v[848:855]*/, v11, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[80:83] /*v[848:851]*/, off offset:1184 nv
	scratch_store_b128 off, v[84:87] /*v[852:855]*/, off offset:1200 nv
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
	v_wmma_scale_f32_16x16x128_f8f6f4 v[88:95] /*v[856:863]*/, v[160:175] /*v[416:431]*/, v[48:63] /*v[304:319]*/, v[88:95] /*v[856:863]*/, v11, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[88:91] /*v[856:859]*/, off offset:1216 nv
	scratch_store_b128 off, v[92:95] /*v[860:863]*/, off offset:1232 nv
.Ltmp223:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[76:79], v2 offset:21856
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
.Ltmp224:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[0:7] /*v[768:775]*/, v[96:111] /*v[352:367]*/, v[16:31] /*v[272:287]*/, v[0:7] /*v[768:775]*/, v10, 0
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[0:3] /*v[768:771]*/, off offset:864 nv
	scratch_store_b128 off, v[4:7] /*v[772:775]*/, off offset:880 nv
.Ltmp225:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[112:115], v2 offset:34816
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
.Ltmp226:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[8:15] /*v[776:783]*/, v[128:143] /*v[384:399]*/, v[16:31] /*v[272:287]*/, v[8:15] /*v[776:783]*/, v10, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[8:11] /*v[776:779]*/, off offset:896 nv
	scratch_store_b128 off, v[12:15] /*v[780:783]*/, off offset:912 nv
.Ltmp227:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[116:119], v2 offset:34848
	ds_load_b128 v[120:123], v2 offset:34880
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
.Ltmp228:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[16:23] /*v[784:791]*/, v[96:111] /*v[352:367]*/, v[32:47] /*v[288:303]*/, v[16:23] /*v[784:791]*/, v10, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[16:19] /*v[784:787]*/, off offset:928 nv
	scratch_store_b128 off, v[20:23] /*v[788:791]*/, off offset:944 nv
.Ltmp229:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[124:127], v2 offset:34912
	ds_load_b128 v[96:99], v2 offset:39168
	ds_load_b128 v[100:103], v2 offset:39200
	ds_load_b128 v[104:107], v2 offset:39232
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
.Ltmp230:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[24:31] /*v[792:799]*/, v[128:143] /*v[384:399]*/, v[32:47] /*v[288:303]*/, v[24:31] /*v[792:799]*/, v10, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[24:27] /*v[792:795]*/, off offset:960 nv
	scratch_store_b128 off, v[28:31] /*v[796:799]*/, off offset:976 nv
.Ltmp231:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[108:111], v2 offset:39264
	ds_load_b128 v[48:51], v2 offset:52224
	ds_load_b128 v[52:55], v2 offset:52256
	ds_load_b128 v[56:59], v2 offset:52288
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
.Ltmp232:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[96:103] /*v[864:871]*/, v[176:191] /*v[432:447]*/, v[16:31] /*v[272:287]*/, v[96:103] /*v[864:871]*/, v11, 0
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[96:99] /*v[864:867]*/, off offset:1248 nv
	scratch_store_b128 off, v[100:103] /*v[868:871]*/, off offset:1264 nv
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
	v_wmma_scale_f32_16x16x128_f8f6f4 v[168:175] /*v[936:943]*/, v[160:175] /*v[416:431]*/, v[16:31] /*v[272:287]*/, v[168:175] /*v[936:943]*/, v11, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[168:171] /*v[936:939]*/, off offset:1472 nv
	scratch_store_b128 off, v[172:175] /*v[940:943]*/, off offset:1488 nv
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
	v_wmma_scale_f32_16x16x128_f8f6f4 v[184:191] /*v[952:959]*/, v[176:191] /*v[432:447]*/, v[32:47] /*v[288:303]*/, v[184:191] /*v[952:959]*/, v11, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[184:187] /*v[952:955]*/, off offset:1536 nv
	scratch_store_b128 off, v[188:191] /*v[956:959]*/, off offset:1552 nv
.Ltmp233:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[60:63], v2 offset:52320
	ds_load_b128 v[32:35], v2 offset:56576
	ds_load_b128 v[36:39], v2 offset:56608
	ds_load_b128 v[40:43], v2 offset:56640
	s_set_vgpr_msb 0xcf5                    ;  msbs: dst=3 src0=1 src1=1 src2=3
.Ltmp234:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[176:183] /*v[944:951]*/, v[160:175] /*v[416:431]*/, v[32:47] /*v[288:303]*/, v[176:183] /*v[944:951]*/, v11, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf50c                   ;  msbs: dst=0 src0=0 src1=3 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[176:179] /*v[944:947]*/, off offset:1504 nv
	scratch_store_b128 off, v[180:183] /*v[948:951]*/, off offset:1520 nv
.Ltmp235:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[44:47], v2 offset:56672
.Ltmp236:
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[2:5], off, off nv
	scratch_load_b128 v[6:9], off, off offset:16 nv
	s_set_vgpr_msb 0xc01                    ;  msbs: dst=0 src0=1 src1=0 src2=0
	s_wait_loadcnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[2:9], v[80:95] /*v[336:351]*/, v[192:207], v[2:9], v12, 0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[2:5], off nv
	scratch_store_b128 off, v[6:9], off offset:16 nv
	s_set_vgpr_msb 0x1a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[248:255] /*v[760:767]*/, v[144:159] /*v[400:415]*/, v[192:207], v[248:255] /*v[760:767]*/, v12, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[248:251] /*v[760:763]*/, off offset:832 nv
	scratch_store_b128 off, v[252:255] /*v[764:767]*/, off offset:848 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[240:247] /*v[752:759]*/, v[80:95] /*v[336:351]*/, v[208:223], v[240:247] /*v[752:759]*/, v12, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[240:243] /*v[752:755]*/, off offset:800 nv
	scratch_store_b128 off, v[244:247] /*v[756:759]*/, off offset:816 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[232:239] /*v[744:751]*/, v[144:159] /*v[400:415]*/, v[208:223], v[232:239] /*v[744:751]*/, v12, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[232:235] /*v[744:747]*/, off offset:768 nv
	scratch_store_b128 off, v[236:239] /*v[748:751]*/, off offset:784 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[224:231] /*v[736:743]*/, v[64:79] /*v[320:335]*/, v[192:207], v[224:231] /*v[736:743]*/, v13, 0
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[224:227] /*v[736:739]*/, off offset:736 nv
	scratch_store_b128 off, v[228:231] /*v[740:743]*/, off offset:752 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[216:223] /*v[728:735]*/, v[112:127] /*v[368:383]*/, v[192:207], v[216:223] /*v[728:735]*/, v13, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[216:219] /*v[728:731]*/, off offset:704 nv
	scratch_store_b128 off, v[220:223] /*v[732:735]*/, off offset:720 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[208:215] /*v[720:727]*/, v[64:79] /*v[320:335]*/, v[208:223], v[208:215] /*v[720:727]*/, v13, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[208:211] /*v[720:723]*/, off offset:672 nv
	scratch_store_b128 off, v[212:215] /*v[724:727]*/, off offset:688 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[200:207] /*v[712:719]*/, v[112:127] /*v[368:383]*/, v[208:223], v[200:207] /*v[712:719]*/, v13, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[200:203] /*v[712:715]*/, off offset:640 nv
	scratch_store_b128 off, v[204:207] /*v[716:719]*/, off offset:656 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[192:199] /*v[704:711]*/, v[80:95] /*v[336:351]*/, v[224:239], v[192:199] /*v[704:711]*/, v12, 0
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[192:195] /*v[704:707]*/, off offset:608 nv
	scratch_store_b128 off, v[196:199] /*v[708:711]*/, off offset:624 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[184:191] /*v[696:703]*/, v[144:159] /*v[400:415]*/, v[224:239], v[184:191] /*v[696:703]*/, v12, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[184:187] /*v[696:699]*/, off offset:576 nv
	scratch_store_b128 off, v[188:191] /*v[700:703]*/, off offset:592 nv
	s_set_vgpr_msb 0x8a5                    ;  msbs: dst=2 src0=1 src1=1 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[176:183] /*v[688:695]*/, v[80:95] /*v[336:351]*/, v[0:15] /*v[256:271]*/, v[176:183] /*v[688:695]*/, v12, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa508                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[176:179] /*v[688:691]*/, off offset:544 nv
	scratch_store_b128 off, v[180:183] /*v[692:695]*/, off offset:560 nv
	s_set_vgpr_msb 0x8a5                    ;  msbs: dst=2 src0=1 src1=1 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[168:175] /*v[680:687]*/, v[144:159] /*v[400:415]*/, v[0:15] /*v[256:271]*/, v[168:175] /*v[680:687]*/, v12, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa508                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[168:171] /*v[680:683]*/, off offset:512 nv
	scratch_store_b128 off, v[172:175] /*v[684:687]*/, off offset:528 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[160:167] /*v[672:679]*/, v[64:79] /*v[320:335]*/, v[224:239], v[160:167] /*v[672:679]*/, v13, 0
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[160:163] /*v[672:675]*/, off offset:480 nv
	scratch_store_b128 off, v[164:167] /*v[676:679]*/, off offset:496 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[152:159] /*v[664:671]*/, v[112:127] /*v[368:383]*/, v[224:239], v[152:159] /*v[664:671]*/, v13, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[152:155] /*v[664:667]*/, off offset:448 nv
	scratch_store_b128 off, v[156:159] /*v[668:671]*/, off offset:464 nv
	s_set_vgpr_msb 0x8a5                    ;  msbs: dst=2 src0=1 src1=1 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[144:151] /*v[656:663]*/, v[64:79] /*v[320:335]*/, v[0:15] /*v[256:271]*/, v[144:151] /*v[656:663]*/, v13, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa508                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[144:147] /*v[656:659]*/, off offset:416 nv
	scratch_store_b128 off, v[148:151] /*v[660:663]*/, off offset:432 nv
	s_set_vgpr_msb 0x8a5                    ;  msbs: dst=2 src0=1 src1=1 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[136:143] /*v[648:655]*/, v[112:127] /*v[368:383]*/, v[0:15] /*v[256:271]*/, v[136:143] /*v[648:655]*/, v13, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa508                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[136:139] /*v[648:651]*/, off offset:384 nv
	scratch_store_b128 off, v[140:143] /*v[652:655]*/, off offset:400 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[128:135] /*v[640:647]*/, v[80:95] /*v[336:351]*/, v[240:255], v[128:135] /*v[640:647]*/, v12, 0
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[128:131] /*v[640:643]*/, off offset:352 nv
	scratch_store_b128 off, v[132:135] /*v[644:647]*/, off offset:368 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[120:127] /*v[632:639]*/, v[144:159] /*v[400:415]*/, v[240:255], v[120:127] /*v[632:639]*/, v12, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[120:123] /*v[632:635]*/, off offset:320 nv
	scratch_store_b128 off, v[124:127] /*v[636:639]*/, off offset:336 nv
	s_set_vgpr_msb 0x8a5                    ;  msbs: dst=2 src0=1 src1=1 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[112:119] /*v[624:631]*/, v[80:95] /*v[336:351]*/, v[48:63] /*v[304:319]*/, v[112:119] /*v[624:631]*/, v12, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa508                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[112:115] /*v[624:627]*/, off offset:288 nv
	scratch_store_b128 off, v[116:119] /*v[628:631]*/, off offset:304 nv
	s_set_vgpr_msb 0x8a5                    ;  msbs: dst=2 src0=1 src1=1 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[104:111] /*v[616:623]*/, v[144:159] /*v[400:415]*/, v[48:63] /*v[304:319]*/, v[104:111] /*v[616:623]*/, v12, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa508                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[104:107] /*v[616:619]*/, off offset:256 nv
	scratch_store_b128 off, v[108:111] /*v[620:623]*/, off offset:272 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[96:103] /*v[608:615]*/, v[64:79] /*v[320:335]*/, v[240:255], v[96:103] /*v[608:615]*/, v13, 0
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[96:99] /*v[608:611]*/, off offset:224 nv
	scratch_store_b128 off, v[100:103] /*v[612:615]*/, off offset:240 nv
	s_set_vgpr_msb 0x8a1                    ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[88:95] /*v[600:607]*/, v[112:127] /*v[368:383]*/, v[240:255], v[88:95] /*v[600:607]*/, v13, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa108                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[88:91] /*v[600:603]*/, off offset:192 nv
	scratch_store_b128 off, v[92:95] /*v[604:607]*/, off offset:208 nv
	s_set_vgpr_msb 0x8a5                    ;  msbs: dst=2 src0=1 src1=1 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[80:87] /*v[592:599]*/, v[64:79] /*v[320:335]*/, v[48:63] /*v[304:319]*/, v[80:87] /*v[592:599]*/, v13, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa508                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[80:83] /*v[592:595]*/, off offset:160 nv
	scratch_store_b128 off, v[84:87] /*v[596:599]*/, off offset:176 nv
	s_set_vgpr_msb 0x8a5                    ;  msbs: dst=2 src0=1 src1=1 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[72:79] /*v[584:591]*/, v[112:127] /*v[368:383]*/, v[48:63] /*v[304:319]*/, v[72:79] /*v[584:591]*/, v13, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa508                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[72:75] /*v[584:587]*/, off offset:128 nv
	scratch_store_b128 off, v[76:79] /*v[588:591]*/, off offset:144 nv
	s_set_vgpr_msb 0x8a5                    ;  msbs: dst=2 src0=1 src1=1 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[64:71] /*v[576:583]*/, v[80:95] /*v[336:351]*/, v[16:31] /*v[272:287]*/, v[64:71] /*v[576:583]*/, v12, 0
	s_set_vgpr_msb 0xa508                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[64:67] /*v[576:579]*/, off offset:96 nv
	scratch_store_b128 off, v[68:71] /*v[580:583]*/, off offset:112 nv
	s_set_vgpr_msb 0x8a5                    ;  msbs: dst=2 src0=1 src1=1 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[56:63] /*v[568:575]*/, v[144:159] /*v[400:415]*/, v[16:31] /*v[272:287]*/, v[56:63] /*v[568:575]*/, v12, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa508                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[56:59] /*v[568:571]*/, off offset:64 nv
	scratch_store_b128 off, v[60:63] /*v[572:575]*/, off offset:80 nv
	s_set_vgpr_msb 0x8a5                    ;  msbs: dst=2 src0=1 src1=1 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[48:55] /*v[560:567]*/, v[80:95] /*v[336:351]*/, v[32:47] /*v[288:303]*/, v[48:55] /*v[560:567]*/, v12, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa508                   ;  msbs: dst=0 src0=0 src1=2 src2=0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[48:51] /*v[560:563]*/, off offset:32 nv
	scratch_store_b128 off, v[52:55] /*v[564:567]*/, off offset:48 nv
	s_set_vgpr_msb 0x8a5                    ;  msbs: dst=2 src0=1 src1=1 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[40:47] /*v[552:559]*/, v[144:159] /*v[400:415]*/, v[32:47] /*v[288:303]*/, v[40:47] /*v[552:559]*/, v12, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[32:39] /*v[544:551]*/, v[64:79] /*v[320:335]*/, v[16:31] /*v[272:287]*/, v[32:39] /*v[544:551]*/, v13, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[24:31] /*v[536:543]*/, v[112:127] /*v[368:383]*/, v[16:31] /*v[272:287]*/, v[24:31] /*v[536:543]*/, v13, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa555                   ;  msbs: dst=1 src0=1 src1=1 src2=1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[208:215] /*v[464:471]*/, v[64:79] /*v[320:335]*/, v[32:47] /*v[288:303]*/, v[208:215] /*v[464:471]*/, v13, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0x55f5                   ;  msbs: dst=3 src0=1 src1=1 src2=3
	v_wmma_scale_f32_16x16x128_f8f6f4 v[248:255] /*v[1016:1023]*/, v[112:127] /*v[368:383]*/, v[32:47] /*v[288:303]*/, v[248:255] /*v[1016:1023]*/, v13, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf500                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	.loc	1 1039 9                        ; mxfp_gemm_gfx1250.py:1039:9 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_cbranch_scc1 .LBB0_1
; %bb.2:                                ; %._crit_edge
.Ltmp237:
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_dscnt 0x0
	s_barrier_signal -1
	scratch_load_b32 v0, off, off offset:1612 th:TH_LOAD_LU nv ; 4-byte Folded Reload
	s_wait_loadcnt 0x0
	v_lshlrev_b32_e32 v0, 10, v0
	scratch_load_b32 v1, off, off offset:1616 th:TH_LOAD_LU nv ; 4-byte Folded Reload
	s_wait_loadcnt 0x0
	v_lshlrev_b32_e32 v1, 1, v1
	s_lshl_b32 s0, s61, 2
	s_lshl_b32 s3, s35, 9
.Ltmp238:
	.loc	1 1469 14                       ; mxfp_gemm_gfx1250.py:1469:14
	s_bitset1_b32 s7, 31
.Ltmp239:
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_or_b32 s3, s3, s0
.Ltmp240:
	.loc	1 1469 14                       ; mxfp_gemm_gfx1250.py:1469:14
	s_ashr_i32 s5, s34, 31
.Ltmp241:
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add3_u32 v0, s3, v1, v0
	v_add_nc_u32_e32 v1, 0x10000, v0
	v_add_nc_u32_e32 v2, 0x10010, v0
	v_add_nc_u32_e32 v3, 0x10040, v0
	v_add_nc_u32_e32 v4, 0x10050, v0
	s_mov_b32 s0, 1
	s_mov_b32 s11, 0
	s_mov_b32 s4, 0x20000
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_ashr_i32 s63, s62, 31
	s_ashr_i32 s3, s2, 31
	s_sub_co_i32 s10, s10, s62
	s_mov_b32 s8, 64
	s_mov_b32 s9, s34
.Ltmp242:
	.loc	1 1469 14                       ; mxfp_gemm_gfx1250.py:1469:14
	s_and_b32 s35, s5, 0xffff
.Ltmp243:
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_max_i32 s5, s10, 0
	s_mul_u64 s[12:13], s[34:35], s[62:63]
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v5, 0x14000, v0
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[12:13], s[12:13], s[2:3]
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v6, 0x14010, v0
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshl_b64 s[12:13], s[12:13], 2
	s_cmp_gt_i32 s62, -1
	s_add_nc_u64 s[6:7], s[12:13], s[6:7]
	s_cselect_b32 s3, s5, 0
	s_set_vgpr_msb 12                       ;  msbs: dst=0 src0=0 src1=3 src2=0
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_barrier_wait -1
	ds_store_b128 v0, v[200:203] /*v[968:971]*/
	ds_store_b128 v0, v[204:207] /*v[972:975]*/ offset:16
	ds_store_b128 v0, v[192:195] /*v[960:963]*/ offset:64
	ds_store_b128 v0, v[196:199] /*v[964:967]*/ offset:80
	ds_store_b128 v0, v[112:115] /*v[880:883]*/ offset:16384
	ds_store_b128 v0, v[116:119] /*v[884:887]*/ offset:16400
	ds_store_b128 v0, v[224:227] /*v[992:995]*/ offset:16448
	ds_store_b128 v0, v[228:231] /*v[996:999]*/ offset:16464
	ds_store_b128 v0, v[216:219] /*v[984:987]*/ offset:256
	ds_store_b128 v0, v[220:223] /*v[988:991]*/ offset:272
	ds_store_b128 v0, v[208:211] /*v[976:979]*/ offset:320
	ds_store_b128 v0, v[212:215] /*v[980:983]*/ offset:336
	ds_store_b128 v0, v[232:235] /*v[1000:1003]*/ offset:16640
	ds_store_b128 v0, v[236:239] /*v[1004:1007]*/ offset:16656
	ds_store_b128 v0, v[240:243] /*v[1008:1011]*/ offset:16704
	ds_store_b128 v0, v[244:247] /*v[1012:1015]*/ offset:16720
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_sub_co_i32 s1, s1, s2
	s_set_vgpr_msb 0xc00                    ;  msbs: dst=0 src0=0 src1=0 src2=0
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v7, 0x14040, v0
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_max_i32 s1, s1, 0
	s_cmp_gt_i32 s2, -1
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v8, 0x14050, v0
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_cselect_b32 s2, s1, 0
	s_and_b32 s5, s3, 0x7fff0000
	s_lshl_b32 s1, s33, 16
	s_lshl_b32 s10, s60, 2
	s_lshr_b64 s[14:15], s[2:3], 16
	s_mul_u64 s[16:17], s[10:11], s[34:35]
	s_sub_co_i32 s13, s5, s60
	s_lshl_b32 s5, s2, 16
	s_mov_b32 s10, s35
	s_and_b32 s12, s14, 0x7fff
	s_lshr_b32 s14, s14, 16
	s_add_nc_u64 s[2:3], s[6:7], s[16:17]
	s_add_co_i32 s13, s13, s14
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v9, 0x10100, v0
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_max_i32 s7, s13, 0
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v10, 0x10110, v0
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshl_b32 s6, s7, 16
	s_lshr_b32 s7, s7, 16
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v11, 0x10140, v0
	v_add_nc_u32_e32 v12, 0x10150, v0
	v_add_nc_u32_e32 v13, 0x14100, v0
	v_add_nc_u32_e32 v14, 0x14110, v0
	v_add_nc_u32_e32 v15, 0x14140, v0
	v_add_nc_u32_e32 v16, 0x14150, v0
	v_add_nc_u32_e32 v17, 0x10200, v0
	v_add_nc_u32_e32 v18, 0x10210, v0
	v_add_nc_u32_e32 v19, 0x10240, v0
	v_add_nc_u32_e32 v20, 0x10250, v0
	v_add_nc_u32_e32 v21, 0x14200, v0
	v_add_nc_u32_e32 v22, 0x14210, v0
	v_add_nc_u32_e32 v23, 0x14240, v0
	v_add_nc_u32_e32 v24, 0x14250, v0
	v_add_nc_u32_e32 v25, 0x10300, v0
	v_add_nc_u32_e32 v26, 0x10310, v0
	v_add_nc_u32_e32 v27, 0x10340, v0
	v_add_nc_u32_e32 v28, 0x10350, v0
	v_add_nc_u32_e32 v29, 0x14300, v0
	v_add_nc_u32_e32 v30, 0x14310, v0
	v_add_nc_u32_e32 v31, 0x14340, v0
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[32:35], off, off th:TH_LOAD_LU nv
	scratch_load_b128 v[36:39], off, off offset:16 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v0, v[32:35] offset:512
	s_wait_loadcnt 0x0
	ds_store_b128 v0, v[36:39] offset:528
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[32:35], off, off offset:832 th:TH_LOAD_LU nv
	scratch_load_b128 v[36:39], off, off offset:848 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v0, v[32:35] offset:576
	s_wait_loadcnt 0x0
	ds_store_b128 v0, v[36:39] offset:592
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[32:35], off, off offset:800 th:TH_LOAD_LU nv
	scratch_load_b128 v[36:39], off, off offset:816 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v0, v[32:35] offset:16896
	s_wait_loadcnt 0x0
	ds_store_b128 v0, v[36:39] offset:16912
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[32:35], off, off offset:768 th:TH_LOAD_LU nv
	scratch_load_b128 v[36:39], off, off offset:784 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v0, v[32:35] offset:16960
	s_wait_loadcnt 0x0
	ds_store_b128 v0, v[36:39] offset:16976
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[32:35], off, off offset:736 th:TH_LOAD_LU nv
	scratch_load_b128 v[36:39], off, off offset:752 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v0, v[32:35] offset:768
	s_wait_loadcnt 0x0
	ds_store_b128 v0, v[36:39] offset:784
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[32:35], off, off offset:704 th:TH_LOAD_LU nv
	scratch_load_b128 v[36:39], off, off offset:720 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v0, v[32:35] offset:832
	s_wait_loadcnt 0x0
	ds_store_b128 v0, v[36:39] offset:848
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[32:35], off, off offset:672 th:TH_LOAD_LU nv
	scratch_load_b128 v[36:39], off, off offset:688 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v0, v[32:35] offset:17152
	s_wait_loadcnt 0x0
	ds_store_b128 v0, v[36:39] offset:17168
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[32:35], off, off offset:640 th:TH_LOAD_LU nv
	scratch_load_b128 v[36:39], off, off offset:656 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v0, v[32:35] offset:17216
	s_wait_loadcnt 0x0
	ds_store_b128 v0, v[36:39] offset:17232
	v_add_nc_u32_e32 v32, 0x14350, v0
	v_add_nc_u32_e32 v33, 0x20000, v0
	v_add_nc_u32_e32 v34, 0x20010, v0
	v_add_nc_u32_e32 v35, 0x20040, v0
	v_add_nc_u32_e32 v36, 0x20050, v0
	v_add_nc_u32_e32 v37, 0x24000, v0
	v_add_nc_u32_e32 v38, 0x24010, v0
	v_add_nc_u32_e32 v39, 0x24040, v0
	v_add_nc_u32_e32 v40, 0x24050, v0
	v_add_nc_u32_e32 v41, 0x20100, v0
	v_add_nc_u32_e32 v42, 0x20110, v0
	v_add_nc_u32_e32 v43, 0x20140, v0
	v_add_nc_u32_e32 v44, 0x20150, v0
	v_add_nc_u32_e32 v45, 0x24100, v0
	v_add_nc_u32_e32 v46, 0x24110, v0
	v_add_nc_u32_e32 v47, 0x24140, v0
	v_add_nc_u32_e32 v48, 0x24150, v0
	v_add_nc_u32_e32 v49, 0x20200, v0
	v_add_nc_u32_e32 v50, 0x20210, v0
	v_add_nc_u32_e32 v51, 0x20240, v0
	v_add_nc_u32_e32 v52, 0x20250, v0
	v_add_nc_u32_e32 v53, 0x24200, v0
	v_add_nc_u32_e32 v54, 0x24210, v0
	v_add_nc_u32_e32 v55, 0x24240, v0
	v_add_nc_u32_e32 v56, 0x24250, v0
	v_add_nc_u32_e32 v57, 0x20300, v0
	v_add_nc_u32_e32 v58, 0x20310, v0
	v_add_nc_u32_e32 v59, 0x20340, v0
	v_add_nc_u32_e32 v60, 0x20350, v0
	v_add_nc_u32_e32 v61, 0x24300, v0
	v_add_nc_u32_e32 v62, 0x24310, v0
	v_add_nc_u32_e32 v63, 0x24340, v0
	v_add_nc_u32_e32 v64, 0x24350, v0
	v_add_nc_u32_e32 v65, 0x30000, v0
	v_add_nc_u32_e32 v66, 0x30010, v0
	v_add_nc_u32_e32 v67, 0x30040, v0
	v_add_nc_u32_e32 v68, 0x30050, v0
	v_add_nc_u32_e32 v69, 0x34000, v0
	v_add_nc_u32_e32 v70, 0x34010, v0
	v_add_nc_u32_e32 v71, 0x34040, v0
	v_add_nc_u32_e32 v72, 0x34050, v0
	v_add_nc_u32_e32 v73, 0x30100, v0
	v_add_nc_u32_e32 v74, 0x30110, v0
	v_add_nc_u32_e32 v75, 0x30140, v0
	s_set_vgpr_msb 4                        ;  msbs: dst=0 src0=0 src1=1 src2=0
	ds_store_b128 v1, v[240:243] /*v[496:499]*/
	ds_store_b128 v2, v[244:247] /*v[500:503]*/
	s_set_vgpr_msb 0x40c                    ;  msbs: dst=0 src0=0 src1=3 src2=0
	ds_store_b128 v3, v[104:107] /*v[872:875]*/
	ds_store_b128 v4, v[108:111] /*v[876:879]*/
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[76:79], off, off offset:1280 th:TH_LOAD_LU nv
	scratch_load_b128 v[80:83], off, off offset:1296 th:TH_LOAD_LU nv
	s_set_vgpr_msb 0xc00                    ;  msbs: dst=0 src0=0 src1=0 src2=0
	s_wait_loadcnt 0x1
	ds_store_b128 v5, v[76:79]
	s_wait_loadcnt 0x0
	ds_store_b128 v6, v[80:83]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[76:79], off, off offset:1312 th:TH_LOAD_LU nv
	scratch_load_b128 v[80:83], off, off offset:1328 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v7, v[76:79]
	s_wait_loadcnt 0x0
	ds_store_b128 v8, v[80:83]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[76:79], off, off offset:1344 th:TH_LOAD_LU nv
	scratch_load_b128 v[80:83], off, off offset:1360 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v9, v[76:79]
	s_wait_loadcnt 0x0
	ds_store_b128 v10, v[80:83]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[2:5], off, off offset:1376 th:TH_LOAD_LU nv
	scratch_load_b128 v[6:9], off, off offset:1392 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v11, v[2:5]
	s_wait_loadcnt 0x0
	ds_store_b128 v12, v[6:9]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[2:5], off, off offset:1408 th:TH_LOAD_LU nv
	scratch_load_b128 v[6:9], off, off offset:1424 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v13, v[2:5]
	s_wait_loadcnt 0x0
	ds_store_b128 v14, v[6:9]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[2:5], off, off offset:1440 th:TH_LOAD_LU nv
	scratch_load_b128 v[6:9], off, off offset:1456 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v15, v[2:5]
	s_wait_loadcnt 0x0
	ds_store_b128 v16, v[6:9]
	v_add_nc_u32_e32 v1, 0x30150, v0
	v_add_nc_u32_e32 v2, 0x34100, v0
	v_add_nc_u32_e32 v3, 0x34110, v0
	v_add_nc_u32_e32 v4, 0x34140, v0
	v_add_nc_u32_e32 v5, 0x34150, v0
	v_add_nc_u32_e32 v6, 0x30200, v0
	v_add_nc_u32_e32 v7, 0x30210, v0
	v_add_nc_u32_e32 v8, 0x30240, v0
	v_add_nc_u32_e32 v9, 0x30250, v0
	v_add_nc_u32_e32 v10, 0x34200, v0
	v_add_nc_u32_e32 v11, 0x34210, v0
	v_add_nc_u32_e32 v12, 0x34240, v0
	v_add_nc_u32_e32 v13, 0x34250, v0
	v_add_nc_u32_e32 v14, 0x30300, v0
	v_add_nc_u32_e32 v15, 0x30310, v0
	v_add_nc_u32_e32 v16, 0x30340, v0
	v_add_nc_u32_e32 v76, 0x30350, v0
	v_add_nc_u32_e32 v77, 0x34300, v0
	v_add_nc_u32_e32 v78, 0x34310, v0
	v_add_nc_u32_e32 v79, 0x34340, v0
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_or_b32 s6, s6, s12
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v0, 0x34350, v0
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_bitset1_b32 s7, 24
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[80:83], off, off offset:608 th:TH_LOAD_LU nv
	scratch_load_b128 v[84:87], off, off offset:624 th:TH_LOAD_LU nv
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_loadcnt 0x1
	ds_store_b128 v17, v[80:83]
	s_wait_loadcnt 0x0
	ds_store_b128 v18, v[84:87]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[80:83], off, off offset:576 th:TH_LOAD_LU nv
	scratch_load_b128 v[84:87], off, off offset:592 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v19, v[80:83]
	s_wait_loadcnt 0x0
	ds_store_b128 v20, v[84:87]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[80:83], off, off offset:544 th:TH_LOAD_LU nv
	scratch_load_b128 v[84:87], off, off offset:560 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v21, v[80:83]
	s_wait_loadcnt 0x0
	ds_store_b128 v22, v[84:87]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[80:83], off, off offset:512 th:TH_LOAD_LU nv
	scratch_load_b128 v[84:87], off, off offset:528 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v23, v[80:83]
	s_wait_loadcnt 0x0
	ds_store_b128 v24, v[84:87]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[80:83], off, off offset:480 th:TH_LOAD_LU nv
	scratch_load_b128 v[84:87], off, off offset:496 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v25, v[80:83]
	s_wait_loadcnt 0x0
	ds_store_b128 v26, v[84:87]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:448 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:464 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v27, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v28, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:416 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:432 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v29, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v30, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:384 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:400 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v31, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v32, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:992 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:1008 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v33, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v34, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:1024 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:1040 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v35, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v36, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:1056 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:1072 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v37, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v38, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:1120 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:1136 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v39, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v40, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:1088 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:1104 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v41, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v42, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:1152 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:1168 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v43, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v44, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:1184 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:1200 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v45, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v46, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:1216 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:1232 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v47, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v48, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:352 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:368 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v49, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v50, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:320 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:336 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v51, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v52, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:288 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:304 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v53, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v54, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:256 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:272 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v55, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v56, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:224 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:240 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v57, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v58, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:192 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:208 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v59, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v60, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:160 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:176 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v61, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v62, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:128 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:144 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v63, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v64, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:864 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:880 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v65, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v66, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:896 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:912 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v67, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v68, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:928 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:944 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v69, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v70, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:960 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:976 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v71, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v72, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:1248 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:1264 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v73, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v74, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:1472 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:1488 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v75, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v1, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:1536 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:1552 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v2, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v3, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:1504 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:1520 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v4, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v5, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:96 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:112 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v6, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v7, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[18:21], off, off offset:64 th:TH_LOAD_LU nv
	scratch_load_b128 v[22:25], off, off offset:80 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v8, v[18:21]
	s_wait_loadcnt 0x0
	ds_store_b128 v9, v[22:25]
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[2:5], off, off offset:32 th:TH_LOAD_LU nv
	scratch_load_b128 v[6:9], off, off offset:48 th:TH_LOAD_LU nv
	s_wait_loadcnt 0x1
	ds_store_b128 v10, v[2:5]
	s_wait_loadcnt 0x0
	ds_store_b128 v11, v[6:9]
	s_set_vgpr_msb 8                        ;  msbs: dst=0 src0=0 src1=2 src2=0
	ds_store_b128 v12, v[40:43] /*v[552:555]*/
	ds_store_b128 v13, v[44:47] /*v[556:559]*/
	ds_store_b128 v14, v[32:35] /*v[544:547]*/
	ds_store_b128 v15, v[36:39] /*v[548:551]*/
	ds_store_b128 v16, v[24:27] /*v[536:539]*/
	ds_store_b128 v76, v[28:31] /*v[540:543]*/
	s_set_vgpr_msb 0x804                    ;  msbs: dst=0 src0=0 src1=1 src2=0
	ds_store_b128 v77, v[208:211] /*v[464:467]*/
	ds_store_b128 v78, v[212:215] /*v[468:471]*/
	s_set_vgpr_msb 0x40c                    ;  msbs: dst=0 src0=0 src1=3 src2=0
	ds_store_b128 v79, v[248:251] /*v[1016:1019]*/
	ds_store_b128 v0, v[252:255] /*v[1020:1023]*/
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_dscnt 0x0
	s_barrier_signal -1
	s_barrier_wait -1
	tensor_store_from_lds s[0:3], s[4:11]
	.loc	1 411 5                         ; mxfp_gemm_gfx1250.py:411:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_tensorcnt 0x0
	s_barrier_signal -1
	s_barrier_wait -1
.Ltmp244:
	.loc	1 1415 1                        ; mxfp_gemm_gfx1250.py:1415:1
	s_endpgm
.Ltmp245:
.Lfunc_end0:
	.size	mxgemm_tdm_pipelined_kernel, .Lfunc_end0-mxgemm_tdm_pipelined_kernel
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel mxgemm_tdm_pipelined_kernel
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 1624
		.amdhsa_kernarg_size 80
		.amdhsa_user_sgpr_count 22
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_kernarg_preload_length 20
		.amdhsa_user_sgpr_kernarg_preload_offset 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 1
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 1
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 1024
		.amdhsa_next_free_sgpr 76
		.amdhsa_named_barrier_count 0
		.amdhsa_reserve_vcc 0
		.amdhsa_reserve_xnack_mask 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size ((instprefsize(.Lfunc_end0-mxgemm_tdm_pipelined_kernel)<<4)&4080)>>4
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
                                        ; -- End function
	.set .Lmxgemm_tdm_pipelined_kernel.num_vgpr, 1024
	.set .Lmxgemm_tdm_pipelined_kernel.num_agpr, 0
	.set .Lmxgemm_tdm_pipelined_kernel.numbered_sgpr, 76
	.set .Lmxgemm_tdm_pipelined_kernel.num_named_barrier, 0
	.set .Lmxgemm_tdm_pipelined_kernel.private_seg_size, 1624
	.set .Lmxgemm_tdm_pipelined_kernel.uses_vcc, 0
	.set .Lmxgemm_tdm_pipelined_kernel.uses_flat_scratch, 1
	.set .Lmxgemm_tdm_pipelined_kernel.has_dyn_sized_stack, 0
	.set .Lmxgemm_tdm_pipelined_kernel.has_recursion, 0
	.set .Lmxgemm_tdm_pipelined_kernel.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 15020
; TotalNumSgprs: 76
; NumVgprs: 1024
; ScratchSize: 1624
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 63
; NumSGPRsForWavesPerEU: 76
; NumVGPRsForWavesPerEU: 1024
; NamedBarCnt: 0
; Occupancy: 1
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 1
; COMPUTE_PGM_RSRC2:USER_SGPR: 22
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 1
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.p2alignl 7, 3214868480
	.fill 96, 4, 3214868480
	.section	.AMDGPU.gpr_maximums,"",@progbits
	.set amdgpu.max_num_vgpr, 0
	.set amdgpu.max_num_agpr, 0
	.set amdgpu.max_num_sgpr, 0
	.set amdgpu.max_num_named_barrier, 0
	.text
	.section	.debug_abbrev,"",@progbits
	.byte	1                               ; Abbreviation Code
	.byte	17                              ; DW_TAG_compile_unit
	.byte	1                               ; DW_CHILDREN_yes
	.byte	37                              ; DW_AT_producer
	.byte	14                              ; DW_FORM_strp
	.byte	19                              ; DW_AT_language
	.byte	5                               ; DW_FORM_data2
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	16                              ; DW_AT_stmt_list
	.byte	23                              ; DW_FORM_sec_offset
	.byte	27                              ; DW_AT_comp_dir
	.byte	14                              ; DW_FORM_strp
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	2                               ; Abbreviation Code
	.byte	46                              ; DW_TAG_subprogram
	.byte	0                               ; DW_CHILDREN_no
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	32                              ; DW_AT_inline
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	3                               ; Abbreviation Code
	.byte	46                              ; DW_TAG_subprogram
	.byte	1                               ; DW_CHILDREN_yes
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	49                              ; DW_AT_abstract_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	4                               ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	1                               ; DW_CHILDREN_yes
	.byte	49                              ; DW_AT_abstract_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	85                              ; DW_AT_ranges
	.byte	23                              ; DW_FORM_sec_offset
	.byte	88                              ; DW_AT_call_file
	.byte	11                              ; DW_FORM_data1
	.byte	89                              ; DW_AT_call_line
	.byte	5                               ; DW_FORM_data2
	.byte	87                              ; DW_AT_call_column
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	5                               ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	0                               ; DW_CHILDREN_no
	.byte	49                              ; DW_AT_abstract_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	85                              ; DW_AT_ranges
	.byte	23                              ; DW_FORM_sec_offset
	.byte	88                              ; DW_AT_call_file
	.byte	11                              ; DW_FORM_data1
	.byte	89                              ; DW_AT_call_line
	.byte	5                               ; DW_FORM_data2
	.byte	87                              ; DW_AT_call_column
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	6                               ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	0                               ; DW_CHILDREN_no
	.byte	49                              ; DW_AT_abstract_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	88                              ; DW_AT_call_file
	.byte	11                              ; DW_FORM_data1
	.byte	89                              ; DW_AT_call_line
	.byte	5                               ; DW_FORM_data2
	.byte	87                              ; DW_AT_call_column
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	0                               ; EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 ; Length of Unit
.Ldebug_info_start0:
	.short	4                               ; DWARF version number
	.long	.debug_abbrev                   ; Offset Into Abbrev. Section
	.byte	8                               ; Address Size (in bytes)
	.byte	1                               ; Abbrev [1] 0xb:0x18e DW_TAG_compile_unit
	.long	.Linfo_string0                  ; DW_AT_producer
	.short	2                               ; DW_AT_language
	.long	.Linfo_string1                  ; DW_AT_name
	.long	.Lline_table_start0             ; DW_AT_stmt_list
	.long	.Linfo_string2                  ; DW_AT_comp_dir
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       ; DW_AT_high_pc
	.byte	2                               ; Abbrev [2] 0x2a:0x6 DW_TAG_subprogram
	.long	.Linfo_string3                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	3                               ; Abbrev [3] 0x30:0x168 DW_TAG_subprogram
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       ; DW_AT_high_pc
	.long	42                              ; DW_AT_abstract_origin
	.byte	4                               ; Abbrev [4] 0x41:0x127 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges0                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1491                            ; DW_AT_call_line
	.byte	9                               ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x4e:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges1                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1023                            ; DW_AT_call_line
	.byte	24                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x5b:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges2                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1024                            ; DW_AT_call_line
	.byte	26                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x68:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges3                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1079                            ; DW_AT_call_line
	.byte	9                               ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x75:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges4                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1017                            ; DW_AT_call_line
	.byte	28                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x82:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges5                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1018                            ; DW_AT_call_line
	.byte	22                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x8f:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges6                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1019                            ; DW_AT_call_line
	.byte	22                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x9c:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges7                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1028                            ; DW_AT_call_line
	.byte	24                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0xa9:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges8                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1029                            ; DW_AT_call_line
	.byte	18                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0xb6:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges9                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1030                            ; DW_AT_call_line
	.byte	18                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0xc3:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges10                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1036                            ; DW_AT_call_line
	.byte	19                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0xd0:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges11                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1070                            ; DW_AT_call_line
	.byte	22                              ; DW_AT_call_column
	.byte	6                               ; Abbrev [6] 0xdd:0x15 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Ltmp74                         ; DW_AT_low_pc
	.long	.Ltmp75-.Ltmp74                 ; DW_AT_high_pc
	.byte	1                               ; DW_AT_call_file
	.short	1022                            ; DW_AT_call_line
	.byte	9                               ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0xf2:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges12                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1042                            ; DW_AT_call_line
	.byte	30                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0xff:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges13                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1068                            ; DW_AT_call_line
	.byte	28                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x10c:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges14                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1051                            ; DW_AT_call_line
	.byte	28                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x119:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges15                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1072                            ; DW_AT_call_line
	.byte	28                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x126:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges16                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1073                            ; DW_AT_call_line
	.byte	30                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x133:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges17                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1069                            ; DW_AT_call_line
	.byte	22                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x140:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges18                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1052                            ; DW_AT_call_line
	.byte	30                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x14d:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges19                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1056                            ; DW_AT_call_line
	.byte	30                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x15a:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges20                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1065                            ; DW_AT_call_line
	.byte	13                              ; DW_AT_call_column
	.byte	0                               ; End Of Children Mark
	.byte	6                               ; Abbrev [6] 0x168:0x15 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Ltmp3                          ; DW_AT_low_pc
	.long	.Ltmp4-.Ltmp3                   ; DW_AT_high_pc
	.byte	1                               ; DW_AT_call_file
	.short	1449                            ; DW_AT_call_line
	.byte	17                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x17d:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges21                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1448                            ; DW_AT_call_line
	.byte	17                              ; DW_AT_call_column
	.byte	5                               ; Abbrev [5] 0x18a:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges22                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	1461                            ; DW_AT_call_line
	.byte	50                              ; DW_AT_call_column
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.quad	.Ltmp0-.Lfunc_begin0
	.quad	.Ltmp3-.Lfunc_begin0
	.quad	.Ltmp5-.Lfunc_begin0
	.quad	.Ltmp6-.Lfunc_begin0
	.quad	.Ltmp17-.Lfunc_begin0
	.quad	.Ltmp18-.Lfunc_begin0
	.quad	.Ltmp19-.Lfunc_begin0
	.quad	.Ltmp20-.Lfunc_begin0
	.quad	.Ltmp21-.Lfunc_begin0
	.quad	.Ltmp22-.Lfunc_begin0
	.quad	.Ltmp23-.Lfunc_begin0
	.quad	.Ltmp24-.Lfunc_begin0
	.quad	.Ltmp25-.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	.Ltmp27-.Lfunc_begin0
	.quad	.Ltmp28-.Lfunc_begin0
	.quad	.Ltmp30-.Lfunc_begin0
	.quad	.Ltmp31-.Lfunc_begin0
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp37-.Lfunc_begin0
	.quad	.Ltmp38-.Lfunc_begin0
	.quad	.Ltmp39-.Lfunc_begin0
	.quad	.Ltmp40-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp61-.Lfunc_begin0
	.quad	.Ltmp62-.Lfunc_begin0
	.quad	.Ltmp238-.Lfunc_begin0
	.quad	.Ltmp239-.Lfunc_begin0
	.quad	.Ltmp240-.Lfunc_begin0
	.quad	.Ltmp241-.Lfunc_begin0
	.quad	.Ltmp242-.Lfunc_begin0
	.quad	.Ltmp243-.Lfunc_begin0
	.quad	.Ltmp244-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges1:
	.quad	.Ltmp0-.Lfunc_begin0
	.quad	.Ltmp1-.Lfunc_begin0
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp3-.Lfunc_begin0
	.quad	.Ltmp46-.Lfunc_begin0
	.quad	.Ltmp47-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.quad	.Ltmp53-.Lfunc_begin0
	.quad	.Ltmp54-.Lfunc_begin0
	.quad	.Ltmp55-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp63-.Lfunc_begin0
	.quad	.Ltmp64-.Lfunc_begin0
	.quad	.Ltmp75-.Lfunc_begin0
	.quad	.Ltmp76-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges2:
	.quad	.Ltmp1-.Lfunc_begin0
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp46-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	.Ltmp51-.Lfunc_begin0
	.quad	.Ltmp52-.Lfunc_begin0
	.quad	.Ltmp54-.Lfunc_begin0
	.quad	.Ltmp55-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	.Ltmp64-.Lfunc_begin0
	.quad	.Ltmp65-.Lfunc_begin0
	.quad	.Ltmp66-.Lfunc_begin0
	.quad	.Ltmp67-.Lfunc_begin0
	.quad	.Ltmp76-.Lfunc_begin0
	.quad	.Ltmp77-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges3:
	.quad	.Ltmp5-.Lfunc_begin0
	.quad	.Ltmp6-.Lfunc_begin0
	.quad	.Ltmp237-.Lfunc_begin0
	.quad	.Ltmp238-.Lfunc_begin0
	.quad	.Ltmp239-.Lfunc_begin0
	.quad	.Ltmp240-.Lfunc_begin0
	.quad	.Ltmp241-.Lfunc_begin0
	.quad	.Ltmp242-.Lfunc_begin0
	.quad	.Ltmp243-.Lfunc_begin0
	.quad	.Ltmp244-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges4:
	.quad	.Ltmp17-.Lfunc_begin0
	.quad	.Ltmp18-.Lfunc_begin0
	.quad	.Ltmp19-.Lfunc_begin0
	.quad	.Ltmp20-.Lfunc_begin0
	.quad	.Ltmp21-.Lfunc_begin0
	.quad	.Ltmp22-.Lfunc_begin0
	.quad	.Ltmp30-.Lfunc_begin0
	.quad	.Ltmp31-.Lfunc_begin0
	.quad	.Ltmp47-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges5:
	.quad	.Ltmp23-.Lfunc_begin0
	.quad	.Ltmp24-.Lfunc_begin0
	.quad	.Ltmp25-.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	.Ltmp27-.Lfunc_begin0
	.quad	.Ltmp28-.Lfunc_begin0
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp37-.Lfunc_begin0
	.quad	.Ltmp38-.Lfunc_begin0
	.quad	.Ltmp39-.Lfunc_begin0
	.quad	.Ltmp40-.Lfunc_begin0
	.quad	.Ltmp67-.Lfunc_begin0
	.quad	.Ltmp68-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges6:
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp69-.Lfunc_begin0
	.quad	.Ltmp70-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges7:
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	.Ltmp51-.Lfunc_begin0
	.quad	.Ltmp52-.Lfunc_begin0
	.quad	.Ltmp53-.Lfunc_begin0
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Ltmp72-.Lfunc_begin0
	.quad	.Ltmp77-.Lfunc_begin0
	.quad	.Ltmp78-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges8:
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	.Ltmp58-.Lfunc_begin0
	.quad	.Ltmp68-.Lfunc_begin0
	.quad	.Ltmp69-.Lfunc_begin0
	.quad	.Ltmp72-.Lfunc_begin0
	.quad	.Ltmp73-.Lfunc_begin0
	.quad	.Ltmp78-.Lfunc_begin0
	.quad	.Ltmp79-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges9:
	.quad	.Ltmp58-.Lfunc_begin0
	.quad	.Ltmp59-.Lfunc_begin0
	.quad	.Ltmp70-.Lfunc_begin0
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Ltmp73-.Lfunc_begin0
	.quad	.Ltmp74-.Lfunc_begin0
	.quad	.Ltmp79-.Lfunc_begin0
	.quad	.Ltmp80-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges10:
	.quad	.Ltmp59-.Lfunc_begin0
	.quad	.Ltmp60-.Lfunc_begin0
	.quad	.Ltmp62-.Lfunc_begin0
	.quad	.Ltmp63-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges11:
	.quad	.Ltmp60-.Lfunc_begin0
	.quad	.Ltmp61-.Lfunc_begin0
	.quad	.Ltmp196-.Lfunc_begin0
	.quad	.Ltmp197-.Lfunc_begin0
	.quad	.Ltmp198-.Lfunc_begin0
	.quad	.Ltmp199-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges12:
	.quad	.Ltmp81-.Lfunc_begin0
	.quad	.Ltmp82-.Lfunc_begin0
	.quad	.Ltmp83-.Lfunc_begin0
	.quad	.Ltmp84-.Lfunc_begin0
	.quad	.Ltmp85-.Lfunc_begin0
	.quad	.Ltmp86-.Lfunc_begin0
	.quad	.Ltmp87-.Lfunc_begin0
	.quad	.Ltmp88-.Lfunc_begin0
	.quad	.Ltmp91-.Lfunc_begin0
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp93-.Lfunc_begin0
	.quad	.Ltmp94-.Lfunc_begin0
	.quad	.Ltmp95-.Lfunc_begin0
	.quad	.Ltmp96-.Lfunc_begin0
	.quad	.Ltmp97-.Lfunc_begin0
	.quad	.Ltmp98-.Lfunc_begin0
	.quad	.Ltmp99-.Lfunc_begin0
	.quad	.Ltmp100-.Lfunc_begin0
	.quad	.Ltmp101-.Lfunc_begin0
	.quad	.Ltmp102-.Lfunc_begin0
	.quad	.Ltmp103-.Lfunc_begin0
	.quad	.Ltmp104-.Lfunc_begin0
	.quad	.Ltmp106-.Lfunc_begin0
	.quad	.Ltmp107-.Lfunc_begin0
	.quad	.Ltmp108-.Lfunc_begin0
	.quad	.Ltmp109-.Lfunc_begin0
	.quad	.Ltmp111-.Lfunc_begin0
	.quad	.Ltmp112-.Lfunc_begin0
	.quad	.Ltmp113-.Lfunc_begin0
	.quad	.Ltmp114-.Lfunc_begin0
	.quad	.Ltmp117-.Lfunc_begin0
	.quad	.Ltmp118-.Lfunc_begin0
	.quad	.Ltmp119-.Lfunc_begin0
	.quad	.Ltmp120-.Lfunc_begin0
	.quad	.Ltmp122-.Lfunc_begin0
	.quad	.Ltmp123-.Lfunc_begin0
	.quad	.Ltmp128-.Lfunc_begin0
	.quad	.Ltmp129-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges13:
	.quad	.Ltmp84-.Lfunc_begin0
	.quad	.Ltmp85-.Lfunc_begin0
	.quad	.Ltmp98-.Lfunc_begin0
	.quad	.Ltmp99-.Lfunc_begin0
	.quad	.Ltmp102-.Lfunc_begin0
	.quad	.Ltmp103-.Lfunc_begin0
	.quad	.Ltmp104-.Lfunc_begin0
	.quad	.Ltmp105-.Lfunc_begin0
	.quad	.Ltmp107-.Lfunc_begin0
	.quad	.Ltmp108-.Lfunc_begin0
	.quad	.Ltmp109-.Lfunc_begin0
	.quad	.Ltmp110-.Lfunc_begin0
	.quad	.Ltmp115-.Lfunc_begin0
	.quad	.Ltmp116-.Lfunc_begin0
	.quad	.Ltmp192-.Lfunc_begin0
	.quad	.Ltmp193-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges14:
	.quad	.Ltmp89-.Lfunc_begin0
	.quad	.Ltmp90-.Lfunc_begin0
	.quad	.Ltmp130-.Lfunc_begin0
	.quad	.Ltmp131-.Lfunc_begin0
	.quad	.Ltmp132-.Lfunc_begin0
	.quad	.Ltmp133-.Lfunc_begin0
	.quad	.Ltmp140-.Lfunc_begin0
	.quad	.Ltmp141-.Lfunc_begin0
	.quad	.Ltmp142-.Lfunc_begin0
	.quad	.Ltmp143-.Lfunc_begin0
	.quad	.Ltmp144-.Lfunc_begin0
	.quad	.Ltmp145-.Lfunc_begin0
	.quad	.Ltmp151-.Lfunc_begin0
	.quad	.Ltmp152-.Lfunc_begin0
	.quad	.Ltmp153-.Lfunc_begin0
	.quad	.Ltmp154-.Lfunc_begin0
	.quad	.Ltmp155-.Lfunc_begin0
	.quad	.Ltmp156-.Lfunc_begin0
	.quad	.Ltmp157-.Lfunc_begin0
	.quad	.Ltmp158-.Lfunc_begin0
	.quad	.Ltmp159-.Lfunc_begin0
	.quad	.Ltmp160-.Lfunc_begin0
	.quad	.Ltmp161-.Lfunc_begin0
	.quad	.Ltmp162-.Lfunc_begin0
	.quad	.Ltmp163-.Lfunc_begin0
	.quad	.Ltmp164-.Lfunc_begin0
	.quad	.Ltmp165-.Lfunc_begin0
	.quad	.Ltmp166-.Lfunc_begin0
	.quad	.Ltmp167-.Lfunc_begin0
	.quad	.Ltmp168-.Lfunc_begin0
	.quad	.Ltmp169-.Lfunc_begin0
	.quad	.Ltmp170-.Lfunc_begin0
	.quad	.Ltmp171-.Lfunc_begin0
	.quad	.Ltmp172-.Lfunc_begin0
	.quad	.Ltmp173-.Lfunc_begin0
	.quad	.Ltmp174-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges15:
	.quad	.Ltmp112-.Lfunc_begin0
	.quad	.Ltmp113-.Lfunc_begin0
	.quad	.Ltmp114-.Lfunc_begin0
	.quad	.Ltmp115-.Lfunc_begin0
	.quad	.Ltmp118-.Lfunc_begin0
	.quad	.Ltmp119-.Lfunc_begin0
	.quad	.Ltmp200-.Lfunc_begin0
	.quad	.Ltmp201-.Lfunc_begin0
	.quad	.Ltmp202-.Lfunc_begin0
	.quad	.Ltmp203-.Lfunc_begin0
	.quad	.Ltmp204-.Lfunc_begin0
	.quad	.Ltmp205-.Lfunc_begin0
	.quad	.Ltmp210-.Lfunc_begin0
	.quad	.Ltmp211-.Lfunc_begin0
	.quad	.Ltmp212-.Lfunc_begin0
	.quad	.Ltmp213-.Lfunc_begin0
	.quad	.Ltmp214-.Lfunc_begin0
	.quad	.Ltmp215-.Lfunc_begin0
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	.Ltmp220-.Lfunc_begin0
	.quad	.Ltmp221-.Lfunc_begin0
	.quad	.Ltmp222-.Lfunc_begin0
	.quad	.Ltmp223-.Lfunc_begin0
	.quad	.Ltmp224-.Lfunc_begin0
	.quad	.Ltmp225-.Lfunc_begin0
	.quad	.Ltmp226-.Lfunc_begin0
	.quad	.Ltmp227-.Lfunc_begin0
	.quad	.Ltmp228-.Lfunc_begin0
	.quad	.Ltmp229-.Lfunc_begin0
	.quad	.Ltmp230-.Lfunc_begin0
	.quad	.Ltmp231-.Lfunc_begin0
	.quad	.Ltmp232-.Lfunc_begin0
	.quad	.Ltmp233-.Lfunc_begin0
	.quad	.Ltmp234-.Lfunc_begin0
	.quad	.Ltmp235-.Lfunc_begin0
	.quad	.Ltmp236-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges16:
	.quad	.Ltmp120-.Lfunc_begin0
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp124-.Lfunc_begin0
	.quad	.Ltmp125-.Lfunc_begin0
	.quad	.Ltmp205-.Lfunc_begin0
	.quad	.Ltmp206-.Lfunc_begin0
	.quad	.Ltmp207-.Lfunc_begin0
	.quad	.Ltmp208-.Lfunc_begin0
	.quad	.Ltmp209-.Lfunc_begin0
	.quad	.Ltmp210-.Lfunc_begin0
	.quad	.Ltmp216-.Lfunc_begin0
	.quad	.Ltmp217-.Lfunc_begin0
	.quad	.Ltmp218-.Lfunc_begin0
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges17:
	.quad	.Ltmp126-.Lfunc_begin0
	.quad	.Ltmp127-.Lfunc_begin0
	.quad	.Ltmp194-.Lfunc_begin0
	.quad	.Ltmp195-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges18:
	.quad	.Ltmp133-.Lfunc_begin0
	.quad	.Ltmp134-.Lfunc_begin0
	.quad	.Ltmp135-.Lfunc_begin0
	.quad	.Ltmp136-.Lfunc_begin0
	.quad	.Ltmp137-.Lfunc_begin0
	.quad	.Ltmp138-.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.quad	.Ltmp140-.Lfunc_begin0
	.quad	.Ltmp146-.Lfunc_begin0
	.quad	.Ltmp147-.Lfunc_begin0
	.quad	.Ltmp148-.Lfunc_begin0
	.quad	.Ltmp149-.Lfunc_begin0
	.quad	.Ltmp150-.Lfunc_begin0
	.quad	.Ltmp151-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges19:
	.quad	.Ltmp175-.Lfunc_begin0
	.quad	.Ltmp176-.Lfunc_begin0
	.quad	.Ltmp177-.Lfunc_begin0
	.quad	.Ltmp178-.Lfunc_begin0
	.quad	.Ltmp179-.Lfunc_begin0
	.quad	.Ltmp180-.Lfunc_begin0
	.quad	.Ltmp181-.Lfunc_begin0
	.quad	.Ltmp182-.Lfunc_begin0
	.quad	.Ltmp183-.Lfunc_begin0
	.quad	.Ltmp184-.Lfunc_begin0
	.quad	.Ltmp185-.Lfunc_begin0
	.quad	.Ltmp186-.Lfunc_begin0
	.quad	.Ltmp187-.Lfunc_begin0
	.quad	.Ltmp188-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges20:
	.quad	.Ltmp189-.Lfunc_begin0
	.quad	.Ltmp190-.Lfunc_begin0
	.quad	.Ltmp191-.Lfunc_begin0
	.quad	.Ltmp192-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges21:
	.quad	.Ltmp7-.Lfunc_begin0
	.quad	.Ltmp8-.Lfunc_begin0
	.quad	.Ltmp9-.Lfunc_begin0
	.quad	.Ltmp10-.Lfunc_begin0
	.quad	.Ltmp11-.Lfunc_begin0
	.quad	.Ltmp12-.Lfunc_begin0
	.quad	.Ltmp13-.Lfunc_begin0
	.quad	.Ltmp14-.Lfunc_begin0
	.quad	.Ltmp15-.Lfunc_begin0
	.quad	.Ltmp16-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges22:
	.quad	.Ltmp29-.Lfunc_begin0
	.quad	.Ltmp30-.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	.Ltmp33-.Lfunc_begin0
	.quad	.Ltmp34-.Lfunc_begin0
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp37-.Lfunc_begin0
	.quad	.Ltmp38-.Lfunc_begin0
	.quad	.Ltmp39-.Lfunc_begin0
	.quad	.Ltmp41-.Lfunc_begin0
	.quad	.Ltmp42-.Lfunc_begin0
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp61-.Lfunc_begin0
	.quad	.Ltmp62-.Lfunc_begin0
	.quad	0
	.quad	0
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"triton"                        ; string offset=0 ; triton
.Linfo_string1:
	.asciz	"mxfp_gemm_gfx1250.py"          ; string offset=7 ; mxfp_gemm_gfx1250.py
.Linfo_string2:
	.asciz	"/var/asorenso/triton-mi450-internal/third_party/amd/python/examples/gluon" ; string offset=28 ; /var/asorenso/triton-mi450-internal/third_party/amd/python/examples/gluon
.Linfo_string3:
	.asciz	"mxgemm_tdm_pipelined_kernel"   ; string offset=102 ; mxgemm_tdm_pipelined_kernel
	.section	".note.GNU-stack","",@progbits
	.amdgpu_metadata
---
amdhsa.kernels:
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .offset:         32
        .size:           4
        .value_kind:     by_value
      - .offset:         36
        .size:           4
        .value_kind:     by_value
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         44
        .size:           4
        .value_kind:     by_value
      - .offset:         48
        .size:           4
        .value_kind:     by_value
      - .offset:         52
        .size:           4
        .value_kind:     by_value
      - .offset:         56
        .size:           4
        .value_kind:     by_value
      - .address_space:  global
        .offset:         64
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         72
        .size:           8
        .value_kind:     global_buffer
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 80
    .max_flat_workgroup_size: 128
    .name:           mxgemm_tdm_pipelined_kernel
    .private_segment_fixed_size: 1624
    .sgpr_count:     76
    .sgpr_spill_count: 0
    .symbol:         mxgemm_tdm_pipelined_kernel.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     1024
    .vgpr_spill_count: 805
    .wavefront_size: 32
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx1250
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
	.section	.debug_line,"",@progbits
.Lline_table_start0:
