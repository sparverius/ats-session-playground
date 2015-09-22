/*
**
** The C code is generated by ATS/Postiats
** The starting compilation time is: 2015-3-31: 17h:23m
**
*/

/*
** include runtime header files
*/
#ifndef _ATS_CCOMP_HEADER_NONE
#include "pats_ccomp_config.h"
#include "pats_ccomp_basics.h"
#include "pats_ccomp_typedefs.h"
#include "pats_ccomp_instrset.h"
#include "pats_ccomp_memalloc.h"
#ifndef _ATS_CCOMP_EXCEPTION_NONE
#include "pats_ccomp_memalloca.h"
#include "pats_ccomp_exception.h"
#endif // end of [_ATS_CCOMP_EXCEPTION_NONE]
#endif /* _ATS_CCOMP_HEADER_NONE */


/*
** include prelude cats files
*/
#ifndef _ATS_CCOMP_PRELUDE_NONE
//
#include "prelude/CATS/basics.cats"
#include "prelude/CATS/integer.cats"
#include "prelude/CATS/pointer.cats"
#include "prelude/CATS/bool.cats"
#include "prelude/CATS/char.cats"
#include "prelude/CATS/integer_ptr.cats"
#include "prelude/CATS/integer_fixed.cats"
#include "prelude/CATS/float.cats"
#include "prelude/CATS/memory.cats"
#include "prelude/CATS/string.cats"
#include "prelude/CATS/strptr.cats"
//
#include "prelude/CATS/filebas.cats"
//
#include "prelude/CATS/list.cats"
#include "prelude/CATS/option.cats"
#include "prelude/CATS/array.cats"
#include "prelude/CATS/arrayptr.cats"
#include "prelude/CATS/arrayref.cats"
#include "prelude/CATS/matrix.cats"
#include "prelude/CATS/matrixptr.cats"
//
#endif /* _ATS_CCOMP_PRELUDE_NONE */
/*
** for user-supplied prelude
*/
#ifdef _ATS_CCOMP_PRELUDE_USER
//
#include _ATS_CCOMP_PRELUDE_USER
//
#endif /* _ATS_CCOMP_PRELUDE_USER */

/*
staload-prologues(beg)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/pointer.dats: 1533(line=44, offs=1) -- 1572(line=44, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/integer.dats: 1636(line=51, offs=1) -- 1675(line=51, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/integer_fixed.dats: 1641(line=51, offs=1) -- 1680(line=51, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/memory.dats: 1410(line=38, offs=1) -- 1449(line=39, offs=32)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/string.dats: 1609(line=48, offs=1) -- 1648(line=48, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/strptr.dats: 1609(line=48, offs=1) -- 1648(line=48, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/strptr.dats: 1671(line=52, offs=1) -- 1718(line=52, offs=48)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/integer.dats: 1636(line=51, offs=1) -- 1675(line=51, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/filebas.dats: 1613(line=48, offs=1) -- 1652(line=48, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/filebas.dats: 1675(line=52, offs=1) -- 1722(line=52, offs=48)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/integer.dats: 1636(line=51, offs=1) -- 1675(line=51, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/filebas.dats: 1745(line=56, offs=1) -- 1783(line=56, offs=39)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/libc/SATS/stdio.sats: 1380(line=35, offs=1) -- 1418(line=37, offs=3)
*/

#include "libc/CATS/stdio.cats"
/*
/usr/local/lib/ats2-postiats-0.1.4/libc/SATS/stdio.sats: 1791(line=56, offs=1) -- 1833(line=58, offs=27)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/libc/sys/SATS/types.sats: 1390(line=36, offs=1) -- 1432(line=38, offs=3)
*/

#include "libc/sys/CATS/types.cats"
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/filebas.dats: 1861(line=61, offs=1) -- 1901(line=61, offs=41)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/libc/sys/SATS/stat.sats: 1390(line=36, offs=1) -- 1431(line=38, offs=3)
*/

#include "libc/sys/CATS/stat.cats"
/*
/usr/local/lib/ats2-postiats-0.1.4/libc/sys/SATS/stat.sats: 1776(line=53, offs=1) -- 1818(line=54, offs=35)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/libc/sys/SATS/types.sats: 1390(line=36, offs=1) -- 1432(line=38, offs=3)
*/

#include "libc/sys/CATS/types.cats"
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/filebas.dats: 15159(line=816, offs=1) -- 15189(line=816, offs=31)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/libc/SATS/stdio.sats: 1380(line=35, offs=1) -- 1418(line=37, offs=3)
*/

#include "libc/CATS/stdio.cats"
/*
/usr/local/lib/ats2-postiats-0.1.4/libc/SATS/stdio.sats: 1791(line=56, offs=1) -- 1833(line=58, offs=27)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/libc/sys/SATS/types.sats: 1390(line=36, offs=1) -- 1432(line=38, offs=3)
*/

#include "libc/sys/CATS/types.cats"
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/list.dats: 1527(line=44, offs=1) -- 1566(line=44, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/list.dats: 1567(line=45, offs=1) -- 1613(line=45, offs=47)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/unsafe.dats: 1532(line=44, offs=1) -- 1566(line=44, offs=35)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/list_vt.dats: 1536(line=44, offs=1) -- 1575(line=44, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/list_vt_mergesort.dats: 1546(line=44, offs=1) -- 1585(line=44, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/list_vt_quicksort.dats: 1546(line=44, offs=1) -- 1585(line=44, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/array.dats: 1534(line=44, offs=1) -- 1573(line=44, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/array.dats: 1574(line=45, offs=1) -- 1616(line=45, offs=43)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/array_bsearch.dats: 1531(line=44, offs=1) -- 1570(line=44, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/array_quicksort.dats: 1531(line=44, offs=1) -- 1570(line=44, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/arrayptr.dats: 1532(line=44, offs=1) -- 1571(line=44, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/arrayref.dats: 1532(line=44, offs=1) -- 1571(line=44, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/matrix.dats: 1535(line=44, offs=1) -- 1574(line=44, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/matrixptr.dats: 1538(line=44, offs=1) -- 1577(line=44, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/matrixref.dats: 1538(line=44, offs=1) -- 1577(line=44, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/stream.dats: 1570(line=48, offs=1) -- 1609(line=48, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/stream_vt.dats: 1573(line=48, offs=1) -- 1612(line=48, offs=40)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/unsafe.dats: 1532(line=44, offs=1) -- 1566(line=44, offs=35)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/prelude/DATS/checkast.dats: 1531(line=44, offs=1) -- 1570(line=45, offs=32)
*/
/*
/home/hwwu/GitHub/ats-session-playground/session.dats: 39(line=3, offs=1) -- 61(line=3, offs=23)
*/
/*
/home/hwwu/GitHub/ats-session-playground/session.dats: 62(line=4, offs=1) -- 80(line=4, offs=19)
*/
/*
/home/hwwu/GitHub/ats-session-playground/zmq.sats: 3(line=3, offs=1) -- 61(line=8, offs=3)
*/

#ifndef __ZMQ
#define __ZMQ
#include <zmq.h>
#endif
/*
/home/hwwu/GitHub/ats-session-playground/session.dats: 81(line=5, offs=1) -- 120(line=5, offs=40)
*/
/*
/home/hwwu/GitHub/ats-session-playground/session.dats: 121(line=6, offs=1) -- 152(line=6, offs=32)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/libc/SATS/string.sats: 1380(line=35, offs=1) -- 1419(line=37, offs=3)
*/

#include "libc/CATS/string.cats"
/*
/home/hwwu/GitHub/ats-session-playground/session.dats: 153(line=7, offs=1) -- 188(line=7, offs=36)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/libc/DATS/string.dats: 1566(line=41, offs=1) -- 1597(line=41, offs=32)
*/
/*
/usr/local/lib/ats2-postiats-0.1.4/libc/SATS/string.sats: 1380(line=35, offs=1) -- 1419(line=37, offs=3)
*/

#include "libc/CATS/string.cats"
/*
staload-prologues(end)
*/
/*
typedefs-for-tyrecs-and-tysums(beg)
*/
/*
typedefs-for-tyrecs-and-tysums(end)
*/
/*
dynconlst-declaration(beg)
*/
/*
dynconlst-declaration(end)
*/
/*
dyncstlst-declaration(beg)
*/
ATSdyncst_extfun(_057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_session_056_sats__send, (atsrefarg0_type(atstkind_type(atstype_ptrk)), atstkind_type(atstype_ptrk)), atsvoid_t0ype) ;
ATSdyncst_extfun(_057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_session_056_sats__receive, (atsrefarg0_type(atstkind_type(atstype_ptrk))), atstkind_type(atstype_ptrk)) ;
ATSdyncst_mac(atspre_print_string)
ATSdyncst_mac(atspre_print_newline)
ATSdyncst_extfun(_057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_session_056_sats__close, (atstkind_type(atstype_ptrk)), atsvoid_t0ype) ;
ATSdyncst_extfun(_057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_session_056_sats__create_client, (atstype_funptr, atstkind_type(atstype_ptrk)), atsvoid_t0ype) ;
/*
dyncstlst-declaration(end)
*/
/*
dynvalist-implementation(beg)
*/
/*
dynvalist-implementation(end)
*/
/*
exnconlst-declaration(beg)
*/
#ifndef _ATS_CCOMP_EXCEPTION_NONE
ATSextern()
atsvoid_t0ype
the_atsexncon_initize
(
  atstype_exnconptr d2c, atstype_string exnmsg
) ;
#endif // end of [_ATS_CCOMP_EXCEPTION_NONE]
/*
exnconlst-declaration(end)
*/
/*
assumelst-declaration(beg)
*/
/*
assumelst-declaration(end)
*/
/*
extypelst-declaration(beg)
*/
/*
extypelst-declaration(end)
*/
#if(0)
ATSextern()
atsvoid_t0ype
mainats_void_0() ;
#endif // end of [QUALIFIED]

ATSstatic()
atsvoid_t0ype
fserv_1(atstkind_type(atstype_ptrk)) ;

ATSstatic()
atsvoid_t0ype
__patsfun_2(atstkind_type(atstype_ptrk)) ;

/*
/home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 132(line=10, offs=17) -- 419(line=20, offs=2)
*/
/*
local: 
global: mainats_void_0$0$0(level=0)
local: 
global: 
*/
ATSextern()
atsvoid_t0ype
mainats_void_0()
{
/* tmpvardeclst(beg) */
// ATStmpdec_void(tmpret0) ;
// ATStmpdec_void(tmp6) ;
/* tmpvardeclst(end) */
ATSfunbody_beg()
/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 126(line=10, offs=11) -- 419(line=20, offs=2)
*/
ATSINSflab(__patsflab_main_void_0):
/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 137(line=10, offs=22) -- 419(line=20, offs=2)
*/
/*
letpush(beg)
*/
/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 361(line=19, offs=10) -- 417(line=19, offs=66)
*/
ATSINSmove_void(tmp6, _057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_session_056_sats__create_client(ATSPMVfunlab(__patsfun_2), ATSPMVstring("tcp://localhost:5555"))) ;

/*
letpush(end)
*/

/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 137(line=10, offs=22) -- 139(line=10, offs=24)
*/
ATSINSmove_void(tmpret0, ATSPMVempty()) ;
/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 137(line=10, offs=22) -- 419(line=20, offs=2)
*/
/*
INSletpop()
*/
ATSfunbody_end()
ATSreturn_void(tmpret0) ;
} /* end of [mainats_void_0] */

/*
/home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 153(line=11, offs=6) -- 350(line=17, offs=3)
*/
/*
local: 
global: fserv_1$0(level=1)
local: 
global: 
*/
ATSstatic()
atsvoid_t0ype
fserv_1(atstkind_type(atstype_ptrk) arg0)
{
/* tmpvardeclst(beg) */
// ATStmpdec_void(tmpret1) ;
// ATStmpdec_void(tmp2) ;
ATStmpdec(tmp3, atstkind_type(atstype_ptrk)) ;
// ATStmpdec_void(tmp4) ;
// ATStmpdec_void(tmp5) ;
/* tmpvardeclst(end) */
ATSfunbody_beg()
/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 153(line=11, offs=6) -- 350(line=17, offs=3)
*/
ATSINSflab(__patsflab_fserv_1):
/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 220(line=11, offs=73) -- 350(line=17, offs=3)
*/
/*
letpush(beg)
*/
/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 242(line=12, offs=12) -- 265(line=12, offs=35)
*/
ATSINSmove_void(tmp2, _057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_session_056_sats__send(ATSPMVrefarg0(arg0), ATSPMVstring("hello"))) ;

/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 278(line=13, offs=13) -- 294(line=13, offs=29)
*/
ATSINSmove(tmp3, _057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_session_056_sats__receive(ATSPMVrefarg0(arg0))) ;

/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 307(line=14, offs=12) -- 319(line=14, offs=24)
*/
ATSINSmove_void(tmp4, atspre_print_string(tmp3)) ;

/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 307(line=14, offs=12) -- 319(line=14, offs=24)
*/
ATSINSmove_void(tmp5, atspre_print_newline()) ;

/*
letpush(end)
*/

/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 332(line=16, offs=12) -- 346(line=16, offs=26)
*/
ATSINSmove_void(tmpret1, _057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_session_056_sats__close(arg0)) ;

/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 220(line=11, offs=73) -- 350(line=17, offs=3)
*/
/*
INSletpop()
*/
ATSfunbody_end()
ATSreturn_void(tmpret1) ;
} /* end of [fserv_1] */

/*
/home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 376(line=19, offs=25) -- 392(line=19, offs=41)
*/
/*
local: fserv_1$0(level=1)
global: fserv_1$0(level=1), __patsfun_2$0(level=1)
local: 
global: 
*/
ATSstatic()
atsvoid_t0ype
__patsfun_2(atstkind_type(atstype_ptrk) arg0)
{
/* tmpvardeclst(beg) */
// ATStmpdec_void(tmpret7) ;
/* tmpvardeclst(end) */
ATSfunbody_beg()
/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 376(line=19, offs=25) -- 392(line=19, offs=41)
*/
ATSINSflab(__patsflab___patsfun_2):
/*
emit_instr: loc0 = /home/hwwu/GitHub/ats-session-playground/sessionclient.dats: 385(line=19, offs=34) -- 392(line=19, offs=41)
*/
ATSINSmove_void(tmpret7, fserv_1(arg0)) ;

ATSfunbody_end()
ATSreturn_void(tmpret7) ;
} /* end of [__patsfun_2] */

ATSdynloadflag_init(_057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_session_056_dats__dynloadflag) ;
extern atsvoid_t0ype
_057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_session_056_dats__dynload(/*void*/) ;
/*
** for initialization(dynloading)
*/
ATSdynloadflag_init(_057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_sessionclient_056_dats__dynloadflag) ;
ATSextern()
atsvoid_t0ype
_057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_sessionclient_056_dats__dynload()
{
ATSfunbody_beg()
ATSdynload(/*void*/)
ATSdynloadflag_sta(
_057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_sessionclient_056_dats__dynloadflag
) ;
ATSif(
ATSCKiseqz(
_057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_sessionclient_056_dats__dynloadflag
)
) ATSthen() {
ATSdynloadset(_057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_sessionclient_056_dats__dynloadflag) ;
/*
dynexnlst-initize(beg)
*/
/*
dynexnlst-initize(end)
*/
ATSdynloadfcall(_057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_session_056_dats__dynload) ;
} /* ATSendif */
ATSfunbody_end()
ATSreturn_void(tmpret_void) ;
} /* end of [*_dynload] */

/*
** the ATS runtime
*/
#ifndef _ATS_CCOMP_RUNTIME_NONE
#include "pats_ccomp_runtime.c"
#include "pats_ccomp_runtime_memalloc.c"
#ifndef _ATS_CCOMP_EXCEPTION_NONE
#include "pats_ccomp_runtime2_dats.c"
#ifndef _ATS_CCOMP_RUNTIME_TRYWITH_NONE
#include "pats_ccomp_runtime_trywith.c"
#endif /* _ATS_CCOMP_RUNTIME_TRYWITH_NONE */
#endif // end of [_ATS_CCOMP_EXCEPTION_NONE]
#endif /* _ATS_CCOMP_RUNTIME_NONE */

/*
** the [main] implementation
*/
int
main
(
int argc, char **argv, char **envp
) {
int err = 0 ;
_057_home_057_hwwu_057_GitHub_057_ats_055_session_055_playground_057_sessionclient_056_dats__dynload() ;
ATSmainats_void_0(err) ;
return (err) ;
} /* end of [main] */

/* ****** ****** */

/* end-of-compilation-unit */