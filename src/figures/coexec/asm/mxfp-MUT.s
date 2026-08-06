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
	v_and_b32_e32 v22, 15, v0
	v_dual_mov_b32 v4, 0 :: v_dual_bitop2_b32 v23, 16, v0 bitop3:0x40
	v_and_b32_e32 v1, 31, v0
.Ltmp1:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_dual_lshrrev_b32 v0, 1, v0 :: v_dual_lshlrev_b32 v2, 8, v22
.Ltmp2:
	.file	2 "/var/asorenso/triton-mi450-internal/python/triton/language" "standard.py"
	.loc	2 43 13                         ; standard.py:43:13 @[ mxfp_gemm_gfx1250.py:1449:17 ]
	s_addk_co_i32 s11, 0xff
	v_dual_mov_b32 v5, v4 :: v_dual_mov_b32 v6, v4
	v_dual_mov_b32 v7, v4 :: v_dual_mov_b32 v8, v4
	v_dual_mov_b32 v9, v4 :: v_dual_mov_b32 v10, v4
	v_mov_b32_e32 v11, v4
	s_set_vgpr_msb 0x80                     ;  msbs: dst=2 src0=0 src1=0 src2=0
	v_dual_mov_b32 v112 /*v624*/, v4 :: v_dual_mov_b32 v113 /*v625*/, v4
	v_dual_mov_b32 v114 /*v626*/, v4 :: v_dual_mov_b32 v115 /*v627*/, v4
	v_dual_mov_b32 v116 /*v628*/, v4 :: v_dual_mov_b32 v117 /*v629*/, v4
	v_dual_mov_b32 v118 /*v630*/, v4 :: v_dual_mov_b32 v119 /*v631*/, v4
	v_dual_mov_b32 v104 /*v616*/, v4 :: v_dual_mov_b32 v105 /*v617*/, v4
	v_dual_mov_b32 v106 /*v618*/, v4 :: v_dual_mov_b32 v107 /*v619*/, v4
	v_dual_mov_b32 v108 /*v620*/, v4 :: v_dual_mov_b32 v109 /*v621*/, v4
	v_dual_mov_b32 v110 /*v622*/, v4 :: v_dual_mov_b32 v111 /*v623*/, v4
	v_dual_mov_b32 v96 /*v608*/, v4 :: v_dual_mov_b32 v97 /*v609*/, v4
	v_dual_mov_b32 v98 /*v610*/, v4 :: v_dual_mov_b32 v99 /*v611*/, v4
	v_dual_mov_b32 v100 /*v612*/, v4 :: v_dual_mov_b32 v101 /*v613*/, v4
	v_dual_mov_b32 v102 /*v614*/, v4 :: v_dual_mov_b32 v103 /*v615*/, v4
	v_dual_mov_b32 v88 /*v600*/, v4 :: v_dual_mov_b32 v89 /*v601*/, v4
	v_dual_mov_b32 v90 /*v602*/, v4 :: v_dual_mov_b32 v91 /*v603*/, v4
	v_dual_mov_b32 v92 /*v604*/, v4 :: v_dual_mov_b32 v93 /*v605*/, v4
	v_dual_mov_b32 v94 /*v606*/, v4 :: v_dual_mov_b32 v95 /*v607*/, v4
	v_dual_mov_b32 v80 /*v592*/, v4 :: v_dual_mov_b32 v81 /*v593*/, v4
	v_dual_mov_b32 v82 /*v594*/, v4 :: v_dual_mov_b32 v83 /*v595*/, v4
	v_dual_mov_b32 v84 /*v596*/, v4 :: v_dual_mov_b32 v85 /*v597*/, v4
	v_dual_mov_b32 v86 /*v598*/, v4 :: v_dual_mov_b32 v87 /*v599*/, v4
	v_dual_mov_b32 v72 /*v584*/, v4 :: v_dual_mov_b32 v73 /*v585*/, v4
	v_dual_mov_b32 v74 /*v586*/, v4 :: v_dual_mov_b32 v75 /*v587*/, v4
	v_dual_mov_b32 v76 /*v588*/, v4 :: v_dual_mov_b32 v77 /*v589*/, v4
	v_dual_mov_b32 v78 /*v590*/, v4 :: v_dual_mov_b32 v79 /*v591*/, v4
	v_dual_mov_b32 v64 /*v576*/, v4 :: v_dual_mov_b32 v65 /*v577*/, v4
	v_dual_mov_b32 v66 /*v578*/, v4 :: v_dual_mov_b32 v67 /*v579*/, v4
	v_dual_mov_b32 v68 /*v580*/, v4 :: v_dual_mov_b32 v69 /*v581*/, v4
	v_dual_mov_b32 v70 /*v582*/, v4 :: v_dual_mov_b32 v71 /*v583*/, v4
	v_dual_mov_b32 v56 /*v568*/, v4 :: v_dual_mov_b32 v57 /*v569*/, v4
	v_dual_mov_b32 v58 /*v570*/, v4 :: v_dual_mov_b32 v59 /*v571*/, v4
	v_dual_mov_b32 v60 /*v572*/, v4 :: v_dual_mov_b32 v61 /*v573*/, v4
	v_dual_mov_b32 v62 /*v574*/, v4 :: v_dual_mov_b32 v63 /*v575*/, v4
	v_dual_mov_b32 v48 /*v560*/, v4 :: v_dual_mov_b32 v49 /*v561*/, v4
	v_dual_mov_b32 v50 /*v562*/, v4 :: v_dual_mov_b32 v51 /*v563*/, v4
	v_dual_mov_b32 v52 /*v564*/, v4 :: v_dual_mov_b32 v53 /*v565*/, v4
	v_dual_mov_b32 v54 /*v566*/, v4 :: v_dual_mov_b32 v55 /*v567*/, v4
	v_dual_mov_b32 v40 /*v552*/, v4 :: v_dual_mov_b32 v41 /*v553*/, v4
	v_dual_mov_b32 v42 /*v554*/, v4 :: v_dual_mov_b32 v43 /*v555*/, v4
	v_dual_mov_b32 v44 /*v556*/, v4 :: v_dual_mov_b32 v45 /*v557*/, v4
	v_dual_mov_b32 v46 /*v558*/, v4 :: v_dual_mov_b32 v47 /*v559*/, v4
	v_dual_mov_b32 v32 /*v544*/, v4 :: v_dual_mov_b32 v33 /*v545*/, v4
	v_dual_mov_b32 v34 /*v546*/, v4 :: v_dual_mov_b32 v35 /*v547*/, v4
	v_dual_mov_b32 v36 /*v548*/, v4 :: v_dual_mov_b32 v37 /*v549*/, v4
	v_dual_mov_b32 v38 /*v550*/, v4 :: v_dual_mov_b32 v39 /*v551*/, v4
	v_dual_mov_b32 v24 /*v536*/, v4 :: v_dual_mov_b32 v25 /*v537*/, v4
	v_dual_mov_b32 v26 /*v538*/, v4 :: v_dual_mov_b32 v27 /*v539*/, v4
	v_dual_mov_b32 v28 /*v540*/, v4 :: v_dual_mov_b32 v29 /*v541*/, v4
	v_dual_mov_b32 v30 /*v542*/, v4 :: v_dual_mov_b32 v31 /*v543*/, v4
	v_dual_mov_b32 v16 /*v528*/, v4 :: v_dual_mov_b32 v17 /*v529*/, v4
	v_dual_mov_b32 v18 /*v530*/, v4 :: v_dual_mov_b32 v19 /*v531*/, v4
	v_dual_mov_b32 v20 /*v532*/, v4 :: v_dual_mov_b32 v21 /*v533*/, v4
	v_dual_mov_b32 v22 /*v534*/, v4 :: v_dual_mov_b32 v23 /*v535*/, v4
	v_dual_mov_b32 v8 /*v520*/, v4 :: v_dual_mov_b32 v9 /*v521*/, v4
	v_dual_mov_b32 v10 /*v522*/, v4 :: v_dual_mov_b32 v11 /*v523*/, v4
	v_dual_mov_b32 v12 /*v524*/, v4 :: v_dual_mov_b32 v13 /*v525*/, v4
	v_dual_mov_b32 v14 /*v526*/, v4 :: v_dual_mov_b32 v15 /*v527*/, v4
	v_dual_mov_b32 v0 /*v512*/, v4 :: v_dual_mov_b32 v1 /*v513*/, v4
	v_dual_mov_b32 v2 /*v514*/, v4 :: v_dual_mov_b32 v3 /*v515*/, v4
	v_dual_mov_b32 v4 /*v516*/, v4 :: v_dual_mov_b32 v5 /*v517*/, v4
	v_dual_mov_b32 v6 /*v518*/, v4 :: v_dual_mov_b32 v7 /*v519*/, v4
	s_set_vgpr_msb 0x8040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
	v_dual_mov_b32 v248 /*v504*/, v4 :: v_dual_mov_b32 v249 /*v505*/, v4
	v_dual_mov_b32 v250 /*v506*/, v4 :: v_dual_mov_b32 v251 /*v507*/, v4
	v_dual_mov_b32 v252 /*v508*/, v4 :: v_dual_mov_b32 v253 /*v509*/, v4
	v_dual_mov_b32 v254 /*v510*/, v4 :: v_dual_mov_b32 v255 /*v511*/, v4
	v_dual_mov_b32 v240 /*v496*/, v4 :: v_dual_mov_b32 v241 /*v497*/, v4
	v_dual_mov_b32 v242 /*v498*/, v4 :: v_dual_mov_b32 v243 /*v499*/, v4
	v_dual_mov_b32 v244 /*v500*/, v4 :: v_dual_mov_b32 v245 /*v501*/, v4
	v_dual_mov_b32 v246 /*v502*/, v4 :: v_dual_mov_b32 v247 /*v503*/, v4
	v_dual_mov_b32 v232 /*v488*/, v4 :: v_dual_mov_b32 v233 /*v489*/, v4
	v_dual_mov_b32 v234 /*v490*/, v4 :: v_dual_mov_b32 v235 /*v491*/, v4
	v_dual_mov_b32 v236 /*v492*/, v4 :: v_dual_mov_b32 v237 /*v493*/, v4
	v_dual_mov_b32 v238 /*v494*/, v4 :: v_dual_mov_b32 v239 /*v495*/, v4
	v_dual_mov_b32 v224 /*v480*/, v4 :: v_dual_mov_b32 v225 /*v481*/, v4
	v_dual_mov_b32 v226 /*v482*/, v4 :: v_dual_mov_b32 v227 /*v483*/, v4
	v_dual_mov_b32 v228 /*v484*/, v4 :: v_dual_mov_b32 v229 /*v485*/, v4
	v_dual_mov_b32 v230 /*v486*/, v4 :: v_dual_mov_b32 v231 /*v487*/, v4
	v_dual_mov_b32 v216 /*v472*/, v4 :: v_dual_mov_b32 v217 /*v473*/, v4
	v_dual_mov_b32 v218 /*v474*/, v4 :: v_dual_mov_b32 v219 /*v475*/, v4
	v_dual_mov_b32 v220 /*v476*/, v4 :: v_dual_mov_b32 v221 /*v477*/, v4
	v_dual_mov_b32 v222 /*v478*/, v4 :: v_dual_mov_b32 v223 /*v479*/, v4
	v_dual_mov_b32 v208 /*v464*/, v4 :: v_dual_mov_b32 v209 /*v465*/, v4
	v_dual_mov_b32 v210 /*v466*/, v4 :: v_dual_mov_b32 v211 /*v467*/, v4
	v_dual_mov_b32 v212 /*v468*/, v4 :: v_dual_mov_b32 v213 /*v469*/, v4
	v_dual_mov_b32 v214 /*v470*/, v4 :: v_dual_mov_b32 v215 /*v471*/, v4
	v_dual_mov_b32 v200 /*v456*/, v4 :: v_dual_mov_b32 v201 /*v457*/, v4
	v_dual_mov_b32 v202 /*v458*/, v4 :: v_dual_mov_b32 v203 /*v459*/, v4
	v_dual_mov_b32 v204 /*v460*/, v4 :: v_dual_mov_b32 v205 /*v461*/, v4
	v_dual_mov_b32 v206 /*v462*/, v4 :: v_dual_mov_b32 v207 /*v463*/, v4
	v_dual_mov_b32 v192 /*v448*/, v4 :: v_dual_mov_b32 v193 /*v449*/, v4
	v_dual_mov_b32 v194 /*v450*/, v4 :: v_dual_mov_b32 v195 /*v451*/, v4
	v_dual_mov_b32 v196 /*v452*/, v4 :: v_dual_mov_b32 v197 /*v453*/, v4
	v_dual_mov_b32 v198 /*v454*/, v4 :: v_dual_mov_b32 v199 /*v455*/, v4
	v_dual_mov_b32 v184 /*v440*/, v4 :: v_dual_mov_b32 v185 /*v441*/, v4
	v_dual_mov_b32 v186 /*v442*/, v4 :: v_dual_mov_b32 v187 /*v443*/, v4
	v_dual_mov_b32 v188 /*v444*/, v4 :: v_dual_mov_b32 v189 /*v445*/, v4
	v_dual_mov_b32 v190 /*v446*/, v4 :: v_dual_mov_b32 v191 /*v447*/, v4
	v_dual_mov_b32 v176 /*v432*/, v4 :: v_dual_mov_b32 v177 /*v433*/, v4
	v_dual_mov_b32 v178 /*v434*/, v4 :: v_dual_mov_b32 v179 /*v435*/, v4
	v_dual_mov_b32 v180 /*v436*/, v4 :: v_dual_mov_b32 v181 /*v437*/, v4
	v_dual_mov_b32 v182 /*v438*/, v4 :: v_dual_mov_b32 v183 /*v439*/, v4
	v_dual_mov_b32 v168 /*v424*/, v4 :: v_dual_mov_b32 v169 /*v425*/, v4
	v_dual_mov_b32 v170 /*v426*/, v4 :: v_dual_mov_b32 v171 /*v427*/, v4
	v_dual_mov_b32 v172 /*v428*/, v4 :: v_dual_mov_b32 v173 /*v429*/, v4
	v_dual_mov_b32 v174 /*v430*/, v4 :: v_dual_mov_b32 v175 /*v431*/, v4
	v_dual_mov_b32 v160 /*v416*/, v4 :: v_dual_mov_b32 v161 /*v417*/, v4
	v_dual_mov_b32 v162 /*v418*/, v4 :: v_dual_mov_b32 v163 /*v419*/, v4
	v_dual_mov_b32 v164 /*v420*/, v4 :: v_dual_mov_b32 v165 /*v421*/, v4
	v_dual_mov_b32 v166 /*v422*/, v4 :: v_dual_mov_b32 v167 /*v423*/, v4
	v_dual_mov_b32 v152 /*v408*/, v4 :: v_dual_mov_b32 v153 /*v409*/, v4
	v_dual_mov_b32 v154 /*v410*/, v4 :: v_dual_mov_b32 v155 /*v411*/, v4
	v_dual_mov_b32 v156 /*v412*/, v4 :: v_dual_mov_b32 v157 /*v413*/, v4
	v_dual_mov_b32 v158 /*v414*/, v4 :: v_dual_mov_b32 v159 /*v415*/, v4
	v_dual_mov_b32 v144 /*v400*/, v4 :: v_dual_mov_b32 v145 /*v401*/, v4
	v_dual_mov_b32 v146 /*v402*/, v4 :: v_dual_mov_b32 v147 /*v403*/, v4
	v_dual_mov_b32 v148 /*v404*/, v4 :: v_dual_mov_b32 v149 /*v405*/, v4
	v_dual_mov_b32 v150 /*v406*/, v4 :: v_dual_mov_b32 v151 /*v407*/, v4
	v_dual_mov_b32 v136 /*v392*/, v4 :: v_dual_mov_b32 v137 /*v393*/, v4
	v_dual_mov_b32 v138 /*v394*/, v4 :: v_dual_mov_b32 v139 /*v395*/, v4
	v_dual_mov_b32 v140 /*v396*/, v4 :: v_dual_mov_b32 v141 /*v397*/, v4
	v_dual_mov_b32 v142 /*v398*/, v4 :: v_dual_mov_b32 v143 /*v399*/, v4
	v_dual_mov_b32 v128 /*v384*/, v4 :: v_dual_mov_b32 v129 /*v385*/, v4
	v_dual_mov_b32 v130 /*v386*/, v4 :: v_dual_mov_b32 v131 /*v387*/, v4
	v_dual_mov_b32 v132 /*v388*/, v4 :: v_dual_mov_b32 v133 /*v389*/, v4
	v_dual_mov_b32 v134 /*v390*/, v4 :: v_dual_mov_b32 v135 /*v391*/, v4
	s_set_vgpr_msb 0x40c0                   ;  msbs: dst=3 src0=0 src1=0 src2=0
	v_dual_mov_b32 v72 /*v840*/, v4 :: v_dual_mov_b32 v73 /*v841*/, v4
	v_dual_mov_b32 v74 /*v842*/, v4 :: v_dual_mov_b32 v75 /*v843*/, v4
	v_dual_mov_b32 v76 /*v844*/, v4 :: v_dual_mov_b32 v77 /*v845*/, v4
	v_dual_mov_b32 v78 /*v846*/, v4 :: v_dual_mov_b32 v79 /*v847*/, v4
	v_dual_mov_b32 v64 /*v832*/, v4 :: v_dual_mov_b32 v65 /*v833*/, v4
	v_dual_mov_b32 v66 /*v834*/, v4 :: v_dual_mov_b32 v67 /*v835*/, v4
	v_dual_mov_b32 v68 /*v836*/, v4 :: v_dual_mov_b32 v69 /*v837*/, v4
	v_dual_mov_b32 v70 /*v838*/, v4 :: v_dual_mov_b32 v71 /*v839*/, v4
	v_mov_b32_e32 v56 /*v824*/, v4
	.loc	2 43 12 is_stmt 0               ; standard.py:43:12 @[ mxfp_gemm_gfx1250.py:1449:17 ]
	s_ashr_i32 s13, s11, 31
	v_mov_b32_e32 v57 /*v825*/, v4
	s_lshr_b32 s13, s13, 24
	v_mov_b32_e32 v58 /*v826*/, v4
	s_add_co_i32 s11, s11, s13
	v_mov_b32_e32 v59 /*v827*/, v4
	s_ashr_i32 s13, s11, 8
	v_mov_b32_e32 v60 /*v828*/, v4
.Ltmp3:
	.loc	1 1450 24 is_stmt 1             ; mxfp_gemm_gfx1250.py:1450:24
	s_lshl_b32 s13, s13, 3
	v_mov_b32_e32 v61 /*v829*/, v4
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_abs_i32 s15, s13
	v_mov_b32_e32 v62 /*v830*/, v4
	s_cvt_f32_u32 s17, s15
	v_mov_b32_e32 v63 /*v831*/, v4
.Ltmp4:
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_bfe_u32 s35, ttmp8, 0x50019
	v_mov_b32_e32 v96 /*v864*/, v4
.Ltmp5:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	v_s_rcp_f32 s17, s17
	v_dual_mov_b32 v97 /*v865*/, v4 :: v_dual_mov_b32 v98 /*v866*/, v4
	v_dual_mov_b32 v99 /*v867*/, v4 :: v_dual_mov_b32 v100 /*v868*/, v4
	v_dual_mov_b32 v101 /*v869*/, v4 :: v_dual_mov_b32 v102 /*v870*/, v4
	v_dual_mov_b32 v103 /*v871*/, v4 :: v_dual_mov_b32 v88 /*v856*/, v4
	v_dual_mov_b32 v89 /*v857*/, v4 :: v_dual_mov_b32 v90 /*v858*/, v4
	v_dual_mov_b32 v91 /*v859*/, v4 :: v_dual_mov_b32 v92 /*v860*/, v4
	v_dual_mov_b32 v93 /*v861*/, v4 :: v_dual_mov_b32 v94 /*v862*/, v4
	v_dual_mov_b32 v95 /*v863*/, v4 :: v_dual_mov_b32 v80 /*v848*/, v4
	s_ashr_i32 s18, ttmp9, 31
	s_abs_i32 s19, ttmp9
.Ltmp6:
	.loc	2 43 13                         ; standard.py:43:13 @[ mxfp_gemm_gfx1250.py:1448:17 ]
	s_add_co_i32 s20, s10, 0xff
.Ltmp7:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_ashr_i32 s11, s11, 31
.Ltmp8:
	.loc	2 43 12                         ; standard.py:43:12 @[ mxfp_gemm_gfx1250.py:1448:17 ]
	s_ashr_i32 s21, s20, 31
.Ltmp9:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_xor_b32 s11, s18, s11
.Ltmp10:
	.loc	2 43 12                         ; standard.py:43:12 @[ mxfp_gemm_gfx1250.py:1448:17 ]
	s_lshr_b32 s21, s21, 24
.Ltmp11:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_mul_f32 s17, s17, 0x4f7ffffe
.Ltmp12:
	.loc	2 43 12                         ; standard.py:43:12 @[ mxfp_gemm_gfx1250.py:1448:17 ]
	s_add_co_i32 s20, s20, s21
.Ltmp13:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_sub_co_i32 s21, 0, s15
.Ltmp14:
	.loc	2 43 12                         ; standard.py:43:12 @[ mxfp_gemm_gfx1250.py:1448:17 ]
	s_ashr_i32 s22, s20, 8
.Ltmp15:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_cvt_u32_f32 s17, s17
	s_mov_b32 s27, 0
	s_mov_b32 s28, 1
.Ltmp16:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1017:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s20, 0x3500000
.Ltmp17:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_mul_i32 s21, s21, s17
.Ltmp18:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1017:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s23, s27
	v_mov_b32_e32 v81 /*v849*/, v4
.Ltmp19:
	.loc	1 1451 16                       ; mxfp_gemm_gfx1250.py:1451:16
	s_mul_hi_u32 s21, s17, s21
	v_mov_b32_e32 v82 /*v850*/, v4
	s_add_co_i32 s17, s17, s21
	v_mov_b32_e32 v83 /*v851*/, v4
	s_mul_hi_u32 s17, s19, s17
	v_mov_b32_e32 v84 /*v852*/, v4
	s_mul_i32 s21, s17, s15
	v_mov_b32_e32 v85 /*v853*/, v4
	s_sub_co_i32 s21, s19, s21
	v_mov_b32_e32 v86 /*v854*/, v4
	s_add_co_i32 s24, s17, 1
	v_mov_b32_e32 v87 /*v855*/, v4
	s_sub_co_i32 s25, s21, s15
	v_mov_b32_e32 v104 /*v872*/, v4
	s_cmp_ge_u32 s21, s15
	v_mov_b32_e32 v105 /*v873*/, v4
	s_cselect_b32 s17, s24, s17
	v_mov_b32_e32 v106 /*v874*/, v4
	s_cselect_b32 s21, s25, s21
	v_mov_b32_e32 v107 /*v875*/, v4
	s_add_co_i32 s24, s17, 1
	v_mov_b32_e32 v108 /*v876*/, v4
	s_cmp_ge_u32 s21, s15
	v_mov_b32_e32 v109 /*v877*/, v4
	s_cselect_b32 s15, s24, s17
	v_mov_b32_e32 v110 /*v878*/, v4
	s_xor_b32 s15, s15, s11
	v_mov_b32_e32 v111 /*v879*/, v4
	s_sub_co_i32 s11, s15, s11
	v_mov_b32_e32 v112 /*v880*/, v4
	.loc	1 1452 19                       ; mxfp_gemm_gfx1250.py:1452:19
	s_lshl_b32 s15, s11, 3
	v_mov_b32_e32 v113 /*v881*/, v4
	.loc	1 1453 24                       ; mxfp_gemm_gfx1250.py:1453:24
	s_sub_co_i32 s17, s22, s15
	v_mov_b32_e32 v114 /*v882*/, v4
	.loc	1 1453 20 is_stmt 0             ; mxfp_gemm_gfx1250.py:1453:20
	s_min_i32 s17, s17, 8
	v_mov_b32_e32 v115 /*v883*/, v4
	.loc	1 1454 28 is_stmt 1             ; mxfp_gemm_gfx1250.py:1454:28
	s_abs_i32 s21, s17
	v_mov_b32_e32 v116 /*v884*/, v4
	s_cvt_f32_u32 s22, s21
	v_mov_b32_e32 v117 /*v885*/, v4
	s_sub_co_i32 s26, 0, s21
	v_mov_b32_e32 v118 /*v886*/, v4
	v_s_rcp_f32 s22, s22
	v_mov_b32_e32 v119 /*v887*/, v4
	s_set_vgpr_msb 0xc080                   ;  msbs: dst=2 src0=0 src1=0 src2=0
	v_dual_mov_b32 v232 /*v744*/, v4 :: v_dual_mov_b32 v233 /*v745*/, v4
	v_dual_mov_b32 v234 /*v746*/, v4 :: v_dual_mov_b32 v235 /*v747*/, v4
	v_dual_mov_b32 v236 /*v748*/, v4 :: v_dual_mov_b32 v237 /*v749*/, v4
	v_dual_mov_b32 v238 /*v750*/, v4 :: v_dual_mov_b32 v239 /*v751*/, v4
	v_dual_mov_b32 v224 /*v736*/, v4 :: v_dual_mov_b32 v225 /*v737*/, v4
	v_dual_mov_b32 v226 /*v738*/, v4 :: v_dual_mov_b32 v227 /*v739*/, v4
	v_dual_mov_b32 v228 /*v740*/, v4 :: v_dual_mov_b32 v229 /*v741*/, v4
	v_mov_b32_e32 v230 /*v742*/, v4
	s_mul_f32 s22, s22, 0x4f7ffffe
	.loc	1 1455 14                       ; mxfp_gemm_gfx1250.py:1455:14
	s_mul_i32 s11, s11, s13
.Ltmp20:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1017:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s24, s28
	s_mov_b32 s25, s16
.Ltmp21:
	.loc	1 1454 28                       ; mxfp_gemm_gfx1250.py:1454:28
	s_cvt_u32_f32 s13, s22
	s_mov_b32 s40, 64
.Ltmp22:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s36, 0x7500000
	s_mov_b32 s61, s27
.Ltmp23:
	.loc	1 1454 28                       ; mxfp_gemm_gfx1250.py:1454:28
	s_mul_i32 s26, s26, s13
.Ltmp24:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s43, s27
.Ltmp25:
	.loc	1 1454 28                       ; mxfp_gemm_gfx1250.py:1454:28
	s_mul_hi_u32 s22, s13, s26
.Ltmp26:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s41, s12
.Ltmp27:
	.loc	1 1454 28                       ; mxfp_gemm_gfx1250.py:1454:28
	s_add_co_i32 s13, s13, s22
	s_mul_hi_u32 s22, s19, s13
	s_mul_i32 s22, s22, s21
	v_mov_b32_e32 v231 /*v743*/, v4
	s_sub_co_i32 s19, s19, s22
	v_mov_b32_e32 v240 /*v752*/, v4
	s_sub_co_i32 s22, s19, s21
	v_mov_b32_e32 v241 /*v753*/, v4
	s_cmp_ge_u32 s19, s21
	v_mov_b32_e32 v242 /*v754*/, v4
	s_cselect_b32 s19, s22, s19
	v_mov_b32_e32 v243 /*v755*/, v4
	s_sub_co_i32 s22, s19, s21
	v_mov_b32_e32 v244 /*v756*/, v4
	s_cmp_ge_u32 s19, s21
	v_mov_b32_e32 v245 /*v757*/, v4
	s_cselect_b32 s19, s22, s19
	v_mov_b32_e32 v246 /*v758*/, v4
	s_xor_b32 s19, s19, s18
	v_mov_b32_e32 v247 /*v759*/, v4
	s_sub_co_i32 s18, s19, s18
	v_mov_b32_e32 v248 /*v760*/, v4
	.loc	1 1454 13 is_stmt 0             ; mxfp_gemm_gfx1250.py:1454:13
	s_add_co_i32 s15, s15, s18
	v_mov_b32_e32 v249 /*v761*/, v4
	.loc	1 1455 14 is_stmt 1             ; mxfp_gemm_gfx1250.py:1455:14
	s_sub_co_i32 s11, ttmp9, s11
	v_mov_b32_e32 v250 /*v762*/, v4
	.loc	1 1455 13 is_stmt 0             ; mxfp_gemm_gfx1250.py:1455:13
	s_xor_b32 s17, s11, s17
	v_mov_b32_e32 v251 /*v763*/, v4
	s_ashr_i32 s17, s17, 31
	v_mov_b32_e32 v252 /*v764*/, v4
	s_abs_i32 s11, s11
	v_mov_b32_e32 v253 /*v765*/, v4
	s_mul_hi_u32 s13, s11, s13
	v_mov_b32_e32 v254 /*v766*/, v4
	s_mul_i32 s18, s13, s21
	v_mov_b32_e32 v255 /*v767*/, v4
	s_sub_co_i32 s11, s11, s18
	s_set_vgpr_msb 0x80c0                   ;  msbs: dst=3 src0=0 src1=0 src2=0
	v_mov_b32_e32 v0 /*v768*/, v4
	s_add_co_i32 s18, s13, 1
	v_mov_b32_e32 v1 /*v769*/, v4
	s_sub_co_i32 s19, s11, s21
	v_mov_b32_e32 v2 /*v770*/, v4
	s_cmp_ge_u32 s11, s21
	v_mov_b32_e32 v3 /*v771*/, v4
	s_cselect_b32 s13, s18, s13
	v_mov_b32_e32 v4 /*v772*/, v4
	s_cselect_b32 s11, s19, s11
	v_mov_b32_e32 v5 /*v773*/, v4
	s_add_co_i32 s18, s13, 1
	v_mov_b32_e32 v6 /*v774*/, v4
	s_cmp_ge_u32 s11, s21
	v_mov_b32_e32 v7 /*v775*/, v4
	s_cselect_b32 s11, s18, s13
	v_mov_b32_e32 v8 /*v776*/, v4
	s_xor_b32 s11, s11, s17
	v_mov_b32_e32 v9 /*v777*/, v4
	s_sub_co_i32 s44, s11, s17
	v_mov_b32_e32 v10 /*v778*/, v4
	.loc	1 1460 20 is_stmt 1             ; mxfp_gemm_gfx1250.py:1460:20
	s_mul_i32 s11, s16, s44
	v_mov_b32_e32 v11 /*v779*/, v4
	s_lshl_b32 s18, s11, 1
	v_mov_b32_e32 v12 /*v780*/, v4
.Ltmp28:
	.loc	1 1405 18                       ; mxfp_gemm_gfx1250.py:1405:18 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s19, s18, 31
	v_mov_b32_e32 v13 /*v781*/, v4
	s_add_nc_u64 s[18:19], s[8:9], s[18:19]
	v_mov_b32_e32 v14 /*v782*/, v4
	.loc	1 1406 20                       ; mxfp_gemm_gfx1250.py:1406:20 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s8, s1, 31
	v_mov_b32_e32 v15 /*v783*/, v4
	s_lshr_b32 s8, s8, 25
	v_mov_b32_e32 v16 /*v784*/, v4
	s_add_co_i32 s8, s1, s8
	v_mov_b32_e32 v17 /*v785*/, v4
	s_ashr_i32 s11, s8, 7
	v_mov_b32_e32 v18 /*v786*/, v4
	.loc	1 1406 44 is_stmt 0             ; mxfp_gemm_gfx1250.py:1406:44 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s8, s0, 31
	v_mov_b32_e32 v19 /*v787*/, v4
	s_lshr_b32 s8, s8, 27
	v_mov_b32_e32 v20 /*v788*/, v4
	s_add_co_i32 s8, s0, s8
	v_mov_b32_e32 v21 /*v789*/, v4
	s_ashr_i32 s9, s8, 5
	v_mov_b32_e32 v22 /*v790*/, v4
	.loc	1 1404 24 is_stmt 1             ; mxfp_gemm_gfx1250.py:1404:24 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s8, s16, 31
	v_mov_b32_e32 v23 /*v791*/, v4
	s_and_b32 s17, s8, 0xffff
	v_mov_b32_e32 v24 /*v792*/, v4
	s_bitset1_b32 s19, 31
	v_mov_b32_e32 v25 /*v793*/, v4
	s_lshl_b32 s8, s9, 23
	v_mov_b32_e32 v26 /*v794*/, v4
	s_lshr_b32 s9, s9, 9
	v_mov_b32_e32 v27 /*v795*/, v4
.Ltmp29:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1017:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_max_i32 s31, s11, 0
	v_mov_b32_e32 v28 /*v796*/, v4
	s_lshr_b64 s[8:9], s[8:9], 16
	v_mov_b32_e32 v29 /*v797*/, v4
	s_max_i32 s30, s8, 0
	v_mov_b32_e32 v30 /*v798*/, v4
	s_lshr_b64 s[8:9], s[30:31], 16
	v_mov_b32_e32 v31 /*v799*/, v4
	s_and_b32 s13, s30, 0xff80
	s_set_vgpr_msb 0xc080                   ;  msbs: dst=2 src0=0 src1=0 src2=0
	v_mov_b32_e32 v152 /*v664*/, v4
	s_lshl_b32 s21, s8, 16
	v_mov_b32_e32 v153 /*v665*/, v4
	s_lshr_b32 s30, s8, 16
	v_mov_b32_e32 v154 /*v666*/, v4
	s_and_b32 s31, s31, 0xff0000
	v_mov_b32_e32 v155 /*v667*/, v4
	s_and_b32 s26, s35, 1
	v_mov_b32_e32 v156 /*v668*/, v4
	s_lshl_b32 s8, s35, 8
	v_mov_b32_e32 v157 /*v669*/, v4
	s_and_b32 s22, s8, 0x200
	v_mov_b32_e32 v158 /*v670*/, v4
	s_mul_u64 s[8:9], s[16:17], s[26:27]
	v_mov_b32_e32 v159 /*v671*/, v4
	s_add_nc_u64 s[8:9], s[8:9], s[22:23]
	v_mov_b32_e32 v160 /*v672*/, v4
	s_and_b32 s33, s35, 3
	v_mov_b32_e32 v161 /*v673*/, v4
	s_brev_b32 s11, s33
	v_mov_b32_e32 v162 /*v674*/, v4
	s_lshr_b32 s16, s11, 21
	v_mov_b32_e32 v163 /*v675*/, v4
	s_lshr_b32 s11, s11, 26
	v_mov_b32_e32 v164 /*v676*/, v4
	s_or_b32 s11, s11, s16
	v_mov_b32_e32 v165 /*v677*/, v4
	s_add_co_i32 s29, s11, 0x43fe0
	v_mov_b32_e32 v166 /*v678*/, v4
	s_sub_co_i32 s16, s31, s26
	v_mov_b32_e32 v167 /*v679*/, v4
	s_add_co_i32 s16, s16, s30
	v_mov_b32_e32 v168 /*v680*/, v4
	s_max_i32 s39, s16, 0
	v_mov_b32_e32 v169 /*v681*/, v4
	s_sub_co_i32 s13, s13, s22
	v_mov_b32_e32 v170 /*v682*/, v4
	s_add_co_i32 s13, s13, s21
	v_mov_b32_e32 v171 /*v683*/, v4
	s_max_i32 s38, s13, 0
	v_mov_b32_e32 v172 /*v684*/, v4
	s_add_nc_u64 s[30:31], s[18:19], s[8:9]
	v_mov_b32_e32 v173 /*v685*/, v4
	s_lshl_b32 s21, s38, 16
	v_mov_b32_e32 v174 /*v686*/, v4
	s_lshr_b64 s[22:23], s[38:39], 16
	v_mov_b32_e32 v175 /*v687*/, v4
	s_lshr_b32 s13, s39, 16
	v_mov_b32_e32 v184 /*v696*/, v4
	s_or_b32 s23, s13, 0x2000000
	v_mov_b32_e32 v185 /*v697*/, v4
	s_mov_b32 s26, s17
	v_mov_b32_e32 v186 /*v698*/, v4
	tensor_load_to_lds s[28:31], s[20:27]
	v_dual_mov_b32 v187 /*v699*/, v4 :: v_dual_mov_b32 v188 /*v700*/, v4
	v_dual_mov_b32 v189 /*v701*/, v4 :: v_dual_mov_b32 v190 /*v702*/, v4
	v_dual_mov_b32 v191 /*v703*/, v4 :: v_dual_mov_b32 v176 /*v688*/, v4
	v_mov_b32_e32 v177 /*v689*/, v4
.Ltmp30:
	.loc	1 1457 14                       ; mxfp_gemm_gfx1250.py:1457:14
	s_lshl_b32 s62, s15, 8
.Ltmp31:
	.loc	1 1363 14                       ; mxfp_gemm_gfx1250.py:1363:14 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s13, s12, 31
.Ltmp32:
	.loc	1 1457 14                       ; mxfp_gemm_gfx1250.py:1457:14
	s_mul_i32 s16, s62, s12
.Ltmp33:
	.loc	1 1363 14                       ; mxfp_gemm_gfx1250.py:1363:14 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_and_b32 s13, s13, 0xffff
	.loc	1 1363 61 is_stmt 0             ; mxfp_gemm_gfx1250.py:1363:61 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s17, s16, 31
.Ltmp34:
	.loc	1 963 9 is_stmt 1               ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_max_i32 s59, s10, 0
.Ltmp35:
	.loc	1 1363 61                       ; mxfp_gemm_gfx1250.py:1363:61 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_add_nc_u64 s[54:55], s[2:3], s[16:17]
.Ltmp36:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_max_i32 s58, s0, 0
	v_mov_b32_e32 v178 /*v690*/, v4
.Ltmp37:
	.loc	1 1363 14                       ; mxfp_gemm_gfx1250.py:1363:14 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_bitset1_b32 s55, 31
	v_mov_b32_e32 v179 /*v691*/, v4
.Ltmp38:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshr_b64 s[2:3], s[58:59], 16
	v_mov_b32_e32 v180 /*v692*/, v4
	s_and_b32 s3, s2, 0x7fff
	v_mov_b32_e32 v181 /*v693*/, v4
	s_lshr_b32 s2, s2, 16
	v_mov_b32_e32 v182 /*v694*/, v4
	s_and_b32 s15, s59, 0x7fff0000
	v_mov_b32_e32 v183 /*v695*/, v4
	s_lshl_b32 s60, s33, 6
	v_mov_b32_e32 v192 /*v704*/, v4
	s_mul_u64 s[64:65], s[12:13], s[60:61]
	v_mov_b32_e32 v193 /*v705*/, v4
	s_mul_i32 s29, s33, 0x4400
	v_mov_b32_e32 v194 /*v706*/, v4
	s_sub_co_i32 s53, s15, s60
	v_mov_b32_e32 v195 /*v707*/, v4
	s_add_co_i32 s2, s53, s2
	v_mov_b32_e32 v196 /*v708*/, v4
	s_max_i32 s2, s2, 0
	v_mov_b32_e32 v197 /*v709*/, v4
	s_add_nc_u64 s[30:31], s[54:55], s[64:65]
	v_mov_b32_e32 v198 /*v710*/, v4
	s_lshl_b32 s37, s58, 16
	v_mov_b32_e32 v199 /*v711*/, v4
	s_lshl_b32 s15, s2, 16
	v_mov_b32_e32 v200 /*v712*/, v4
	s_or_b32 s38, s15, s3
	v_mov_b32_e32 v201 /*v713*/, v4
	s_lshr_b32 s2, s2, 16
	v_mov_b32_e32 v202 /*v714*/, v4
	s_or_b32 s39, s2, 0x1000000
	v_mov_b32_e32 v203 /*v715*/, v4
	s_mov_b32 s42, s13
	v_mov_b32_e32 v204 /*v716*/, v4
	tensor_load_to_lds s[28:31], s[36:43]
	v_dual_mov_b32 v205 /*v717*/, v4 :: v_dual_mov_b32 v206 /*v718*/, v4
	v_dual_mov_b32 v207 /*v719*/, v4 :: v_dual_mov_b32 v208 /*v720*/, v4
	v_dual_mov_b32 v209 /*v721*/, v4 :: v_dual_mov_b32 v210 /*v722*/, v4
	v_mov_b32_e32 v211 /*v723*/, v4
.Ltmp39:
	.loc	1 1458 14                       ; mxfp_gemm_gfx1250.py:1458:14
	s_lshl_b32 s2, s44, 8
.Ltmp40:
	.loc	1 1370 18                       ; mxfp_gemm_gfx1250.py:1370:18 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s3, s14, 31
.Ltmp41:
	.loc	1 1458 14                       ; mxfp_gemm_gfx1250.py:1458:14
	s_mul_i32 s16, s2, s14
.Ltmp42:
	.loc	1 1370 18                       ; mxfp_gemm_gfx1250.py:1370:18 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_and_b32 s15, s3, 0xffff
	.loc	1 1370 65 is_stmt 0             ; mxfp_gemm_gfx1250.py:1370:65 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_ashr_i32 s17, s16, 31
                                        ; kill: def $sgpr30 killed $sgpr66
	s_add_nc_u64 s[66:67], s[4:5], s[16:17]
                                        ; kill: def $sgpr31 killed $sgpr67
	v_mov_b32_e32 v212 /*v724*/, v4
	.loc	1 1370 18                       ; mxfp_gemm_gfx1250.py:1370:18 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_bitset1_b32 s67, 31
	v_mov_b32_e32 v213 /*v725*/, v4
.Ltmp43:
	.loc	1 985 9 is_stmt 1               ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1019:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_max_i32 s5, s1, 0
	v_mov_b32_e32 v214 /*v726*/, v4
	s_mov_b32 s4, s58
	v_mov_b32_e32 v215 /*v727*/, v4
	s_lshr_b64 s[16:17], s[4:5], 16
	v_mov_b32_e32 v120 /*v632*/, v4
	s_and_b32 s17, s16, 0x7fff
	v_mov_b32_e32 v121 /*v633*/, v4
	s_lshr_b32 s16, s16, 16
	v_mov_b32_e32 v122 /*v634*/, v4
	s_and_b32 s44, s5, 0x7fff0000
	v_mov_b32_e32 v123 /*v635*/, v4
	s_mul_u64 s[4:5], s[14:15], s[60:61]
	v_mov_b32_e32 v124 /*v636*/, v4
	s_add_co_i32 s3, s29, 0x21ff0
	v_mov_b32_e32 v125 /*v637*/, v4
	s_sub_co_i32 s44, s44, s60
	v_mov_b32_e32 v126 /*v638*/, v4
	s_add_co_i32 s44, s44, s16
	v_mov_b32_e32 v127 /*v639*/, v4
	s_max_i32 s16, s44, 0
	v_mov_b32_e32 v128 /*v640*/, v4
	s_mov_b64 s[70:71], s[30:31]
	s_mov_b64 s[68:69], s[28:29]
	v_mov_b32_e32 v129 /*v641*/, v4
	s_mov_b32 s69, s3
	v_mov_b32_e32 v130 /*v642*/, v4
	s_add_nc_u64 s[70:71], s[66:67], s[4:5]
	v_mov_b32_e32 v131 /*v643*/, v4
	s_lshl_b32 s30, s16, 16
	v_mov_b32_e32 v132 /*v644*/, v4
	s_or_b32 s30, s30, s17
	v_mov_b32_e32 v133 /*v645*/, v4
	s_lshr_b32 s16, s16, 16
	v_mov_b32_e32 v134 /*v646*/, v4
	s_bitset1_b32 s16, 24
	v_mov_b32_e32 v135 /*v647*/, v4
	s_mov_b64 s[50:51], s[42:43]
	s_mov_b64 s[48:49], s[40:41]
	s_mov_b64 s[46:47], s[38:39]
	s_mov_b64 s[44:45], s[36:37]
	v_mov_b32_e32 v136 /*v648*/, v4
	s_mov_b32 s46, s30
	v_mov_b32_e32 v137 /*v649*/, v4
	s_mov_b32 s47, s16
	v_mov_b32_e32 v138 /*v650*/, v4
	s_mov_b32 s49, s14
	v_mov_b32_e32 v139 /*v651*/, v4
	s_mov_b32 s50, s15
	v_mov_b32_e32 v140 /*v652*/, v4
	tensor_load_to_lds s[68:71], s[44:51]
	s_set_vgpr_msb 0x8000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp44:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_dual_lshlrev_b32 v3, 4, v1 :: v_dual_bitop2_b32 v0, 8, v0 bitop3:0x40
	s_set_vgpr_msb 0x80                     ;  msbs: dst=2 src0=0 src1=0 src2=0
	v_dual_mov_b32 v141 /*v653*/, v4 :: v_dual_mov_b32 v142 /*v654*/, v4
	v_dual_mov_b32 v143 /*v655*/, v4 :: v_dual_mov_b32 v144 /*v656*/, v4
	v_mov_b32_e32 v145 /*v657*/, v4
.Ltmp45:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshl_b32 s30, s35, 5
.Ltmp46:
	.loc	1 977 28                        ; mxfp_gemm_gfx1250.py:977:28 @[ mxfp_gemm_gfx1250.py:1017:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[68:69], s[18:19], 0x400
.Ltmp47:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_and_b32 s35, s30, 64
.Ltmp48:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_and_b32 s61, s30, 32
.Ltmp49:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1028:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s17, s11, 0x44820
.Ltmp50:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshr_b32 s31, s61, 3
.Ltmp51:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1028:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[18:19], s[68:69], s[8:9]
	s_mov_b32 s16, s28
	s_set_vgpr_msb 0x8000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp52:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_lshl_or_b32 v2, s35, 7, v2
	v_or_b32_e32 v1, s30, v1
.Ltmp53:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_or3_b32 v24, s31, v3, v0
	s_set_vgpr_msb 0x80                     ;  msbs: dst=2 src0=0 src1=0 src2=0
	v_dual_mov_b32 v146 /*v658*/, v4 :: v_dual_mov_b32 v147 /*v659*/, v4
	s_set_vgpr_msb 0x8000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp54:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_dual_lshrrev_b32 v2, 4, v2 :: v_dual_bitop2_b32 v0, v2, v23 bitop3:0x54
.Ltmp55:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_lshlrev_b32_e32 v1, 8, v1
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v16, 0x43fe0, v24
	s_set_vgpr_msb 0x80                     ;  msbs: dst=2 src0=0 src1=0 src2=0
	v_dual_mov_b32 v148 /*v660*/, v4 :: v_dual_mov_b32 v149 /*v661*/, v4
.Ltmp56:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1029:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s56, s28
.Ltmp57:
	.loc	1 985 9                         ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1030:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mov_b32 s52, s28
	s_mov_b32 s70, s27
.Ltmp58:
	.loc	2 43 13                         ; standard.py:43:13 @[ mxfp_gemm_gfx1250.py:1036:19 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s28, s0, 0xff
.Ltmp59:
	.loc	1 985 9                         ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1070:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_and_b32 s57, s1, 0xffff0000
.Ltmp60:
	.loc	1 1370 18                       ; mxfp_gemm_gfx1250.py:1370:18 @[ mxfp_gemm_gfx1250.py:1461:50 ]
	s_lshr_b64 s[30:31], s[0:1], 16
.Ltmp61:
	.loc	2 43 12                         ; standard.py:43:12 @[ mxfp_gemm_gfx1250.py:1036:19 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshr_b32 s28, s28, 8
	s_mov_b32 s58, s0
	s_lshr_b32 s63, s30, 16
	s_set_vgpr_msb 0x8000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp62:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add3_u32 v25, v0, v2, 0
	s_and_b32 s72, s30, 0x7fff
.Ltmp63:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_and_b32_e32 v0, 0x2f00, v1
	s_lshr_b64 s[30:31], s[58:59], 16
	s_set_vgpr_msb 0x80                     ;  msbs: dst=2 src0=0 src1=0 src2=0
	v_mov_b32_e32 v150 /*v662*/, v4
	s_or_b32 s31, s63, s57
	v_mov_b32_e32 v151 /*v663*/, v4
.Ltmp64:
	.loc	1 1039 9                        ; mxfp_gemm_gfx1250.py:1039:9 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_sub_co_i32 s63, 2, s28
	s_set_vgpr_msb 0x8000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp65:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_or_b32_e32 v1, v0, v23
	s_and_b32 s71, s30, 0x7fff
	v_lshrrev_b32_e32 v0, 4, v0
	s_lshr_b32 s30, s30, 16
	s_set_vgpr_msb 0x80                     ;  msbs: dst=2 src0=0 src1=0 src2=0
	v_mov_b32_e32 v216 /*v728*/, v4
	s_max_i32 s31, s31, 0
	v_mov_b32_e32 v217 /*v729*/, v4
	s_add_co_i32 s53, s53, s30
	s_set_vgpr_msb 0x8000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	v_add3_u32 v26, v1, v0, 0x21ff0
	s_sub_co_i32 s57, s31, s60
	s_set_vgpr_msb 0x80                     ;  msbs: dst=2 src0=0 src1=0 src2=0
	v_mov_b32_e32 v218 /*v730*/, v4
.Ltmp66:
	.loc	1 966 16                        ; mxfp_gemm_gfx1250.py:966:16 @[ mxfp_gemm_gfx1250.py:1018:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[30:31], s[54:55], 0x100
	v_mov_b32_e32 v219 /*v731*/, v4
	s_max_i32 s53, s53, 0
	v_mov_b32_e32 v220 /*v732*/, v4
	s_max_i32 s54, s57, 0
	v_mov_b32_e32 v221 /*v733*/, v4
.Ltmp67:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1029:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[58:59], s[30:31], s[64:65]
	v_mov_b32_e32 v222 /*v734*/, v4
	.loc	1 966 16                        ; mxfp_gemm_gfx1250.py:966:16 @[ mxfp_gemm_gfx1250.py:1029:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[30:31], s[30:31], 0x100
	v_mov_b32_e32 v223 /*v735*/, v4
	s_lshl_b32 s74, s53, 16
	s_set_vgpr_msb 0x80c0                   ;  msbs: dst=3 src0=0 src1=0 src2=0
	v_mov_b32_e32 v32 /*v800*/, v4
	s_lshr_b32 s75, s53, 16
	v_mov_b32_e32 v33 /*v801*/, v4
	s_lshl_b32 s53, s54, 16
	v_mov_b32_e32 v34 /*v802*/, v4
	s_lshr_b32 s73, s54, 16
	v_mov_b32_e32 v35 /*v803*/, v4
	s_or_b32 s72, s53, s72
	v_mov_b32_e32 v36 /*v804*/, v4
	s_bitset1_b32 s73, 24
	v_mov_b32_e32 v37 /*v805*/, v4
.Ltmp68:
	.loc	1 989 22                        ; mxfp_gemm_gfx1250.py:989:22 @[ mxfp_gemm_gfx1250.py:1019:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[66:67], s[66:67], 0x100
	v_mov_b32_e32 v38 /*v806*/, v4
.Ltmp69:
	.loc	1 985 9                         ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1030:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[54:55], s[66:67], s[4:5]
	v_mov_b32_e32 v39 /*v807*/, v4
	.loc	1 989 22                        ; mxfp_gemm_gfx1250.py:989:22 @[ mxfp_gemm_gfx1250.py:1030:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[66:67], s[66:67], 0x100
	v_mov_b32_e32 v48 /*v816*/, v4
.Ltmp70:
	.loc	1 977 28                        ; mxfp_gemm_gfx1250.py:977:28 @[ mxfp_gemm_gfx1250.py:1028:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[68:69], s[68:69], 0x400
	v_mov_b32_e32 v49 /*v817*/, v4
.Ltmp71:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1029:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s57, s29, 0x11000
	v_mov_b32_e32 v50 /*v818*/, v4
.Ltmp72:
	.loc	1 985 9                         ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1030:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s53, s29, 0x32ff0
	v_dual_mov_b32 v51 /*v819*/, v4 :: v_dual_mov_b32 v52 /*v820*/, v4
	v_dual_mov_b32 v53 /*v821*/, v4 :: v_dual_mov_b32 v54 /*v822*/, v4
	v_dual_mov_b32 v55 /*v823*/, v4 :: v_dual_mov_b32 v40 /*v808*/, v4
	v_dual_mov_b32 v41 /*v809*/, v4 :: v_dual_mov_b32 v42 /*v810*/, v4
	v_dual_mov_b32 v43 /*v811*/, v4 :: v_dual_mov_b32 v44 /*v812*/, v4
	v_dual_mov_b32 v45 /*v813*/, v4 :: v_dual_mov_b32 v46 /*v814*/, v4
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[4:7], off nv
	scratch_store_b128 off, v[8:11], off offset:16 nv
	v_mov_b32_e32 v47 /*v815*/, v4
.Ltmp73:
	.loc	1 1001 13                       ; mxfp_gemm_gfx1250.py:1001:13 @[ mxfp_gemm_gfx1250.py:1022:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_tensorcnt 0x0
	s_barrier_signal -1
	s_barrier_wait -1
.Ltmp74:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1023:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[120:123] /*v[888:891]*/, v25
	ds_load_b128 v[124:127] /*v[892:895]*/, v25 offset:32
	ds_load_b128 v[128:131] /*v[896:899]*/, v25 offset:64
	ds_load_b128 v[132:135] /*v[900:903]*/, v25 offset:96
	s_set_vgpr_msb 0xc000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	ds_load_b128 v[48:51], v25 offset:4352
	ds_load_b128 v[52:55], v25 offset:4384
	ds_load_b128 v[56:59], v25 offset:4416
	ds_load_b128 v[60:63], v25 offset:4448
	ds_load_b128 v[112:115], v25 offset:17408
	ds_load_b128 v[116:119], v25 offset:17440
	ds_load_b128 v[120:123], v25 offset:17472
	ds_load_b128 v[124:127], v25 offset:17504
	ds_load_b128 v[96:99], v25 offset:21760
	ds_load_b128 v[100:103], v25 offset:21792
	ds_load_b128 v[104:107], v25 offset:21824
	ds_load_b128 v[108:111], v25 offset:21856
	ds_load_b128 v[80:83], v25 offset:34816
	ds_load_b128 v[84:87], v25 offset:34848
	ds_load_b128 v[88:91], v25 offset:34880
	ds_load_b128 v[92:95], v25 offset:34912
	ds_load_b128 v[64:67], v25 offset:39168
	ds_load_b128 v[68:71], v25 offset:39200
	ds_load_b128 v[72:75], v25 offset:39232
	ds_load_b128 v[76:79], v25 offset:39264
	ds_load_b128 v[32:35], v25 offset:52224
	ds_load_b128 v[36:39], v25 offset:52256
	ds_load_b128 v[40:43], v25 offset:52288
	ds_load_b128 v[44:47], v25 offset:52320
	ds_load_b128 v[0:3], v25 offset:56576
	ds_load_b128 v[4:7], v25 offset:56608
	ds_load_b128 v[8:11], v25 offset:56640
	ds_load_b128 v[12:15], v25 offset:56672
.Ltmp75:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[128:131], v26
	ds_load_b128 v[132:135], v26 offset:32
	ds_load_b128 v[136:139], v26 offset:64
	ds_load_b128 v[140:143], v26 offset:96
	ds_load_b128 v[144:147], v26 offset:4352
	ds_load_b128 v[148:151], v26 offset:4384
	ds_load_b128 v[152:155], v26 offset:4416
	ds_load_b128 v[156:159], v26 offset:4448
	ds_load_b128 v[176:179], v26 offset:17408
	ds_load_b128 v[180:183], v26 offset:17440
	ds_load_b128 v[184:187], v26 offset:17472
	ds_load_b128 v[188:191], v26 offset:17504
	ds_load_b128 v[160:163], v26 offset:21760
	ds_load_b128 v[164:167], v26 offset:21792
	ds_load_b128 v[168:171], v26 offset:21824
	ds_load_b128 v[172:175], v26 offset:21856
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1024:26 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_2addr_b32 v[16:17], v16 offset1:2
.Ltmp76:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1028:24 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	tensor_load_to_lds s[16:19], s[20:27]
.Ltmp77:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1029:18 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	tensor_load_to_lds s[56:59], s[36:43]
.Ltmp78:
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
.Ltmp79:
.LBB0_1:                                ; =>This Inner Loop Header: Depth=1
	.loc	1 0 9 is_stmt 0                 ; mxfp_gemm_gfx1250.py:0:9
	s_set_vgpr_msb 0xfc                     ;  msbs: dst=3 src0=0 src1=3 src2=3
.Ltmp80:
	.loc	1 924 17 is_stmt 1              ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_barrier_signal -1
.Ltmp81:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x28
	v_wmma_scale_f32_16x16x128_f8f6f4 v[72:79] /*v[840:847]*/, v[128:143], v[120:135] /*v[888:903]*/, v[72:79] /*v[840:847]*/, v16, 0
.Ltmp82:
	.loc	1 924 32                        ; mxfp_gemm_gfx1250.py:924:32 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_and_b32 s0, s70, 1
.Ltmp83:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[14:15], s[68:69], s[8:9]
.Ltmp84:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mul_i32 s12, s0, 0x11000
.Ltmp85:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_add_co_i32 s13, s70, 2
	.loc	1 1064 26                       ; mxfp_gemm_gfx1250.py:1064:26 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_add_co_i32 s16, s63, s70
	s_set_vgpr_msb 0xfc00                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp86:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v27, s12, v26
	s_set_vgpr_msb 0xfc                     ;  msbs: dst=3 src0=0 src1=3 src2=3
.Ltmp87:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x24
	v_wmma_scale_f32_16x16x128_f8f6f4 v[64:71] /*v[832:839]*/, v[144:159], v[120:135] /*v[888:903]*/, v[64:71] /*v[832:839]*/, v16, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xfc00                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp88:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v28, s12, v25
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
.Ltmp89:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x20
	v_wmma_scale_f32_16x16x128_f8f6f4 v[56:63] /*v[824:831]*/, v[128:143], v[48:63], v[56:63] /*v[824:831]*/, v16, 0 matrix_b_scale:MATRIX_SCALE_ROW1
.Ltmp90:
	.loc	1 932 32                        ; mxfp_gemm_gfx1250.py:932:32 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshl_b32 s12, s0, 11
	s_lshl_b32 s0, s0, 6
.Ltmp91:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[96:103] /*v[864:871]*/, v[144:159], v[48:63], v[96:103] /*v[864:871]*/, v16, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
.Ltmp92:
	.loc	1 932 32                        ; mxfp_gemm_gfx1250.py:932:32 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s17, s12, 0x43fe0
.Ltmp93:
	.loc	1 1064 26                       ; mxfp_gemm_gfx1250.py:1064:26 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_lshr_b32 s12, s16, 31
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp94:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add3_u32 v18, s17, s0, v24
	s_set_vgpr_msb 0xfc                     ;  msbs: dst=3 src0=0 src1=3 src2=3
.Ltmp95:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x1c
	v_wmma_scale_f32_16x16x128_f8f6f4 v[88:95] /*v[856:863]*/, v[176:191], v[120:135] /*v[888:903]*/, v[88:95] /*v[856:863]*/, v17, 0
	s_set_vgpr_msb 0xfc00                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp96:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add_nc_u32_e32 v29, 0x400, v18
.Ltmp97:
	.loc	1 971 58                        ; mxfp_gemm_gfx1250.py:971:58 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_and_b32 s16, s13, 1
	s_set_vgpr_msb 0xfc                     ;  msbs: dst=3 src0=0 src1=3 src2=3
.Ltmp98:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_barrier_wait -1
.Ltmp99:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x18
	v_wmma_scale_f32_16x16x128_f8f6f4 v[80:87] /*v[848:855]*/, v[160:175], v[120:135] /*v[888:903]*/, v[80:87] /*v[848:855]*/, v17, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xfc40                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp100:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[64:67] /*v[320:323]*/, v27 offset:34816
.Ltmp101:
	.loc	1 971 32                        ; mxfp_gemm_gfx1250.py:971:32 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshl_b32 s0, s16, 11
.Ltmp102:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[68:71] /*v[324:327]*/, v27 offset:34848
	ds_load_b128 v[72:75] /*v[328:331]*/, v27 offset:34880
.Ltmp103:
	.loc	1 971 32                        ; mxfp_gemm_gfx1250.py:971:32 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshl_b32 s13, s16, 6
	s_add_co_i32 s0, s0, 0x43fe0
	s_set_vgpr_msb 0x40f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
.Ltmp104:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[104:111] /*v[872:879]*/, v[176:191], v[48:63], v[104:111] /*v[872:879]*/, v17, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp105:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[76:79] /*v[332:335]*/, v27 offset:34912
.Ltmp106:
	.loc	1 971 32                        ; mxfp_gemm_gfx1250.py:971:32 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s13, s0, s13
.Ltmp107:
	.loc	1 1059 13                       ; mxfp_gemm_gfx1250.py:1059:13 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_add_co_i32 s0, s70, 1
.Ltmp108:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_co_i32 s13, s13, s11
.Ltmp109:
	.loc	1 892 28                        ; mxfp_gemm_gfx1250.py:892:28 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_and_b32 s17, s0, 1
.Ltmp110:
	.loc	1 977 28                        ; mxfp_gemm_gfx1250.py:977:28 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[68:69], s[68:69], 0x400
	s_set_vgpr_msb 0x40f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
.Ltmp111:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[112:119] /*v[880:887]*/, v[160:175], v[48:63], v[112:119] /*v[880:887]*/, v17, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
.Ltmp112:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mul_i32 s18, s17, 0x11000
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	v_dual_add_nc_u32 v30, s18, v25 :: v_dual_add_nc_u32 v31, s18, v26
	s_set_vgpr_msb 0xa0                     ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp113:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x18
	v_wmma_scale_f32_16x16x128_f8f6f4 v[232:239] /*v[744:751]*/, v[128:143], v[112:127], v[232:239] /*v[744:751]*/, v16, 0
	s_set_vgpr_msb 0xa000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp114:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_2addr_b32 v[20:21], v29 offset0:8 offset1:10
	s_set_vgpr_msb 64                       ;  msbs: dst=1 src0=0 src1=0 src2=0
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[96:99] /*v[352:355]*/, v27 offset:39168
	ds_load_b128 v[100:103] /*v[356:359]*/, v27 offset:39200
	ds_load_b128 v[104:107] /*v[360:363]*/, v27 offset:39232
	ds_load_b128 v[108:111] /*v[364:367]*/, v27 offset:39264
	s_set_vgpr_msb 0x40a0                   ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp115:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[224:231] /*v[736:743]*/, v[144:159], v[112:127], v[224:231] /*v[736:743]*/, v16, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp116:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[80:83] /*v[336:339]*/, v27 offset:52224
.Ltmp117:
	.loc	1 932 32                        ; mxfp_gemm_gfx1250.py:932:32 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshl_b32 s18, s17, 11
.Ltmp118:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[84:87] /*v[340:343]*/, v27 offset:52256
	ds_load_b128 v[88:91] /*v[344:347]*/, v27 offset:52288
.Ltmp119:
	.loc	1 932 32                        ; mxfp_gemm_gfx1250.py:932:32 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_lshl_b32 s17, s17, 6
	s_add_co_i32 s18, s18, 0x43fe0
	s_set_vgpr_msb 0x40a0                   ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp120:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x1c
	v_wmma_scale_f32_16x16x128_f8f6f4 v[240:247] /*v[752:759]*/, v[128:143], v[96:111], v[240:247] /*v[752:759]*/, v16, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp121:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[92:95] /*v[348:351]*/, v27 offset:52320
	s_set_vgpr_msb 0x40c0                   ;  msbs: dst=3 src0=0 src1=0 src2=0
.Ltmp122:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	v_add3_u32 v136 /*v904*/, s18, s17, v24
	s_set_vgpr_msb 0xc040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp123:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[112:115] /*v[368:371]*/, v27 offset:56576
	ds_load_b128 v[116:119] /*v[372:375]*/, v27 offset:56608
	s_set_vgpr_msb 0x40a0                   ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp124:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[248:255] /*v[760:767]*/, v[144:159], v[96:111], v[248:255] /*v[760:767]*/, v16, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp125:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[120:123] /*v[376:379]*/, v27 offset:56640
.Ltmp126:
	.loc	1 964 39                        ; mxfp_gemm_gfx1250.py:964:39 @[ mxfp_gemm_gfx1250.py:1069:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_mul_i32 s16, s16, 0x11000
	s_set_vgpr_msb 0x40f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
.Ltmp127:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[0:7] /*v[768:775]*/, v[176:191], v[112:127], v[0:7] /*v[768:775]*/, v17, 0
	s_mov_b32 s70, s0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[8:15] /*v[776:783]*/, v[160:175], v[112:127], v[8:15] /*v[776:783]*/, v17, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp128:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1042:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[124:127] /*v[380:383]*/, v27 offset:56672
	s_set_vgpr_msb 0x40f0                   ;  msbs: dst=3 src0=0 src1=0 src2=3
.Ltmp129:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[16:23] /*v[784:791]*/, v[176:191], v[96:111], v[16:23] /*v[784:791]*/, v17, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp130:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[192:195], v28 offset:128
	ds_load_b128 v[196:199], v28 offset:160
	ds_load_b128 v[200:203], v28 offset:192
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
.Ltmp131:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[24:31] /*v[792:799]*/, v[160:175], v[96:111], v[24:31] /*v[792:799]*/, v17, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf0a0                   ;  msbs: dst=2 src0=0 src1=0 src2=2
	s_wait_dscnt 0x20
	v_wmma_scale_f32_16x16x128_f8f6f4 v[152:159] /*v[664:671]*/, v[128:143], v[80:95], v[152:159] /*v[664:671]*/, v16, 0
	s_set_vgpr_msb 0xa000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp132:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[204:207], v28 offset:224
	s_set_vgpr_msb 0xa0                     ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp133:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[160:167] /*v[672:679]*/, v[144:159], v[80:95], v[160:167] /*v[672:679]*/, v16, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp134:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[0:3] /*v[256:259]*/, v27 offset:128
	ds_load_b128 v[4:7] /*v[260:263]*/, v27 offset:160
	ds_load_b128 v[8:11] /*v[264:267]*/, v27 offset:192
	ds_load_b128 v[12:15] /*v[268:271]*/, v27 offset:224
	s_set_vgpr_msb 0x4000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_2addr_b32 v[18:19], v18 offset0:132 offset1:134
	s_set_vgpr_msb 0xa0                     ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp135:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x22
	v_wmma_scale_f32_16x16x128_f8f6f4 v[168:175] /*v[680:687]*/, v[128:143], v[64:79], v[168:175] /*v[680:687]*/, v16, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp136:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[16:19] /*v[272:275]*/, v27 offset:4480
	ds_load_b128 v[20:23] /*v[276:279]*/, v27 offset:4512
	ds_load_b128 v[24:27] /*v[280:283]*/, v27 offset:4544
	s_set_vgpr_msb 0x40a0                   ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp137:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[184:191] /*v[696:703]*/, v[144:159], v[64:79], v[184:191] /*v[696:703]*/, v16, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp138:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[28:31] /*v[284:287]*/, v27 offset:4576
	s_set_vgpr_msb 0x4000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp139:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[208:211], v28 offset:4480
	ds_load_b128 v[212:215], v28 offset:4512
	s_set_vgpr_msb 0xa0                     ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp140:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[176:183] /*v[688:695]*/, v[176:191], v[80:95], v[176:183] /*v[688:695]*/, v17, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[192:199] /*v[704:711]*/, v[160:175], v[80:95], v[192:199] /*v[704:711]*/, v17, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp141:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[216:219], v28 offset:4544
	s_set_vgpr_msb 0xa0                     ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp142:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[200:207] /*v[712:719]*/, v[176:191], v[64:79], v[200:207] /*v[712:719]*/, v17, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp143:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[220:223], v28 offset:4576
	s_set_vgpr_msb 0xa0                     ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp144:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[208:215] /*v[720:727]*/, v[160:175], v[64:79], v[208:215] /*v[720:727]*/, v17, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp145:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[32:35] /*v[288:291]*/, v27 offset:17536
	ds_load_b128 v[36:39] /*v[292:295]*/, v27 offset:17568
	s_set_vgpr_msb 0x40a0                   ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp146:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x28
	v_wmma_scale_f32_16x16x128_f8f6f4 v[120:127] /*v[632:639]*/, v[128:143], v[32:47], v[120:127] /*v[632:639]*/, v16, 0
	s_set_vgpr_msb 0xa040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp147:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[40:43] /*v[296:299]*/, v27 offset:17600
	s_set_vgpr_msb 0x40a0                   ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp148:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[128:135] /*v[640:647]*/, v[144:159], v[32:47], v[128:135] /*v[640:647]*/, v16, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp149:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[44:47] /*v[300:303]*/, v27 offset:17632
	s_set_vgpr_msb 0x40a0                   ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp150:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x26
	v_wmma_scale_f32_16x16x128_f8f6f4 v[136:143] /*v[648:655]*/, v[128:143], v[0:15], v[136:143] /*v[648:655]*/, v16, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa040                   ;  msbs: dst=1 src0=0 src1=0 src2=0
.Ltmp151:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1052:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[48:51] /*v[304:307]*/, v27 offset:21888
	ds_load_b128 v[52:55] /*v[308:311]*/, v27 offset:21920
	ds_load_b128 v[56:59] /*v[312:315]*/, v27 offset:21952
	ds_load_b128 v[60:63] /*v[316:319]*/, v27 offset:21984
	s_set_vgpr_msb 0x4000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp152:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[240:243], v28 offset:17536
	s_set_vgpr_msb 0xa0                     ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp153:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[144:151] /*v[656:663]*/, v[144:159], v[0:15], v[144:151] /*v[656:663]*/, v16, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp154:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[244:247], v28 offset:17568
	ds_load_b128 v[248:251], v28 offset:17600
	ds_load_b128 v[252:255], v28 offset:17632
	ds_load_b128 v[224:227], v28 offset:21888
	s_set_vgpr_msb 0xa0                     ;  msbs: dst=2 src0=0 src1=0 src2=2
.Ltmp155:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[216:223] /*v[728:735]*/, v[176:191], v[32:47], v[216:223] /*v[728:735]*/, v17, 0
	s_set_vgpr_msb 0xa000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp156:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[228:231], v28 offset:21920
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
.Ltmp157:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[32:39] /*v[800:807]*/, v[160:175], v[32:47], v[32:39] /*v[800:807]*/, v17, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp158:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[232:235], v28 offset:21952
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
.Ltmp159:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[48:55] /*v[816:823]*/, v[176:191], v[0:15], v[48:55] /*v[816:823]*/, v17, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp160:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[236:239], v28 offset:21984
	s_set_vgpr_msb 0xf0                     ;  msbs: dst=3 src0=0 src1=0 src2=3
.Ltmp161:
	.loc	1 1041 18                       ; mxfp_gemm_gfx1250.py:1041:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[40:47] /*v[808:815]*/, v[160:175], v[0:15], v[40:47] /*v[808:815]*/, v17, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp162:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[128:131], v28 offset:34944
	s_clause 0x1                            ; 32-byte Folded Reload
	scratch_load_b128 v[164:167], off, off th:TH_LOAD_LU nv
	scratch_load_b128 v[168:171], off, off offset:16 th:TH_LOAD_LU nv
	s_set_vgpr_msb 13                       ;  msbs: dst=0 src0=1 src1=3 src2=0
.Ltmp163:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_loadcnt_dscnt 0x2e
	v_wmma_scale_f32_16x16x128_f8f6f4 v[164:171], v[64:79] /*v[320:335]*/, v[120:135] /*v[888:903]*/, v[164:171], v20, 0
	s_set_vgpr_msb 0xd00                    ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp164:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[132:135], v28 offset:34976
	ds_load_b128 v[136:139], v28 offset:35008
	s_set_vgpr_msb 0xad                     ;  msbs: dst=2 src0=1 src1=3 src2=2
.Ltmp165:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x2c
	v_wmma_scale_f32_16x16x128_f8f6f4 v[112:119] /*v[624:631]*/, v[96:111] /*v[352:367]*/, v[120:135] /*v[888:903]*/, v[112:119] /*v[624:631]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xad00                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp166:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[140:143], v28 offset:35040
	s_set_vgpr_msb 0xa1                     ;  msbs: dst=2 src0=1 src1=0 src2=2
.Ltmp167:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[104:111] /*v[616:623]*/, v[64:79] /*v[320:335]*/, v[48:63], v[104:111] /*v[616:623]*/, v20, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp168:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[148:151], v28 offset:39296
	s_set_vgpr_msb 0xa1                     ;  msbs: dst=2 src0=1 src1=0 src2=2
.Ltmp169:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[96:103] /*v[608:615]*/, v[96:111] /*v[352:367]*/, v[48:63], v[96:103] /*v[608:615]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp170:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[152:155], v28 offset:39328
	ds_load_b128 v[156:159], v28 offset:39360
	ds_load_b128 v[160:163], v28 offset:39392
	s_set_vgpr_msb 0xad                     ;  msbs: dst=2 src0=1 src1=3 src2=2
.Ltmp171:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x2d
	v_wmma_scale_f32_16x16x128_f8f6f4 v[88:95] /*v[600:607]*/, v[80:95] /*v[336:351]*/, v[120:135] /*v[888:903]*/, v[88:95] /*v[600:607]*/, v21, 0
	s_wait_dscnt 0x29
	v_wmma_scale_f32_16x16x128_f8f6f4 v[80:87] /*v[592:599]*/, v[112:127] /*v[368:383]*/, v[120:135] /*v[888:903]*/, v[80:87] /*v[592:599]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xada1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	v_wmma_scale_f32_16x16x128_f8f6f4 v[72:79] /*v[584:591]*/, v[80:95] /*v[336:351]*/, v[48:63], v[72:79] /*v[584:591]*/, v21, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[64:71] /*v[576:583]*/, v[112:127] /*v[368:383]*/, v[48:63], v[64:71] /*v[576:583]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[56:63] /*v[568:575]*/, v[64:79] /*v[320:335]*/, v[112:127], v[56:63] /*v[568:575]*/, v20, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[48:55] /*v[560:567]*/, v[96:111] /*v[352:367]*/, v[112:127], v[48:55] /*v[560:567]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[40:47] /*v[552:559]*/, v[64:79] /*v[320:335]*/, v[96:111], v[40:47] /*v[552:559]*/, v20, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[32:39] /*v[544:551]*/, v[96:111] /*v[352:367]*/, v[96:111], v[32:39] /*v[544:551]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[24:31] /*v[536:543]*/, v[80:95] /*v[336:351]*/, v[112:127], v[24:31] /*v[536:543]*/, v21, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[16:23] /*v[528:535]*/, v[112:127] /*v[368:383]*/, v[112:127], v[16:23] /*v[528:535]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[8:15] /*v[520:527]*/, v[80:95] /*v[336:351]*/, v[96:111], v[8:15] /*v[520:527]*/, v21, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[0:7] /*v[512:519]*/, v[112:127] /*v[368:383]*/, v[96:111], v[0:7] /*v[512:519]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa151                   ;  msbs: dst=1 src0=1 src1=0 src2=1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[248:255] /*v[504:511]*/, v[64:79] /*v[320:335]*/, v[80:95], v[248:255] /*v[504:511]*/, v20, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[240:247] /*v[496:503]*/, v[96:111] /*v[352:367]*/, v[80:95], v[240:247] /*v[496:503]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[232:239] /*v[488:495]*/, v[64:79] /*v[320:335]*/, v[64:79], v[232:239] /*v[488:495]*/, v20, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[224:231] /*v[480:487]*/, v[96:111] /*v[352:367]*/, v[64:79], v[224:231] /*v[480:487]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[216:223] /*v[472:479]*/, v[80:95] /*v[336:351]*/, v[80:95], v[216:223] /*v[472:479]*/, v21, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[208:215] /*v[464:471]*/, v[112:127] /*v[368:383]*/, v[80:95], v[208:215] /*v[464:471]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[200:207] /*v[456:463]*/, v[80:95] /*v[336:351]*/, v[64:79], v[200:207] /*v[456:463]*/, v21, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[192:199] /*v[448:455]*/, v[112:127] /*v[368:383]*/, v[64:79], v[192:199] /*v[448:455]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[184:191] /*v[440:447]*/, v[64:79] /*v[320:335]*/, v[32:47], v[184:191] /*v[440:447]*/, v20, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[176:183] /*v[432:439]*/, v[96:111] /*v[352:367]*/, v[32:47], v[176:183] /*v[432:439]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[168:175] /*v[424:431]*/, v[64:79] /*v[320:335]*/, v[0:15], v[168:175] /*v[424:431]*/, v20, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[160:167] /*v[416:423]*/, v[96:111] /*v[352:367]*/, v[0:15], v[160:167] /*v[416:423]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0x5100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp172:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[80:83], v28 offset:52352
	ds_load_b128 v[84:87], v28 offset:52384
	ds_load_b128 v[88:91], v28 offset:52416
	ds_load_b128 v[92:95], v28 offset:52448
	s_set_vgpr_msb 0x51                     ;  msbs: dst=1 src0=1 src1=0 src2=1
.Ltmp173:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[152:159] /*v[408:415]*/, v[80:95] /*v[336:351]*/, v[32:47], v[152:159] /*v[408:415]*/, v21, 0
	s_set_vgpr_msb 0x5100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp174:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1051:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[64:67], v28 offset:56704
	ds_load_b128 v[68:71], v28 offset:56736
	ds_load_b128 v[72:75], v28 offset:56768
	ds_load_b128 v[76:79], v28 offset:56800
	s_set_vgpr_msb 0x51                     ;  msbs: dst=1 src0=1 src1=0 src2=1
.Ltmp175:
	.loc	1 1050 18                       ; mxfp_gemm_gfx1250.py:1050:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[144:151] /*v[400:407]*/, v[112:127] /*v[368:383]*/, v[32:47], v[144:151] /*v[400:407]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[136:143] /*v[392:399]*/, v[80:95] /*v[336:351]*/, v[0:15], v[136:143] /*v[392:399]*/, v21, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[128:135] /*v[384:391]*/, v[112:127] /*v[368:383]*/, v[0:15], v[128:135] /*v[384:391]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0x5100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp176:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[0:3], v27 offset:34944
	ds_load_b128 v[4:7], v27 offset:34976
	ds_load_b128 v[8:11], v27 offset:35008
	ds_load_b128 v[12:15], v27 offset:35040
	s_set_vgpr_msb 0xf1                     ;  msbs: dst=3 src0=1 src1=0 src2=3
.Ltmp177:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x2c
	v_wmma_scale_f32_16x16x128_f8f6f4 v[72:79] /*v[840:847]*/, v[0:15] /*v[256:271]*/, v[192:207], v[72:79] /*v[840:847]*/, v18, 0
	s_set_vgpr_msb 0xf100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp178:
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_2addr_b32 v[20:21], v29 offset0:140 offset1:142
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[32:35], v27 offset:39296
	ds_load_b128 v[36:39], v27 offset:39328
	ds_load_b128 v[40:43], v27 offset:39360
	s_set_vgpr_msb 0xf1                     ;  msbs: dst=3 src0=1 src1=0 src2=3
.Ltmp179:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x2c
	v_wmma_scale_f32_16x16x128_f8f6f4 v[64:71] /*v[832:839]*/, v[16:31] /*v[272:287]*/, v[192:207], v[64:71] /*v[832:839]*/, v18, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_wait_dscnt 0x28
	v_wmma_scale_f32_16x16x128_f8f6f4 v[56:63] /*v[824:831]*/, v[0:15] /*v[256:271]*/, v[208:223], v[56:63] /*v[824:831]*/, v18, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[96:103] /*v[864:871]*/, v[16:31] /*v[272:287]*/, v[208:223], v[96:103] /*v[864:871]*/, v18, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp180:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[44:47], v27 offset:39392
	s_set_vgpr_msb 0xf1                     ;  msbs: dst=3 src0=1 src1=0 src2=3
.Ltmp181:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0x25
	v_wmma_scale_f32_16x16x128_f8f6f4 v[88:95] /*v[856:863]*/, v[32:47] /*v[288:303]*/, v[192:207], v[88:95] /*v[856:863]*/, v19, 0
	s_wait_dscnt 0x21
	v_wmma_scale_f32_16x16x128_f8f6f4 v[80:87] /*v[848:855]*/, v[48:63] /*v[304:319]*/, v[192:207], v[80:87] /*v[848:855]*/, v19, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[104:111] /*v[872:879]*/, v[32:47] /*v[288:303]*/, v[208:223], v[104:111] /*v[872:879]*/, v19, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[112:119] /*v[880:887]*/, v[48:63] /*v[304:319]*/, v[208:223], v[112:119] /*v[880:887]*/, v19, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf1a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	s_wait_dscnt 0x1d
	v_wmma_scale_f32_16x16x128_f8f6f4 v[232:239] /*v[744:751]*/, v[0:15] /*v[256:271]*/, v[240:255], v[232:239] /*v[744:751]*/, v18, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[224:231] /*v[736:743]*/, v[16:31] /*v[272:287]*/, v[240:255], v[224:231] /*v[736:743]*/, v18, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_wait_dscnt 0x19
	v_wmma_scale_f32_16x16x128_f8f6f4 v[240:247] /*v[752:759]*/, v[0:15] /*v[256:271]*/, v[224:239], v[240:247] /*v[752:759]*/, v18, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[248:255] /*v[760:767]*/, v[16:31] /*v[272:287]*/, v[224:239], v[248:255] /*v[760:767]*/, v18, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa1f1                   ;  msbs: dst=3 src0=1 src1=0 src2=3
	v_wmma_scale_f32_16x16x128_f8f6f4 v[0:7] /*v[768:775]*/, v[32:47] /*v[288:303]*/, v[240:255], v[0:7] /*v[768:775]*/, v19, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[8:15] /*v[776:783]*/, v[48:63] /*v[304:319]*/, v[240:255], v[8:15] /*v[776:783]*/, v19, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[16:23] /*v[784:791]*/, v[32:47] /*v[288:303]*/, v[224:239], v[16:23] /*v[784:791]*/, v19, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[24:31] /*v[792:799]*/, v[48:63] /*v[304:319]*/, v[224:239], v[24:31] /*v[792:799]*/, v19, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf1a1                   ;  msbs: dst=2 src0=1 src1=0 src2=2
	s_wait_dscnt 0x15
	v_wmma_scale_f32_16x16x128_f8f6f4 v[152:159] /*v[664:671]*/, v[0:15] /*v[256:271]*/, v[128:143], v[152:159] /*v[664:671]*/, v18, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[160:167] /*v[672:679]*/, v[16:31] /*v[272:287]*/, v[128:143], v[160:167] /*v[672:679]*/, v18, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_wait_dscnt 0x11
	v_wmma_scale_f32_16x16x128_f8f6f4 v[168:175] /*v[680:687]*/, v[0:15] /*v[256:271]*/, v[148:163], v[168:175] /*v[680:687]*/, v18, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[184:191] /*v[696:703]*/, v[16:31] /*v[272:287]*/, v[148:163], v[184:191] /*v[696:703]*/, v18, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[176:183] /*v[688:695]*/, v[32:47] /*v[288:303]*/, v[128:143], v[176:183] /*v[688:695]*/, v19, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[192:199] /*v[704:711]*/, v[48:63] /*v[304:319]*/, v[128:143], v[192:199] /*v[704:711]*/, v19, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[200:207] /*v[712:719]*/, v[32:47] /*v[288:303]*/, v[148:163], v[200:207] /*v[712:719]*/, v19, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[208:215] /*v[720:727]*/, v[48:63] /*v[304:319]*/, v[148:163], v[208:215] /*v[720:727]*/, v19, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_wait_dscnt 0xd
	v_wmma_scale_f32_16x16x128_f8f6f4 v[120:127] /*v[632:639]*/, v[0:15] /*v[256:271]*/, v[80:95], v[120:127] /*v[632:639]*/, v18, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[128:135] /*v[640:647]*/, v[16:31] /*v[272:287]*/, v[80:95], v[128:135] /*v[640:647]*/, v18, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_wait_dscnt 0x9
	v_wmma_scale_f32_16x16x128_f8f6f4 v[136:143] /*v[648:655]*/, v[0:15] /*v[256:271]*/, v[64:79], v[136:143] /*v[648:655]*/, v18, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[144:151] /*v[656:663]*/, v[16:31] /*v[272:287]*/, v[64:79], v[144:151] /*v[656:663]*/, v18, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp182:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[112:115], v27 offset:52352
	ds_load_b128 v[116:119], v27 offset:52384
	ds_load_b128 v[120:123], v27 offset:52416
	ds_load_b128 v[124:127], v27 offset:52448
	s_set_vgpr_msb 0xa1                     ;  msbs: dst=2 src0=1 src1=0 src2=2
.Ltmp183:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[216:223] /*v[728:735]*/, v[32:47] /*v[288:303]*/, v[80:95], v[216:223] /*v[728:735]*/, v19, 0
	s_set_vgpr_msb 0xa100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp184:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1056:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[96:99], v27 offset:56704
	ds_load_b128 v[100:103], v27 offset:56736
	ds_load_b128 v[104:107], v27 offset:56768
	ds_load_b128 v[108:111], v27 offset:56800
	s_set_vgpr_msb 0xf1                     ;  msbs: dst=3 src0=1 src1=0 src2=3
.Ltmp185:
	.loc	1 1055 18                       ; mxfp_gemm_gfx1250.py:1055:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[32:39] /*v[800:807]*/, v[48:63] /*v[304:319]*/, v[80:95], v[32:39] /*v[800:807]*/, v19, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[48:55] /*v[816:823]*/, v[32:47] /*v[288:303]*/, v[64:79], v[48:55] /*v[816:823]*/, v19, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[40:47] /*v[808:815]*/, v[48:63] /*v[304:319]*/, v[64:79], v[40:47] /*v[808:815]*/, v19, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xf100                   ;  msbs: dst=0 src0=0 src1=0 src2=0
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_wait_dscnt 0xc
	v_wmma_scale_f32_16x16x128_f8f6f4 v[164:171], v[0:15], v[192:207], v[164:171], v20, 0
	s_clause 0x1                            ; 32-byte Folded Spill
	scratch_store_b128 off, v[164:167], off nv
	scratch_store_b128 off, v[168:171], off offset:16 nv
	s_set_vgpr_msb 0xa0                     ;  msbs: dst=2 src0=0 src1=0 src2=2
	s_wait_dscnt 0x8
	v_wmma_scale_f32_16x16x128_f8f6f4 v[112:119] /*v[624:631]*/, v[32:47], v[192:207], v[112:119] /*v[624:631]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[104:111] /*v[616:623]*/, v[0:15], v[208:223], v[104:111] /*v[616:623]*/, v20, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[96:103] /*v[608:615]*/, v[32:47], v[208:223], v[96:103] /*v[608:615]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_wait_dscnt 0x4
	v_wmma_scale_f32_16x16x128_f8f6f4 v[88:95] /*v[600:607]*/, v[112:127], v[192:207], v[88:95] /*v[600:607]*/, v21, 0
	s_wait_dscnt 0x0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[80:87] /*v[592:599]*/, v[96:111], v[192:207], v[80:87] /*v[592:599]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1
.Ltmp186:
	.loc	1 1001 13                       ; mxfp_gemm_gfx1250.py:1001:13 @[ mxfp_gemm_gfx1250.py:1065:13 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_tensorcnt 0x0
	s_barrier_signal -1
.Ltmp187:
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[72:79] /*v[584:591]*/, v[112:127], v[208:223], v[72:79] /*v[584:591]*/, v21, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[64:71] /*v[576:583]*/, v[96:111], v[208:223], v[64:71] /*v[576:583]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[56:63] /*v[568:575]*/, v[0:15], v[240:255], v[56:63] /*v[568:575]*/, v20, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[48:55] /*v[560:567]*/, v[32:47], v[240:255], v[48:55] /*v[560:567]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[40:47] /*v[552:559]*/, v[0:15], v[224:239], v[40:47] /*v[552:559]*/, v20, 0 matrix_b_scale:MATRIX_SCALE_ROW1
.Ltmp188:
	.loc	1 1001 13                       ; mxfp_gemm_gfx1250.py:1001:13 @[ mxfp_gemm_gfx1250.py:1065:13 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_barrier_wait -1
.Ltmp189:
	.loc	1 975 13                        ; mxfp_gemm_gfx1250.py:975:13 @[ mxfp_gemm_gfx1250.py:1068:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	tensor_load_to_lds s[12:15], s[20:27]
.Ltmp190:
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[32:39] /*v[544:551]*/, v[32:47], v[224:239], v[32:39] /*v[544:551]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[24:31] /*v[536:543]*/, v[112:127], v[240:255], v[24:31] /*v[536:543]*/, v21, 0
.Ltmp191:
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1069:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[14:15], s[30:31], s[64:65]
	s_add_co_i32 s13, s29, s16
	.loc	1 966 16                        ; mxfp_gemm_gfx1250.py:966:16 @[ mxfp_gemm_gfx1250.py:1069:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[30:31], s[30:31], 0x100
	.loc	1 963 9                         ; mxfp_gemm_gfx1250.py:963:9 @[ mxfp_gemm_gfx1250.py:1069:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	tensor_load_to_lds s[12:15], s[36:43]
.Ltmp192:
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[16:23] /*v[528:535]*/, v[96:111], v[240:255], v[16:23] /*v[528:535]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[8:15] /*v[520:527]*/, v[112:127], v[224:239], v[8:15] /*v[520:527]*/, v21, 0 matrix_b_scale:MATRIX_SCALE_ROW1
.Ltmp193:
	.loc	1 985 9                         ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1070:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[14:15], s[66:67], s[4:5]
	s_add_co_i32 s13, s3, s16
	.loc	1 989 22                        ; mxfp_gemm_gfx1250.py:989:22 @[ mxfp_gemm_gfx1250.py:1070:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_add_nc_u64 s[66:67], s[66:67], 0x100
.Ltmp194:
	.loc	1 1039 9                        ; mxfp_gemm_gfx1250.py:1039:9 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_cmp_lg_u32 s28, s0
.Ltmp195:
	.loc	1 985 9                         ; mxfp_gemm_gfx1250.py:985:9 @[ mxfp_gemm_gfx1250.py:1070:22 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	tensor_load_to_lds s[12:15], s[44:51]
.Ltmp196:
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[0:7] /*v[512:519]*/, v[96:111], v[224:239], v[0:7] /*v[512:519]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0xa050                   ;  msbs: dst=1 src0=0 src1=0 src2=1
.Ltmp197:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_barrier_signal -1
.Ltmp198:
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[248:255] /*v[504:511]*/, v[0:15], v[128:143], v[248:255] /*v[504:511]*/, v20, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[240:247] /*v[496:503]*/, v[32:47], v[128:143], v[240:247] /*v[496:503]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[232:239] /*v[488:495]*/, v[0:15], v[148:163], v[232:239] /*v[488:495]*/, v20, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[224:231] /*v[480:487]*/, v[32:47], v[148:163], v[224:231] /*v[480:487]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[216:223] /*v[472:479]*/, v[112:127], v[128:143], v[216:223] /*v[472:479]*/, v21, 0
.Ltmp199:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_barrier_wait -1
.Ltmp200:
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[208:215] /*v[464:471]*/, v[96:111], v[128:143], v[208:215] /*v[464:471]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0x50c0                   ;  msbs: dst=3 src0=0 src1=0 src2=0
.Ltmp201:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[120:123] /*v[888:891]*/, v30
	ds_load_b128 v[124:127] /*v[892:895]*/, v30 offset:32
	ds_load_b128 v[128:131] /*v[896:899]*/, v30 offset:64
	ds_load_b128 v[132:135] /*v[900:903]*/, v30 offset:96
	s_set_vgpr_msb 0xc000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp202:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[128:131], v31
	s_set_vgpr_msb 0x50                     ;  msbs: dst=1 src0=0 src1=0 src2=1
.Ltmp203:
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[200:207] /*v[456:463]*/, v[112:127], v[148:163], v[200:207] /*v[456:463]*/, v21, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0x5000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp204:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[132:135], v31 offset:32
	ds_load_b128 v[136:139], v31 offset:64
	ds_load_b128 v[140:143], v31 offset:96
	s_set_vgpr_msb 3                        ;  msbs: dst=0 src0=3 src1=0 src2=0
	.loc	1 942 19                        ; mxfp_gemm_gfx1250.py:942:19 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_2addr_b32 v[16:17], v136 /*v904*/ offset1:2
	s_set_vgpr_msb 0x300                    ;  msbs: dst=0 src0=0 src1=0 src2=0
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[144:147], v31 offset:4352
	s_set_vgpr_msb 0x50                     ;  msbs: dst=1 src0=0 src1=0 src2=1
.Ltmp205:
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[192:199] /*v[448:455]*/, v[96:111], v[148:163], v[192:199] /*v[448:455]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0x5000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp206:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[148:151], v31 offset:4384
	ds_load_b128 v[152:155], v31 offset:4416
	ds_load_b128 v[156:159], v31 offset:4448
.Ltmp207:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[48:51], v30 offset:4352
	ds_load_b128 v[52:55], v30 offset:4384
	s_set_vgpr_msb 0x50                     ;  msbs: dst=1 src0=0 src1=0 src2=1
.Ltmp208:
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[184:191] /*v[440:447]*/, v[0:15], v[80:95], v[184:191] /*v[440:447]*/, v20, 0
	s_set_vgpr_msb 0x5000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp209:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[56:59], v30 offset:4416
	s_set_vgpr_msb 0x50                     ;  msbs: dst=1 src0=0 src1=0 src2=1
.Ltmp210:
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[176:183] /*v[432:439]*/, v[32:47], v[80:95], v[176:183] /*v[432:439]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[168:175] /*v[424:431]*/, v[0:15], v[64:79], v[168:175] /*v[424:431]*/, v20, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[160:167] /*v[416:423]*/, v[32:47], v[64:79], v[160:167] /*v[416:423]*/, v20, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	v_wmma_scale_f32_16x16x128_f8f6f4 v[152:159] /*v[408:415]*/, v[112:127], v[80:95], v[152:159] /*v[408:415]*/, v21, 0
	v_wmma_scale_f32_16x16x128_f8f6f4 v[144:151] /*v[400:407]*/, v[96:111], v[80:95], v[144:151] /*v[400:407]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0x5000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp211:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[60:63], v30 offset:4448
	s_set_vgpr_msb 0x50                     ;  msbs: dst=1 src0=0 src1=0 src2=1
.Ltmp212:
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[136:143] /*v[392:399]*/, v[112:127], v[64:79], v[136:143] /*v[392:399]*/, v21, 0 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0x5000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp213:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[176:179], v31 offset:17408
	ds_load_b128 v[180:183], v31 offset:17440
	ds_load_b128 v[184:187], v31 offset:17472
	ds_load_b128 v[188:191], v31 offset:17504
	ds_load_b128 v[160:163], v31 offset:21760
	s_set_vgpr_msb 0x50                     ;  msbs: dst=1 src0=0 src1=0 src2=1
.Ltmp214:
	.loc	1 1060 18                       ; mxfp_gemm_gfx1250.py:1060:18 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	v_wmma_scale_f32_16x16x128_f8f6f4 v[128:135] /*v[384:391]*/, v[96:111], v[64:79], v[128:135] /*v[384:391]*/, v21, 0 matrix_a_scale:MATRIX_SCALE_ROW1 matrix_b_scale:MATRIX_SCALE_ROW1
	s_set_vgpr_msb 0x5000                   ;  msbs: dst=0 src0=0 src1=0 src2=0
.Ltmp215:
	.loc	1 924 17                        ; mxfp_gemm_gfx1250.py:924:17 @[ mxfp_gemm_gfx1250.py:1073:30 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[164:167], v31 offset:21792
	ds_load_b128 v[168:171], v31 offset:21824
	ds_load_b128 v[172:175], v31 offset:21856
.Ltmp216:
	.loc	1 892 13                        ; mxfp_gemm_gfx1250.py:892:13 @[ mxfp_gemm_gfx1250.py:1072:28 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_load_b128 v[112:115], v30 offset:17408
	ds_load_b128 v[116:119], v30 offset:17440
	ds_load_b128 v[120:123], v30 offset:17472
	ds_load_b128 v[124:127], v30 offset:17504
	ds_load_b128 v[96:99], v30 offset:21760
	ds_load_b128 v[100:103], v30 offset:21792
	ds_load_b128 v[104:107], v30 offset:21824
	ds_load_b128 v[108:111], v30 offset:21856
	ds_load_b128 v[80:83], v30 offset:34816
	ds_load_b128 v[84:87], v30 offset:34848
	ds_load_b128 v[88:91], v30 offset:34880
	ds_load_b128 v[92:95], v30 offset:34912
	ds_load_b128 v[64:67], v30 offset:39168
	ds_load_b128 v[68:71], v30 offset:39200
	ds_load_b128 v[72:75], v30 offset:39232
	ds_load_b128 v[76:79], v30 offset:39264
	ds_load_b128 v[32:35], v30 offset:52224
	ds_load_b128 v[36:39], v30 offset:52256
	ds_load_b128 v[40:43], v30 offset:52288
	ds_load_b128 v[44:47], v30 offset:52320
	ds_load_b128 v[0:3], v30 offset:56576
	ds_load_b128 v[4:7], v30 offset:56608
	ds_load_b128 v[8:11], v30 offset:56640
	ds_load_b128 v[12:15], v30 offset:56672
.Ltmp217:
	.loc	1 1039 9                        ; mxfp_gemm_gfx1250.py:1039:9 @[ mxfp_gemm_gfx1250.py:1491:9 ]
	s_cbranch_scc1 .LBB0_1
; %bb.2:                                ; %._crit_edge
.Ltmp218:
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_dscnt 0x0
	s_barrier_signal -1
	v_nop
	v_nop
	v_nop
	v_dual_lshlrev_b32 v0, 10, v22 :: v_dual_lshlrev_b32 v1, 1, v23
	s_lshl_b32 s0, s61, 2
	s_lshl_b32 s3, s35, 9
.Ltmp219:
	.loc	1 1469 14                       ; mxfp_gemm_gfx1250.py:1469:14
	s_bitset1_b32 s7, 31
.Ltmp220:
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_or_b32 s3, s3, s0
.Ltmp221:
	.loc	1 1469 14                       ; mxfp_gemm_gfx1250.py:1469:14
	s_ashr_i32 s5, s34, 31
.Ltmp222:
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
.Ltmp223:
	.loc	1 1469 14                       ; mxfp_gemm_gfx1250.py:1469:14
	s_and_b32 s35, s5, 0xffff
.Ltmp224:
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
	ds_store_b128 v0, v[72:75] /*v[840:843]*/
	ds_store_b128 v0, v[76:79] /*v[844:847]*/ offset:16
	ds_store_b128 v0, v[64:67] /*v[832:835]*/ offset:64
	ds_store_b128 v0, v[68:71] /*v[836:839]*/ offset:80
	ds_store_b128 v0, v[56:59] /*v[824:827]*/ offset:16384
	ds_store_b128 v0, v[60:63] /*v[828:831]*/ offset:16400
	ds_store_b128 v0, v[96:99] /*v[864:867]*/ offset:16448
	ds_store_b128 v0, v[100:103] /*v[868:871]*/ offset:16464
	ds_store_b128 v0, v[88:91] /*v[856:859]*/ offset:256
	ds_store_b128 v0, v[92:95] /*v[860:863]*/ offset:272
	ds_store_b128 v0, v[80:83] /*v[848:851]*/ offset:320
	ds_store_b128 v0, v[84:87] /*v[852:855]*/ offset:336
	ds_store_b128 v0, v[104:107] /*v[872:875]*/ offset:16640
	ds_store_b128 v0, v[108:111] /*v[876:879]*/ offset:16656
	ds_store_b128 v0, v[112:115] /*v[880:883]*/ offset:16704
	ds_store_b128 v0, v[116:119] /*v[884:887]*/ offset:16720
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
	s_set_vgpr_msb 8                        ;  msbs: dst=0 src0=0 src1=2 src2=0
	ds_store_b128 v0, v[112:115] /*v[624:627]*/ offset:576
	ds_store_b128 v0, v[116:119] /*v[628:631]*/ offset:592
	ds_store_b128 v0, v[104:107] /*v[616:619]*/ offset:16896
	ds_store_b128 v0, v[108:111] /*v[620:623]*/ offset:16912
	ds_store_b128 v0, v[96:99] /*v[608:611]*/ offset:16960
	ds_store_b128 v0, v[100:103] /*v[612:615]*/ offset:16976
	ds_store_b128 v0, v[88:91] /*v[600:603]*/ offset:768
	ds_store_b128 v0, v[92:95] /*v[604:607]*/ offset:784
	ds_store_b128 v0, v[80:83] /*v[592:595]*/ offset:832
	ds_store_b128 v0, v[84:87] /*v[596:599]*/ offset:848
	ds_store_b128 v0, v[72:75] /*v[584:587]*/ offset:17152
	ds_store_b128 v0, v[76:79] /*v[588:591]*/ offset:17168
	ds_store_b128 v0, v[64:67] /*v[576:579]*/ offset:17216
	ds_store_b128 v0, v[68:71] /*v[580:583]*/ offset:17232
	s_set_vgpr_msb 0x800                    ;  msbs: dst=0 src0=0 src1=0 src2=0
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
	s_set_vgpr_msb 8                        ;  msbs: dst=0 src0=0 src1=2 src2=0
	ds_store_b128 v1, v[232:235] /*v[744:747]*/
	ds_store_b128 v2, v[236:239] /*v[748:751]*/
	ds_store_b128 v3, v[224:227] /*v[736:739]*/
	ds_store_b128 v4, v[228:231] /*v[740:743]*/
	ds_store_b128 v5, v[240:243] /*v[752:755]*/
	ds_store_b128 v6, v[244:247] /*v[756:759]*/
	ds_store_b128 v7, v[248:251] /*v[760:763]*/
	ds_store_b128 v8, v[252:255] /*v[764:767]*/
	s_set_vgpr_msb 0x80c                    ;  msbs: dst=0 src0=0 src1=3 src2=0
	ds_store_b128 v9, v[0:3] /*v[768:771]*/
	ds_store_b128 v10, v[4:7] /*v[772:775]*/
	ds_store_b128 v11, v[8:11] /*v[776:779]*/
	ds_store_b128 v12, v[12:15] /*v[780:783]*/
	ds_store_b128 v13, v[16:19] /*v[784:787]*/
	ds_store_b128 v14, v[20:23] /*v[788:791]*/
	ds_store_b128 v15, v[24:27] /*v[792:795]*/
	ds_store_b128 v16, v[28:31] /*v[796:799]*/
	s_set_vgpr_msb 0xc00                    ;  msbs: dst=0 src0=0 src1=0 src2=0
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
	s_set_vgpr_msb 8                        ;  msbs: dst=0 src0=0 src1=2 src2=0
	.loc	1 409 5                         ; mxfp_gemm_gfx1250.py:409:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	ds_store_b128 v17, v[56:59] /*v[568:571]*/
	ds_store_b128 v18, v[60:63] /*v[572:575]*/
	ds_store_b128 v19, v[48:51] /*v[560:563]*/
	ds_store_b128 v20, v[52:55] /*v[564:567]*/
	ds_store_b128 v21, v[40:43] /*v[552:555]*/
	ds_store_b128 v22, v[44:47] /*v[556:559]*/
	ds_store_b128 v23, v[32:35] /*v[544:547]*/
	ds_store_b128 v24, v[36:39] /*v[548:551]*/
	ds_store_b128 v25, v[24:27] /*v[536:539]*/
	ds_store_b128 v26, v[28:31] /*v[540:543]*/
	ds_store_b128 v27, v[16:19] /*v[528:531]*/
	ds_store_b128 v28, v[20:23] /*v[532:535]*/
	ds_store_b128 v29, v[8:11] /*v[520:523]*/
	ds_store_b128 v30, v[12:15] /*v[524:527]*/
	ds_store_b128 v31, v[0:3] /*v[512:515]*/
	ds_store_b128 v32, v[4:7] /*v[516:519]*/
	ds_store_b128 v33, v[152:155] /*v[664:667]*/
	ds_store_b128 v34, v[156:159] /*v[668:671]*/
	ds_store_b128 v35, v[160:163] /*v[672:675]*/
	ds_store_b128 v36, v[164:167] /*v[676:679]*/
	ds_store_b128 v37, v[168:171] /*v[680:683]*/
	ds_store_b128 v38, v[172:175] /*v[684:687]*/
	ds_store_b128 v39, v[184:187] /*v[696:699]*/
	ds_store_b128 v40, v[188:191] /*v[700:703]*/
	ds_store_b128 v41, v[176:179] /*v[688:691]*/
	ds_store_b128 v42, v[180:183] /*v[692:695]*/
	ds_store_b128 v43, v[192:195] /*v[704:707]*/
	ds_store_b128 v44, v[196:199] /*v[708:711]*/
	ds_store_b128 v45, v[200:203] /*v[712:715]*/
	ds_store_b128 v46, v[204:207] /*v[716:719]*/
	ds_store_b128 v47, v[208:211] /*v[720:723]*/
	ds_store_b128 v48, v[212:215] /*v[724:727]*/
	s_set_vgpr_msb 0x804                    ;  msbs: dst=0 src0=0 src1=1 src2=0
	ds_store_b128 v49, v[248:251] /*v[504:507]*/
	ds_store_b128 v50, v[252:255] /*v[508:511]*/
	ds_store_b128 v51, v[240:243] /*v[496:499]*/
	ds_store_b128 v52, v[244:247] /*v[500:503]*/
	ds_store_b128 v53, v[232:235] /*v[488:491]*/
	ds_store_b128 v54, v[236:239] /*v[492:495]*/
	ds_store_b128 v55, v[224:227] /*v[480:483]*/
	ds_store_b128 v56, v[228:231] /*v[484:487]*/
	ds_store_b128 v57, v[216:219] /*v[472:475]*/
	ds_store_b128 v58, v[220:223] /*v[476:479]*/
	ds_store_b128 v59, v[208:211] /*v[464:467]*/
	ds_store_b128 v60, v[212:215] /*v[468:471]*/
	ds_store_b128 v61, v[200:203] /*v[456:459]*/
	ds_store_b128 v62, v[204:207] /*v[460:463]*/
	ds_store_b128 v63, v[192:195] /*v[448:451]*/
	ds_store_b128 v64, v[196:199] /*v[452:455]*/
	s_set_vgpr_msb 0x408                    ;  msbs: dst=0 src0=0 src1=2 src2=0
	ds_store_b128 v65, v[120:123] /*v[632:635]*/
	ds_store_b128 v66, v[124:127] /*v[636:639]*/
	ds_store_b128 v67, v[128:131] /*v[640:643]*/
	ds_store_b128 v68, v[132:135] /*v[644:647]*/
	ds_store_b128 v69, v[136:139] /*v[648:651]*/
	ds_store_b128 v70, v[140:143] /*v[652:655]*/
	ds_store_b128 v71, v[144:147] /*v[656:659]*/
	ds_store_b128 v72, v[148:151] /*v[660:663]*/
	ds_store_b128 v73, v[216:219] /*v[728:731]*/
	ds_store_b128 v74, v[220:223] /*v[732:735]*/
	s_set_vgpr_msb 0x80c                    ;  msbs: dst=0 src0=0 src1=3 src2=0
	ds_store_b128 v75, v[32:35] /*v[800:803]*/
	ds_store_b128 v1, v[36:39] /*v[804:807]*/
	ds_store_b128 v2, v[48:51] /*v[816:819]*/
	ds_store_b128 v3, v[52:55] /*v[820:823]*/
	ds_store_b128 v4, v[40:43] /*v[808:811]*/
	ds_store_b128 v5, v[44:47] /*v[812:815]*/
	s_set_vgpr_msb 0xc04                    ;  msbs: dst=0 src0=0 src1=1 src2=0
	ds_store_b128 v6, v[184:187] /*v[440:443]*/
	ds_store_b128 v7, v[188:191] /*v[444:447]*/
	ds_store_b128 v8, v[176:179] /*v[432:435]*/
	ds_store_b128 v9, v[180:183] /*v[436:439]*/
	ds_store_b128 v10, v[168:171] /*v[424:427]*/
	ds_store_b128 v11, v[172:175] /*v[428:431]*/
	ds_store_b128 v12, v[160:163] /*v[416:419]*/
	ds_store_b128 v13, v[164:167] /*v[420:423]*/
	ds_store_b128 v14, v[152:155] /*v[408:411]*/
	ds_store_b128 v15, v[156:159] /*v[412:415]*/
	ds_store_b128 v16, v[144:147] /*v[400:403]*/
	ds_store_b128 v76, v[148:151] /*v[404:407]*/
	ds_store_b128 v77, v[136:139] /*v[392:395]*/
	ds_store_b128 v78, v[140:143] /*v[396:399]*/
	ds_store_b128 v79, v[128:131] /*v[384:387]*/
	ds_store_b128 v0, v[132:135] /*v[388:391]*/
	.loc	1 410 5                         ; mxfp_gemm_gfx1250.py:410:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_dscnt 0x0
	s_barrier_signal -1
	s_barrier_wait -1
	tensor_store_from_lds s[0:3], s[4:11]
	.loc	1 411 5                         ; mxfp_gemm_gfx1250.py:411:5 @[ mxfp_gemm_gfx1250.py:1079:9 @[ mxfp_gemm_gfx1250.py:1491:9 ] ]
	s_wait_tensorcnt 0x0
	s_barrier_signal -1
	s_barrier_wait -1
.Ltmp225:
	.loc	1 1415 1                        ; mxfp_gemm_gfx1250.py:1415:1
	s_endpgm
.Ltmp226:
.Lfunc_end0:
	.size	mxgemm_tdm_pipelined_kernel, .Lfunc_end0-mxgemm_tdm_pipelined_kernel
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel mxgemm_tdm_pipelined_kernel
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 36
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
		.amdhsa_next_free_vgpr 905
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
	.set .Lmxgemm_tdm_pipelined_kernel.num_vgpr, 905
	.set .Lmxgemm_tdm_pipelined_kernel.num_agpr, 0
	.set .Lmxgemm_tdm_pipelined_kernel.numbered_sgpr, 76
	.set .Lmxgemm_tdm_pipelined_kernel.num_named_barrier, 0
	.set .Lmxgemm_tdm_pipelined_kernel.private_seg_size, 36
	.set .Lmxgemm_tdm_pipelined_kernel.uses_vcc, 0
	.set .Lmxgemm_tdm_pipelined_kernel.uses_flat_scratch, 1
	.set .Lmxgemm_tdm_pipelined_kernel.has_dyn_sized_stack, 0
	.set .Lmxgemm_tdm_pipelined_kernel.has_recursion, 0
	.set .Lmxgemm_tdm_pipelined_kernel.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 10076
; TotalNumSgprs: 76
; NumVgprs: 905
; ScratchSize: 36
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 56
; NumSGPRsForWavesPerEU: 76
; NumVGPRsForWavesPerEU: 905
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
	.quad	.Ltmp73                         ; DW_AT_low_pc
	.long	.Ltmp74-.Ltmp73                 ; DW_AT_high_pc
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
	.quad	.Ltmp2                          ; DW_AT_low_pc
	.long	.Ltmp3-.Ltmp2                   ; DW_AT_high_pc
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
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp4-.Lfunc_begin0
	.quad	.Ltmp5-.Lfunc_begin0
	.quad	.Ltmp16-.Lfunc_begin0
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
	.quad	.Ltmp29-.Lfunc_begin0
	.quad	.Ltmp30-.Lfunc_begin0
	.quad	.Ltmp34-.Lfunc_begin0
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp37-.Lfunc_begin0
	.quad	.Ltmp38-.Lfunc_begin0
	.quad	.Ltmp39-.Lfunc_begin0
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	.Ltmp60-.Lfunc_begin0
	.quad	.Ltmp61-.Lfunc_begin0
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	.Ltmp220-.Lfunc_begin0
	.quad	.Ltmp221-.Lfunc_begin0
	.quad	.Ltmp222-.Lfunc_begin0
	.quad	.Ltmp223-.Lfunc_begin0
	.quad	.Ltmp224-.Lfunc_begin0
	.quad	.Ltmp225-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges1:
	.quad	.Ltmp0-.Lfunc_begin0
	.quad	.Ltmp1-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp46-.Lfunc_begin0
	.quad	.Ltmp47-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	.Ltmp52-.Lfunc_begin0
	.quad	.Ltmp53-.Lfunc_begin0
	.quad	.Ltmp54-.Lfunc_begin0
	.quad	.Ltmp55-.Lfunc_begin0
	.quad	.Ltmp62-.Lfunc_begin0
	.quad	.Ltmp63-.Lfunc_begin0
	.quad	.Ltmp74-.Lfunc_begin0
	.quad	.Ltmp75-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges2:
	.quad	.Ltmp1-.Lfunc_begin0
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	.Ltmp51-.Lfunc_begin0
	.quad	.Ltmp53-.Lfunc_begin0
	.quad	.Ltmp54-.Lfunc_begin0
	.quad	.Ltmp55-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp63-.Lfunc_begin0
	.quad	.Ltmp64-.Lfunc_begin0
	.quad	.Ltmp65-.Lfunc_begin0
	.quad	.Ltmp66-.Lfunc_begin0
	.quad	.Ltmp75-.Lfunc_begin0
	.quad	.Ltmp76-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges3:
	.quad	.Ltmp4-.Lfunc_begin0
	.quad	.Ltmp5-.Lfunc_begin0
	.quad	.Ltmp218-.Lfunc_begin0
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	.Ltmp220-.Lfunc_begin0
	.quad	.Ltmp221-.Lfunc_begin0
	.quad	.Ltmp222-.Lfunc_begin0
	.quad	.Ltmp223-.Lfunc_begin0
	.quad	.Ltmp224-.Lfunc_begin0
	.quad	.Ltmp225-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges4:
	.quad	.Ltmp16-.Lfunc_begin0
	.quad	.Ltmp17-.Lfunc_begin0
	.quad	.Ltmp18-.Lfunc_begin0
	.quad	.Ltmp19-.Lfunc_begin0
	.quad	.Ltmp20-.Lfunc_begin0
	.quad	.Ltmp21-.Lfunc_begin0
	.quad	.Ltmp29-.Lfunc_begin0
	.quad	.Ltmp30-.Lfunc_begin0
	.quad	.Ltmp46-.Lfunc_begin0
	.quad	.Ltmp47-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges5:
	.quad	.Ltmp22-.Lfunc_begin0
	.quad	.Ltmp23-.Lfunc_begin0
	.quad	.Ltmp24-.Lfunc_begin0
	.quad	.Ltmp25-.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	.Ltmp27-.Lfunc_begin0
	.quad	.Ltmp34-.Lfunc_begin0
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp37-.Lfunc_begin0
	.quad	.Ltmp38-.Lfunc_begin0
	.quad	.Ltmp39-.Lfunc_begin0
	.quad	.Ltmp66-.Lfunc_begin0
	.quad	.Ltmp67-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges6:
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp68-.Lfunc_begin0
	.quad	.Ltmp69-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges7:
	.quad	.Ltmp49-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	.Ltmp51-.Lfunc_begin0
	.quad	.Ltmp52-.Lfunc_begin0
	.quad	.Ltmp70-.Lfunc_begin0
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Ltmp76-.Lfunc_begin0
	.quad	.Ltmp77-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges8:
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	.Ltmp67-.Lfunc_begin0
	.quad	.Ltmp68-.Lfunc_begin0
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Ltmp72-.Lfunc_begin0
	.quad	.Ltmp77-.Lfunc_begin0
	.quad	.Ltmp78-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges9:
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	.Ltmp58-.Lfunc_begin0
	.quad	.Ltmp69-.Lfunc_begin0
	.quad	.Ltmp70-.Lfunc_begin0
	.quad	.Ltmp72-.Lfunc_begin0
	.quad	.Ltmp73-.Lfunc_begin0
	.quad	.Ltmp78-.Lfunc_begin0
	.quad	.Ltmp79-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges10:
	.quad	.Ltmp58-.Lfunc_begin0
	.quad	.Ltmp59-.Lfunc_begin0
	.quad	.Ltmp61-.Lfunc_begin0
	.quad	.Ltmp62-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges11:
	.quad	.Ltmp59-.Lfunc_begin0
	.quad	.Ltmp60-.Lfunc_begin0
	.quad	.Ltmp193-.Lfunc_begin0
	.quad	.Ltmp194-.Lfunc_begin0
	.quad	.Ltmp195-.Lfunc_begin0
	.quad	.Ltmp196-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges12:
	.quad	.Ltmp80-.Lfunc_begin0
	.quad	.Ltmp81-.Lfunc_begin0
	.quad	.Ltmp82-.Lfunc_begin0
	.quad	.Ltmp83-.Lfunc_begin0
	.quad	.Ltmp84-.Lfunc_begin0
	.quad	.Ltmp85-.Lfunc_begin0
	.quad	.Ltmp86-.Lfunc_begin0
	.quad	.Ltmp87-.Lfunc_begin0
	.quad	.Ltmp90-.Lfunc_begin0
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
	.quad	.Ltmp105-.Lfunc_begin0
	.quad	.Ltmp106-.Lfunc_begin0
	.quad	.Ltmp114-.Lfunc_begin0
	.quad	.Ltmp115-.Lfunc_begin0
	.quad	.Ltmp116-.Lfunc_begin0
	.quad	.Ltmp117-.Lfunc_begin0
	.quad	.Ltmp118-.Lfunc_begin0
	.quad	.Ltmp119-.Lfunc_begin0
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp122-.Lfunc_begin0
	.quad	.Ltmp123-.Lfunc_begin0
	.quad	.Ltmp124-.Lfunc_begin0
	.quad	.Ltmp125-.Lfunc_begin0
	.quad	.Ltmp126-.Lfunc_begin0
	.quad	.Ltmp128-.Lfunc_begin0
	.quad	.Ltmp129-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges13:
	.quad	.Ltmp83-.Lfunc_begin0
	.quad	.Ltmp84-.Lfunc_begin0
	.quad	.Ltmp97-.Lfunc_begin0
	.quad	.Ltmp98-.Lfunc_begin0
	.quad	.Ltmp101-.Lfunc_begin0
	.quad	.Ltmp102-.Lfunc_begin0
	.quad	.Ltmp103-.Lfunc_begin0
	.quad	.Ltmp104-.Lfunc_begin0
	.quad	.Ltmp106-.Lfunc_begin0
	.quad	.Ltmp107-.Lfunc_begin0
	.quad	.Ltmp108-.Lfunc_begin0
	.quad	.Ltmp109-.Lfunc_begin0
	.quad	.Ltmp110-.Lfunc_begin0
	.quad	.Ltmp111-.Lfunc_begin0
	.quad	.Ltmp189-.Lfunc_begin0
	.quad	.Ltmp190-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges14:
	.quad	.Ltmp88-.Lfunc_begin0
	.quad	.Ltmp89-.Lfunc_begin0
	.quad	.Ltmp130-.Lfunc_begin0
	.quad	.Ltmp131-.Lfunc_begin0
	.quad	.Ltmp132-.Lfunc_begin0
	.quad	.Ltmp133-.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.quad	.Ltmp140-.Lfunc_begin0
	.quad	.Ltmp141-.Lfunc_begin0
	.quad	.Ltmp142-.Lfunc_begin0
	.quad	.Ltmp143-.Lfunc_begin0
	.quad	.Ltmp144-.Lfunc_begin0
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
	.quad	.Ltmp175-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges15:
	.quad	.Ltmp109-.Lfunc_begin0
	.quad	.Ltmp110-.Lfunc_begin0
	.quad	.Ltmp112-.Lfunc_begin0
	.quad	.Ltmp113-.Lfunc_begin0
	.quad	.Ltmp197-.Lfunc_begin0
	.quad	.Ltmp198-.Lfunc_begin0
	.quad	.Ltmp199-.Lfunc_begin0
	.quad	.Ltmp200-.Lfunc_begin0
	.quad	.Ltmp201-.Lfunc_begin0
	.quad	.Ltmp202-.Lfunc_begin0
	.quad	.Ltmp207-.Lfunc_begin0
	.quad	.Ltmp208-.Lfunc_begin0
	.quad	.Ltmp209-.Lfunc_begin0
	.quad	.Ltmp210-.Lfunc_begin0
	.quad	.Ltmp211-.Lfunc_begin0
	.quad	.Ltmp212-.Lfunc_begin0
	.quad	.Ltmp216-.Lfunc_begin0
	.quad	.Ltmp217-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges16:
	.quad	.Ltmp117-.Lfunc_begin0
	.quad	.Ltmp118-.Lfunc_begin0
	.quad	.Ltmp119-.Lfunc_begin0
	.quad	.Ltmp120-.Lfunc_begin0
	.quad	.Ltmp122-.Lfunc_begin0
	.quad	.Ltmp123-.Lfunc_begin0
	.quad	.Ltmp202-.Lfunc_begin0
	.quad	.Ltmp203-.Lfunc_begin0
	.quad	.Ltmp204-.Lfunc_begin0
	.quad	.Ltmp205-.Lfunc_begin0
	.quad	.Ltmp206-.Lfunc_begin0
	.quad	.Ltmp207-.Lfunc_begin0
	.quad	.Ltmp213-.Lfunc_begin0
	.quad	.Ltmp214-.Lfunc_begin0
	.quad	.Ltmp215-.Lfunc_begin0
	.quad	.Ltmp216-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges17:
	.quad	.Ltmp126-.Lfunc_begin0
	.quad	.Ltmp127-.Lfunc_begin0
	.quad	.Ltmp191-.Lfunc_begin0
	.quad	.Ltmp192-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges18:
	.quad	.Ltmp134-.Lfunc_begin0
	.quad	.Ltmp135-.Lfunc_begin0
	.quad	.Ltmp136-.Lfunc_begin0
	.quad	.Ltmp137-.Lfunc_begin0
	.quad	.Ltmp138-.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.quad	.Ltmp145-.Lfunc_begin0
	.quad	.Ltmp146-.Lfunc_begin0
	.quad	.Ltmp147-.Lfunc_begin0
	.quad	.Ltmp148-.Lfunc_begin0
	.quad	.Ltmp149-.Lfunc_begin0
	.quad	.Ltmp150-.Lfunc_begin0
	.quad	.Ltmp151-.Lfunc_begin0
	.quad	.Ltmp152-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges19:
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
	.quad	0
	.quad	0
.Ldebug_ranges20:
	.quad	.Ltmp186-.Lfunc_begin0
	.quad	.Ltmp187-.Lfunc_begin0
	.quad	.Ltmp188-.Lfunc_begin0
	.quad	.Ltmp189-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges21:
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
	.quad	0
	.quad	0
.Ldebug_ranges22:
	.quad	.Ltmp28-.Lfunc_begin0
	.quad	.Ltmp29-.Lfunc_begin0
	.quad	.Ltmp31-.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	.Ltmp33-.Lfunc_begin0
	.quad	.Ltmp34-.Lfunc_begin0
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp37-.Lfunc_begin0
	.quad	.Ltmp38-.Lfunc_begin0
	.quad	.Ltmp40-.Lfunc_begin0
	.quad	.Ltmp41-.Lfunc_begin0
	.quad	.Ltmp42-.Lfunc_begin0
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	.Ltmp60-.Lfunc_begin0
	.quad	.Ltmp61-.Lfunc_begin0
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
    .private_segment_fixed_size: 36
    .sgpr_count:     76
    .sgpr_spill_count: 0
    .symbol:         mxgemm_tdm_pipelined_kernel.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     905
    .vgpr_spill_count: 16
    .wavefront_size: 32
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx1250
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
	.section	.debug_line,"",@progbits
.Lline_table_start0:
