#include "contrib/libatscc/libatscc2erl/staloadall.hats"
staload "session.sats"
staload "intset.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define ATS_DYNLOADFLAG 0

%{^
%%
-module(test).
%%
-compile(nowarn_unused_vars).
-compile(nowarn_unused_function).
-compile(export_all).
-compile(debug_info).
%%
%%-include("$PATSHOMERELOC/contrib/libatscc/libatscc2erl/libatscc2erl_all.hrl").
-include("./session.erl").
%%
%} // end of [%{]


//#define ++ proj_seqs 
//#define -+ proj_seqs_skipp 
//infixr (::) ++ 
//infixr (::) -+



(*************************)
local 
(*************************)

prval _ = $solver_assert (set_range_base)
prval _ = $solver_assert (set_range_ind)
prval _ = $solver_assert (set_range_lemma1)
prval _ = $solver_assert (set_range_lemma2)

#define ** rtseqs
infixr (::) **


#define SELLER 0
#define BUYER1 1
#define BUYER2 2
#define BUYER3 3

#define :: seqs
#define PROTO (msg(BUYER1,SELLER,string)::msg(SELLER,BUYER1,int)::msg(SELLER,BUYER2,int)::msg(BUYER1,BUYER2,int)::chse(BUYER2,msg(BUYER2,SELLER,string)::msg(SELLER,BUYER2,string)::cls(),cls()))
#define RT (rtmsg(BUYER1,SELLER)**rtmsg(SELLER,BUYER1)**rtmsg(SELLER,BUYER2)**rtmsg(BUYER1,BUYER2)**rtchse(BUYER2, rtmsg(BUYER2,SELLER)**rtmsg(SELLER,BUYER2)**rtcls(), rtcls()))

#define PROTO2 (msg(BUYER2,BUYER3,int)::chse(BUYER3, msg(BUYER2,BUYER3,session(range(BUYER2,BUYER2),range(0,2),msg(BUYER2,SELLER,string)::msg(SELLER,BUYER2,string)::cls()))::cls(), cls()))
#define RT2 (rtmsg(BUYER2,BUYER3)**rtchse(BUYER3, rtmsg(BUYER2,BUYER3)**rtcls(), rtcls()))

extern fun inspect {a:t@ype} (a): string = "mac#libsession_inspect"
extern fun debug (string): void = "mac#libsession_debug"
extern fun info (string): void = "mac#libsession_info"


(*************************)
in 
(*************************)


extern fun a (int): void = "mac#"
implement a (price) =  
	init (name, set_add(empty_set(), SELLER), 
		llam opt => 
			case+ opt of 
			| ~Nothing () => info "nothing"	
			| ~Just (session) => let 
				val title = receive (session, BUYER1)
				val _ = info title 
				val _ = send (session, BUYER1, price)
				val _ = send (session, BUYER2, price)
				val _ = skip_msg session 
				val choice = offer (session, BUYER2)
			in case+ choice of 
				| ~ChooseFst () => let 
						val address = receive (session, BUYER2)
						val _ = info address 
						val _ = send (session, BUYER2, "tomorrow")
					in close session end 
				| ~ChooseSnd () => close session 
			end 
	) where {
		val name = make_name {range(0,2)} {PROTO} (set_range(0,2), RT, "test")
	}


extern fun b (int): void = "mac#"
implement b (contrib) = 
	init (name, set_add(empty_set(), BUYER1), 
		llam opt => 
			case+ opt of 
			| ~Nothing () => info "nothing1"	
			| ~Just (session) => let 
				val _ = send (session, SELLER, "book title")
				val price = receive (session, SELLER)
				val _ = info (inspect price)
				val _ = skip_msg (session)
				val _ = send (session, BUYER2, contrib)
				val choice = offer (session, BUYER2)
			in case+ choice of 
			 	| ~ChooseFst () => let 
			 			val _ = skip_msg session 
			 			val _ = skip_msg session 
			 		in close session end 
			 	| ~ChooseSnd () => close session 
			end 
	) where {
		val name = make_name {range(0,2)} {PROTO} (set_range(0,2), RT, "test")
	}


extern fun c (int): void = "mac#"
implement c (budget) = 
	init (name, set_add(empty_set(), BUYER2), 
		llam opt => 
			case+ opt of 
			| ~Nothing () => info "nothing2"	
			| ~Just (session) => let 
				val _ = skip_msg session 
				val _ = skip_msg session 
				val price = receive (session, SELLER)
				val _ = info (inspect price)
				val contrib = receive (session, BUYER1)
			in 
				if price - contrib > budget
				then let val _ = choose_snd (session) in close session end 
				else let 
					val _ = choose_fst (session)
					val _ = send (session, SELLER, "my address")
					val date = receive (session, SELLER)
					val _ = info date
				in close session end 
			end 
	) where {
		val name = make_name {range(0,2)} {PROTO} (set_range(0,2), RT, "test")
	}

extern fun c2 (int): void = "mac#"
implement c2 (budget) = 
	init (name, set_add(empty_set(), BUYER2), 
		llam opt => 
			case+ opt of 
			| ~Nothing () => info "nothing2"	
			| ~Just (session) => let 
				val _ = skip_msg session 
				val _ = skip_msg session 
				val price = receive (session, SELLER)
				val _ = info (inspect price)
				val contrib = receive (session, BUYER1)
			in 
				if price - contrib > budget
				then let 
						val name = make_name {range(2,3)} {PROTO2} (set_range(2,3), RT2, "test")
					in 
						init (name, set_range(BUYER2,BUYER2), 
							llam opt => 
								case+ opt of 
								| ~Nothing () => let val _ = choose_snd session in close session end 
								| ~Just (buyer3) => let 
									val _ = send (buyer3, BUYER3, price - contrib)
									val choice = offer (buyer3, BUYER3)
								in 
									case+ choice of 
									| ~ChooseSnd () => let val _ = choose_snd session in (close session; close buyer3) end 
									| ~ChooseFst () => let val _ = choose_fst session in (send (buyer3, BUYER3, session); close buyer3) end 
								end 
						)
					end
				else let 
					val _ = choose_fst (session)
					val _ = send (session, SELLER, "my address")
					val date = receive (session, SELLER)
					val _ = info date
				in close session end 
			end 
	) where {
		val name = make_name {range(0,2)} {PROTO} (set_range(0,2), RT, "test")
	}

extern fun c3 (): void = "mac#"
implement c3 () = 
	init (name, set_add(empty_set(), BUYER3), 
		llam opt => 
			case+ opt of 
			| ~Nothing() => info "nothing"
			| ~Just (session) => let 
					val price = receive (session, BUYER2): int 
					val _ = choose_fst session
					val buyer2 = receive (session, BUYER2)
					val _ = send (buyer2, SELLER, "my other address")
					val date = receive (buyer2, SELLER)
					val _ = info date
					val _ = close buyer2
				in 
					close session
				end
	) where {
		val name = make_name {range(2,3)} {PROTO2} (set_range(2,3), RT2, "test")
	}

extern fun d (): void = "mac#"
implement d () = let 
	val opt = create (set_range(1,2), set_range(0,0), rtinit(set_range(0,2)) ** RT, 
		llam opt => 
			case+ opt of 
			| ~Nothing () => info "nothing"	
			| ~Just (session) => let 
				val title = receive (session, BUYER1)
				val _ = info title 
				val _ = send (session, BUYER1, 50)
				val _ = send (session, BUYER2, 50)
				val _ = skip_msg session 
				val choice = offer (session, BUYER2)
			in case+ choice of 
				| ~ChooseFst () => let 
						val address = receive (session, BUYER2)
						val _ = info address 
						val _ = send (session, BUYER2, "tomorrow")
					in close session end 
				| ~ChooseSnd () => close session 
			end 
	)
in 
	case+ opt of 
	| ~Nothing () => info "nothing"
	| ~Just (session) => let 
		val _ = send (session, SELLER, "book title")
		val price = receive (session, SELLER)
		val _ = info (inspect ($UN.castvwtp0{int} price))
		val price = receive (session, SELLER)
		val _ = info (inspect ($UN.castvwtp0{int} price))
		val _ = skip_msg session
		val _ = choose_fst session 
		val _ = send (session, SELLER, "my address")
		val date = receive (session, SELLER)
		val _ = info date
	in 
		close session 
	end 
end 

extern fun e (): void = "mac#"
//implement e () = let 
//	val opt0 = create (set_range(1,2), set_range(0,0), rtinit(set_range(0,2)) ** RT, 
//		llam opt => 
//			case+ opt of 
//			| ~Nothing () => info "nothing"	
//			| ~Just (session) => let 
//				val title = receive (session, BUYER1)
//				val _ = info title 
//				val _ = send (session, BUYER1, 50)
//				val _ = send (session, BUYER2, 50)
//				val _ = skip_msg session 
//				val choice = offer (session, BUYER2)
//			in case+ choice of 
//				| ~ChooseFst () => let 
//						val address = receive (session, BUYER2)
//						val _ = info address 
//						val _ = send (session, BUYER2, "tomorrow")
//					in close session end 
//				| ~ChooseSnd () => close session 
//			end 
//	)

//	val opt1 = create (set_add(set_add(empty_set(), 0), 2), set_range(1,1), rtinit(set_range(0,2)) ** RT, 
//		llam opt => 
//			case+ opt of 
//			| ~Nothing () => info "nothing1"	
//			| ~Just (session) => let 
//				val _ = send (session, SELLER, "book title")
//				val price = receive (session, SELLER)
//				val price = $UN.castvwtp0{int} price
//				val _ = info (inspect price)
//				val _ = skip_msg (session)
//				val _ = send (session, BUYER2, price)
//				val choice = offer (session, BUYER2)
//			in case+ choice of 
//			 	| ~ChooseFst () => let 
//			 			val _ = skip_msg session 
//			 			val _ = skip_msg session 
//			 		in close session end 
//			 	| ~ChooseSnd () => close session 
//			end 
//	)

//in 
//	case+ (opt0, opt1) of 
//	| (~Nothing(), ~Nothing()) => info "nothing after link"
//	| (~Just(a), ~Just(b)) => let 
//			val session = link (a, b)
//			val _ = skip_msg session 
//			val _ = skip_msg session 
//			val price = receive (session, SELLER)
//			val price = $UN.castvwtp0{int} price
//			val _ = info (inspect price)
//			val contrib = receive (session, BUYER1) :int
//		in 
//			if contrib < 20 
//			then let val _ = choose_snd (session) in close session end 
//			else let 
//				val _ = choose_fst (session)
//				val _ = send (session, SELLER, "my address")
//				val date = receive (session, SELLER)
//				val _ = info date
//			in close session end 
//		end 
//	| (~Just (a), ~Nothing()) =>> let prval _ = $UN.cast2void a in end
//	| (~Nothing (), ~Just(b)) =>> let prval _ = $UN.cast2void b in end
//end


(*************************)
end 
(*************************)
////
extern fun a (): void = "mac#"
implement a () = let 

	val name = make_name {msg(0,1,int) :: msg(1,2,int) :: msg(2,0,int) :: msg(0,~1,bool) :: chse (2,cls(),msg(2,~1,string)::cls())} ("test")
	fun loop (s: option (session (0, msg(0,1,int)::msg(2,0,int)::msg(0,~1,bool)::chse(2,cls(),msg(2,0,string)::cls())))): void = 
		case+ s of 
		| ~None () => ()
		| ~Some (session) => let 
			val _ = send (session, 1, 10)
			val x = receive (session, 2)
			val _ = broadcast (session, if x = 10 then true else false)
			val choice = offer (session, 2)
			//if ...
			//then broadcast 
			//else broadcast
		in 
			case+ choice of 
			| ChooseFst () => close session 
			| ChooseSnd () => let 
				val msg = receive (session, 2)
				val _ = println! msg 
			in 
				close session 
			end
		end

	val gp = rtmsg(0,1) ** rtmsg(1,2) ** rtmsg(2,0) ** rtmsg(0,~1) ** rtchse (2, rtcls(), rtmsg(2,~1) ** rtcls())

	prval pf = proj_msg_from() ++ proj_msg_skip() -+ proj_msg_to() ++ proj_msg_broadcast_from() ++ proj_chse(proj_cls(), proj_msg_broadcast_to() ++ proj_cls())
in 
	accept (pf | name, 0, gp, llam session => loop session)
end 
//
extern fun b (): void = "mac#"
implement b () = let 

	val name = make_name {msg(0,1,int) :: msg(1,2,int) :: msg(2,0,int) :: msg(0,~1,bool) :: chse(2,cls(),msg(2,~1,string)::cls())} ("test")
	fun loop (s: option (session (1, msg(0,1,int)::msg(1,2,int)::msg(0,1,bool)::chse(2,cls(),msg(2,1,string)::cls())))): void = 
		case+ s of 
		| ~None () => ()
		| ~Some (session) => let 
			val x = receive (session, 0)
			val _ = send (session, 2, x)
			val ret = receive (session, 0)
			val _ = println! ret
			val choice = offer (session, 2)
		in 
			case+ choice of 
			| ChooseFst () => close session
			| ChooseSnd () => let 
				val msg = receive (session, 2)
				val _ = println! msg 
			in 
				close session 
			end
		end

	val gp = rtmsg(0,1) ** rtmsg(1,2) ** rtmsg(2,0) ** rtmsg(0,~1) ** rtchse (2, rtcls(), rtmsg(2,~1) ** rtcls())
z
	prval pf = proj_msg_to() ++ proj_msg_from() ++ proj_msg_skip() -+ proj_msg_broadcast_to() ++ proj_chse(proj_cls(), proj_msg_broadcast_to() ++ proj_cls())
in 
	accept (pf | name, 1, gp, llam session => loop session)
end 

extern fun c (): void = "mac#"
implement c () = let 

	val name = make_name {msg(0,1,int) :: msg(1,2,int) :: msg(2,0,int) :: msg(0,~1,bool) :: chse(2,cls(),msg(2,~1,string)::cls())} ("test")
	fun loop (s: option (session (2, msg(1,2,int)::msg(2,0,int)::msg(0,2,bool)::chse(2,cls(),msg(2,~1,string)::cls())))): void = 
		case+ s of 
		| ~None () => ()
		| ~Some (session) => let 
			val x = receive (session, 1)
			val _ = send (session, 0, x)
			val ret = receive (session, 0)
			val _ = println! ret
			val _ = choose_snd (session)
			val _ = broadcast (session, "Hello")
		in 
			close session
		end

	val gp = rtmsg(0,1) ** rtmsg(1,2) ** rtmsg(2,0) ** rtmsg(0,~1) ** rtchse (2, rtcls(), rtmsg(2,~1) ** rtcls())

	prval pf = proj_msg_skip() -+ proj_msg_to() ++ proj_msg_from() ++ proj_msg_broadcast_to() ++ proj_chse(proj_cls(), proj_msg_broadcast_from() ++ proj_cls())
in 
	loop (request (pf | name, 2, gp, 3))
end 


