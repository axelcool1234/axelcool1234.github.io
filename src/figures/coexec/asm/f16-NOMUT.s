	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx1250"
	.amdhsa_code_object_version 5
	.text
	.globl	gemm_tdm_pipelined_single_warp_per_simd_schedule_kernel ; -- Begin function gemm_tdm_pipelined_single_warp_per_simd_schedule_kernel
	.p2align	8
	.type	gemm_tdm_pipelined_single_warp_per_simd_schedule_kernel,@function
gemm_tdm_pipelined_single_warp_per_simd_schedule_kernel: ; @gemm_tdm_pipelined_single_warp_per_simd_schedule_kernel
.Lfunc_begin0:
	.file	1 "/var/asorenso/triton-mi450-internal/third_party/amd/python/examples/gluon" "f16_gemm_gfx1250.py"
	.loc	1 307 0                         ; f16_gemm_gfx1250.py:307:0
	.cfi_sections .debug_frame
	.cfi_startproc
; %bb.0:                                ; %.lr.ph
	.cfi_escape 0x0f, 0x04, 0x30, 0x36, 0xe9, 0x02 ; CFA is 0 in private_wave aspace
	.cfi_undefined 16
	s_setreg_imm32_b32 hwreg(HW_REG_WAVE_MODE, 25, 1), 1 ;  msbs: dst=0 src0=0 src1=0 src2=0
	s_mov_b32 s29, s8
	s_mov_b32 s17, s11
	s_mov_b32 s25, s12
	s_mov_b32 s28, s9
	s_mov_b32 s30, s13
.Ltmp0:
	.file	2 "/var/asorenso/triton-mi450-internal/third_party/amd/python/examples/gluon" "f16_gemm_common_gfx1250.py"
	.loc	2 284 9 prologue_end            ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:361:14 ]
	v_lshlrev_b32_e32 v1, 8, v0
	s_set_vgpr_msb 64                       ;  msbs: dst=1 src0=0 src1=0 src2=0
	v_and_b32_e32 v96 /*v352*/, 16, v0
	s_set_vgpr_msb 0x4000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	v_mov_b32_e32 v224, 0
.Ltmp1:
	.file	3 "/var/asorenso/triton-mi450-internal/python/triton/language" "standard.py"
	.loc	3 43 13                         ; standard.py:43:13 @[ f16_gemm_gfx1250.py:337:17 ]
	s_add_co_i32 s0, s8, 0xff
.Ltmp2:
	.loc	1 419 5                         ; f16_gemm_gfx1250.py:419:5
	s_bfe_u32 s11, ttmp8, 0x50019
	s_set_vgpr_msb 64                       ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp3:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:361:14 ]
	v_and_b32_e32 v97 /*v353*/, 0xf00, v1
	s_set_vgpr_msb 0x4000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	v_lshl_or_b32 v188, s11, 12, v0
	v_dual_mov_b32 v225, v224 :: v_dual_mov_b32 v226, v224
	v_dual_mov_b32 v227, v224 :: v_dual_mov_b32 v228, v224
	v_dual_mov_b32 v229, v224 :: v_dual_mov_b32 v230, v224
	v_dual_mov_b32 v231, v224 :: v_dual_mov_b32 v232, v224
	v_dual_mov_b32 v233, v224 :: v_dual_mov_b32 v234, v224
	v_dual_mov_b32 v235, v224 :: v_dual_mov_b32 v236, v224
	v_dual_mov_b32 v237, v224 :: v_dual_mov_b32 v238, v224
	v_dual_mov_b32 v239, v224 :: v_dual_mov_b32 v216, v224
	v_dual_mov_b32 v217, v224 :: v_dual_mov_b32 v218, v224
	v_dual_mov_b32 v219, v224 :: v_dual_mov_b32 v220, v224
	v_dual_mov_b32 v221, v224 :: v_dual_mov_b32 v222, v224
	v_dual_mov_b32 v223, v224 :: v_dual_mov_b32 v200, v224
	v_dual_mov_b32 v201, v224 :: v_dual_mov_b32 v202, v224
	v_dual_mov_b32 v203, v224 :: v_dual_mov_b32 v204, v224
	v_dual_mov_b32 v205, v224 :: v_dual_mov_b32 v206, v224
	v_dual_mov_b32 v207, v224 :: v_dual_mov_b32 v168, v224
	v_dual_mov_b32 v169, v224 :: v_dual_mov_b32 v170, v224
	v_dual_mov_b32 v171, v224 :: v_dual_mov_b32 v172, v224
	v_dual_mov_b32 v173, v224 :: v_dual_mov_b32 v174, v224
	v_dual_mov_b32 v175, v224 :: v_dual_mov_b32 v144, v224
	v_dual_mov_b32 v145, v224 :: v_dual_mov_b32 v146, v224
	v_dual_mov_b32 v147, v224 :: v_dual_mov_b32 v148, v224
	v_dual_mov_b32 v149, v224 :: v_dual_mov_b32 v150, v224
	v_dual_mov_b32 v151, v224 :: v_dual_mov_b32 v136, v224
	v_dual_mov_b32 v137, v224 :: v_dual_mov_b32 v138, v224
	v_dual_mov_b32 v139, v224 :: v_dual_mov_b32 v140, v224
	v_dual_mov_b32 v141, v224 :: v_dual_mov_b32 v142, v224
	v_dual_mov_b32 v143, v224 :: v_dual_mov_b32 v128, v224
	v_dual_mov_b32 v129, v224 :: v_dual_mov_b32 v130, v224
	v_dual_mov_b32 v131, v224 :: v_dual_mov_b32 v132, v224
	v_dual_mov_b32 v133, v224 :: v_dual_mov_b32 v134, v224
	v_dual_mov_b32 v135, v224 :: v_dual_mov_b32 v112, v224
	v_dual_mov_b32 v113, v224 :: v_dual_mov_b32 v114, v224
	v_dual_mov_b32 v115, v224 :: v_dual_mov_b32 v116, v224
	v_dual_mov_b32 v117, v224 :: v_dual_mov_b32 v118, v224
	v_dual_mov_b32 v119, v224 :: v_dual_mov_b32 v96, v224
	v_dual_mov_b32 v97, v224 :: v_dual_mov_b32 v98, v224
	v_dual_mov_b32 v99, v224 :: v_dual_mov_b32 v100, v224
	v_dual_mov_b32 v101, v224 :: v_dual_mov_b32 v102, v224
	v_dual_mov_b32 v103, v224 :: v_dual_mov_b32 v72, v224
	v_dual_mov_b32 v73, v224 :: v_dual_mov_b32 v74, v224
	v_dual_mov_b32 v75, v224 :: v_dual_mov_b32 v76, v224
	v_dual_mov_b32 v77, v224 :: v_dual_mov_b32 v78, v224
	v_dual_mov_b32 v79, v224 :: v_dual_mov_b32 v56, v224
	v_dual_mov_b32 v57, v224 :: v_dual_mov_b32 v58, v224
	v_dual_mov_b32 v59, v224 :: v_dual_mov_b32 v60, v224
	v_dual_mov_b32 v61, v224 :: v_dual_mov_b32 v62, v224
	v_dual_mov_b32 v63, v224 :: v_dual_mov_b32 v40, v224
	v_dual_mov_b32 v41, v224 :: v_dual_mov_b32 v42, v224
	v_dual_mov_b32 v43, v224 :: v_dual_mov_b32 v44, v224
	v_dual_mov_b32 v45, v224 :: v_dual_mov_b32 v46, v224
	v_dual_mov_b32 v47, v224 :: v_dual_mov_b32 v32, v224
	v_dual_mov_b32 v33, v224 :: v_dual_mov_b32 v34, v224
	v_dual_mov_b32 v35, v224 :: v_dual_mov_b32 v36, v224
	v_dual_mov_b32 v37, v224 :: v_dual_mov_b32 v38, v224
	v_dual_mov_b32 v39, v224 :: v_dual_mov_b32 v24, v224
	v_dual_mov_b32 v25, v224 :: v_dual_mov_b32 v26, v224
	v_dual_mov_b32 v27, v224 :: v_dual_mov_b32 v28, v224
	v_dual_mov_b32 v29, v224 :: v_dual_mov_b32 v30, v224
	v_mov_b32_e32 v31, v224
.Ltmp4:
	.loc	3 43 12                         ; standard.py:43:12 @[ f16_gemm_gfx1250.py:337:17 ]
	s_ashr_i32 s1, s0, 31
	v_mov_b32_e32 v8, v224
	s_lshr_b32 s1, s1, 24
	v_mov_b32_e32 v9, v224
	s_add_co_i32 s0, s0, s1
	v_mov_b32_e32 v10, v224
	s_ashr_i32 s1, s0, 8
	v_mov_b32_e32 v11, v224
.Ltmp5:
	.loc	1 339 13                        ; f16_gemm_gfx1250.py:339:13
	s_abs_i32 s8, s1
	v_mov_b32_e32 v12, v224
	s_cvt_f32_u32 s0, s8
	v_mov_b32_e32 v13, v224
	s_abs_i32 s9, ttmp9
	v_mov_b32_e32 v14, v224
	v_s_rcp_f32 s13, s0
	v_dual_mov_b32 v15, v224 :: v_dual_mov_b32 v16, v224
	v_dual_mov_b32 v17, v224 :: v_dual_mov_b32 v18, v224
	v_dual_mov_b32 v19, v224 :: v_dual_mov_b32 v20, v224
	v_dual_mov_b32 v21, v224 :: v_dual_mov_b32 v22, v224
	v_dual_mov_b32 v23, v224 :: v_dual_mov_b32 v0, v224
	v_dual_mov_b32 v1, v224 :: v_dual_mov_b32 v2, v224
	v_dual_mov_b32 v3, v224 :: v_dual_mov_b32 v4, v224
	v_dual_mov_b32 v5, v224 :: v_dual_mov_b32 v6, v224
	s_mov_b32 s19, 0
	s_mov_b32 s0, 1
.Ltmp6:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:357:20 ]
	s_mov_b32 s16, 64
	s_mov_b32 s12, 0x7510000
.Ltmp7:
	.loc	1 339 13                        ; f16_gemm_gfx1250.py:339:13
	s_xor_b32 s14, ttmp9, s1
	s_mul_f32 s13, s13, 0x4f7ffffe
	s_ashr_i32 s15, s14, 31
	s_sub_co_i32 s18, 0, s8
.Ltmp8:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:357:20 ]
	s_mov_b32 s14, s17
.Ltmp9:
	.loc	1 339 13                        ; f16_gemm_gfx1250.py:339:13
	s_cvt_u32_f32 s13, s13
.Ltmp10:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:357:20 ]
	s_mov_b32 s37, s19
	s_mov_b32 s24, 32
	s_mov_b32 s35, s19
.Ltmp11:
	.loc	1 339 13                        ; f16_gemm_gfx1250.py:339:13
	s_mul_i32 s18, s18, s13
.Ltmp12:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:357:20 ]
	s_mov_b32 s22, s25
.Ltmp13:
	.loc	1 339 13                        ; f16_gemm_gfx1250.py:339:13
	s_mul_hi_u32 s18, s13, s18
.Ltmp14:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:357:20 ]
	s_mov_b32 s20, s12
	v_mov_b32_e32 v7, v224
.Ltmp15:
	.loc	1 339 13                        ; f16_gemm_gfx1250.py:339:13
	s_add_co_i32 s13, s13, s18
	v_mov_b32_e32 v48, v224
	s_mul_hi_u32 s13, s9, s13
	v_mov_b32_e32 v49, v224
	s_mul_i32 s18, s13, s8
	v_mov_b32_e32 v50, v224
	s_sub_co_i32 s9, s9, s18
	v_mov_b32_e32 v51, v224
	s_add_co_i32 s18, s13, 1
	v_mov_b32_e32 v52, v224
	s_sub_co_i32 s21, s9, s8
	v_mov_b32_e32 v53, v224
	s_cmp_ge_u32 s9, s8
	v_mov_b32_e32 v54, v224
	s_cselect_b32 s13, s18, s13
	v_mov_b32_e32 v55, v224
	s_cselect_b32 s9, s21, s9
	v_mov_b32_e32 v64, v224
	s_add_co_i32 s18, s13, 1
	v_mov_b32_e32 v65, v224
	s_cmp_ge_u32 s9, s8
	v_mov_b32_e32 v66, v224
	s_cselect_b32 s8, s18, s13
	v_mov_b32_e32 v67, v224
	s_xor_b32 s8, s8, s15
	v_mov_b32_e32 v68, v224
	s_sub_co_i32 s21, s8, s15
	v_mov_b32_e32 v69, v224
	.loc	1 338 13                        ; f16_gemm_gfx1250.py:338:13
	s_mul_i32 s1, s21, s1
	v_mov_b32_e32 v70, v224
	s_sub_co_i32 s54, ttmp9, s1
	v_mov_b32_e32 v71, v224
	.loc	1 341 62                        ; f16_gemm_gfx1250.py:341:62
	s_lshl_b32 s38, s54, 8
	v_mov_b32_e32 v80, v224
	s_mul_i32 s8, s38, s17
	v_mov_b32_e32 v81, v224
.Ltmp16:
	.loc	2 121 63                        ; f16_gemm_common_gfx1250.py:121:63 @[ f16_gemm_gfx1250.py:341:22 ]
	s_ashr_i32 s9, s8, 31
	v_mov_b32_e32 v82, v224
	s_lshl_b64 s[8:9], s[8:9], 1
	v_mov_b32_e32 v83, v224
	s_add_nc_u64 s[8:9], s[2:3], s[8:9]
	v_mov_b32_e32 v84, v224
	.loc	2 121 14 is_stmt 0              ; f16_gemm_common_gfx1250.py:121:14 @[ f16_gemm_gfx1250.py:341:22 ]
	s_ashr_i32 s1, s17, 31
	v_mov_b32_e32 v85, v224
	s_and_b32 s18, s1, 0xffff
	v_mov_b32_e32 v86, v224
	s_bitset1_b32 s9, 31
	v_mov_b32_e32 v87, v224
.Ltmp17:
	.loc	2 170 5 is_stmt 1               ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:357:20 ]
	s_and_b32 s33, s11, 3
	v_mov_b32_e32 v88, v224
	s_mul_i32 s31, s33, 0x2200
	v_mov_b32_e32 v89, v224
	s_lshl1_add_u32 s1, s31, 0
	v_mov_b32_e32 v90, v224
	s_mov_b32 s15, s18
	v_mov_b32_e32 v91, v224
	s_lshl_b32 s36, s33, 7
	v_mov_b32_e32 v92, v224
	s_mul_u64 s[42:43], s[36:37], s[14:15]
	v_mov_b32_e32 v93, v224
	s_add_nc_u64 s[2:3], s[8:9], s[42:43]
	v_mov_b32_e32 v94, v224
	s_max_i32 s45, s29, 0
	v_mov_b32_e32 v95, v224
	s_max_i32 s50, s10, 0
	v_mov_b32_e32 v104, v224
	s_lshl_b32 s34, s33, 6
	v_mov_b32_e32 v105, v224
	s_sub_co_i32 s13, s45, s34
	v_mov_b32_e32 v106, v224
	s_max_i32 s51, s13, 0
	v_mov_b32_e32 v107, v224
	s_lshl_b32 s13, s50, 16
	v_mov_b32_e32 v108, v224
	s_lshr_b64 s[14:15], s[50:51], 16
	v_mov_b32_e32 v109, v224
	s_lshr_b32 s15, s51, 16
	v_mov_b32_e32 v110, v224
	s_bitset1_b32 s15, 23
	v_mov_b32_e32 v111, v224
	tensor_load_to_lds s[0:3], s[12:19]
	v_dual_mov_b32 v120, v224 :: v_dual_mov_b32 v121, v224
	v_dual_mov_b32 v122, v224 :: v_dual_mov_b32 v123, v224
	v_dual_mov_b32 v124, v224 :: v_dual_mov_b32 v125, v224
	v_mov_b32_e32 v126, v224
.Ltmp18:
	.loc	1 341 91                        ; f16_gemm_gfx1250.py:341:91
	s_lshl_b32 s40, s21, 7
.Ltmp19:
	.loc	2 129 18                        ; f16_gemm_common_gfx1250.py:129:18 @[ f16_gemm_gfx1250.py:341:22 ]
	s_ashr_i32 s3, s25, 31
.Ltmp20:
	.loc	1 341 91                        ; f16_gemm_gfx1250.py:341:91
	s_mul_i32 s2, s40, s25
.Ltmp21:
	.loc	2 129 18                        ; f16_gemm_common_gfx1250.py:129:18 @[ f16_gemm_gfx1250.py:341:22 ]
	s_and_b32 s26, s3, 0xffff
	.loc	2 129 67 is_stmt 0              ; f16_gemm_common_gfx1250.py:129:67 @[ f16_gemm_gfx1250.py:341:22 ]
	s_ashr_i32 s3, s2, 31
.Ltmp22:
	.loc	2 176 9 is_stmt 1               ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:357:20 ]
	s_mul_i32 s39, s33, 0x1100
.Ltmp23:
	.loc	2 129 67                        ; f16_gemm_common_gfx1250.py:129:67 @[ f16_gemm_gfx1250.py:341:22 ]
	s_lshl_b64 s[2:3], s[2:3], 1
.Ltmp24:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:357:20 ]
	s_lshl1_add_u32 s44, s39, 0x32ff0
	v_mov_b32_e32 v127, v224
.Ltmp25:
	.loc	2 129 67                        ; f16_gemm_common_gfx1250.py:129:67 @[ f16_gemm_gfx1250.py:341:22 ]
	s_add_nc_u64 s[4:5], s[4:5], s[2:3]
	v_mov_b32_e32 v152, v224
	.loc	2 129 18 is_stmt 0              ; f16_gemm_common_gfx1250.py:129:18 @[ f16_gemm_gfx1250.py:341:22 ]
	s_bitset1_b32 s5, 31
	v_mov_b32_e32 v153, v224
.Ltmp26:
	.loc	2 176 9 is_stmt 1               ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:357:20 ]
	s_mov_b64 s[58:59], s[2:3]
	s_mov_b64 s[56:57], s[0:1]
	v_mov_b32_e32 v154, v224
	s_mov_b32 s57, s44
	v_mov_b32_e32 v155, v224
	s_mov_b32 s23, s26
	v_mov_b32_e32 v156, v224
	s_mul_u64 s[46:47], s[22:23], s[34:35]
	v_mov_b32_e32 v157, v224
	s_add_nc_u64 s[58:59], s[4:5], s[46:47]
	v_mov_b32_e32 v158, v224
	s_max_i32 s49, s28, 0
	v_mov_b32_e32 v159, v224
	s_lshl_b32 s48, s33, 5
	v_mov_b32_e32 v160, v224
	s_sub_co_i32 s2, s49, s48
	v_mov_b32_e32 v161, v224
	s_max_i32 s53, s2, 0
	v_mov_b32_e32 v162, v224
	s_mov_b32 s52, s50
	v_mov_b32_e32 v163, v224
	s_lshr_b64 s[22:23], s[52:53], 16
	v_mov_b32_e32 v164, v224
	s_lshr_b32 s2, s53, 16
	v_mov_b32_e32 v165, v224
	s_or_b32 s23, s2, 0x800000
	v_mov_b32_e32 v166, v224
	s_mov_b32 s27, s19
	v_mov_b32_e32 v167, v224
	s_mov_b32 s21, s13
	v_mov_b32_e32 v176, v224
	tensor_load_to_lds s[56:59], s[20:27]
	v_dual_mov_b32 v177, v224 :: v_dual_mov_b32 v178, v224
	v_dual_mov_b32 v179, v224 :: v_dual_mov_b32 v180, v224
	v_dual_mov_b32 v181, v224 :: v_dual_mov_b32 v182, v224
	v_mov_b32_e32 v183, v224
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:357:20 ]
	s_add_nc_u64 s[2:3], s[8:9], 0x100
	s_add_co_i32 s13, s10, 0xffffff80
	s_add_co_i32 s14, s1, 0x11000
	s_max_i32 s50, s13, 0
	s_mov_b64 s[58:59], s[2:3]
	s_mov_b64 s[56:57], s[0:1]
	s_mov_b32 s57, s14
	s_add_nc_u64 s[58:59], s[2:3], s[42:43]
	s_lshl_b32 s13, s50, 16
	v_mov_b32_e32 v192, v224
	s_lshr_b64 s[2:3], s[50:51], 16
	v_mov_b32_e32 v193, v224
	s_mov_b32 s14, s2
	v_mov_b32_e32 v194, v224
	tensor_load_to_lds s[56:59], s[12:19]
	v_dual_mov_b32 v195, v224 :: v_dual_mov_b32 v196, v224
	v_dual_mov_b32 v197, v224 :: v_dual_mov_b32 v198, v224
	v_dual_mov_b32 v199, v224 :: v_dual_mov_b32 v184, v224
	v_mov_b32_e32 v185, v224
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:357:20 ]
	s_add_nc_u64 s[2:3], s[4:5], 0x100
	s_add_co_i32 s14, s44, 0x8800
	s_mov_b64 s[58:59], s[2:3]
	s_mov_b64 s[56:57], s[0:1]
	s_mov_b32 s57, s14
	s_add_nc_u64 s[58:59], s[2:3], s[46:47]
	s_mov_b32 s52, s50
	s_mov_b32 s21, s13
	s_lshr_b64 s[2:3], s[52:53], 16
	v_mov_b32_e32 v186, v224
	s_mov_b32 s22, s2
	v_mov_b32_e32 v187, v224
	tensor_load_to_lds s[56:59], s[20:27]
	s_set_vgpr_msb 16                       ;  msbs: dst=0 src0=0 src1=0 src2=1
.Ltmp27:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:361:14 ]
	v_and_or_b32 v212, 0x1010, v188, v97 /*v353*/
	v_dual_mov_b32 v188, v224 :: v_dual_mov_b32 v189, v224
	v_dual_mov_b32 v190, v224 :: v_dual_mov_b32 v191, v224
	v_dual_mov_b32 v208, v224 :: v_dual_lshrrev_b32 v209, 4, v212
.Ltmp28:
	.loc	1 359 5                         ; f16_gemm_gfx1250.py:359:5
	s_wait_tensorcnt 0x2
	s_barrier_signal -1
.Ltmp29:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:361:14 ]
	s_lshl_b32 s0, s11, 11
.Ltmp30:
	.loc	3 43 13                         ; standard.py:43:13 @[ f16_gemm_gfx1250.py:364:15 ]
	s_add_co_i32 s13, s10, 0x7f
.Ltmp31:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:361:14 ]
	s_and_b32 s35, s0, 0x1000
.Ltmp32:
	.loc	3 43 12                         ; standard.py:43:12 @[ f16_gemm_gfx1250.py:364:15 ]
	s_ashr_i32 s0, s13, 31
.Ltmp33:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:369:16 ]
	s_add_nc_u64 s[2:3], s[8:9], 0x200
.Ltmp34:
	.loc	3 43 12                         ; standard.py:43:12 @[ f16_gemm_gfx1250.py:364:15 ]
	s_lshr_b32 s0, s0, 25
.Ltmp35:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:369:16 ]
	s_add_nc_u64 s[2:3], s[2:3], s[42:43]
.Ltmp36:
	.loc	3 43 12                         ; standard.py:43:12 @[ f16_gemm_gfx1250.py:364:15 ]
	s_add_co_i32 s0, s13, s0
	s_set_vgpr_msb 0x1005                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp37:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:361:14 ]
	v_or3_b32 v215, v97 /*v353*/, v96 /*v352*/, s35
	s_set_vgpr_msb 0x500                    ;  msbs: dst=0 src0=0 src1=0 src2=0
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:361:14 ]
	v_and_b32_e32 v213, 0x1f0, v209
	v_dual_mov_b32 v209, v224 :: v_dual_mov_b32 v210, v224
	v_dual_mov_b32 v211, v224 :: v_dual_lshrrev_b32 v214, 4, v215
	s_set_vgpr_msb 64                       ;  msbs: dst=1 src0=0 src1=0 src2=0
	v_add_nc_u32_e32 v98 /*v354*/, v213, v212
	s_set_vgpr_msb 0x4000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	v_dual_mov_b32 v212, v224 :: v_dual_mov_b32 v213, v224
.Ltmp38:
	.loc	3 43 12                         ; standard.py:43:12 @[ f16_gemm_gfx1250.py:364:15 ]
	s_ashr_i32 s41, s0, 7
.Ltmp39:
	.loc	1 368 13                        ; f16_gemm_gfx1250.py:368:13
	s_cmp_gt_i32 s13, 0x17f
	s_mov_b32 s52, 3
	s_cselect_b32 s0, -1, 0
	s_and_b32 s0, s0, exec_lo
	s_cselect_b32 s0, 1, 0
.Ltmp40:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:369:16 ]
	s_add_co_i32 s13, s10, 0xffffff00
	s_add_co_i32 s1, s1, 0x22000
.Ltmp41:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:361:14 ]
	v_and_b32_e32 v240, 0x1f0, v214
.Ltmp42:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:369:16 ]
	s_max_i32 s50, s13, 0
	s_set_vgpr_msb 4                        ;  msbs: dst=0 src0=0 src1=1 src2=0
.Ltmp43:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:361:14 ]
	v_add_nc_u32_e32 v242, 0x32ff0, v98 /*v354*/
.Ltmp44:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:369:16 ]
	s_lshl_b32 s13, s50, 16
	v_mov_b32_e32 v214, v224
	s_lshr_b64 s[56:57], s[50:51], 16
	s_set_vgpr_msb 0x440                    ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp45:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:361:14 ]
	v_add_nc_u32_e32 v99 /*v355*/, v240, v215
.Ltmp46:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:369:16 ]
	s_mov_b32 s14, s56
	s_set_vgpr_msb 0x4000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp47:
	.loc	1 359 5                         ; f16_gemm_gfx1250.py:359:5
	s_barrier_wait -1
	v_mov_b32_e32 v215, v224
	s_set_vgpr_msb 0x44                     ;  msbs: dst=1 src0=0 src1=1 src2=0
.Ltmp48:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:361:14 ]
	v_add_nc_u32_e32 v36 /*v292*/, 0, v99 /*v355*/
	s_set_vgpr_msb 0x4400                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	v_dual_mov_b32 v240, v224 :: v_dual_mov_b32 v241, v224
	s_mov_b32 s58, s19
	s_set_vgpr_msb 64                       ;  msbs: dst=1 src0=0 src1=0 src2=0
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:361:14 ]
	ds_load_b128 v[24:27] /*v[280:283]*/, v242
	ds_load_b128 v[28:31] /*v[284:287]*/, v242 offset:32
	ds_load_b128 v[16:19] /*v[272:275]*/, v242 offset:8704
	ds_load_b128 v[20:23] /*v[276:279]*/, v242 offset:8736
	ds_load_b128 v[8:11] /*v[264:267]*/, v242 offset:17408
	ds_load_b128 v[12:15] /*v[268:271]*/, v242 offset:17440
	ds_load_b128 v[0:3] /*v[256:259]*/, v242 offset:26112
	ds_load_b128 v[4:7] /*v[260:263]*/, v242 offset:26144
	s_set_vgpr_msb 0x4000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	v_mov_b32_e32 v242, v224
.Ltmp49:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:357:20 ]
	s_and_b32 s21, s49, 0x7fff0000
	s_set_vgpr_msb 0x41                     ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp50:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:361:14 ]
	ds_load_b128 v[88:91] /*v[344:347]*/, v36 /*v292*/
	ds_load_b128 v[92:95] /*v[348:351]*/, v36 /*v292*/ offset:32
	ds_load_b128 v[80:83] /*v[336:339]*/, v36 /*v292*/ offset:8704
	ds_load_b128 v[84:87] /*v[340:343]*/, v36 /*v292*/ offset:8736
	ds_load_b128 v[72:75] /*v[328:331]*/, v36 /*v292*/ offset:17408
	ds_load_b128 v[76:79] /*v[332:335]*/, v36 /*v292*/ offset:17440
	ds_load_b128 v[64:67] /*v[320:323]*/, v36 /*v292*/ offset:26112
	ds_load_b128 v[68:71] /*v[324:327]*/, v36 /*v292*/ offset:26144
	s_set_vgpr_msb 0x4100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	v_mov_b32_e32 v243, v224
.Ltmp51:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:357:20 ]
	s_and_b32 s22, s45, 0x7fff0000
	v_mov_b32_e32 v244, v224
.Ltmp52:
	.loc	1 374 5                         ; f16_gemm_gfx1250.py:374:5
	s_sub_co_i32 s55, 3, s41
	v_mov_b32_e32 v245, v224
	s_sub_co_i32 s56, s22, s34
	v_mov_b32_e32 v246, v224
	s_sub_co_i32 s57, s21, s48
	v_mov_b32_e32 v247, v224
.Ltmp53:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:369:16 ]
	s_mov_b32 s51, s53
	v_mov_b32_e32 v248, v224
	s_lshr_b64 s[50:51], s[50:51], 16
	v_mov_b32_e32 v249, v224
	s_mov_b32 s21, s13
	v_mov_b32_e32 v250, v224
	s_mov_b32 s22, s50
	v_dual_mov_b32 v251, v224 :: v_dual_mov_b32 v252, v224
	v_dual_mov_b32 v253, v224 :: v_dual_mov_b32 v254, v224
	v_mov_b32_e32 v255, v224
	s_set_vgpr_msb 0x41                     ;  msbs: dst=1 src0=1 src1=0 src2=0
.Ltmp54:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:361:14 ]
	ds_load_b128 v[56:59] /*v[312:315]*/, v36 /*v292*/ offset:34816
	ds_load_b128 v[60:63] /*v[316:319]*/, v36 /*v292*/ offset:34848
	ds_load_b128 v[48:51] /*v[304:307]*/, v36 /*v292*/ offset:43520
	ds_load_b128 v[52:55] /*v[308:311]*/, v36 /*v292*/ offset:43552
	ds_load_b128 v[40:43] /*v[296:299]*/, v36 /*v292*/ offset:52224
	ds_load_b128 v[44:47] /*v[300:303]*/, v36 /*v292*/ offset:52256
	ds_load_b128 v[32:35] /*v[288:291]*/, v36 /*v292*/ offset:60928
	ds_load_b128 v[36:39] /*v[292:295]*/, v36 /*v292*/ offset:60960
.Ltmp55:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:369:16 ]
	tensor_load_to_lds s[0:3], s[12:19]
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:369:16 ]
	s_add_nc_u64 s[2:3], s[4:5], 0x200
	s_add_co_i32 s1, s44, 0x11000
	s_add_nc_u64 s[2:3], s[2:3], s[46:47]
	tensor_load_to_lds s[0:3], s[20:27]
	s_set_vgpr_msb 0x4100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	s_wait_dscnt 0x0
.Ltmp56:
.LBB0_1:                                ; =>This Inner Loop Header: Depth=1
	.loc	2 0 9 is_stmt 0                 ; f16_gemm_common_gfx1250.py:0:9
	s_set_vgpr_msb 5                        ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp57:
	.loc	2 284 9 is_stmt 1               ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	s_barrier_signal -1
.Ltmp58:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	s_wait_dscnt 0x14
	v_wmma_f32_16x16x32_f16 v[224:231], v[24:31] /*v[280:287]*/, v[88:95] /*v[344:351]*/, v[224:231]
.Ltmp59:
	.loc	2 283 13                        ; f16_gemm_common_gfx1250.py:283:13 @[ f16_gemm_gfx1250.py:377:18 ]
	s_mul_hi_u32 s0, s58, 0xaaaaaaab
.Ltmp60:
	.loc	1 404 9                         ; f16_gemm_gfx1250.py:404:9
	s_add_co_i32 s53, s58, 1
.Ltmp61:
	.loc	2 283 13                        ; f16_gemm_common_gfx1250.py:283:13 @[ f16_gemm_gfx1250.py:377:18 ]
	s_lshr_b32 s0, s0, 1
	s_add_co_i32 s1, s58, s55
	s_mul_i32 s0, s0, 3
.Ltmp62:
	.loc	2 170 54                        ; f16_gemm_common_gfx1250.py:170:54 @[ f16_gemm_gfx1250.py:410:20 ]
	s_lshl_b32 s2, s52, 7
.Ltmp63:
	.loc	2 283 13                        ; f16_gemm_common_gfx1250.py:283:13 @[ f16_gemm_gfx1250.py:377:18 ]
	s_sub_co_i32 s0, s58, s0
.Ltmp64:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	s_wait_dscnt 0x12
	v_wmma_f32_16x16x32_f16 v[232:239], v[16:23] /*v[272:279]*/, v[88:95] /*v[344:351]*/, v[232:239]
.Ltmp65:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	s_lshl_b32 s3, s0, 16
	s_lshl_b32 s13, s0, 12
.Ltmp66:
	.loc	2 170 90                        ; f16_gemm_common_gfx1250.py:170:90 @[ f16_gemm_gfx1250.py:410:20 ]
	s_mul_hi_i32 s14, s52, 0x55555556
.Ltmp67:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:377:18 ]
	s_lshl_b32 s15, s0, 15
	s_lshl_b32 s20, s0, 11
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	v_nop
	v_nop
	v_nop
	v_nop
	v_nop
	v_nop
	s_set_vgpr_msb 0x590                    ;  msbs: dst=2 src0=0 src1=0 src2=1
	v_add3_u32 v72 /*v584*/, s3, s13, v99 /*v355*/
	s_set_vgpr_msb 0x9005                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp68:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	s_wait_dscnt 0x10
	v_wmma_f32_16x16x32_f16 v[216:223], v[8:15] /*v[264:271]*/, v[88:95] /*v[344:351]*/, v[216:223]
.Ltmp69:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:377:18 ]
	s_add_co_i32 s3, s15, 0x32ff0
.Ltmp70:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	s_wait_dscnt 0xe
	v_wmma_f32_16x16x32_f16 v[200:207], v[0:7] /*v[256:263]*/, v[88:95] /*v[344:351]*/, v[200:207]
	.loc	1 409 17                        ; f16_gemm_gfx1250.py:409:17
	s_lshr_b32 s0, s1, 31
	s_set_vgpr_msb 0x590                    ;  msbs: dst=2 src0=0 src1=0 src2=1
.Ltmp71:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:377:18 ]
	v_add3_u32 v104 /*v616*/, s3, s20, v98 /*v354*/
	s_set_vgpr_msb 0x9005                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp72:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	s_wait_dscnt 0xc
	v_wmma_f32_16x16x32_f16 v[168:175], v[24:31] /*v[280:287]*/, v[80:87] /*v[336:343]*/, v[168:175]
.Ltmp73:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	s_barrier_wait -1
.Ltmp74:
	.loc	2 170 90                        ; f16_gemm_common_gfx1250.py:170:90 @[ f16_gemm_gfx1250.py:410:20 ]
	s_lshr_b32 s1, s14, 31
	.loc	2 170 5 is_stmt 0               ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:410:20 ]
	s_ashr_i32 s3, s2, 31
	.loc	2 170 90                        ; f16_gemm_common_gfx1250.py:170:90 @[ f16_gemm_gfx1250.py:410:20 ]
	s_add_co_i32 s1, s14, s1
.Ltmp75:
	.loc	1 380 23 is_stmt 1              ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[144:151], v[16:23] /*v[272:279]*/, v[80:87] /*v[336:343]*/, v[144:151]
.Ltmp76:
	.loc	2 170 90                        ; f16_gemm_common_gfx1250.py:170:90 @[ f16_gemm_gfx1250.py:410:20 ]
	s_mul_i32 s1, s1, 3
	.loc	2 170 5 is_stmt 0               ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:410:20 ]
	s_lshl_b64 s[50:51], s[2:3], 1
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp77:
	.loc	2 284 9 is_stmt 1               ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[88:91] /*v[344:347]*/, v72 /*v584*/ offset:64
	ds_load_b128 v[92:95] /*v[348:351]*/, v72 /*v584*/ offset:96
.Ltmp78:
	.loc	2 170 90                        ; f16_gemm_common_gfx1250.py:170:90 @[ f16_gemm_gfx1250.py:410:20 ]
	s_sub_co_i32 s20, s52, s1
	.loc	2 170 5 is_stmt 0               ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:410:20 ]
	s_sub_co_i32 s1, s10, s2
.Ltmp79:
	.loc	2 284 9 is_stmt 1               ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[100:103] /*v[356:359]*/, v72 /*v584*/ offset:8768
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp80:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[136:143], v[8:15] /*v[264:271]*/, v[80:87] /*v[336:343]*/, v[136:143]
.Ltmp81:
	.loc	2 170 75                        ; f16_gemm_common_gfx1250.py:170:75 @[ f16_gemm_gfx1250.py:410:20 ]
	s_lshl_b32 s21, s20, 15
	s_lshl_b32 s3, s20, 16
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp82:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[104:107] /*v[360:363]*/, v72 /*v584*/ offset:8800
	ds_load_b128 v[108:111] /*v[364:367]*/, v72 /*v584*/ offset:17472
.Ltmp83:
	.loc	2 170 75                        ; f16_gemm_common_gfx1250.py:170:75 @[ f16_gemm_gfx1250.py:410:20 ]
	s_lshr_b32 s13, s21, 3
	.loc	2 170 5 is_stmt 0               ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:410:20 ]
	s_max_i32 s1, s1, 0
.Ltmp84:
	.loc	2 284 9 is_stmt 1               ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[112:115] /*v[368:371]*/, v72 /*v584*/ offset:17504
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp85:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[128:135], v[0:7] /*v[256:263]*/, v[80:87] /*v[336:343]*/, v[128:135]
.Ltmp86:
	.loc	2 170 75                        ; f16_gemm_common_gfx1250.py:170:75 @[ f16_gemm_gfx1250.py:410:20 ]
	s_add_co_i32 s13, s3, s13
	.loc	2 170 5 is_stmt 0               ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:410:20 ]
	s_cmp_gt_i32 s2, -1
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp87:
	.loc	2 288 13 is_stmt 1              ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[116:119] /*v[372:375]*/, v104 /*v616*/ offset:64
	ds_load_b128 v[120:123] /*v[376:379]*/, v104 /*v616*/ offset:96
.Ltmp88:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:410:20 ]
	s_cselect_b32 s44, s1, 0
	s_add_nc_u64 s[2:3], s[50:51], s[8:9]
.Ltmp89:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[124:127] /*v[380:383]*/, v104 /*v616*/ offset:8768
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp90:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	s_wait_dscnt 0x13
	v_wmma_f32_16x16x32_f16 v[112:119], v[24:31] /*v[280:287]*/, v[72:79] /*v[328:335]*/, v[112:119]
.Ltmp91:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:410:20 ]
	s_lshr_b64 s[14:15], s[44:45], 16
	s_lshl1_add_u32 s1, s31, s13
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp92:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[128:131] /*v[384:387]*/, v104 /*v616*/ offset:8800
	ds_load_b128 v[132:135] /*v[388:391]*/, v104 /*v616*/ offset:17472
.Ltmp93:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:410:20 ]
	s_and_b32 s15, s14, 0x7fff
	s_lshr_b32 s13, s14, 16
.Ltmp94:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[136:139] /*v[392:395]*/, v104 /*v616*/ offset:17504
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp95:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[96:103], v[16:23] /*v[272:279]*/, v[72:79] /*v[328:335]*/, v[96:103]
.Ltmp96:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:410:20 ]
	s_add_co_i32 s13, s56, s13
	s_add_nc_u64 s[2:3], s[2:3], s[42:43]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp97:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[140:143] /*v[396:399]*/, v104 /*v616*/ offset:26176
	ds_load_b128 v[144:147] /*v[400:403]*/, v104 /*v616*/ offset:26208
.Ltmp98:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:410:20 ]
	s_max_i32 s14, s13, 0
	s_lshl_b32 s13, s44, 16
.Ltmp99:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[80:83] /*v[336:339]*/, v72 /*v584*/ offset:26176
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp100:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[72:79], v[8:15] /*v[264:271]*/, v[72:79] /*v[328:335]*/, v[72:79]
.Ltmp101:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:410:20 ]
	s_lshl_b32 s22, s14, 16
	s_lshr_b32 s23, s14, 16
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp102:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[84:87] /*v[340:343]*/, v72 /*v584*/ offset:26208
.Ltmp103:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:410:20 ]
	s_or_b32 s14, s22, s15
	s_or_b32 s15, s23, 0x800000
.Ltmp104:
	.loc	2 283 13                        ; f16_gemm_common_gfx1250.py:283:13 @[ f16_gemm_gfx1250.py:413:18 ]
	s_mul_hi_u32 s22, s53, 0xaaaaaaab
.Ltmp105:
	.loc	2 176 79                        ; f16_gemm_common_gfx1250.py:176:79 @[ f16_gemm_gfx1250.py:410:20 ]
	s_add_co_i32 s59, s21, 0x32ff0
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp106:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[56:63], v[0:7] /*v[256:263]*/, v[72:79] /*v[328:335]*/, v[56:63]
.Ltmp107:
	.loc	2 283 13                        ; f16_gemm_common_gfx1250.py:283:13 @[ f16_gemm_gfx1250.py:413:18 ]
	s_lshr_b32 s21, s22, 1
.Ltmp108:
	.loc	2 176 79                        ; f16_gemm_common_gfx1250.py:176:79 @[ f16_gemm_gfx1250.py:410:20 ]
	s_lshl_b32 s22, s20, 11
.Ltmp109:
	.loc	2 283 13                        ; f16_gemm_common_gfx1250.py:283:13 @[ f16_gemm_gfx1250.py:413:18 ]
	s_mul_i32 s21, s21, 3
.Ltmp110:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:410:20 ]
	s_mov_b32 s20, s12
.Ltmp111:
	.loc	2 283 13                        ; f16_gemm_common_gfx1250.py:283:13 @[ f16_gemm_gfx1250.py:413:18 ]
	s_sub_co_i32 s21, s53, s21
.Ltmp112:
	.loc	2 176 79                        ; f16_gemm_common_gfx1250.py:176:79 @[ f16_gemm_gfx1250.py:410:20 ]
	s_and_b32 s22, s22, 0x1ffff800
.Ltmp113:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:413:18 ]
	s_lshl_b32 s23, s21, 16
.Ltmp114:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	s_wait_dscnt 0x18
	v_wmma_f32_16x16x32_f16 v[40:47], v[24:31] /*v[280:287]*/, v[64:71] /*v[320:327]*/, v[40:47]
.Ltmp115:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:413:18 ]
	s_lshl_b32 s27, s21, 12
.Ltmp116:
	.loc	2 176 79                        ; f16_gemm_common_gfx1250.py:176:79 @[ f16_gemm_gfx1250.py:410:20 ]
	s_add_co_i32 s59, s59, s22
	s_set_vgpr_msb 0x590                    ;  msbs: dst=2 src0=0 src1=0 src2=1
.Ltmp117:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:413:18 ]
	v_add3_u32 v108 /*v620*/, s23, s27, v99 /*v355*/
	s_set_vgpr_msb 0x9042                   ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp118:
	.loc	2 284 9 is_stmt 0               ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[72:75] /*v[328:331]*/, v72 /*v584*/ offset:34880
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp119:
	.loc	1 380 23 is_stmt 1              ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[32:39], v[16:23] /*v[272:279]*/, v[64:71] /*v[320:327]*/, v[32:39]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp120:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[76:79] /*v[332:335]*/, v72 /*v584*/ offset:34912
.Ltmp121:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:413:18 ]
	s_lshl_b32 s22, s21, 15
	s_lshl_b32 s21, s21, 11
	s_add_co_i32 s22, s22, 0x32ff0
.Ltmp122:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[148:151] /*v[404:407]*/, v72 /*v584*/ offset:43584
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp123:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[24:31], v[8:15] /*v[264:271]*/, v[64:71] /*v[320:327]*/, v[24:31]
.Ltmp124:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:410:20 ]
	s_mov_b32 s27, s19
	s_set_vgpr_msb 0x590                    ;  msbs: dst=2 src0=0 src1=0 src2=1
.Ltmp125:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:413:18 ]
	v_add3_u32 v109 /*v621*/, s22, s21, v98 /*v354*/
	s_set_vgpr_msb 0x9042                   ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp126:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[152:155] /*v[408:411]*/, v72 /*v584*/ offset:43616
	ds_load_b128 v[156:159] /*v[412:415]*/, v72 /*v584*/ offset:52288
	ds_load_b128 v[160:163] /*v[416:419]*/, v72 /*v584*/ offset:52320
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp127:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[8:15], v[0:7] /*v[256:263]*/, v[64:71] /*v[320:327]*/, v[8:15]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp128:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[164:167] /*v[420:423]*/, v72 /*v584*/ offset:60992
.Ltmp129:
	.loc	2 178 5                         ; f16_gemm_common_gfx1250.py:178:5 @[ f16_gemm_gfx1250.py:410:20 ]
	s_add_co_i32 s52, s52, 1
.Ltmp130:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:377:18 ]
	ds_load_b128 v[168:171] /*v[424:427]*/, v72 /*v584*/ offset:61024
	s_mov_b32 s58, s53
.Ltmp131:
	.loc	2 284 9 is_stmt 0               ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[172:175] /*v[428:431]*/, v72 /*v584*/ offset:128
	ds_load_b128 v[176:179] /*v[432:435]*/, v72 /*v584*/ offset:160
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp132:
	.loc	1 380 23 is_stmt 1              ; f16_gemm_gfx1250.py:380:23
	s_wait_dscnt 0x20
	v_wmma_f32_16x16x32_f16 v[16:23], v[24:31] /*v[280:287]*/, v[56:63] /*v[312:319]*/, v[16:23]
.Ltmp133:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:410:20 ]
	s_mov_b32 s48, s44
	s_lshr_b64 s[22:23], s[48:49], 16
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp134:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[180:183] /*v[436:439]*/, v72 /*v584*/ offset:8832
.Ltmp135:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:410:20 ]
	s_mov_b32 s21, s13
	s_and_b32 s23, s22, 0x7fff
.Ltmp136:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[184:187] /*v[440:443]*/, v72 /*v584*/ offset:8864
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp137:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[0:7], v[16:23] /*v[272:279]*/, v[56:63] /*v[312:319]*/, v[0:7]
.Ltmp138:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:410:20 ]
	s_lshr_b32 s22, s22, 16
	s_add_co_i32 s22, s57, s22
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp139:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[188:191] /*v[444:447]*/, v72 /*v584*/ offset:17536
.Ltmp140:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:410:20 ]
	s_max_i32 s22, s22, 0
	s_lshl_b32 s44, s22, 16
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp141:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[48:55], v[8:15] /*v[264:271]*/, v[56:63] /*v[312:319]*/, v[48:55]
.Ltmp142:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:410:20 ]
	s_lshr_b32 s48, s22, 16
	s_or_b32 s22, s44, s23
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp143:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[192:195] /*v[448:451]*/, v72 /*v584*/ offset:17568
	ds_load_b128 v[196:199] /*v[452:455]*/, v72 /*v584*/ offset:26240
.Ltmp144:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:410:20 ]
	s_or_b32 s23, s48, 0x800000
.Ltmp145:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[200:203] /*v[456:459]*/, v72 /*v584*/ offset:26272
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp146:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[64:71], v[0:7] /*v[256:263]*/, v[56:63] /*v[312:319]*/, v[64:71]
	s_wait_dscnt 0x24
	v_wmma_f32_16x16x32_f16 v[80:87], v[24:31] /*v[280:287]*/, v[48:55] /*v[304:311]*/, v[80:87]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp147:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[204:207] /*v[460:463]*/, v72 /*v584*/ offset:34944
	ds_load_b128 v[208:211] /*v[464:467]*/, v72 /*v584*/ offset:34976
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp148:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[88:95], v[16:23] /*v[272:279]*/, v[48:55] /*v[304:311]*/, v[88:95]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp149:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[212:215] /*v[468:471]*/, v72 /*v584*/ offset:43648
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp150:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[104:111], v[8:15] /*v[264:271]*/, v[48:55] /*v[304:311]*/, v[104:111]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp151:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[216:219] /*v[472:475]*/, v72 /*v584*/ offset:43680
	ds_load_b128 v[220:223] /*v[476:479]*/, v72 /*v584*/ offset:52352
	ds_load_b128 v[224:227] /*v[480:483]*/, v72 /*v584*/ offset:52384
	ds_load_b128 v[228:231] /*v[484:487]*/, v72 /*v584*/ offset:61056
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp152:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[120:127], v[0:7] /*v[256:263]*/, v[48:55] /*v[304:311]*/, v[120:127]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp153:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[232:235] /*v[488:491]*/, v72 /*v584*/ offset:61088
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[236:239] /*v[492:495]*/, v104 /*v616*/ offset:128
	ds_load_b128 v[240:243] /*v[496:499]*/, v104 /*v616*/ offset:160
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp154:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	s_wait_dscnt 0x2c
	v_wmma_f32_16x16x32_f16 v[152:159], v[24:31] /*v[280:287]*/, v[40:47] /*v[296:303]*/, v[152:159]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp155:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[244:247] /*v[500:503]*/, v104 /*v616*/ offset:8832
	ds_load_b128 v[248:251] /*v[504:507]*/, v104 /*v616*/ offset:8864
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp156:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[160:167], v[16:23] /*v[272:279]*/, v[40:47] /*v[296:303]*/, v[160:167]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp157:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[252:255] /*v[508:511]*/, v104 /*v616*/ offset:17536
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp158:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[176:183], v[8:15] /*v[264:271]*/, v[40:47] /*v[296:303]*/, v[176:183]
	s_set_vgpr_msb 0x582                    ;  msbs: dst=2 src0=2 src1=0 src2=0
.Ltmp159:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:387:18 ]
	ds_load_b128 v[0:3] /*v[512:515]*/, v104 /*v616*/ offset:17568
	ds_load_b128 v[4:7] /*v[516:519]*/, v104 /*v616*/ offset:26240
	ds_load_b128 v[8:11] /*v[520:523]*/, v104 /*v616*/ offset:26272
	s_set_vgpr_msb 0x8205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp160:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[192:199], v[0:7] /*v[256:263]*/, v[40:47] /*v[296:303]*/, v[192:199]
	s_set_vgpr_msb 0x582                    ;  msbs: dst=2 src0=2 src1=0 src2=0
.Ltmp161:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:394:18 ]
	ds_load_b128 v[12:15] /*v[524:527]*/, v72 /*v584*/ offset:192
	ds_load_b128 v[16:19] /*v[528:531]*/, v72 /*v584*/ offset:224
	s_set_vgpr_msb 0x8205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp162:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	s_wait_dscnt 0x32
	v_wmma_f32_16x16x32_f16 v[184:191], v[24:31] /*v[280:287]*/, v[32:39] /*v[288:295]*/, v[184:191]
	s_set_vgpr_msb 0x582                    ;  msbs: dst=2 src0=2 src1=0 src2=0
.Ltmp163:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:394:18 ]
	ds_load_b128 v[20:23] /*v[532:535]*/, v72 /*v584*/ offset:8896
	s_set_vgpr_msb 0x8205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp164:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[208:215], v[16:23] /*v[272:279]*/, v[32:39] /*v[288:295]*/, v[208:215]
	s_set_vgpr_msb 0x582                    ;  msbs: dst=2 src0=2 src1=0 src2=0
.Ltmp165:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:394:18 ]
	ds_load_b128 v[24:27] /*v[536:539]*/, v72 /*v584*/ offset:8928
	ds_load_b128 v[28:31] /*v[540:543]*/, v72 /*v584*/ offset:17600
	ds_load_b128 v[32:35] /*v[544:547]*/, v72 /*v584*/ offset:17632
	s_set_vgpr_msb 0x8205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp166:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[240:247], v[8:15] /*v[264:271]*/, v[32:39] /*v[288:295]*/, v[240:247]
	s_set_vgpr_msb 0x582                    ;  msbs: dst=2 src0=2 src1=0 src2=0
.Ltmp167:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:394:18 ]
	ds_load_b128 v[36:39] /*v[548:551]*/, v72 /*v584*/ offset:26304
	ds_load_b128 v[40:43] /*v[552:555]*/, v72 /*v584*/ offset:26336
	ds_load_b128 v[44:47] /*v[556:559]*/, v72 /*v584*/ offset:35008
	ds_load_b128 v[48:51] /*v[560:563]*/, v72 /*v584*/ offset:35040
	s_set_vgpr_msb 0x8205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp168:
	.loc	1 380 23                        ; f16_gemm_gfx1250.py:380:23
	v_wmma_f32_16x16x32_f16 v[248:255], v[0:7] /*v[256:263]*/, v[32:39] /*v[288:295]*/, v[248:255]
	s_set_vgpr_msb 0x582                    ;  msbs: dst=2 src0=2 src1=0 src2=0
.Ltmp169:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:394:18 ]
	ds_load_b128 v[52:55] /*v[564:567]*/, v72 /*v584*/ offset:43712
	ds_load_b128 v[56:59] /*v[568:571]*/, v72 /*v584*/ offset:43744
	s_set_vgpr_msb 0x8205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp170:
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	s_wait_dscnt 0x34
	v_wmma_f32_16x16x32_f16 v[224:231], v[116:123] /*v[372:379]*/, v[88:95] /*v[344:351]*/, v[224:231]
	s_set_vgpr_msb 0x582                    ;  msbs: dst=2 src0=2 src1=0 src2=0
.Ltmp171:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:394:18 ]
	ds_load_b128 v[60:63] /*v[572:575]*/, v72 /*v584*/ offset:52416
	s_set_vgpr_msb 0x8205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp172:
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	s_wait_dscnt 0x33
	v_wmma_f32_16x16x32_f16 v[232:239], v[124:131] /*v[380:387]*/, v[88:95] /*v[344:351]*/, v[232:239]
	s_set_vgpr_msb 0x582                    ;  msbs: dst=2 src0=2 src1=0 src2=0
.Ltmp173:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:394:18 ]
	ds_load_b128 v[64:67] /*v[576:579]*/, v72 /*v584*/ offset:52448
	ds_load_b128 v[68:71] /*v[580:583]*/, v72 /*v584*/ offset:61120
	ds_load_b128 v[72:75] /*v[584:587]*/, v72 /*v584*/ offset:61152
	s_set_vgpr_msb 0x8205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp174:
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	s_wait_dscnt 0x34
	v_wmma_f32_16x16x32_f16 v[216:223], v[132:139] /*v[388:395]*/, v[88:95] /*v[344:351]*/, v[216:223]
	s_set_vgpr_msb 0x582                    ;  msbs: dst=2 src0=2 src1=0 src2=0
.Ltmp175:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:394:18 ]
	ds_load_b128 v[76:79] /*v[588:591]*/, v104 /*v616*/ offset:192
	ds_load_b128 v[80:83] /*v[592:595]*/, v104 /*v616*/ offset:224
	s_set_vgpr_msb 0x8205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp176:
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	s_wait_dscnt 0x34
	v_wmma_f32_16x16x32_f16 v[200:207], v[140:147] /*v[396:403]*/, v[88:95] /*v[344:351]*/, v[200:207]
	s_set_vgpr_msb 0x582                    ;  msbs: dst=2 src0=2 src1=0 src2=0
.Ltmp177:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:394:18 ]
	ds_load_b128 v[84:87] /*v[596:599]*/, v104 /*v616*/ offset:8896
	s_set_vgpr_msb 0x8205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp178:
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	v_wmma_f32_16x16x32_f16 v[168:175], v[116:123] /*v[372:379]*/, v[100:107] /*v[356:363]*/, v[168:175]
	s_set_vgpr_msb 0x582                    ;  msbs: dst=2 src0=2 src1=0 src2=0
.Ltmp179:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:394:18 ]
	ds_load_b128 v[88:91] /*v[600:603]*/, v104 /*v616*/ offset:8928
	ds_load_b128 v[92:95] /*v[604:607]*/, v104 /*v616*/ offset:17600
	ds_load_b128 v[96:99] /*v[608:611]*/, v104 /*v616*/ offset:17632
	s_set_vgpr_msb 0x8205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp180:
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	v_wmma_f32_16x16x32_f16 v[144:151], v[124:131] /*v[380:387]*/, v[100:107] /*v[356:363]*/, v[144:151]
	s_set_vgpr_msb 0x582                    ;  msbs: dst=2 src0=2 src1=0 src2=0
.Ltmp181:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:394:18 ]
	ds_load_b128 v[100:103] /*v[612:615]*/, v104 /*v616*/ offset:26304
	ds_load_b128 v[104:107] /*v[616:619]*/, v104 /*v616*/ offset:26336
	s_set_vgpr_msb 0x8205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp182:
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	v_wmma_f32_16x16x32_f16 v[136:143], v[132:139] /*v[388:395]*/, v[100:107] /*v[356:363]*/, v[136:143]
	v_wmma_f32_16x16x32_f16 v[128:135], v[140:147] /*v[396:403]*/, v[100:107] /*v[356:363]*/, v[128:135]
	v_wmma_f32_16x16x32_f16 v[112:119], v[116:123] /*v[372:379]*/, v[108:115] /*v[364:371]*/, v[112:119]
	v_wmma_f32_16x16x32_f16 v[96:103], v[124:131] /*v[380:387]*/, v[108:115] /*v[364:371]*/, v[96:103]
	v_wmma_f32_16x16x32_f16 v[72:79], v[132:139] /*v[388:395]*/, v[108:115] /*v[364:371]*/, v[72:79]
	v_wmma_f32_16x16x32_f16 v[56:63], v[140:147] /*v[396:403]*/, v[108:115] /*v[364:371]*/, v[56:63]
	s_wait_dscnt 0x38
	v_wmma_f32_16x16x32_f16 v[40:47], v[116:123] /*v[372:379]*/, v[80:87] /*v[336:343]*/, v[40:47]
	.loc	1 405 9                         ; f16_gemm_gfx1250.py:405:9
	s_wait_tensorcnt 0x2
	s_wait_dscnt 0x0
	s_barrier_signal -1
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	v_wmma_f32_16x16x32_f16 v[32:39], v[124:131] /*v[380:387]*/, v[80:87] /*v[336:343]*/, v[32:39]
	v_wmma_f32_16x16x32_f16 v[24:31], v[132:139] /*v[388:395]*/, v[80:87] /*v[336:343]*/, v[24:31]
	v_wmma_f32_16x16x32_f16 v[8:15], v[140:147] /*v[396:403]*/, v[80:87] /*v[336:343]*/, v[8:15]
	v_wmma_f32_16x16x32_f16 v[16:23], v[116:123] /*v[372:379]*/, v[72:79] /*v[328:335]*/, v[16:23]
	.loc	1 405 9                         ; f16_gemm_gfx1250.py:405:9
	s_barrier_wait -1
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	v_wmma_f32_16x16x32_f16 v[0:7], v[124:131] /*v[380:387]*/, v[72:79] /*v[328:335]*/, v[0:7]
.Ltmp183:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:410:20 ]
	tensor_load_to_lds s[0:3], s[12:19]
.Ltmp184:
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	v_wmma_f32_16x16x32_f16 v[48:55], v[132:139] /*v[388:395]*/, v[72:79] /*v[328:335]*/, v[48:55]
.Ltmp185:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:410:20 ]
	s_add_nc_u64 s[2:3], s[50:51], s[4:5]
	s_lshl1_add_u32 s1, s39, s59
	s_add_nc_u64 s[2:3], s[2:3], s[46:47]
.Ltmp186:
	.loc	1 374 5                         ; f16_gemm_gfx1250.py:374:5
	s_cmp_lg_u32 s53, s41
.Ltmp187:
	.loc	2 176 9                         ; f16_gemm_common_gfx1250.py:176:9 @[ f16_gemm_gfx1250.py:410:20 ]
	tensor_load_to_lds s[0:3], s[20:27]
.Ltmp188:
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	v_wmma_f32_16x16x32_f16 v[64:71], v[140:147] /*v[396:403]*/, v[72:79] /*v[328:335]*/, v[64:71]
.Ltmp189:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:413:18 ]
	s_barrier_signal -1
.Ltmp190:
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	v_wmma_f32_16x16x32_f16 v[80:87], v[116:123] /*v[372:379]*/, v[148:155] /*v[404:411]*/, v[80:87]
	v_wmma_f32_16x16x32_f16 v[88:95], v[124:131] /*v[380:387]*/, v[148:155] /*v[404:411]*/, v[88:95]
	v_wmma_f32_16x16x32_f16 v[104:111], v[132:139] /*v[388:395]*/, v[148:155] /*v[404:411]*/, v[104:111]
	v_wmma_f32_16x16x32_f16 v[120:127], v[140:147] /*v[396:403]*/, v[148:155] /*v[404:411]*/, v[120:127]
	v_wmma_f32_16x16x32_f16 v[152:159], v[116:123] /*v[372:379]*/, v[156:163] /*v[412:419]*/, v[152:159]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp191:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:413:18 ]
	s_barrier_wait -1
	ds_load_b128 v[88:91] /*v[344:347]*/, v108 /*v620*/
	ds_load_b128 v[92:95] /*v[348:351]*/, v108 /*v620*/ offset:32
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:413:18 ]
	ds_load_b128 v[24:27] /*v[280:283]*/, v109 /*v621*/
	ds_load_b128 v[28:31] /*v[284:287]*/, v109 /*v621*/ offset:32
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp192:
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	v_wmma_f32_16x16x32_f16 v[160:167], v[124:131] /*v[380:387]*/, v[156:163] /*v[412:419]*/, v[160:167]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp193:
	.loc	2 288 13                        ; f16_gemm_common_gfx1250.py:288:13 @[ f16_gemm_gfx1250.py:413:18 ]
	ds_load_b128 v[16:19] /*v[272:275]*/, v109 /*v621*/ offset:8704
	ds_load_b128 v[20:23] /*v[276:279]*/, v109 /*v621*/ offset:8736
	ds_load_b128 v[8:11] /*v[264:267]*/, v109 /*v621*/ offset:17408
	ds_load_b128 v[12:15] /*v[268:271]*/, v109 /*v621*/ offset:17440
	ds_load_b128 v[0:3] /*v[256:259]*/, v109 /*v621*/ offset:26112
	ds_load_b128 v[4:7] /*v[260:263]*/, v109 /*v621*/ offset:26144
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:413:18 ]
	ds_load_b128 v[80:83] /*v[336:339]*/, v108 /*v620*/ offset:8704
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp194:
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	v_wmma_f32_16x16x32_f16 v[176:183], v[132:139] /*v[388:395]*/, v[156:163] /*v[412:419]*/, v[176:183]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp195:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:413:18 ]
	ds_load_b128 v[84:87] /*v[340:343]*/, v108 /*v620*/ offset:8736
	ds_load_b128 v[72:75] /*v[328:331]*/, v108 /*v620*/ offset:17408
	ds_load_b128 v[76:79] /*v[332:335]*/, v108 /*v620*/ offset:17440
	ds_load_b128 v[64:67] /*v[320:323]*/, v108 /*v620*/ offset:26112
	ds_load_b128 v[68:71] /*v[324:327]*/, v108 /*v620*/ offset:26144
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp196:
	.loc	1 390 23                        ; f16_gemm_gfx1250.py:390:23
	v_wmma_f32_16x16x32_f16 v[192:199], v[140:147] /*v[396:403]*/, v[156:163] /*v[412:419]*/, v[192:199]
	v_wmma_f32_16x16x32_f16 v[184:191], v[116:123] /*v[372:379]*/, v[164:171] /*v[420:427]*/, v[184:191]
	v_wmma_f32_16x16x32_f16 v[208:215], v[124:131] /*v[380:387]*/, v[164:171] /*v[420:427]*/, v[208:215]
	v_wmma_f32_16x16x32_f16 v[240:247], v[132:139] /*v[388:395]*/, v[164:171] /*v[420:427]*/, v[240:247]
	v_wmma_f32_16x16x32_f16 v[248:255], v[140:147] /*v[396:403]*/, v[164:171] /*v[420:427]*/, v[248:255]
	.loc	1 399 23                        ; f16_gemm_gfx1250.py:399:23
	v_wmma_f32_16x16x32_f16 v[224:231], v[236:243] /*v[492:499]*/, v[172:179] /*v[428:435]*/, v[224:231]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp197:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:413:18 ]
	ds_load_b128 v[56:59] /*v[312:315]*/, v108 /*v620*/ offset:34816
	ds_load_b128 v[60:63] /*v[316:319]*/, v108 /*v620*/ offset:34848
	ds_load_b128 v[48:51] /*v[304:307]*/, v108 /*v620*/ offset:43520
	ds_load_b128 v[52:55] /*v[308:311]*/, v108 /*v620*/ offset:43552
	ds_load_b128 v[40:43] /*v[296:299]*/, v108 /*v620*/ offset:52224
	ds_load_b128 v[44:47] /*v[300:303]*/, v108 /*v620*/ offset:52256
	ds_load_b128 v[32:35] /*v[288:291]*/, v108 /*v620*/ offset:60928
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp198:
	.loc	1 399 23                        ; f16_gemm_gfx1250.py:399:23
	v_wmma_f32_16x16x32_f16 v[232:239], v[244:251] /*v[500:507]*/, v[172:179] /*v[428:435]*/, v[232:239]
	s_set_vgpr_msb 0x542                    ;  msbs: dst=1 src0=2 src1=0 src2=0
.Ltmp199:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:413:18 ]
	ds_load_b128 v[36:39] /*v[292:295]*/, v108 /*v620*/ offset:60960
	s_set_vgpr_msb 0x4205                   ;  msbs: dst=0 src0=1 src1=1 src2=0
.Ltmp200:
	.loc	1 399 23                        ; f16_gemm_gfx1250.py:399:23
	v_wmma_f32_16x16x32_f16 v[216:223], v[252:259] /*v[508:515]*/, v[172:179] /*v[428:435]*/, v[216:223]
	s_set_vgpr_msb 0x506                    ;  msbs: dst=0 src0=2 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[200:207], v[4:11] /*v[516:523]*/, v[172:179] /*v[428:435]*/, v[200:207]
	s_set_vgpr_msb 0x605                    ;  msbs: dst=0 src0=1 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[168:175], v[236:243] /*v[492:499]*/, v[180:187] /*v[436:443]*/, v[168:175]
	v_wmma_f32_16x16x32_f16 v[144:151], v[244:251] /*v[500:507]*/, v[180:187] /*v[436:443]*/, v[144:151]
	v_wmma_f32_16x16x32_f16 v[136:143], v[252:259] /*v[508:515]*/, v[180:187] /*v[436:443]*/, v[136:143]
	s_set_vgpr_msb 0x506                    ;  msbs: dst=0 src0=2 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[128:135], v[4:11] /*v[516:523]*/, v[180:187] /*v[436:443]*/, v[128:135]
	s_set_vgpr_msb 0x605                    ;  msbs: dst=0 src0=1 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[112:119], v[236:243] /*v[492:499]*/, v[188:195] /*v[444:451]*/, v[112:119]
	v_wmma_f32_16x16x32_f16 v[96:103], v[244:251] /*v[500:507]*/, v[188:195] /*v[444:451]*/, v[96:103]
	v_wmma_f32_16x16x32_f16 v[72:79], v[252:259] /*v[508:515]*/, v[188:195] /*v[444:451]*/, v[72:79]
	s_set_vgpr_msb 0x506                    ;  msbs: dst=0 src0=2 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[56:63], v[4:11] /*v[516:523]*/, v[188:195] /*v[444:451]*/, v[56:63]
	s_set_vgpr_msb 0x605                    ;  msbs: dst=0 src0=1 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[40:47], v[236:243] /*v[492:499]*/, v[196:203] /*v[452:459]*/, v[40:47]
	v_wmma_f32_16x16x32_f16 v[32:39], v[244:251] /*v[500:507]*/, v[196:203] /*v[452:459]*/, v[32:39]
	v_wmma_f32_16x16x32_f16 v[24:31], v[252:259] /*v[508:515]*/, v[196:203] /*v[452:459]*/, v[24:31]
	s_set_vgpr_msb 0x506                    ;  msbs: dst=0 src0=2 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[8:15], v[4:11] /*v[516:523]*/, v[196:203] /*v[452:459]*/, v[8:15]
	s_set_vgpr_msb 0x605                    ;  msbs: dst=0 src0=1 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[16:23], v[236:243] /*v[492:499]*/, v[204:211] /*v[460:467]*/, v[16:23]
	v_wmma_f32_16x16x32_f16 v[0:7], v[244:251] /*v[500:507]*/, v[204:211] /*v[460:467]*/, v[0:7]
	v_wmma_f32_16x16x32_f16 v[48:55], v[252:259] /*v[508:515]*/, v[204:211] /*v[460:467]*/, v[48:55]
	s_set_vgpr_msb 0x506                    ;  msbs: dst=0 src0=2 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[64:71], v[4:11] /*v[516:523]*/, v[204:211] /*v[460:467]*/, v[64:71]
	s_set_vgpr_msb 0x605                    ;  msbs: dst=0 src0=1 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[80:87], v[236:243] /*v[492:499]*/, v[212:219] /*v[468:475]*/, v[80:87]
	v_wmma_f32_16x16x32_f16 v[88:95], v[244:251] /*v[500:507]*/, v[212:219] /*v[468:475]*/, v[88:95]
	v_wmma_f32_16x16x32_f16 v[104:111], v[252:259] /*v[508:515]*/, v[212:219] /*v[468:475]*/, v[104:111]
	s_set_vgpr_msb 0x506                    ;  msbs: dst=0 src0=2 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[120:127], v[4:11] /*v[516:523]*/, v[212:219] /*v[468:475]*/, v[120:127]
	s_set_vgpr_msb 0x605                    ;  msbs: dst=0 src0=1 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[152:159], v[236:243] /*v[492:499]*/, v[220:227] /*v[476:483]*/, v[152:159]
	v_wmma_f32_16x16x32_f16 v[160:167], v[244:251] /*v[500:507]*/, v[220:227] /*v[476:483]*/, v[160:167]
	v_wmma_f32_16x16x32_f16 v[176:183], v[252:259] /*v[508:515]*/, v[220:227] /*v[476:483]*/, v[176:183]
	s_set_vgpr_msb 0x506                    ;  msbs: dst=0 src0=2 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[192:199], v[4:11] /*v[516:523]*/, v[220:227] /*v[476:483]*/, v[192:199]
	s_set_vgpr_msb 0x605                    ;  msbs: dst=0 src0=1 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[184:191], v[236:243] /*v[492:499]*/, v[228:235] /*v[484:491]*/, v[184:191]
	v_wmma_f32_16x16x32_f16 v[208:215], v[244:251] /*v[500:507]*/, v[228:235] /*v[484:491]*/, v[208:215]
	v_wmma_f32_16x16x32_f16 v[240:247], v[252:259] /*v[508:515]*/, v[228:235] /*v[484:491]*/, v[240:247]
	s_set_vgpr_msb 0x506                    ;  msbs: dst=0 src0=2 src1=1 src2=0
	v_wmma_f32_16x16x32_f16 v[248:255], v[4:11] /*v[516:523]*/, v[228:235] /*v[484:491]*/, v[248:255]
	s_set_vgpr_msb 0x60a                    ;  msbs: dst=0 src0=2 src1=2 src2=0
	.loc	1 415 23                        ; f16_gemm_gfx1250.py:415:23
	v_wmma_f32_16x16x32_f16 v[224:231], v[76:83] /*v[588:595]*/, v[12:19] /*v[524:531]*/, v[224:231]
	v_wmma_f32_16x16x32_f16 v[232:239], v[84:91] /*v[596:603]*/, v[12:19] /*v[524:531]*/, v[232:239]
	v_wmma_f32_16x16x32_f16 v[216:223], v[92:99] /*v[604:611]*/, v[12:19] /*v[524:531]*/, v[216:223]
	v_wmma_f32_16x16x32_f16 v[200:207], v[100:107] /*v[612:619]*/, v[12:19] /*v[524:531]*/, v[200:207]
	v_wmma_f32_16x16x32_f16 v[168:175], v[76:83] /*v[588:595]*/, v[20:27] /*v[532:539]*/, v[168:175]
	v_wmma_f32_16x16x32_f16 v[144:151], v[84:91] /*v[596:603]*/, v[20:27] /*v[532:539]*/, v[144:151]
	v_wmma_f32_16x16x32_f16 v[136:143], v[92:99] /*v[604:611]*/, v[20:27] /*v[532:539]*/, v[136:143]
	v_wmma_f32_16x16x32_f16 v[128:135], v[100:107] /*v[612:619]*/, v[20:27] /*v[532:539]*/, v[128:135]
	v_wmma_f32_16x16x32_f16 v[112:119], v[76:83] /*v[588:595]*/, v[28:35] /*v[540:547]*/, v[112:119]
	v_wmma_f32_16x16x32_f16 v[96:103], v[84:91] /*v[596:603]*/, v[28:35] /*v[540:547]*/, v[96:103]
	v_wmma_f32_16x16x32_f16 v[72:79], v[92:99] /*v[604:611]*/, v[28:35] /*v[540:547]*/, v[72:79]
	v_wmma_f32_16x16x32_f16 v[56:63], v[100:107] /*v[612:619]*/, v[28:35] /*v[540:547]*/, v[56:63]
	v_wmma_f32_16x16x32_f16 v[40:47], v[76:83] /*v[588:595]*/, v[36:43] /*v[548:555]*/, v[40:47]
	v_wmma_f32_16x16x32_f16 v[32:39], v[84:91] /*v[596:603]*/, v[36:43] /*v[548:555]*/, v[32:39]
	v_wmma_f32_16x16x32_f16 v[24:31], v[92:99] /*v[604:611]*/, v[36:43] /*v[548:555]*/, v[24:31]
	v_wmma_f32_16x16x32_f16 v[8:15], v[100:107] /*v[612:619]*/, v[36:43] /*v[548:555]*/, v[8:15]
	v_wmma_f32_16x16x32_f16 v[16:23], v[76:83] /*v[588:595]*/, v[44:51] /*v[556:563]*/, v[16:23]
	v_wmma_f32_16x16x32_f16 v[0:7], v[84:91] /*v[596:603]*/, v[44:51] /*v[556:563]*/, v[0:7]
	v_wmma_f32_16x16x32_f16 v[48:55], v[92:99] /*v[604:611]*/, v[44:51] /*v[556:563]*/, v[48:55]
	v_wmma_f32_16x16x32_f16 v[64:71], v[100:107] /*v[612:619]*/, v[44:51] /*v[556:563]*/, v[64:71]
	v_wmma_f32_16x16x32_f16 v[80:87], v[76:83] /*v[588:595]*/, v[52:59] /*v[564:571]*/, v[80:87]
	v_wmma_f32_16x16x32_f16 v[88:95], v[84:91] /*v[596:603]*/, v[52:59] /*v[564:571]*/, v[88:95]
	v_wmma_f32_16x16x32_f16 v[104:111], v[92:99] /*v[604:611]*/, v[52:59] /*v[564:571]*/, v[104:111]
	v_wmma_f32_16x16x32_f16 v[120:127], v[100:107] /*v[612:619]*/, v[52:59] /*v[564:571]*/, v[120:127]
	v_wmma_f32_16x16x32_f16 v[152:159], v[76:83] /*v[588:595]*/, v[60:67] /*v[572:579]*/, v[152:159]
	v_wmma_f32_16x16x32_f16 v[160:167], v[84:91] /*v[596:603]*/, v[60:67] /*v[572:579]*/, v[160:167]
	v_wmma_f32_16x16x32_f16 v[176:183], v[92:99] /*v[604:611]*/, v[60:67] /*v[572:579]*/, v[176:183]
	v_wmma_f32_16x16x32_f16 v[192:199], v[100:107] /*v[612:619]*/, v[60:67] /*v[572:579]*/, v[192:199]
	v_wmma_f32_16x16x32_f16 v[184:191], v[76:83] /*v[588:595]*/, v[68:75] /*v[580:587]*/, v[184:191]
	v_wmma_f32_16x16x32_f16 v[208:215], v[84:91] /*v[596:603]*/, v[68:75] /*v[580:587]*/, v[208:215]
	v_wmma_f32_16x16x32_f16 v[240:247], v[92:99] /*v[604:611]*/, v[68:75] /*v[580:587]*/, v[240:247]
	v_wmma_f32_16x16x32_f16 v[248:255], v[100:107] /*v[612:619]*/, v[68:75] /*v[580:587]*/, v[248:255]
	s_set_vgpr_msb 0xa00                    ;  msbs: dst=0 src0=0 src1=0 src2=0
	.loc	1 374 5                         ; f16_gemm_gfx1250.py:374:5
	s_cbranch_scc1 .LBB0_1
; %bb.2:                                ; %._crit_edge
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	s_wait_dscnt 0x0
	s_barrier_signal -1
.Ltmp201:
	.loc	2 284 9                         ; f16_gemm_common_gfx1250.py:284:9 @[ f16_gemm_gfx1250.py:361:14 ]
	s_lshl_b32 s0, s11, 5
.Ltmp202:
	.loc	2 170 5                         ; f16_gemm_common_gfx1250.py:170:5 @[ f16_gemm_gfx1250.py:357:20 ]
	s_and_b32 s1, s29, 0xffff0000
.Ltmp203:
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	s_and_b32 s16, s0, 32
	.loc	1 344 14                        ; f16_gemm_gfx1250.py:344:14
	s_lshr_b64 s[2:3], s[28:29], 16
	s_bitset1_b32 s7, 31
	s_ashr_i32 s3, s30, 31
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	s_mov_b32 s11, 0
	.loc	1 419 5                         ; f16_gemm_gfx1250.py:419:5
	s_ashr_i32 s39, s38, 31
	s_ashr_i32 s41, s40, 31
	s_mov_b32 s0, 1
	s_mov_b32 s8, 64
	s_mov_b32 s4, 0x10000
	s_mov_b32 s9, s30
	.loc	1 344 14                        ; f16_gemm_gfx1250.py:344:14
	s_and_b32 s31, s3, 0xffff
	.loc	1 419 5                         ; f16_gemm_gfx1250.py:419:5
	s_lshr_b32 s3, s2, 16
	s_mul_u64 s[12:13], s[30:31], s[38:39]
	s_or_b32 s3, s3, s1
	s_mul_u64 s[14:15], s[36:37], s[30:31]
	s_mov_b32 s10, s31
	s_add_nc_u64 s[12:13], s[12:13], s[40:41]
	s_sub_co_i32 s1, s3, s38
	s_lshl_b64 s[12:13], s[12:13], 1
	s_max_i32 s1, s1, 0
	s_cmp_gt_i32 s54, -1
	s_add_nc_u64 s[6:7], s[12:13], s[6:7]
	s_cselect_b32 s13, s1, 0
	s_and_b32 s1, s28, 0xffff
	s_lshl_b32 s5, s2, 16
	s_add_nc_u64 s[2:3], s[6:7], s[14:15]
	s_or_b32 s5, s5, s1
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v224, v224, v225
	.loc	1 419 5                         ; f16_gemm_gfx1250.py:419:5
	s_sub_co_i32 s1, s5, s40
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v225, v226, v227
	.loc	1 419 5                         ; f16_gemm_gfx1250.py:419:5
	s_max_i32 s1, s1, 0
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	s_barrier_wait -1
	.loc	1 419 5                         ; f16_gemm_gfx1250.py:419:5
	s_cmp_gt_i32 s40, -1
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v226, v228, v229
	.loc	1 419 5                         ; f16_gemm_gfx1250.py:419:5
	s_cselect_b32 s12, s1, 0
	s_and_b32 s5, s13, 0x7fff0000
	s_lshl_b32 s1, s33, 14
	s_lshr_b64 s[14:15], s[12:13], 16
	s_sub_co_i32 s7, s5, s34
	s_lshl_b32 s5, s12, 16
	s_and_b32 s6, s14, 0x7fff
	s_lshr_b32 s12, s14, 16
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v227, v230, v231
	.loc	1 419 5                         ; f16_gemm_gfx1250.py:419:5
	s_add_co_i32 s7, s7, s12
	s_set_vgpr_msb 0x50                     ;  msbs: dst=1 src0=0 src1=0 src2=1
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	v_add3_u32 v0 /*v256*/, 0, s35, v97 /*v353*/
	s_set_vgpr_msb 0x5000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	.loc	1 418 22 is_stmt 0              ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v228, v232, v233
	v_cvt_pk_bf16_f32 v229, v234, v235
	v_cvt_pk_bf16_f32 v230, v236, v237
	v_cvt_pk_bf16_f32 v231, v238, v239
	s_set_vgpr_msb 5                        ;  msbs: dst=0 src0=1 src1=1 src2=0
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	v_add3_u32 v232, v0 /*v256*/, v96 /*v352*/, s16
	s_set_vgpr_msb 0x500                    ;  msbs: dst=0 src0=0 src1=0 src2=0
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v216, v216, v217
	v_cvt_pk_bf16_f32 v217, v218, v219
	v_cvt_pk_bf16_f32 v218, v220, v221
	v_cvt_pk_bf16_f32 v219, v222, v223
	v_cvt_pk_bf16_f32 v200, v200, v201
	v_cvt_pk_bf16_f32 v201, v202, v203
	v_cvt_pk_bf16_f32 v202, v204, v205
	v_cvt_pk_bf16_f32 v203, v206, v207
	.loc	1 419 5 is_stmt 1               ; f16_gemm_gfx1250.py:419:5
	s_max_i32 s7, s7, 0
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v168, v168, v169
	.loc	1 419 5                         ; f16_gemm_gfx1250.py:419:5
	s_lshl_b32 s12, s7, 16
	s_lshr_b32 s7, s7, 16
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v169, v170, v171
	v_cvt_pk_bf16_f32 v170, v172, v173
	v_cvt_pk_bf16_f32 v171, v174, v175
	.loc	1 418 5 is_stmt 0               ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[224:227]
	ds_store_b128 v232, v[228:231] offset:64
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v144, v144, v145
	v_cvt_pk_bf16_f32 v145, v146, v147
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[216:219] offset:128
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v146, v148, v149
	v_cvt_pk_bf16_f32 v147, v150, v151
	v_cvt_pk_bf16_f32 v136, v136, v137
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[200:203] offset:192
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v137, v138, v139
	v_cvt_pk_bf16_f32 v138, v140, v141
	v_cvt_pk_bf16_f32 v139, v142, v143
	v_cvt_pk_bf16_f32 v128, v128, v129
	v_cvt_pk_bf16_f32 v129, v130, v131
	v_cvt_pk_bf16_f32 v130, v132, v133
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[168:171] offset:8192
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v131, v134, v135
	v_cvt_pk_bf16_f32 v112, v112, v113
	v_cvt_pk_bf16_f32 v113, v114, v115
	v_cvt_pk_bf16_f32 v114, v116, v117
	v_cvt_pk_bf16_f32 v115, v118, v119
	v_cvt_pk_bf16_f32 v96, v96, v97
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[144:147] offset:8256
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v97, v98, v99
	v_cvt_pk_bf16_f32 v98, v100, v101
	v_cvt_pk_bf16_f32 v99, v102, v103
	v_cvt_pk_bf16_f32 v72, v72, v73
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[136:139] offset:8320
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v73, v74, v75
	v_cvt_pk_bf16_f32 v74, v76, v77
	v_cvt_pk_bf16_f32 v75, v78, v79
	v_cvt_pk_bf16_f32 v56, v56, v57
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[128:131] offset:8384
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v57, v58, v59
	v_cvt_pk_bf16_f32 v58, v60, v61
	v_cvt_pk_bf16_f32 v59, v62, v63
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[112:115] offset:16384
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v40, v40, v41
	v_cvt_pk_bf16_f32 v41, v42, v43
	v_cvt_pk_bf16_f32 v42, v44, v45
	v_cvt_pk_bf16_f32 v43, v46, v47
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[96:99] offset:16448
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v32, v32, v33
	v_cvt_pk_bf16_f32 v33, v34, v35
	v_cvt_pk_bf16_f32 v34, v36, v37
	v_cvt_pk_bf16_f32 v35, v38, v39
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[72:75] offset:16512
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v24, v24, v25
	v_cvt_pk_bf16_f32 v25, v26, v27
	v_cvt_pk_bf16_f32 v26, v28, v29
	v_cvt_pk_bf16_f32 v27, v30, v31
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[56:59] offset:16576
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v8, v8, v9
	v_cvt_pk_bf16_f32 v9, v10, v11
	v_cvt_pk_bf16_f32 v10, v12, v13
	v_cvt_pk_bf16_f32 v11, v14, v15
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[40:43] offset:24576
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v12, v16, v17
	v_cvt_pk_bf16_f32 v13, v18, v19
	v_cvt_pk_bf16_f32 v14, v20, v21
	v_cvt_pk_bf16_f32 v15, v22, v23
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[32:35] offset:24640
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v0, v0, v1
	v_cvt_pk_bf16_f32 v1, v2, v3
	v_cvt_pk_bf16_f32 v2, v4, v5
	v_cvt_pk_bf16_f32 v3, v6, v7
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[24:27] offset:24704
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v4, v48, v49
	v_cvt_pk_bf16_f32 v5, v50, v51
	v_cvt_pk_bf16_f32 v6, v52, v53
	v_cvt_pk_bf16_f32 v7, v54, v55
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[8:11] offset:24768
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v8, v64, v65
	v_cvt_pk_bf16_f32 v9, v66, v67
	v_cvt_pk_bf16_f32 v10, v68, v69
	v_cvt_pk_bf16_f32 v11, v70, v71
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[12:15] offset:32768
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v12, v80, v81
	v_cvt_pk_bf16_f32 v13, v82, v83
	v_cvt_pk_bf16_f32 v14, v84, v85
	v_cvt_pk_bf16_f32 v15, v86, v87
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[0:3] offset:32832
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v0, v88, v89
	v_cvt_pk_bf16_f32 v1, v90, v91
	v_cvt_pk_bf16_f32 v2, v92, v93
	v_cvt_pk_bf16_f32 v3, v94, v95
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[4:7] offset:32896
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v4, v104, v105
	v_cvt_pk_bf16_f32 v5, v106, v107
	v_cvt_pk_bf16_f32 v6, v108, v109
	v_cvt_pk_bf16_f32 v7, v110, v111
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[8:11] offset:32960
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v8, v120, v121
	v_cvt_pk_bf16_f32 v9, v122, v123
	v_cvt_pk_bf16_f32 v10, v124, v125
	v_cvt_pk_bf16_f32 v11, v126, v127
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[12:15] offset:40960
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v12, v152, v153
	v_cvt_pk_bf16_f32 v13, v154, v155
	v_cvt_pk_bf16_f32 v14, v156, v157
	v_cvt_pk_bf16_f32 v15, v158, v159
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[0:3] offset:41024
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v0, v160, v161
	v_cvt_pk_bf16_f32 v1, v162, v163
	v_cvt_pk_bf16_f32 v2, v164, v165
	v_cvt_pk_bf16_f32 v3, v166, v167
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[4:7] offset:41088
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v4, v176, v177
	v_cvt_pk_bf16_f32 v5, v178, v179
	v_cvt_pk_bf16_f32 v6, v180, v181
	v_cvt_pk_bf16_f32 v7, v182, v183
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[8:11] offset:41152
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v8, v192, v193
	v_cvt_pk_bf16_f32 v9, v194, v195
	v_cvt_pk_bf16_f32 v10, v196, v197
	v_cvt_pk_bf16_f32 v11, v198, v199
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[12:15] offset:49152
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v12, v184, v185
	v_cvt_pk_bf16_f32 v13, v186, v187
	v_cvt_pk_bf16_f32 v14, v188, v189
	v_cvt_pk_bf16_f32 v15, v190, v191
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[0:3] offset:49216
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v0, v208, v209
	v_cvt_pk_bf16_f32 v1, v210, v211
	v_cvt_pk_bf16_f32 v2, v212, v213
	v_cvt_pk_bf16_f32 v3, v214, v215
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[4:7] offset:49280
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v4, v240, v241
	v_cvt_pk_bf16_f32 v5, v242, v243
	v_cvt_pk_bf16_f32 v6, v244, v245
	v_cvt_pk_bf16_f32 v7, v246, v247
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[8:11] offset:49344
	.loc	1 418 22                        ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v8, v248, v249
	v_cvt_pk_bf16_f32 v9, v250, v251
	v_cvt_pk_bf16_f32 v10, v252, v253
	.loc	1 419 5 is_stmt 1               ; f16_gemm_gfx1250.py:419:5
	s_or_b32 s6, s12, s6
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[12:15] offset:57344
	.loc	1 418 22 is_stmt 0              ; f16_gemm_gfx1250.py:418:22
	v_cvt_pk_bf16_f32 v11, v254, v255
	.loc	1 419 5 is_stmt 1               ; f16_gemm_gfx1250.py:419:5
	s_bitset1_b32 s7, 23
	.loc	1 418 5                         ; f16_gemm_gfx1250.py:418:5
	ds_store_b128 v232, v[0:3] offset:57408
	ds_store_b128 v232, v[4:7] offset:57472
	ds_store_b128 v232, v[8:11] offset:57536
	.loc	1 419 5                         ; f16_gemm_gfx1250.py:419:5
	s_wait_dscnt 0x0
	s_barrier_signal -1
	s_barrier_wait -1
	tensor_store_from_lds s[0:3], s[4:11]
	.loc	1 420 5                         ; f16_gemm_gfx1250.py:420:5
	s_wait_tensorcnt 0x0
	s_barrier_signal -1
	s_barrier_wait -1
	.loc	1 307 1                         ; f16_gemm_gfx1250.py:307:1
	s_endpgm
.Ltmp204:
.Lfunc_end0:
	.size	gemm_tdm_pipelined_single_warp_per_simd_schedule_kernel, .Lfunc_end0-gemm_tdm_pipelined_single_warp_per_simd_schedule_kernel
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel gemm_tdm_pipelined_single_warp_per_simd_schedule_kernel
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 64
		.amdhsa_user_sgpr_count 18
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_kernarg_preload_length 16
		.amdhsa_user_sgpr_kernarg_preload_offset 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 1
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 622
		.amdhsa_next_free_sgpr 60
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
		.amdhsa_inst_pref_size ((instprefsize(.Lfunc_end0-gemm_tdm_pipelined_single_warp_per_simd_schedule_kernel)<<4)&4080)>>4
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
	.set .Lgemm_tdm_pipelined_single_warp_per_simd_schedule_kernel.num_vgpr, 622
	.set .Lgemm_tdm_pipelined_single_warp_per_simd_schedule_kernel.num_agpr, 0
	.set .Lgemm_tdm_pipelined_single_warp_per_simd_schedule_kernel.numbered_sgpr, 60
	.set .Lgemm_tdm_pipelined_single_warp_per_simd_schedule_kernel.num_named_barrier, 0
	.set .Lgemm_tdm_pipelined_single_warp_per_simd_schedule_kernel.private_seg_size, 0
	.set .Lgemm_tdm_pipelined_single_warp_per_simd_schedule_kernel.uses_vcc, 0
	.set .Lgemm_tdm_pipelined_single_warp_per_simd_schedule_kernel.uses_flat_scratch, 0
	.set .Lgemm_tdm_pipelined_single_warp_per_simd_schedule_kernel.has_dyn_sized_stack, 0
	.set .Lgemm_tdm_pipelined_single_warp_per_simd_schedule_kernel.has_recursion, 0
	.set .Lgemm_tdm_pipelined_single_warp_per_simd_schedule_kernel.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 6460
; TotalNumSgprs: 60
; NumVgprs: 622
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 38
; NumSGPRsForWavesPerEU: 60
; NumVGPRsForWavesPerEU: 622
; NamedBarCnt: 0
; Occupancy: 1
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 18
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
	.byte	0                               ; EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 ; Length of Unit
.Ldebug_info_start0:
	.short	4                               ; DWARF version number
	.long	.debug_abbrev                   ; Offset Into Abbrev. Section
	.byte	8                               ; Address Size (in bytes)
	.byte	1                               ; Abbrev [1] 0xb:0xc7 DW_TAG_compile_unit
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
	.byte	3                               ; Abbrev [3] 0x30:0xa1 DW_TAG_subprogram
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       ; DW_AT_high_pc
	.long	42                              ; DW_AT_abstract_origin
	.byte	4                               ; Abbrev [4] 0x41:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges0                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	361                             ; DW_AT_call_line
	.byte	14                              ; DW_AT_call_column
	.byte	4                               ; Abbrev [4] 0x4e:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges1                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	337                             ; DW_AT_call_line
	.byte	17                              ; DW_AT_call_column
	.byte	4                               ; Abbrev [4] 0x5b:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges2                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	357                             ; DW_AT_call_line
	.byte	20                              ; DW_AT_call_column
	.byte	4                               ; Abbrev [4] 0x68:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges3                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	341                             ; DW_AT_call_line
	.byte	22                              ; DW_AT_call_column
	.byte	4                               ; Abbrev [4] 0x75:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges4                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	364                             ; DW_AT_call_line
	.byte	15                              ; DW_AT_call_column
	.byte	4                               ; Abbrev [4] 0x82:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges5                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	369                             ; DW_AT_call_line
	.byte	16                              ; DW_AT_call_column
	.byte	4                               ; Abbrev [4] 0x8f:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges6                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	377                             ; DW_AT_call_line
	.byte	18                              ; DW_AT_call_column
	.byte	4                               ; Abbrev [4] 0x9c:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges7                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	410                             ; DW_AT_call_line
	.byte	20                              ; DW_AT_call_column
	.byte	4                               ; Abbrev [4] 0xa9:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges8                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	413                             ; DW_AT_call_line
	.byte	18                              ; DW_AT_call_column
	.byte	4                               ; Abbrev [4] 0xb6:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges9                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	387                             ; DW_AT_call_line
	.byte	18                              ; DW_AT_call_column
	.byte	4                               ; Abbrev [4] 0xc3:0xd DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges10                ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	394                             ; DW_AT_call_line
	.byte	18                              ; DW_AT_call_column
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.quad	.Ltmp0-.Lfunc_begin0
	.quad	.Ltmp1-.Lfunc_begin0
	.quad	.Ltmp3-.Lfunc_begin0
	.quad	.Ltmp4-.Lfunc_begin0
	.quad	.Ltmp27-.Lfunc_begin0
	.quad	.Ltmp28-.Lfunc_begin0
	.quad	.Ltmp29-.Lfunc_begin0
	.quad	.Ltmp30-.Lfunc_begin0
	.quad	.Ltmp31-.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	.Ltmp37-.Lfunc_begin0
	.quad	.Ltmp38-.Lfunc_begin0
	.quad	.Ltmp41-.Lfunc_begin0
	.quad	.Ltmp42-.Lfunc_begin0
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp46-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	.Ltmp51-.Lfunc_begin0
	.quad	.Ltmp54-.Lfunc_begin0
	.quad	.Ltmp55-.Lfunc_begin0
	.quad	.Ltmp201-.Lfunc_begin0
	.quad	.Ltmp202-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges1:
	.quad	.Ltmp1-.Lfunc_begin0
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp4-.Lfunc_begin0
	.quad	.Ltmp5-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges2:
	.quad	.Ltmp6-.Lfunc_begin0
	.quad	.Ltmp7-.Lfunc_begin0
	.quad	.Ltmp8-.Lfunc_begin0
	.quad	.Ltmp9-.Lfunc_begin0
	.quad	.Ltmp10-.Lfunc_begin0
	.quad	.Ltmp11-.Lfunc_begin0
	.quad	.Ltmp12-.Lfunc_begin0
	.quad	.Ltmp13-.Lfunc_begin0
	.quad	.Ltmp14-.Lfunc_begin0
	.quad	.Ltmp15-.Lfunc_begin0
	.quad	.Ltmp17-.Lfunc_begin0
	.quad	.Ltmp18-.Lfunc_begin0
	.quad	.Ltmp22-.Lfunc_begin0
	.quad	.Ltmp23-.Lfunc_begin0
	.quad	.Ltmp24-.Lfunc_begin0
	.quad	.Ltmp25-.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	.Ltmp27-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	.Ltmp51-.Lfunc_begin0
	.quad	.Ltmp52-.Lfunc_begin0
	.quad	.Ltmp202-.Lfunc_begin0
	.quad	.Ltmp203-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges3:
	.quad	.Ltmp16-.Lfunc_begin0
	.quad	.Ltmp17-.Lfunc_begin0
	.quad	.Ltmp19-.Lfunc_begin0
	.quad	.Ltmp20-.Lfunc_begin0
	.quad	.Ltmp21-.Lfunc_begin0
	.quad	.Ltmp22-.Lfunc_begin0
	.quad	.Ltmp23-.Lfunc_begin0
	.quad	.Ltmp24-.Lfunc_begin0
	.quad	.Ltmp25-.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges4:
	.quad	.Ltmp30-.Lfunc_begin0
	.quad	.Ltmp31-.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	.Ltmp33-.Lfunc_begin0
	.quad	.Ltmp34-.Lfunc_begin0
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp37-.Lfunc_begin0
	.quad	.Ltmp38-.Lfunc_begin0
	.quad	.Ltmp39-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges5:
	.quad	.Ltmp33-.Lfunc_begin0
	.quad	.Ltmp34-.Lfunc_begin0
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp40-.Lfunc_begin0
	.quad	.Ltmp41-.Lfunc_begin0
	.quad	.Ltmp42-.Lfunc_begin0
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp46-.Lfunc_begin0
	.quad	.Ltmp47-.Lfunc_begin0
	.quad	.Ltmp53-.Lfunc_begin0
	.quad	.Ltmp54-.Lfunc_begin0
	.quad	.Ltmp55-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges6:
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	.Ltmp58-.Lfunc_begin0
	.quad	.Ltmp59-.Lfunc_begin0
	.quad	.Ltmp60-.Lfunc_begin0
	.quad	.Ltmp61-.Lfunc_begin0
	.quad	.Ltmp62-.Lfunc_begin0
	.quad	.Ltmp63-.Lfunc_begin0
	.quad	.Ltmp64-.Lfunc_begin0
	.quad	.Ltmp65-.Lfunc_begin0
	.quad	.Ltmp66-.Lfunc_begin0
	.quad	.Ltmp67-.Lfunc_begin0
	.quad	.Ltmp68-.Lfunc_begin0
	.quad	.Ltmp69-.Lfunc_begin0
	.quad	.Ltmp70-.Lfunc_begin0
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Ltmp72-.Lfunc_begin0
	.quad	.Ltmp73-.Lfunc_begin0
	.quad	.Ltmp74-.Lfunc_begin0
	.quad	.Ltmp77-.Lfunc_begin0
	.quad	.Ltmp78-.Lfunc_begin0
	.quad	.Ltmp79-.Lfunc_begin0
	.quad	.Ltmp80-.Lfunc_begin0
	.quad	.Ltmp82-.Lfunc_begin0
	.quad	.Ltmp83-.Lfunc_begin0
	.quad	.Ltmp84-.Lfunc_begin0
	.quad	.Ltmp85-.Lfunc_begin0
	.quad	.Ltmp87-.Lfunc_begin0
	.quad	.Ltmp88-.Lfunc_begin0
	.quad	.Ltmp89-.Lfunc_begin0
	.quad	.Ltmp90-.Lfunc_begin0
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp93-.Lfunc_begin0
	.quad	.Ltmp94-.Lfunc_begin0
	.quad	.Ltmp95-.Lfunc_begin0
	.quad	.Ltmp97-.Lfunc_begin0
	.quad	.Ltmp98-.Lfunc_begin0
	.quad	.Ltmp99-.Lfunc_begin0
	.quad	.Ltmp100-.Lfunc_begin0
	.quad	.Ltmp102-.Lfunc_begin0
	.quad	.Ltmp103-.Lfunc_begin0
	.quad	.Ltmp118-.Lfunc_begin0
	.quad	.Ltmp119-.Lfunc_begin0
	.quad	.Ltmp120-.Lfunc_begin0
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp122-.Lfunc_begin0
	.quad	.Ltmp123-.Lfunc_begin0
	.quad	.Ltmp126-.Lfunc_begin0
	.quad	.Ltmp127-.Lfunc_begin0
	.quad	.Ltmp128-.Lfunc_begin0
	.quad	.Ltmp129-.Lfunc_begin0
	.quad	.Ltmp130-.Lfunc_begin0
	.quad	.Ltmp131-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges7:
	.quad	.Ltmp62-.Lfunc_begin0
	.quad	.Ltmp63-.Lfunc_begin0
	.quad	.Ltmp66-.Lfunc_begin0
	.quad	.Ltmp67-.Lfunc_begin0
	.quad	.Ltmp74-.Lfunc_begin0
	.quad	.Ltmp75-.Lfunc_begin0
	.quad	.Ltmp76-.Lfunc_begin0
	.quad	.Ltmp77-.Lfunc_begin0
	.quad	.Ltmp78-.Lfunc_begin0
	.quad	.Ltmp79-.Lfunc_begin0
	.quad	.Ltmp81-.Lfunc_begin0
	.quad	.Ltmp82-.Lfunc_begin0
	.quad	.Ltmp83-.Lfunc_begin0
	.quad	.Ltmp84-.Lfunc_begin0
	.quad	.Ltmp86-.Lfunc_begin0
	.quad	.Ltmp87-.Lfunc_begin0
	.quad	.Ltmp88-.Lfunc_begin0
	.quad	.Ltmp89-.Lfunc_begin0
	.quad	.Ltmp91-.Lfunc_begin0
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp93-.Lfunc_begin0
	.quad	.Ltmp94-.Lfunc_begin0
	.quad	.Ltmp96-.Lfunc_begin0
	.quad	.Ltmp97-.Lfunc_begin0
	.quad	.Ltmp98-.Lfunc_begin0
	.quad	.Ltmp99-.Lfunc_begin0
	.quad	.Ltmp101-.Lfunc_begin0
	.quad	.Ltmp102-.Lfunc_begin0
	.quad	.Ltmp103-.Lfunc_begin0
	.quad	.Ltmp104-.Lfunc_begin0
	.quad	.Ltmp105-.Lfunc_begin0
	.quad	.Ltmp106-.Lfunc_begin0
	.quad	.Ltmp108-.Lfunc_begin0
	.quad	.Ltmp109-.Lfunc_begin0
	.quad	.Ltmp110-.Lfunc_begin0
	.quad	.Ltmp111-.Lfunc_begin0
	.quad	.Ltmp112-.Lfunc_begin0
	.quad	.Ltmp113-.Lfunc_begin0
	.quad	.Ltmp116-.Lfunc_begin0
	.quad	.Ltmp117-.Lfunc_begin0
	.quad	.Ltmp124-.Lfunc_begin0
	.quad	.Ltmp125-.Lfunc_begin0
	.quad	.Ltmp129-.Lfunc_begin0
	.quad	.Ltmp130-.Lfunc_begin0
	.quad	.Ltmp133-.Lfunc_begin0
	.quad	.Ltmp134-.Lfunc_begin0
	.quad	.Ltmp135-.Lfunc_begin0
	.quad	.Ltmp136-.Lfunc_begin0
	.quad	.Ltmp138-.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.quad	.Ltmp140-.Lfunc_begin0
	.quad	.Ltmp141-.Lfunc_begin0
	.quad	.Ltmp142-.Lfunc_begin0
	.quad	.Ltmp143-.Lfunc_begin0
	.quad	.Ltmp144-.Lfunc_begin0
	.quad	.Ltmp145-.Lfunc_begin0
	.quad	.Ltmp183-.Lfunc_begin0
	.quad	.Ltmp184-.Lfunc_begin0
	.quad	.Ltmp185-.Lfunc_begin0
	.quad	.Ltmp186-.Lfunc_begin0
	.quad	.Ltmp187-.Lfunc_begin0
	.quad	.Ltmp188-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges8:
	.quad	.Ltmp104-.Lfunc_begin0
	.quad	.Ltmp105-.Lfunc_begin0
	.quad	.Ltmp107-.Lfunc_begin0
	.quad	.Ltmp108-.Lfunc_begin0
	.quad	.Ltmp109-.Lfunc_begin0
	.quad	.Ltmp110-.Lfunc_begin0
	.quad	.Ltmp111-.Lfunc_begin0
	.quad	.Ltmp112-.Lfunc_begin0
	.quad	.Ltmp113-.Lfunc_begin0
	.quad	.Ltmp114-.Lfunc_begin0
	.quad	.Ltmp115-.Lfunc_begin0
	.quad	.Ltmp116-.Lfunc_begin0
	.quad	.Ltmp117-.Lfunc_begin0
	.quad	.Ltmp118-.Lfunc_begin0
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp122-.Lfunc_begin0
	.quad	.Ltmp125-.Lfunc_begin0
	.quad	.Ltmp126-.Lfunc_begin0
	.quad	.Ltmp189-.Lfunc_begin0
	.quad	.Ltmp190-.Lfunc_begin0
	.quad	.Ltmp191-.Lfunc_begin0
	.quad	.Ltmp192-.Lfunc_begin0
	.quad	.Ltmp193-.Lfunc_begin0
	.quad	.Ltmp194-.Lfunc_begin0
	.quad	.Ltmp195-.Lfunc_begin0
	.quad	.Ltmp196-.Lfunc_begin0
	.quad	.Ltmp197-.Lfunc_begin0
	.quad	.Ltmp198-.Lfunc_begin0
	.quad	.Ltmp199-.Lfunc_begin0
	.quad	.Ltmp200-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges9:
	.quad	.Ltmp131-.Lfunc_begin0
	.quad	.Ltmp132-.Lfunc_begin0
	.quad	.Ltmp134-.Lfunc_begin0
	.quad	.Ltmp135-.Lfunc_begin0
	.quad	.Ltmp136-.Lfunc_begin0
	.quad	.Ltmp137-.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.quad	.Ltmp140-.Lfunc_begin0
	.quad	.Ltmp143-.Lfunc_begin0
	.quad	.Ltmp144-.Lfunc_begin0
	.quad	.Ltmp145-.Lfunc_begin0
	.quad	.Ltmp146-.Lfunc_begin0
	.quad	.Ltmp147-.Lfunc_begin0
	.quad	.Ltmp148-.Lfunc_begin0
	.quad	.Ltmp149-.Lfunc_begin0
	.quad	.Ltmp150-.Lfunc_begin0
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
	.quad	0
	.quad	0
.Ldebug_ranges10:
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
	.quad	.Ltmp175-.Lfunc_begin0
	.quad	.Ltmp176-.Lfunc_begin0
	.quad	.Ltmp177-.Lfunc_begin0
	.quad	.Ltmp178-.Lfunc_begin0
	.quad	.Ltmp179-.Lfunc_begin0
	.quad	.Ltmp180-.Lfunc_begin0
	.quad	.Ltmp181-.Lfunc_begin0
	.quad	.Ltmp182-.Lfunc_begin0
	.quad	0
	.quad	0
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"triton"                        ; string offset=0 ; triton
.Linfo_string1:
	.asciz	"f16_gemm_gfx1250.py"           ; string offset=7 ; f16_gemm_gfx1250.py
.Linfo_string2:
	.asciz	"/var/asorenso/triton-mi450-internal/third_party/amd/python/examples/gluon" ; string offset=27 ; /var/asorenso/triton-mi450-internal/third_party/amd/python/examples/gluon
.Linfo_string3:
	.asciz	"gemm_tdm_pipelined_single_warp_per_simd_schedule_kernel" ; string offset=101 ; gemm_tdm_pipelined_single_warp_per_simd_schedule_kernel
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
      - .offset:         24
        .size:           4
        .value_kind:     by_value
      - .offset:         28
        .size:           4
        .value_kind:     by_value
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
      - .address_space:  global
        .offset:         48
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         56
        .size:           8
        .value_kind:     global_buffer
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 64
    .max_flat_workgroup_size: 128
    .name:           gemm_tdm_pipelined_single_warp_per_simd_schedule_kernel
    .private_segment_fixed_size: 0
    .sgpr_count:     60
    .sgpr_spill_count: 0
    .symbol:         gemm_tdm_pipelined_single_warp_per_simd_schedule_kernel.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     622
    .vgpr_spill_count: 0
    .wavefront_size: 32
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx1250
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
	.section	.debug_line,"",@progbits
.Lline_table_start0:
