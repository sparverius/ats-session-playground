staload "draft.sats"
staload UN = "prelude/SATS/unsafe.sats"
#define :: seqs 



implement is_equal {p,q} (x, y) = 
	case+ (x, y) of 
	| (rtcls (), rtcls ()) => true 
	| (rtskip (), rtskip ()) => true 
	| (rtmsg (x1, y1), rtmsg (x2, y2)) => x1 = x2 andalso y1 = y2
	| (rtchse (x1, n1), rtchse (x2, n2)) => x1 = x2 andalso n1 = n2 
	| (rtseqs (x1, y1), rtseqs (x2, y2)) => is_equal (x1, x2) andalso is_equal (y1, y2)
	| (_, _) =>> false


implement request {x} {gp,p} (pf | name, self, gp) = let 
	val (_ | proj) = project (self, gp)
	extern fun _request {p:protocol} (pf: PROJ (x, gp, p) | name: name gp): @{session=pfsession p, rt=rtsession p} = "mac#"
	val @{session=session, rt=rt} = _request (pf | name)

	val _ = assertloc (is_equal (rt, proj))
	val _ = $UN.cast2void proj
in 
	@{session=session, rt=rt, self=self}
end 



implement project {x} {gp} (self, gp) = 
	case+ gp of 
	| ~rtcls ()         => (proj_cls () | rtcls ())
	| ~rtskip ()        => (proj_skip () | rtskip ())
	| ~rtmsg (from, to) =>
		if from = self
			then (proj_msg_from () | rtmsg (from, to))
		else if to = self 
			then (proj_msg_to () | rtmsg (from, to))
		else if to = ~1 
			then (proj_msg_broadcast () | rtmsg (from, self))
		else 
			(proj_msg_skip () | rtskip ())

	| ~rtchse (from, choice) => (proj_chse () | rtchse (from, choice))
	| ~rtseqs (p, q) => 
		let 
			val (pfpp | pp) = project (self, p)
			val (pfqq | qq) = project (self, q)
		in case+ (pp, qq) of
			| (~rtskip (), qq) => (proj_seqs_skipp (pfpp, pfqq) | qq)
			| (pp, ~rtskip ()) =>> (proj_seqs_skipq (pfpp, pfqq) | pp)
			| (pp, qq) =>> (proj_seqs (pfpp, pfqq) | rtseqs (pp, qq))
		end 

extern fun test (): void 
implement test () = () where {

	val rt = 
		rtseqs (
			rtmsg (0, 1), 
			rtseqs (
				rtmsg (1, 2), 
				rtseqs (
					rtmsg (2, 0), 
					rtcls ())))

	val name = make_name {msg(0,1,int) :: msg (1,2,int) :: msg (2,0,int) :: cls()} ("dummy")
	prval pf = 
		let 
			#define ++ proj_seqs
			#define +- proj_seqs_skipq 
			#define -+ proj_seqs_skipp
			infixr ++
			infixr +-
			infixr -+
		in 
			proj_msg_from() ++ proj_msg_skip() -+ proj_msg_to() ++ proj_cls()
		end 

	val session = request (pf | name, 0, rt)
	val _ = send (session, 1)
	val x = receive (session)
	val _ = close (session)	

//	val _ = $UN.cast2void session
//	val _ = $showtype rt
//	extern castfn rt2pf {p:protocol} (!rtsession p): pfsession p
//	val pf = rt2pf {msg(0,1,int)::msg(1,2,int)::msg(2,0,int)::cls()} rt 

//	val gs = '{s=pf, r=rt, arity=3}
//	val (pf | s) = project (0, gs): (PROJ (0, msg (0, 1, int) :: msg (1, 2, int) :: msg (2, 0, int) :: cls (), msg (0, 1, int) :: msg (2, 0, int) :: cls ()) | session (0, msg (0, 1, int) :: msg (2, 0, int) :: cls (), 3))

//	val _ = $showtype s.s

//	val _ = send (0, s.s)
}

implement main0 () = test ()

////
implement project {x} {gp} {arity} (self, gs) = let 

	fun rtproject {gp:protocol} (self: int x, rt: rtsession gp): [p:protocol] (PROJ (x, gp, p) | rtsession p) = let 
		extern praxi proj_cls           {x:nat} ()                              : PROJ (x, cls (), cls ())
		extern praxi proj_msg_from      {x:nat} {y:int} {a:vt@ype} ()           : PROJ (x, msg (x, y, a), msg (x, y, a))
		extern praxi proj_msg_to        {x:nat} {y:int} {a:vt@ype} ()           : PROJ (x, msg (y, x, a), msg (y, x, a))
		extern praxi proj_msg_broadcast {x:nat} {y:int|y != x} {a:vt@ype} ()    : PROJ (x, msg (y, ~1, a), msg (y, x, a))
		extern praxi proj_chse			{x:nat} {y:nat} {c:int} () 			    : PROJ (x, chse (y, c), chse (y, c))

		extern praxi proj_msg_skip      {x:nat} {y,z:nat|x != y && x != z} {a:vt@ype} () : PROJ (x, msg (y, z, a), skip ())
		extern praxi proj_skip 			{x:nat} () 							             : PROJ (x, skip (), skip ())

		extern praxi proj_seqs		 {x:nat} {p,pp,q,qq:protocol} (PROJ (x, p, pp), PROJ (x, q, qq)): PROJ (x, p::q, pp::qq)
		extern praxi proj_seqs_skipp {x:nat} {p,pp,q,qq:protocol} (PROJ (x, p, pp), PROJ (x, q, qq)): PROJ (x, p::q, qq)
		extern praxi proj_seqs_skipq {x:nat} {p,pp,q,qq:protocol} (PROJ (x, p, pp), PROJ (x, q, qq)): PROJ (x, p::q, pp)
//		extern praxi proj {gp,p:protocol} (): PROJ (x, gp, p)
	in  
		case+ rt of 
		| rtcls () => (proj_cls () | rtcls ())
		| rtskip () => (proj_skip () | rtskip ())
		| rtmsg (from, to) => 
			if from = self
				then (proj_msg_from () | rtmsg (from, to))
			else if to = self 
				then (proj_msg_to () | rtmsg (from, to))
			else if to = ~1 
				then (proj_msg_broadcast () | rtmsg (from, self))
			else 
				(proj_msg_skip () | rtskip ())

		| rtchse (from, choice) => (proj_chse () | rtchse (from, choice))
		| rtseqs (p, q) => 
			let 
				val (pfpp | pp) = rtproject (self, p)
				val (pfqq | qq) = rtproject (self, q)
			in case+ (pp, qq) of
				| (rtskip (), qq) => (proj_seqs_skipp (pfpp, pfqq) | qq)
				| (pp, rtskip ()) =>> (proj_seqs_skipq (pfpp, pfqq) | pp)
				| (pp, qq) =>> (proj_seqs (pfpp, pfqq) | rtseqs (pp, qq))
			end 
	end

//	extern castfn pfcreate {gp,p:protocol} (int x, rtsession gp, rtsession p): (PROJ (x, gp, p) | void)
	extern castfn pfproject {gp,p:protocol} (PROJ (x, gp, p) | pfsession gp): pfsession p

	val (pf | rtproj) = rtproject (self, gs.r)
	val pfproj = pfproject (pf | gs.s)
in 
	(pf | '{s=pfproj, r=rtproj, self=self, arity=gs.arity})
end





extern fun test (): void 
implement test () = () where {

	val rt = rtseqs (rtmsg (0, 1), rtseqs (rtmsg (1, 2), rtseqs (rtmsg (2, 0), rtcls ())))
//	val _ = $showtype rt
	extern castfn rt2pf {p:protocol} (rtsession p): pfsession p
	val pf = rt2pf {msg (0, 1, int) :: msg (1, 2, int) :: msg (2, 0, int) :: cls ()} rt 

	val gs = '{s=pf, r=rt, arity=3}
	val (pf | s) = project (0, gs): (PROJ (0, msg (0, 1, int) :: msg (1, 2, int) :: msg (2, 0, int) :: cls (), msg (0, 1, int) :: msg (2, 0, int) :: cls ()) | session (0, msg (0, 1, int) :: msg (2, 0, int) :: cls (), 3))

//	val _ = $showtype s.s

	val _ = send (0, s.s)
}

implement main0 () = test ()

////
implement project {x} {s} (global, ep) = 
	case- global.r of 
	| rtcls {pf} () => (x, pf, rtcls {pf} ())


	////
	| {x,y} {a} rtmsg (x, y) => if x = ep orelse epy = ep then rtmsg (epx, epy) else rtskip ()
	| rtseqs (a, b) => let 
		fun decompose {a,b:type} (prsession (a :: b)): '{prsession a, prsession b} = let 
			

		val '{fst, snd} = decompose
		proja = project (a, ep)