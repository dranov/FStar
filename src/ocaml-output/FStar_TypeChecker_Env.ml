open Prims
type sig_binding =
  (FStar_Ident.lident Prims.list,FStar_Syntax_Syntax.sigelt)
    FStar_Pervasives_Native.tuple2
type delta_level =
  | NoDelta 
  | Inlining 
  | Eager_unfolding_only 
  | Unfold of FStar_Syntax_Syntax.delta_depth 
let (uu___is_NoDelta : delta_level -> Prims.bool) =
  fun projectee  ->
    match projectee with | NoDelta  -> true | uu____17 -> false
  
let (uu___is_Inlining : delta_level -> Prims.bool) =
  fun projectee  ->
    match projectee with | Inlining  -> true | uu____23 -> false
  
let (uu___is_Eager_unfolding_only : delta_level -> Prims.bool) =
  fun projectee  ->
    match projectee with | Eager_unfolding_only  -> true | uu____29 -> false
  
let (uu___is_Unfold : delta_level -> Prims.bool) =
  fun projectee  ->
    match projectee with | Unfold _0 -> true | uu____36 -> false
  
let (__proj__Unfold__item___0 :
  delta_level -> FStar_Syntax_Syntax.delta_depth) =
  fun projectee  -> match projectee with | Unfold _0 -> _0 
type mlift =
  {
  mlift_wp:
    FStar_Syntax_Syntax.universe ->
      FStar_Syntax_Syntax.typ ->
        FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ
    ;
  mlift_term:
    (FStar_Syntax_Syntax.universe ->
       FStar_Syntax_Syntax.typ ->
         FStar_Syntax_Syntax.typ ->
           FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
      FStar_Pervasives_Native.option
    }
let (__proj__Mkmlift__item__mlift_wp :
  mlift ->
    FStar_Syntax_Syntax.universe ->
      FStar_Syntax_Syntax.typ ->
        FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ)
  =
  fun projectee  ->
    match projectee with
    | { mlift_wp = __fname__mlift_wp; mlift_term = __fname__mlift_term;_} ->
        __fname__mlift_wp
  
let (__proj__Mkmlift__item__mlift_term :
  mlift ->
    (FStar_Syntax_Syntax.universe ->
       FStar_Syntax_Syntax.typ ->
         FStar_Syntax_Syntax.typ ->
           FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
      FStar_Pervasives_Native.option)
  =
  fun projectee  ->
    match projectee with
    | { mlift_wp = __fname__mlift_wp; mlift_term = __fname__mlift_term;_} ->
        __fname__mlift_term
  
type edge =
  {
  msource: FStar_Ident.lident ;
  mtarget: FStar_Ident.lident ;
  mlift: mlift }
let (__proj__Mkedge__item__msource : edge -> FStar_Ident.lident) =
  fun projectee  ->
    match projectee with
    | { msource = __fname__msource; mtarget = __fname__mtarget;
        mlift = __fname__mlift;_} -> __fname__msource
  
let (__proj__Mkedge__item__mtarget : edge -> FStar_Ident.lident) =
  fun projectee  ->
    match projectee with
    | { msource = __fname__msource; mtarget = __fname__mtarget;
        mlift = __fname__mlift;_} -> __fname__mtarget
  
let (__proj__Mkedge__item__mlift : edge -> mlift) =
  fun projectee  ->
    match projectee with
    | { msource = __fname__msource; mtarget = __fname__mtarget;
        mlift = __fname__mlift;_} -> __fname__mlift
  
type effects =
  {
  decls:
    (FStar_Syntax_Syntax.eff_decl,FStar_Syntax_Syntax.qualifier Prims.list)
      FStar_Pervasives_Native.tuple2 Prims.list
    ;
  order: edge Prims.list ;
  joins:
    (FStar_Ident.lident,FStar_Ident.lident,FStar_Ident.lident,mlift,mlift)
      FStar_Pervasives_Native.tuple5 Prims.list
    }
let (__proj__Mkeffects__item__decls :
  effects ->
    (FStar_Syntax_Syntax.eff_decl,FStar_Syntax_Syntax.qualifier Prims.list)
      FStar_Pervasives_Native.tuple2 Prims.list)
  =
  fun projectee  ->
    match projectee with
    | { decls = __fname__decls; order = __fname__order;
        joins = __fname__joins;_} -> __fname__decls
  
let (__proj__Mkeffects__item__order : effects -> edge Prims.list) =
  fun projectee  ->
    match projectee with
    | { decls = __fname__decls; order = __fname__order;
        joins = __fname__joins;_} -> __fname__order
  
let (__proj__Mkeffects__item__joins :
  effects ->
    (FStar_Ident.lident,FStar_Ident.lident,FStar_Ident.lident,mlift,mlift)
      FStar_Pervasives_Native.tuple5 Prims.list)
  =
  fun projectee  ->
    match projectee with
    | { decls = __fname__decls; order = __fname__order;
        joins = __fname__joins;_} -> __fname__joins
  
type name_prefix = Prims.string Prims.list
type proof_namespace =
  (name_prefix,Prims.bool) FStar_Pervasives_Native.tuple2 Prims.list
type cached_elt =
  (((FStar_Syntax_Syntax.universes,FStar_Syntax_Syntax.typ)
      FStar_Pervasives_Native.tuple2,(FStar_Syntax_Syntax.sigelt,FStar_Syntax_Syntax.universes
                                                                   FStar_Pervasives_Native.option)
                                       FStar_Pervasives_Native.tuple2)
     FStar_Util.either,FStar_Range.range)
    FStar_Pervasives_Native.tuple2
type goal = FStar_Syntax_Syntax.term
type env =
  {
  solver: solver_t ;
  range: FStar_Range.range ;
  curmodule: FStar_Ident.lident ;
  gamma: FStar_Syntax_Syntax.binding Prims.list ;
  gamma_sig: sig_binding Prims.list ;
  gamma_cache: cached_elt FStar_Util.smap ;
  modules: FStar_Syntax_Syntax.modul Prims.list ;
  expected_typ: FStar_Syntax_Syntax.typ FStar_Pervasives_Native.option ;
  sigtab: FStar_Syntax_Syntax.sigelt FStar_Util.smap ;
  is_pattern: Prims.bool ;
  instantiate_imp: Prims.bool ;
  effects: effects ;
  generalize: Prims.bool ;
  letrecs:
    (FStar_Syntax_Syntax.lbname,FStar_Syntax_Syntax.typ,FStar_Syntax_Syntax.univ_names)
      FStar_Pervasives_Native.tuple3 Prims.list
    ;
  top_level: Prims.bool ;
  check_uvars: Prims.bool ;
  use_eq: Prims.bool ;
  is_iface: Prims.bool ;
  admit: Prims.bool ;
  lax: Prims.bool ;
  lax_universes: Prims.bool ;
  phase1: Prims.bool ;
  failhard: Prims.bool ;
  nosynth: Prims.bool ;
  uvar_subtyping: Prims.bool ;
  weaken_comp_tys: Prims.bool ;
  tc_term:
    env ->
      FStar_Syntax_Syntax.term ->
        (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.lcomp,guard_t)
          FStar_Pervasives_Native.tuple3
    ;
  type_of:
    env ->
      FStar_Syntax_Syntax.term ->
        (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.typ,guard_t)
          FStar_Pervasives_Native.tuple3
    ;
  universe_of:
    env -> FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.universe ;
  check_type_of:
    Prims.bool ->
      env -> FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.typ -> guard_t
    ;
  use_bv_sorts: Prims.bool ;
  qtbl_name_and_index:
    (Prims.int FStar_Util.smap,(FStar_Ident.lident,Prims.int)
                                 FStar_Pervasives_Native.tuple2
                                 FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple2
    ;
  normalized_eff_names: FStar_Ident.lident FStar_Util.smap ;
  proof_ns: proof_namespace ;
  synth_hook:
    env ->
      FStar_Syntax_Syntax.typ ->
        FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term
    ;
  splice:
    env -> FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.sigelt Prims.list ;
  is_native_tactic: FStar_Ident.lid -> Prims.bool ;
  identifier_info: FStar_TypeChecker_Common.id_info_table FStar_ST.ref ;
  tc_hooks: tcenv_hooks ;
  dsenv: FStar_Syntax_DsEnv.env ;
  dep_graph: FStar_Parser_Dep.deps }
and solver_t =
  {
  init: env -> unit ;
  push: Prims.string -> unit ;
  pop: Prims.string -> unit ;
  snapshot:
    Prims.string ->
      ((Prims.int,Prims.int,Prims.int) FStar_Pervasives_Native.tuple3,
        unit) FStar_Pervasives_Native.tuple2
    ;
  rollback:
    Prims.string ->
      (Prims.int,Prims.int,Prims.int) FStar_Pervasives_Native.tuple3
        FStar_Pervasives_Native.option -> unit
    ;
  encode_modul: env -> FStar_Syntax_Syntax.modul -> unit ;
  encode_sig: env -> FStar_Syntax_Syntax.sigelt -> unit ;
  preprocess:
    env ->
      goal ->
        (env,goal,FStar_Options.optionstate) FStar_Pervasives_Native.tuple3
          Prims.list
    ;
  solve:
    (unit -> Prims.string) FStar_Pervasives_Native.option ->
      env -> FStar_Syntax_Syntax.typ -> unit
    ;
  finish: unit -> unit ;
  refresh: unit -> unit }
and guard_t =
  {
  guard_f: FStar_TypeChecker_Common.guard_formula ;
  deferred: FStar_TypeChecker_Common.deferred ;
  univ_ineqs:
    (FStar_Syntax_Syntax.universe Prims.list,FStar_TypeChecker_Common.univ_ineq
                                               Prims.list)
      FStar_Pervasives_Native.tuple2
    ;
  implicits:
    (Prims.string,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.ctx_uvar,
      FStar_Range.range) FStar_Pervasives_Native.tuple4 Prims.list
    }
and tcenv_hooks =
  {
  tc_push_in_gamma_hook:
    env ->
      (FStar_Syntax_Syntax.binding,sig_binding) FStar_Util.either -> unit
    }
let (__proj__Mkenv__item__solver : env -> solver_t) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__solver
  
let (__proj__Mkenv__item__range : env -> FStar_Range.range) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__range
  
let (__proj__Mkenv__item__curmodule : env -> FStar_Ident.lident) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__curmodule
  
let (__proj__Mkenv__item__gamma :
  env -> FStar_Syntax_Syntax.binding Prims.list) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__gamma
  
let (__proj__Mkenv__item__gamma_sig : env -> sig_binding Prims.list) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__gamma_sig
  
let (__proj__Mkenv__item__gamma_cache : env -> cached_elt FStar_Util.smap) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__gamma_cache
  
let (__proj__Mkenv__item__modules :
  env -> FStar_Syntax_Syntax.modul Prims.list) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__modules
  
let (__proj__Mkenv__item__expected_typ :
  env -> FStar_Syntax_Syntax.typ FStar_Pervasives_Native.option) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__expected_typ
  
let (__proj__Mkenv__item__sigtab :
  env -> FStar_Syntax_Syntax.sigelt FStar_Util.smap) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__sigtab
  
let (__proj__Mkenv__item__is_pattern : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__is_pattern
  
let (__proj__Mkenv__item__instantiate_imp : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__instantiate_imp
  
let (__proj__Mkenv__item__effects : env -> effects) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__effects
  
let (__proj__Mkenv__item__generalize : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__generalize
  
let (__proj__Mkenv__item__letrecs :
  env ->
    (FStar_Syntax_Syntax.lbname,FStar_Syntax_Syntax.typ,FStar_Syntax_Syntax.univ_names)
      FStar_Pervasives_Native.tuple3 Prims.list)
  =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__letrecs
  
let (__proj__Mkenv__item__top_level : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__top_level
  
let (__proj__Mkenv__item__check_uvars : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__check_uvars
  
let (__proj__Mkenv__item__use_eq : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__use_eq
  
let (__proj__Mkenv__item__is_iface : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__is_iface
  
let (__proj__Mkenv__item__admit : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__admit
  
let (__proj__Mkenv__item__lax : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__lax
  
let (__proj__Mkenv__item__lax_universes : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__lax_universes
  
let (__proj__Mkenv__item__phase1 : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__phase1
  
let (__proj__Mkenv__item__failhard : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__failhard
  
let (__proj__Mkenv__item__nosynth : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__nosynth
  
let (__proj__Mkenv__item__uvar_subtyping : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__uvar_subtyping
  
let (__proj__Mkenv__item__weaken_comp_tys : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__weaken_comp_tys
  
let (__proj__Mkenv__item__tc_term :
  env ->
    env ->
      FStar_Syntax_Syntax.term ->
        (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.lcomp,guard_t)
          FStar_Pervasives_Native.tuple3)
  =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__tc_term
  
let (__proj__Mkenv__item__type_of :
  env ->
    env ->
      FStar_Syntax_Syntax.term ->
        (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.typ,guard_t)
          FStar_Pervasives_Native.tuple3)
  =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__type_of
  
let (__proj__Mkenv__item__universe_of :
  env -> env -> FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.universe) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__universe_of
  
let (__proj__Mkenv__item__check_type_of :
  env ->
    Prims.bool ->
      env -> FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.typ -> guard_t)
  =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__check_type_of
  
let (__proj__Mkenv__item__use_bv_sorts : env -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__use_bv_sorts
  
let (__proj__Mkenv__item__qtbl_name_and_index :
  env ->
    (Prims.int FStar_Util.smap,(FStar_Ident.lident,Prims.int)
                                 FStar_Pervasives_Native.tuple2
                                 FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple2)
  =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__qtbl_name_and_index
  
let (__proj__Mkenv__item__normalized_eff_names :
  env -> FStar_Ident.lident FStar_Util.smap) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__normalized_eff_names
  
let (__proj__Mkenv__item__proof_ns : env -> proof_namespace) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__proof_ns
  
let (__proj__Mkenv__item__synth_hook :
  env ->
    env ->
      FStar_Syntax_Syntax.typ ->
        FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
  =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__synth_hook
  
let (__proj__Mkenv__item__splice :
  env ->
    env -> FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.sigelt Prims.list)
  =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__splice
  
let (__proj__Mkenv__item__is_native_tactic :
  env -> FStar_Ident.lid -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__is_native_tactic
  
let (__proj__Mkenv__item__identifier_info :
  env -> FStar_TypeChecker_Common.id_info_table FStar_ST.ref) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__identifier_info
  
let (__proj__Mkenv__item__tc_hooks : env -> tcenv_hooks) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__tc_hooks
  
let (__proj__Mkenv__item__dsenv : env -> FStar_Syntax_DsEnv.env) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__dsenv
  
let (__proj__Mkenv__item__dep_graph : env -> FStar_Parser_Dep.deps) =
  fun projectee  ->
    match projectee with
    | { solver = __fname__solver; range = __fname__range;
        curmodule = __fname__curmodule; gamma = __fname__gamma;
        gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache;
        modules = __fname__modules; expected_typ = __fname__expected_typ;
        sigtab = __fname__sigtab; is_pattern = __fname__is_pattern;
        instantiate_imp = __fname__instantiate_imp;
        effects = __fname__effects; generalize = __fname__generalize;
        letrecs = __fname__letrecs; top_level = __fname__top_level;
        check_uvars = __fname__check_uvars; use_eq = __fname__use_eq;
        is_iface = __fname__is_iface; admit = __fname__admit;
        lax = __fname__lax; lax_universes = __fname__lax_universes;
        phase1 = __fname__phase1; failhard = __fname__failhard;
        nosynth = __fname__nosynth; uvar_subtyping = __fname__uvar_subtyping;
        weaken_comp_tys = __fname__weaken_comp_tys;
        tc_term = __fname__tc_term; type_of = __fname__type_of;
        universe_of = __fname__universe_of;
        check_type_of = __fname__check_type_of;
        use_bv_sorts = __fname__use_bv_sorts;
        qtbl_name_and_index = __fname__qtbl_name_and_index;
        normalized_eff_names = __fname__normalized_eff_names;
        proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook;
        splice = __fname__splice;
        is_native_tactic = __fname__is_native_tactic;
        identifier_info = __fname__identifier_info;
        tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv;
        dep_graph = __fname__dep_graph;_} -> __fname__dep_graph
  
let (__proj__Mksolver_t__item__init : solver_t -> env -> unit) =
  fun projectee  ->
    match projectee with
    | { init = __fname__init; push = __fname__push; pop = __fname__pop;
        snapshot = __fname__snapshot; rollback = __fname__rollback;
        encode_modul = __fname__encode_modul;
        encode_sig = __fname__encode_sig; preprocess = __fname__preprocess;
        solve = __fname__solve; finish = __fname__finish;
        refresh = __fname__refresh;_} -> __fname__init
  
let (__proj__Mksolver_t__item__push : solver_t -> Prims.string -> unit) =
  fun projectee  ->
    match projectee with
    | { init = __fname__init; push = __fname__push; pop = __fname__pop;
        snapshot = __fname__snapshot; rollback = __fname__rollback;
        encode_modul = __fname__encode_modul;
        encode_sig = __fname__encode_sig; preprocess = __fname__preprocess;
        solve = __fname__solve; finish = __fname__finish;
        refresh = __fname__refresh;_} -> __fname__push
  
let (__proj__Mksolver_t__item__pop : solver_t -> Prims.string -> unit) =
  fun projectee  ->
    match projectee with
    | { init = __fname__init; push = __fname__push; pop = __fname__pop;
        snapshot = __fname__snapshot; rollback = __fname__rollback;
        encode_modul = __fname__encode_modul;
        encode_sig = __fname__encode_sig; preprocess = __fname__preprocess;
        solve = __fname__solve; finish = __fname__finish;
        refresh = __fname__refresh;_} -> __fname__pop
  
let (__proj__Mksolver_t__item__snapshot :
  solver_t ->
    Prims.string ->
      ((Prims.int,Prims.int,Prims.int) FStar_Pervasives_Native.tuple3,
        unit) FStar_Pervasives_Native.tuple2)
  =
  fun projectee  ->
    match projectee with
    | { init = __fname__init; push = __fname__push; pop = __fname__pop;
        snapshot = __fname__snapshot; rollback = __fname__rollback;
        encode_modul = __fname__encode_modul;
        encode_sig = __fname__encode_sig; preprocess = __fname__preprocess;
        solve = __fname__solve; finish = __fname__finish;
        refresh = __fname__refresh;_} -> __fname__snapshot
  
let (__proj__Mksolver_t__item__rollback :
  solver_t ->
    Prims.string ->
      (Prims.int,Prims.int,Prims.int) FStar_Pervasives_Native.tuple3
        FStar_Pervasives_Native.option -> unit)
  =
  fun projectee  ->
    match projectee with
    | { init = __fname__init; push = __fname__push; pop = __fname__pop;
        snapshot = __fname__snapshot; rollback = __fname__rollback;
        encode_modul = __fname__encode_modul;
        encode_sig = __fname__encode_sig; preprocess = __fname__preprocess;
        solve = __fname__solve; finish = __fname__finish;
        refresh = __fname__refresh;_} -> __fname__rollback
  
let (__proj__Mksolver_t__item__encode_modul :
  solver_t -> env -> FStar_Syntax_Syntax.modul -> unit) =
  fun projectee  ->
    match projectee with
    | { init = __fname__init; push = __fname__push; pop = __fname__pop;
        snapshot = __fname__snapshot; rollback = __fname__rollback;
        encode_modul = __fname__encode_modul;
        encode_sig = __fname__encode_sig; preprocess = __fname__preprocess;
        solve = __fname__solve; finish = __fname__finish;
        refresh = __fname__refresh;_} -> __fname__encode_modul
  
let (__proj__Mksolver_t__item__encode_sig :
  solver_t -> env -> FStar_Syntax_Syntax.sigelt -> unit) =
  fun projectee  ->
    match projectee with
    | { init = __fname__init; push = __fname__push; pop = __fname__pop;
        snapshot = __fname__snapshot; rollback = __fname__rollback;
        encode_modul = __fname__encode_modul;
        encode_sig = __fname__encode_sig; preprocess = __fname__preprocess;
        solve = __fname__solve; finish = __fname__finish;
        refresh = __fname__refresh;_} -> __fname__encode_sig
  
let (__proj__Mksolver_t__item__preprocess :
  solver_t ->
    env ->
      goal ->
        (env,goal,FStar_Options.optionstate) FStar_Pervasives_Native.tuple3
          Prims.list)
  =
  fun projectee  ->
    match projectee with
    | { init = __fname__init; push = __fname__push; pop = __fname__pop;
        snapshot = __fname__snapshot; rollback = __fname__rollback;
        encode_modul = __fname__encode_modul;
        encode_sig = __fname__encode_sig; preprocess = __fname__preprocess;
        solve = __fname__solve; finish = __fname__finish;
        refresh = __fname__refresh;_} -> __fname__preprocess
  
let (__proj__Mksolver_t__item__solve :
  solver_t ->
    (unit -> Prims.string) FStar_Pervasives_Native.option ->
      env -> FStar_Syntax_Syntax.typ -> unit)
  =
  fun projectee  ->
    match projectee with
    | { init = __fname__init; push = __fname__push; pop = __fname__pop;
        snapshot = __fname__snapshot; rollback = __fname__rollback;
        encode_modul = __fname__encode_modul;
        encode_sig = __fname__encode_sig; preprocess = __fname__preprocess;
        solve = __fname__solve; finish = __fname__finish;
        refresh = __fname__refresh;_} -> __fname__solve
  
let (__proj__Mksolver_t__item__finish : solver_t -> unit -> unit) =
  fun projectee  ->
    match projectee with
    | { init = __fname__init; push = __fname__push; pop = __fname__pop;
        snapshot = __fname__snapshot; rollback = __fname__rollback;
        encode_modul = __fname__encode_modul;
        encode_sig = __fname__encode_sig; preprocess = __fname__preprocess;
        solve = __fname__solve; finish = __fname__finish;
        refresh = __fname__refresh;_} -> __fname__finish
  
let (__proj__Mksolver_t__item__refresh : solver_t -> unit -> unit) =
  fun projectee  ->
    match projectee with
    | { init = __fname__init; push = __fname__push; pop = __fname__pop;
        snapshot = __fname__snapshot; rollback = __fname__rollback;
        encode_modul = __fname__encode_modul;
        encode_sig = __fname__encode_sig; preprocess = __fname__preprocess;
        solve = __fname__solve; finish = __fname__finish;
        refresh = __fname__refresh;_} -> __fname__refresh
  
let (__proj__Mkguard_t__item__guard_f :
  guard_t -> FStar_TypeChecker_Common.guard_formula) =
  fun projectee  ->
    match projectee with
    | { guard_f = __fname__guard_f; deferred = __fname__deferred;
        univ_ineqs = __fname__univ_ineqs; implicits = __fname__implicits;_}
        -> __fname__guard_f
  
let (__proj__Mkguard_t__item__deferred :
  guard_t -> FStar_TypeChecker_Common.deferred) =
  fun projectee  ->
    match projectee with
    | { guard_f = __fname__guard_f; deferred = __fname__deferred;
        univ_ineqs = __fname__univ_ineqs; implicits = __fname__implicits;_}
        -> __fname__deferred
  
let (__proj__Mkguard_t__item__univ_ineqs :
  guard_t ->
    (FStar_Syntax_Syntax.universe Prims.list,FStar_TypeChecker_Common.univ_ineq
                                               Prims.list)
      FStar_Pervasives_Native.tuple2)
  =
  fun projectee  ->
    match projectee with
    | { guard_f = __fname__guard_f; deferred = __fname__deferred;
        univ_ineqs = __fname__univ_ineqs; implicits = __fname__implicits;_}
        -> __fname__univ_ineqs
  
let (__proj__Mkguard_t__item__implicits :
  guard_t ->
    (Prims.string,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.ctx_uvar,
      FStar_Range.range) FStar_Pervasives_Native.tuple4 Prims.list)
  =
  fun projectee  ->
    match projectee with
    | { guard_f = __fname__guard_f; deferred = __fname__deferred;
        univ_ineqs = __fname__univ_ineqs; implicits = __fname__implicits;_}
        -> __fname__implicits
  
let (__proj__Mktcenv_hooks__item__tc_push_in_gamma_hook :
  tcenv_hooks ->
    env ->
      (FStar_Syntax_Syntax.binding,sig_binding) FStar_Util.either -> unit)
  =
  fun projectee  ->
    match projectee with
    | { tc_push_in_gamma_hook = __fname__tc_push_in_gamma_hook;_} ->
        __fname__tc_push_in_gamma_hook
  
type solver_depth_t =
  (Prims.int,Prims.int,Prims.int) FStar_Pervasives_Native.tuple3
type implicits =
  (Prims.string,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.ctx_uvar,
    FStar_Range.range) FStar_Pervasives_Native.tuple4 Prims.list
let (rename_gamma :
  FStar_Syntax_Syntax.subst_t ->
    FStar_Syntax_Syntax.gamma -> FStar_Syntax_Syntax.gamma)
  =
  fun subst1  ->
    fun gamma  ->
      FStar_All.pipe_right gamma
        (FStar_List.map
           (fun uu___220_8641  ->
              match uu___220_8641 with
              | FStar_Syntax_Syntax.Binding_var x ->
                  let y =
                    let uu____8644 = FStar_Syntax_Syntax.bv_to_name x  in
                    FStar_Syntax_Subst.subst subst1 uu____8644  in
                  let uu____8645 =
                    let uu____8646 = FStar_Syntax_Subst.compress y  in
                    uu____8646.FStar_Syntax_Syntax.n  in
                  (match uu____8645 with
                   | FStar_Syntax_Syntax.Tm_name y1 ->
                       let uu____8650 =
                         let uu___234_8651 = y1  in
                         let uu____8652 =
                           FStar_Syntax_Subst.subst subst1
                             x.FStar_Syntax_Syntax.sort
                            in
                         {
                           FStar_Syntax_Syntax.ppname =
                             (uu___234_8651.FStar_Syntax_Syntax.ppname);
                           FStar_Syntax_Syntax.index =
                             (uu___234_8651.FStar_Syntax_Syntax.index);
                           FStar_Syntax_Syntax.sort = uu____8652
                         }  in
                       FStar_Syntax_Syntax.Binding_var uu____8650
                   | uu____8655 -> failwith "Not a renaming")
              | b -> b))
  
let (rename_env : FStar_Syntax_Syntax.subst_t -> env -> env) =
  fun subst1  ->
    fun env  ->
      let uu___235_8667 = env  in
      let uu____8668 = rename_gamma subst1 env.gamma  in
      {
        solver = (uu___235_8667.solver);
        range = (uu___235_8667.range);
        curmodule = (uu___235_8667.curmodule);
        gamma = uu____8668;
        gamma_sig = (uu___235_8667.gamma_sig);
        gamma_cache = (uu___235_8667.gamma_cache);
        modules = (uu___235_8667.modules);
        expected_typ = (uu___235_8667.expected_typ);
        sigtab = (uu___235_8667.sigtab);
        is_pattern = (uu___235_8667.is_pattern);
        instantiate_imp = (uu___235_8667.instantiate_imp);
        effects = (uu___235_8667.effects);
        generalize = (uu___235_8667.generalize);
        letrecs = (uu___235_8667.letrecs);
        top_level = (uu___235_8667.top_level);
        check_uvars = (uu___235_8667.check_uvars);
        use_eq = (uu___235_8667.use_eq);
        is_iface = (uu___235_8667.is_iface);
        admit = (uu___235_8667.admit);
        lax = (uu___235_8667.lax);
        lax_universes = (uu___235_8667.lax_universes);
        phase1 = (uu___235_8667.phase1);
        failhard = (uu___235_8667.failhard);
        nosynth = (uu___235_8667.nosynth);
        uvar_subtyping = (uu___235_8667.uvar_subtyping);
        weaken_comp_tys = (uu___235_8667.weaken_comp_tys);
        tc_term = (uu___235_8667.tc_term);
        type_of = (uu___235_8667.type_of);
        universe_of = (uu___235_8667.universe_of);
        check_type_of = (uu___235_8667.check_type_of);
        use_bv_sorts = (uu___235_8667.use_bv_sorts);
        qtbl_name_and_index = (uu___235_8667.qtbl_name_and_index);
        normalized_eff_names = (uu___235_8667.normalized_eff_names);
        proof_ns = (uu___235_8667.proof_ns);
        synth_hook = (uu___235_8667.synth_hook);
        splice = (uu___235_8667.splice);
        is_native_tactic = (uu___235_8667.is_native_tactic);
        identifier_info = (uu___235_8667.identifier_info);
        tc_hooks = (uu___235_8667.tc_hooks);
        dsenv = (uu___235_8667.dsenv);
        dep_graph = (uu___235_8667.dep_graph)
      }
  
let (default_tc_hooks : tcenv_hooks) =
  { tc_push_in_gamma_hook = (fun uu____8675  -> fun uu____8676  -> ()) } 
let (tc_hooks : env -> tcenv_hooks) = fun env  -> env.tc_hooks 
let (set_tc_hooks : env -> tcenv_hooks -> env) =
  fun env  ->
    fun hooks  ->
      let uu___236_8696 = env  in
      {
        solver = (uu___236_8696.solver);
        range = (uu___236_8696.range);
        curmodule = (uu___236_8696.curmodule);
        gamma = (uu___236_8696.gamma);
        gamma_sig = (uu___236_8696.gamma_sig);
        gamma_cache = (uu___236_8696.gamma_cache);
        modules = (uu___236_8696.modules);
        expected_typ = (uu___236_8696.expected_typ);
        sigtab = (uu___236_8696.sigtab);
        is_pattern = (uu___236_8696.is_pattern);
        instantiate_imp = (uu___236_8696.instantiate_imp);
        effects = (uu___236_8696.effects);
        generalize = (uu___236_8696.generalize);
        letrecs = (uu___236_8696.letrecs);
        top_level = (uu___236_8696.top_level);
        check_uvars = (uu___236_8696.check_uvars);
        use_eq = (uu___236_8696.use_eq);
        is_iface = (uu___236_8696.is_iface);
        admit = (uu___236_8696.admit);
        lax = (uu___236_8696.lax);
        lax_universes = (uu___236_8696.lax_universes);
        phase1 = (uu___236_8696.phase1);
        failhard = (uu___236_8696.failhard);
        nosynth = (uu___236_8696.nosynth);
        uvar_subtyping = (uu___236_8696.uvar_subtyping);
        weaken_comp_tys = (uu___236_8696.weaken_comp_tys);
        tc_term = (uu___236_8696.tc_term);
        type_of = (uu___236_8696.type_of);
        universe_of = (uu___236_8696.universe_of);
        check_type_of = (uu___236_8696.check_type_of);
        use_bv_sorts = (uu___236_8696.use_bv_sorts);
        qtbl_name_and_index = (uu___236_8696.qtbl_name_and_index);
        normalized_eff_names = (uu___236_8696.normalized_eff_names);
        proof_ns = (uu___236_8696.proof_ns);
        synth_hook = (uu___236_8696.synth_hook);
        splice = (uu___236_8696.splice);
        is_native_tactic = (uu___236_8696.is_native_tactic);
        identifier_info = (uu___236_8696.identifier_info);
        tc_hooks = hooks;
        dsenv = (uu___236_8696.dsenv);
        dep_graph = (uu___236_8696.dep_graph)
      }
  
let (set_dep_graph : env -> FStar_Parser_Dep.deps -> env) =
  fun e  ->
    fun g  ->
      let uu___237_8707 = e  in
      {
        solver = (uu___237_8707.solver);
        range = (uu___237_8707.range);
        curmodule = (uu___237_8707.curmodule);
        gamma = (uu___237_8707.gamma);
        gamma_sig = (uu___237_8707.gamma_sig);
        gamma_cache = (uu___237_8707.gamma_cache);
        modules = (uu___237_8707.modules);
        expected_typ = (uu___237_8707.expected_typ);
        sigtab = (uu___237_8707.sigtab);
        is_pattern = (uu___237_8707.is_pattern);
        instantiate_imp = (uu___237_8707.instantiate_imp);
        effects = (uu___237_8707.effects);
        generalize = (uu___237_8707.generalize);
        letrecs = (uu___237_8707.letrecs);
        top_level = (uu___237_8707.top_level);
        check_uvars = (uu___237_8707.check_uvars);
        use_eq = (uu___237_8707.use_eq);
        is_iface = (uu___237_8707.is_iface);
        admit = (uu___237_8707.admit);
        lax = (uu___237_8707.lax);
        lax_universes = (uu___237_8707.lax_universes);
        phase1 = (uu___237_8707.phase1);
        failhard = (uu___237_8707.failhard);
        nosynth = (uu___237_8707.nosynth);
        uvar_subtyping = (uu___237_8707.uvar_subtyping);
        weaken_comp_tys = (uu___237_8707.weaken_comp_tys);
        tc_term = (uu___237_8707.tc_term);
        type_of = (uu___237_8707.type_of);
        universe_of = (uu___237_8707.universe_of);
        check_type_of = (uu___237_8707.check_type_of);
        use_bv_sorts = (uu___237_8707.use_bv_sorts);
        qtbl_name_and_index = (uu___237_8707.qtbl_name_and_index);
        normalized_eff_names = (uu___237_8707.normalized_eff_names);
        proof_ns = (uu___237_8707.proof_ns);
        synth_hook = (uu___237_8707.synth_hook);
        splice = (uu___237_8707.splice);
        is_native_tactic = (uu___237_8707.is_native_tactic);
        identifier_info = (uu___237_8707.identifier_info);
        tc_hooks = (uu___237_8707.tc_hooks);
        dsenv = (uu___237_8707.dsenv);
        dep_graph = g
      }
  
let (dep_graph : env -> FStar_Parser_Dep.deps) = fun e  -> e.dep_graph 
type env_t = env
type sigtable = FStar_Syntax_Syntax.sigelt FStar_Util.smap
let (should_verify : env -> Prims.bool) =
  fun env  ->
    ((Prims.op_Negation env.lax) && (Prims.op_Negation env.admit)) &&
      (FStar_Options.should_verify (env.curmodule).FStar_Ident.str)
  
let (visible_at : delta_level -> FStar_Syntax_Syntax.qualifier -> Prims.bool)
  =
  fun d  ->
    fun q  ->
      match (d, q) with
      | (NoDelta ,uu____8730) -> true
      | (Eager_unfolding_only
         ,FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen ) -> true
      | (Unfold
         uu____8731,FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen ) ->
          true
      | (Unfold uu____8732,FStar_Syntax_Syntax.Visible_default ) -> true
      | (Inlining ,FStar_Syntax_Syntax.Inline_for_extraction ) -> true
      | uu____8733 -> false
  
let (default_table_size : Prims.int) = (Prims.parse_int "200") 
let new_sigtab : 'Auu____8742 . unit -> 'Auu____8742 FStar_Util.smap =
  fun uu____8749  -> FStar_Util.smap_create default_table_size 
let new_gamma_cache : 'Auu____8754 . unit -> 'Auu____8754 FStar_Util.smap =
  fun uu____8761  -> FStar_Util.smap_create (Prims.parse_int "100") 
let (initial_env :
  FStar_Parser_Dep.deps ->
    (env ->
       FStar_Syntax_Syntax.term ->
         (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.lcomp,guard_t)
           FStar_Pervasives_Native.tuple3)
      ->
      (env ->
         FStar_Syntax_Syntax.term ->
           (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.typ,guard_t)
             FStar_Pervasives_Native.tuple3)
        ->
        (env -> FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.universe) ->
          (Prims.bool ->
             env ->
               FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.typ -> guard_t)
            -> solver_t -> FStar_Ident.lident -> env)
  =
  fun deps  ->
    fun tc_term  ->
      fun type_of  ->
        fun universe_of  ->
          fun check_type_of  ->
            fun solver  ->
              fun module_lid  ->
                let uu____8871 = new_gamma_cache ()  in
                let uu____8874 = new_sigtab ()  in
                let uu____8877 =
                  let uu____8890 =
                    FStar_Util.smap_create (Prims.parse_int "10")  in
                  (uu____8890, FStar_Pervasives_Native.None)  in
                let uu____8905 =
                  FStar_Util.smap_create (Prims.parse_int "20")  in
                let uu____8908 = FStar_Options.using_facts_from ()  in
                let uu____8909 =
                  FStar_Util.mk_ref
                    FStar_TypeChecker_Common.id_info_table_empty
                   in
                let uu____8912 = FStar_Syntax_DsEnv.empty_env ()  in
                {
                  solver;
                  range = FStar_Range.dummyRange;
                  curmodule = module_lid;
                  gamma = [];
                  gamma_sig = [];
                  gamma_cache = uu____8871;
                  modules = [];
                  expected_typ = FStar_Pervasives_Native.None;
                  sigtab = uu____8874;
                  is_pattern = false;
                  instantiate_imp = true;
                  effects = { decls = []; order = []; joins = [] };
                  generalize = true;
                  letrecs = [];
                  top_level = false;
                  check_uvars = false;
                  use_eq = false;
                  is_iface = false;
                  admit = false;
                  lax = false;
                  lax_universes = false;
                  phase1 = false;
                  failhard = false;
                  nosynth = false;
                  uvar_subtyping = true;
                  weaken_comp_tys = true;
                  tc_term;
                  type_of;
                  universe_of;
                  check_type_of;
                  use_bv_sorts = false;
                  qtbl_name_and_index = uu____8877;
                  normalized_eff_names = uu____8905;
                  proof_ns = uu____8908;
                  synth_hook =
                    (fun e  ->
                       fun g  ->
                         fun tau  -> failwith "no synthesizer available");
                  splice =
                    (fun e  -> fun tau  -> failwith "no splicer available");
                  is_native_tactic = (fun uu____8948  -> false);
                  identifier_info = uu____8909;
                  tc_hooks = default_tc_hooks;
                  dsenv = uu____8912;
                  dep_graph = deps
                }
  
let (dsenv : env -> FStar_Syntax_DsEnv.env) = fun env  -> env.dsenv 
let (sigtab : env -> FStar_Syntax_Syntax.sigelt FStar_Util.smap) =
  fun env  -> env.sigtab 
let (gamma_cache : env -> cached_elt FStar_Util.smap) =
  fun env  -> env.gamma_cache 
let (query_indices :
  (FStar_Ident.lident,Prims.int) FStar_Pervasives_Native.tuple2 Prims.list
    Prims.list FStar_ST.ref)
  = FStar_Util.mk_ref [[]] 
let (push_query_indices : unit -> unit) =
  fun uu____9039  ->
    let uu____9040 = FStar_ST.op_Bang query_indices  in
    match uu____9040 with
    | [] -> failwith "Empty query indices!"
    | uu____9094 ->
        let uu____9103 =
          let uu____9112 =
            let uu____9119 = FStar_ST.op_Bang query_indices  in
            FStar_List.hd uu____9119  in
          let uu____9173 = FStar_ST.op_Bang query_indices  in uu____9112 ::
            uu____9173
           in
        FStar_ST.op_Colon_Equals query_indices uu____9103
  
let (pop_query_indices : unit -> unit) =
  fun uu____9270  ->
    let uu____9271 = FStar_ST.op_Bang query_indices  in
    match uu____9271 with
    | [] -> failwith "Empty query indices!"
    | hd1::tl1 -> FStar_ST.op_Colon_Equals query_indices tl1
  
let (snapshot_query_indices :
  unit -> (Prims.int,unit) FStar_Pervasives_Native.tuple2) =
  fun uu____9394  ->
    FStar_Common.snapshot push_query_indices query_indices ()
  
let (rollback_query_indices :
  Prims.int FStar_Pervasives_Native.option -> unit) =
  fun depth  -> FStar_Common.rollback pop_query_indices query_indices depth 
let (add_query_index :
  (FStar_Ident.lident,Prims.int) FStar_Pervasives_Native.tuple2 -> unit) =
  fun uu____9424  ->
    match uu____9424 with
    | (l,n1) ->
        let uu____9431 = FStar_ST.op_Bang query_indices  in
        (match uu____9431 with
         | hd1::tl1 ->
             FStar_ST.op_Colon_Equals query_indices (((l, n1) :: hd1) :: tl1)
         | uu____9550 -> failwith "Empty query indices")
  
let (peek_query_indices :
  unit ->
    (FStar_Ident.lident,Prims.int) FStar_Pervasives_Native.tuple2 Prims.list)
  =
  fun uu____9569  ->
    let uu____9570 = FStar_ST.op_Bang query_indices  in
    FStar_List.hd uu____9570
  
let (stack : env Prims.list FStar_ST.ref) = FStar_Util.mk_ref [] 
let (push_stack : env -> env) =
  fun env  ->
    (let uu____9647 =
       let uu____9650 = FStar_ST.op_Bang stack  in env :: uu____9650  in
     FStar_ST.op_Colon_Equals stack uu____9647);
    (let uu___238_9707 = env  in
     let uu____9708 = FStar_Util.smap_copy (gamma_cache env)  in
     let uu____9711 = FStar_Util.smap_copy (sigtab env)  in
     let uu____9714 =
       let uu____9727 =
         let uu____9730 =
           FStar_All.pipe_right env.qtbl_name_and_index
             FStar_Pervasives_Native.fst
            in
         FStar_Util.smap_copy uu____9730  in
       let uu____9755 =
         FStar_All.pipe_right env.qtbl_name_and_index
           FStar_Pervasives_Native.snd
          in
       (uu____9727, uu____9755)  in
     let uu____9796 = FStar_Util.smap_copy env.normalized_eff_names  in
     let uu____9799 =
       let uu____9802 = FStar_ST.op_Bang env.identifier_info  in
       FStar_Util.mk_ref uu____9802  in
     {
       solver = (uu___238_9707.solver);
       range = (uu___238_9707.range);
       curmodule = (uu___238_9707.curmodule);
       gamma = (uu___238_9707.gamma);
       gamma_sig = (uu___238_9707.gamma_sig);
       gamma_cache = uu____9708;
       modules = (uu___238_9707.modules);
       expected_typ = (uu___238_9707.expected_typ);
       sigtab = uu____9711;
       is_pattern = (uu___238_9707.is_pattern);
       instantiate_imp = (uu___238_9707.instantiate_imp);
       effects = (uu___238_9707.effects);
       generalize = (uu___238_9707.generalize);
       letrecs = (uu___238_9707.letrecs);
       top_level = (uu___238_9707.top_level);
       check_uvars = (uu___238_9707.check_uvars);
       use_eq = (uu___238_9707.use_eq);
       is_iface = (uu___238_9707.is_iface);
       admit = (uu___238_9707.admit);
       lax = (uu___238_9707.lax);
       lax_universes = (uu___238_9707.lax_universes);
       phase1 = (uu___238_9707.phase1);
       failhard = (uu___238_9707.failhard);
       nosynth = (uu___238_9707.nosynth);
       uvar_subtyping = (uu___238_9707.uvar_subtyping);
       weaken_comp_tys = (uu___238_9707.weaken_comp_tys);
       tc_term = (uu___238_9707.tc_term);
       type_of = (uu___238_9707.type_of);
       universe_of = (uu___238_9707.universe_of);
       check_type_of = (uu___238_9707.check_type_of);
       use_bv_sorts = (uu___238_9707.use_bv_sorts);
       qtbl_name_and_index = uu____9714;
       normalized_eff_names = uu____9796;
       proof_ns = (uu___238_9707.proof_ns);
       synth_hook = (uu___238_9707.synth_hook);
       splice = (uu___238_9707.splice);
       is_native_tactic = (uu___238_9707.is_native_tactic);
       identifier_info = uu____9799;
       tc_hooks = (uu___238_9707.tc_hooks);
       dsenv = (uu___238_9707.dsenv);
       dep_graph = (uu___238_9707.dep_graph)
     })
  
let (pop_stack : unit -> env) =
  fun uu____9852  ->
    let uu____9853 = FStar_ST.op_Bang stack  in
    match uu____9853 with
    | env::tl1 -> (FStar_ST.op_Colon_Equals stack tl1; env)
    | uu____9915 -> failwith "Impossible: Too many pops"
  
let (snapshot_stack : env -> (Prims.int,env) FStar_Pervasives_Native.tuple2)
  = fun env  -> FStar_Common.snapshot push_stack stack env 
let (rollback_stack : Prims.int FStar_Pervasives_Native.option -> env) =
  fun depth  -> FStar_Common.rollback pop_stack stack depth 
type tcenv_depth_t =
  (Prims.int,Prims.int,solver_depth_t,Prims.int)
    FStar_Pervasives_Native.tuple4
let (snapshot :
  env -> Prims.string -> (tcenv_depth_t,env) FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun msg  ->
      FStar_Util.atomically
        (fun uu____9987  ->
           let uu____9988 = snapshot_stack env  in
           match uu____9988 with
           | (stack_depth,env1) ->
               let uu____10013 = snapshot_query_indices ()  in
               (match uu____10013 with
                | (query_indices_depth,()) ->
                    let uu____10037 = (env1.solver).snapshot msg  in
                    (match uu____10037 with
                     | (solver_depth,()) ->
                         let uu____10079 =
                           FStar_Syntax_DsEnv.snapshot env1.dsenv  in
                         (match uu____10079 with
                          | (dsenv_depth,dsenv1) ->
                              ((stack_depth, query_indices_depth,
                                 solver_depth, dsenv_depth),
                                (let uu___239_10125 = env1  in
                                 {
                                   solver = (uu___239_10125.solver);
                                   range = (uu___239_10125.range);
                                   curmodule = (uu___239_10125.curmodule);
                                   gamma = (uu___239_10125.gamma);
                                   gamma_sig = (uu___239_10125.gamma_sig);
                                   gamma_cache = (uu___239_10125.gamma_cache);
                                   modules = (uu___239_10125.modules);
                                   expected_typ =
                                     (uu___239_10125.expected_typ);
                                   sigtab = (uu___239_10125.sigtab);
                                   is_pattern = (uu___239_10125.is_pattern);
                                   instantiate_imp =
                                     (uu___239_10125.instantiate_imp);
                                   effects = (uu___239_10125.effects);
                                   generalize = (uu___239_10125.generalize);
                                   letrecs = (uu___239_10125.letrecs);
                                   top_level = (uu___239_10125.top_level);
                                   check_uvars = (uu___239_10125.check_uvars);
                                   use_eq = (uu___239_10125.use_eq);
                                   is_iface = (uu___239_10125.is_iface);
                                   admit = (uu___239_10125.admit);
                                   lax = (uu___239_10125.lax);
                                   lax_universes =
                                     (uu___239_10125.lax_universes);
                                   phase1 = (uu___239_10125.phase1);
                                   failhard = (uu___239_10125.failhard);
                                   nosynth = (uu___239_10125.nosynth);
                                   uvar_subtyping =
                                     (uu___239_10125.uvar_subtyping);
                                   weaken_comp_tys =
                                     (uu___239_10125.weaken_comp_tys);
                                   tc_term = (uu___239_10125.tc_term);
                                   type_of = (uu___239_10125.type_of);
                                   universe_of = (uu___239_10125.universe_of);
                                   check_type_of =
                                     (uu___239_10125.check_type_of);
                                   use_bv_sorts =
                                     (uu___239_10125.use_bv_sorts);
                                   qtbl_name_and_index =
                                     (uu___239_10125.qtbl_name_and_index);
                                   normalized_eff_names =
                                     (uu___239_10125.normalized_eff_names);
                                   proof_ns = (uu___239_10125.proof_ns);
                                   synth_hook = (uu___239_10125.synth_hook);
                                   splice = (uu___239_10125.splice);
                                   is_native_tactic =
                                     (uu___239_10125.is_native_tactic);
                                   identifier_info =
                                     (uu___239_10125.identifier_info);
                                   tc_hooks = (uu___239_10125.tc_hooks);
                                   dsenv = dsenv1;
                                   dep_graph = (uu___239_10125.dep_graph)
                                 }))))))
  
let (rollback :
  solver_t ->
    Prims.string -> tcenv_depth_t FStar_Pervasives_Native.option -> env)
  =
  fun solver  ->
    fun msg  ->
      fun depth  ->
        FStar_Util.atomically
          (fun uu____10156  ->
             let uu____10157 =
               match depth with
               | FStar_Pervasives_Native.Some (s1,s2,s3,s4) ->
                   ((FStar_Pervasives_Native.Some s1),
                     (FStar_Pervasives_Native.Some s2),
                     (FStar_Pervasives_Native.Some s3),
                     (FStar_Pervasives_Native.Some s4))
               | FStar_Pervasives_Native.None  ->
                   (FStar_Pervasives_Native.None,
                     FStar_Pervasives_Native.None,
                     FStar_Pervasives_Native.None,
                     FStar_Pervasives_Native.None)
                in
             match uu____10157 with
             | (stack_depth,query_indices_depth,solver_depth,dsenv_depth) ->
                 (solver.rollback msg solver_depth;
                  (match () with
                   | () ->
                       (rollback_query_indices query_indices_depth;
                        (match () with
                         | () ->
                             let tcenv = rollback_stack stack_depth  in
                             let dsenv1 =
                               FStar_Syntax_DsEnv.rollback dsenv_depth  in
                             ((let uu____10283 =
                                 FStar_Util.physical_equality tcenv.dsenv
                                   dsenv1
                                  in
                               FStar_Common.runtime_assert uu____10283
                                 "Inconsistent stack state");
                              tcenv))))))
  
let (push : env -> Prims.string -> env) =
  fun env  ->
    fun msg  ->
      let uu____10294 = snapshot env msg  in
      FStar_Pervasives_Native.snd uu____10294
  
let (pop : env -> Prims.string -> env) =
  fun env  ->
    fun msg  -> rollback env.solver msg FStar_Pervasives_Native.None
  
let (incr_query_index : env -> env) =
  fun env  ->
    let qix = peek_query_indices ()  in
    match env.qtbl_name_and_index with
    | (uu____10321,FStar_Pervasives_Native.None ) -> env
    | (tbl,FStar_Pervasives_Native.Some (l,n1)) ->
        let uu____10353 =
          FStar_All.pipe_right qix
            (FStar_List.tryFind
               (fun uu____10379  ->
                  match uu____10379 with
                  | (m,uu____10385) -> FStar_Ident.lid_equals l m))
           in
        (match uu____10353 with
         | FStar_Pervasives_Native.None  ->
             let next = n1 + (Prims.parse_int "1")  in
             (add_query_index (l, next);
              FStar_Util.smap_add tbl l.FStar_Ident.str next;
              (let uu___240_10393 = env  in
               {
                 solver = (uu___240_10393.solver);
                 range = (uu___240_10393.range);
                 curmodule = (uu___240_10393.curmodule);
                 gamma = (uu___240_10393.gamma);
                 gamma_sig = (uu___240_10393.gamma_sig);
                 gamma_cache = (uu___240_10393.gamma_cache);
                 modules = (uu___240_10393.modules);
                 expected_typ = (uu___240_10393.expected_typ);
                 sigtab = (uu___240_10393.sigtab);
                 is_pattern = (uu___240_10393.is_pattern);
                 instantiate_imp = (uu___240_10393.instantiate_imp);
                 effects = (uu___240_10393.effects);
                 generalize = (uu___240_10393.generalize);
                 letrecs = (uu___240_10393.letrecs);
                 top_level = (uu___240_10393.top_level);
                 check_uvars = (uu___240_10393.check_uvars);
                 use_eq = (uu___240_10393.use_eq);
                 is_iface = (uu___240_10393.is_iface);
                 admit = (uu___240_10393.admit);
                 lax = (uu___240_10393.lax);
                 lax_universes = (uu___240_10393.lax_universes);
                 phase1 = (uu___240_10393.phase1);
                 failhard = (uu___240_10393.failhard);
                 nosynth = (uu___240_10393.nosynth);
                 uvar_subtyping = (uu___240_10393.uvar_subtyping);
                 weaken_comp_tys = (uu___240_10393.weaken_comp_tys);
                 tc_term = (uu___240_10393.tc_term);
                 type_of = (uu___240_10393.type_of);
                 universe_of = (uu___240_10393.universe_of);
                 check_type_of = (uu___240_10393.check_type_of);
                 use_bv_sorts = (uu___240_10393.use_bv_sorts);
                 qtbl_name_and_index =
                   (tbl, (FStar_Pervasives_Native.Some (l, next)));
                 normalized_eff_names = (uu___240_10393.normalized_eff_names);
                 proof_ns = (uu___240_10393.proof_ns);
                 synth_hook = (uu___240_10393.synth_hook);
                 splice = (uu___240_10393.splice);
                 is_native_tactic = (uu___240_10393.is_native_tactic);
                 identifier_info = (uu___240_10393.identifier_info);
                 tc_hooks = (uu___240_10393.tc_hooks);
                 dsenv = (uu___240_10393.dsenv);
                 dep_graph = (uu___240_10393.dep_graph)
               }))
         | FStar_Pervasives_Native.Some (uu____10406,m) ->
             let next = m + (Prims.parse_int "1")  in
             (add_query_index (l, next);
              FStar_Util.smap_add tbl l.FStar_Ident.str next;
              (let uu___241_10415 = env  in
               {
                 solver = (uu___241_10415.solver);
                 range = (uu___241_10415.range);
                 curmodule = (uu___241_10415.curmodule);
                 gamma = (uu___241_10415.gamma);
                 gamma_sig = (uu___241_10415.gamma_sig);
                 gamma_cache = (uu___241_10415.gamma_cache);
                 modules = (uu___241_10415.modules);
                 expected_typ = (uu___241_10415.expected_typ);
                 sigtab = (uu___241_10415.sigtab);
                 is_pattern = (uu___241_10415.is_pattern);
                 instantiate_imp = (uu___241_10415.instantiate_imp);
                 effects = (uu___241_10415.effects);
                 generalize = (uu___241_10415.generalize);
                 letrecs = (uu___241_10415.letrecs);
                 top_level = (uu___241_10415.top_level);
                 check_uvars = (uu___241_10415.check_uvars);
                 use_eq = (uu___241_10415.use_eq);
                 is_iface = (uu___241_10415.is_iface);
                 admit = (uu___241_10415.admit);
                 lax = (uu___241_10415.lax);
                 lax_universes = (uu___241_10415.lax_universes);
                 phase1 = (uu___241_10415.phase1);
                 failhard = (uu___241_10415.failhard);
                 nosynth = (uu___241_10415.nosynth);
                 uvar_subtyping = (uu___241_10415.uvar_subtyping);
                 weaken_comp_tys = (uu___241_10415.weaken_comp_tys);
                 tc_term = (uu___241_10415.tc_term);
                 type_of = (uu___241_10415.type_of);
                 universe_of = (uu___241_10415.universe_of);
                 check_type_of = (uu___241_10415.check_type_of);
                 use_bv_sorts = (uu___241_10415.use_bv_sorts);
                 qtbl_name_and_index =
                   (tbl, (FStar_Pervasives_Native.Some (l, next)));
                 normalized_eff_names = (uu___241_10415.normalized_eff_names);
                 proof_ns = (uu___241_10415.proof_ns);
                 synth_hook = (uu___241_10415.synth_hook);
                 splice = (uu___241_10415.splice);
                 is_native_tactic = (uu___241_10415.is_native_tactic);
                 identifier_info = (uu___241_10415.identifier_info);
                 tc_hooks = (uu___241_10415.tc_hooks);
                 dsenv = (uu___241_10415.dsenv);
                 dep_graph = (uu___241_10415.dep_graph)
               })))
  
let (debug : env -> FStar_Options.debug_level_t -> Prims.bool) =
  fun env  ->
    fun l  -> FStar_Options.debug_at_level (env.curmodule).FStar_Ident.str l
  
let (set_range : env -> FStar_Range.range -> env) =
  fun e  ->
    fun r  ->
      if r = FStar_Range.dummyRange
      then e
      else
        (let uu___242_10449 = e  in
         {
           solver = (uu___242_10449.solver);
           range = r;
           curmodule = (uu___242_10449.curmodule);
           gamma = (uu___242_10449.gamma);
           gamma_sig = (uu___242_10449.gamma_sig);
           gamma_cache = (uu___242_10449.gamma_cache);
           modules = (uu___242_10449.modules);
           expected_typ = (uu___242_10449.expected_typ);
           sigtab = (uu___242_10449.sigtab);
           is_pattern = (uu___242_10449.is_pattern);
           instantiate_imp = (uu___242_10449.instantiate_imp);
           effects = (uu___242_10449.effects);
           generalize = (uu___242_10449.generalize);
           letrecs = (uu___242_10449.letrecs);
           top_level = (uu___242_10449.top_level);
           check_uvars = (uu___242_10449.check_uvars);
           use_eq = (uu___242_10449.use_eq);
           is_iface = (uu___242_10449.is_iface);
           admit = (uu___242_10449.admit);
           lax = (uu___242_10449.lax);
           lax_universes = (uu___242_10449.lax_universes);
           phase1 = (uu___242_10449.phase1);
           failhard = (uu___242_10449.failhard);
           nosynth = (uu___242_10449.nosynth);
           uvar_subtyping = (uu___242_10449.uvar_subtyping);
           weaken_comp_tys = (uu___242_10449.weaken_comp_tys);
           tc_term = (uu___242_10449.tc_term);
           type_of = (uu___242_10449.type_of);
           universe_of = (uu___242_10449.universe_of);
           check_type_of = (uu___242_10449.check_type_of);
           use_bv_sorts = (uu___242_10449.use_bv_sorts);
           qtbl_name_and_index = (uu___242_10449.qtbl_name_and_index);
           normalized_eff_names = (uu___242_10449.normalized_eff_names);
           proof_ns = (uu___242_10449.proof_ns);
           synth_hook = (uu___242_10449.synth_hook);
           splice = (uu___242_10449.splice);
           is_native_tactic = (uu___242_10449.is_native_tactic);
           identifier_info = (uu___242_10449.identifier_info);
           tc_hooks = (uu___242_10449.tc_hooks);
           dsenv = (uu___242_10449.dsenv);
           dep_graph = (uu___242_10449.dep_graph)
         })
  
let (get_range : env -> FStar_Range.range) = fun e  -> e.range 
let (toggle_id_info : env -> Prims.bool -> unit) =
  fun env  ->
    fun enabled  ->
      let uu____10465 =
        let uu____10466 = FStar_ST.op_Bang env.identifier_info  in
        FStar_TypeChecker_Common.id_info_toggle uu____10466 enabled  in
      FStar_ST.op_Colon_Equals env.identifier_info uu____10465
  
let (insert_bv_info :
  env -> FStar_Syntax_Syntax.bv -> FStar_Syntax_Syntax.typ -> unit) =
  fun env  ->
    fun bv  ->
      fun ty  ->
        let uu____10528 =
          let uu____10529 = FStar_ST.op_Bang env.identifier_info  in
          FStar_TypeChecker_Common.id_info_insert_bv uu____10529 bv ty  in
        FStar_ST.op_Colon_Equals env.identifier_info uu____10528
  
let (insert_fv_info :
  env -> FStar_Syntax_Syntax.fv -> FStar_Syntax_Syntax.typ -> unit) =
  fun env  ->
    fun fv  ->
      fun ty  ->
        let uu____10591 =
          let uu____10592 = FStar_ST.op_Bang env.identifier_info  in
          FStar_TypeChecker_Common.id_info_insert_fv uu____10592 fv ty  in
        FStar_ST.op_Colon_Equals env.identifier_info uu____10591
  
let (promote_id_info :
  env -> (FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ) -> unit) =
  fun env  ->
    fun ty_map  ->
      let uu____10654 =
        let uu____10655 = FStar_ST.op_Bang env.identifier_info  in
        FStar_TypeChecker_Common.id_info_promote uu____10655 ty_map  in
      FStar_ST.op_Colon_Equals env.identifier_info uu____10654
  
let (modules : env -> FStar_Syntax_Syntax.modul Prims.list) =
  fun env  -> env.modules 
let (current_module : env -> FStar_Ident.lident) = fun env  -> env.curmodule 
let (set_current_module : env -> FStar_Ident.lident -> env) =
  fun env  ->
    fun lid  ->
      let uu___243_10724 = env  in
      {
        solver = (uu___243_10724.solver);
        range = (uu___243_10724.range);
        curmodule = lid;
        gamma = (uu___243_10724.gamma);
        gamma_sig = (uu___243_10724.gamma_sig);
        gamma_cache = (uu___243_10724.gamma_cache);
        modules = (uu___243_10724.modules);
        expected_typ = (uu___243_10724.expected_typ);
        sigtab = (uu___243_10724.sigtab);
        is_pattern = (uu___243_10724.is_pattern);
        instantiate_imp = (uu___243_10724.instantiate_imp);
        effects = (uu___243_10724.effects);
        generalize = (uu___243_10724.generalize);
        letrecs = (uu___243_10724.letrecs);
        top_level = (uu___243_10724.top_level);
        check_uvars = (uu___243_10724.check_uvars);
        use_eq = (uu___243_10724.use_eq);
        is_iface = (uu___243_10724.is_iface);
        admit = (uu___243_10724.admit);
        lax = (uu___243_10724.lax);
        lax_universes = (uu___243_10724.lax_universes);
        phase1 = (uu___243_10724.phase1);
        failhard = (uu___243_10724.failhard);
        nosynth = (uu___243_10724.nosynth);
        uvar_subtyping = (uu___243_10724.uvar_subtyping);
        weaken_comp_tys = (uu___243_10724.weaken_comp_tys);
        tc_term = (uu___243_10724.tc_term);
        type_of = (uu___243_10724.type_of);
        universe_of = (uu___243_10724.universe_of);
        check_type_of = (uu___243_10724.check_type_of);
        use_bv_sorts = (uu___243_10724.use_bv_sorts);
        qtbl_name_and_index = (uu___243_10724.qtbl_name_and_index);
        normalized_eff_names = (uu___243_10724.normalized_eff_names);
        proof_ns = (uu___243_10724.proof_ns);
        synth_hook = (uu___243_10724.synth_hook);
        splice = (uu___243_10724.splice);
        is_native_tactic = (uu___243_10724.is_native_tactic);
        identifier_info = (uu___243_10724.identifier_info);
        tc_hooks = (uu___243_10724.tc_hooks);
        dsenv = (uu___243_10724.dsenv);
        dep_graph = (uu___243_10724.dep_graph)
      }
  
let (has_interface : env -> FStar_Ident.lident -> Prims.bool) =
  fun env  ->
    fun l  ->
      FStar_All.pipe_right env.modules
        (FStar_Util.for_some
           (fun m  ->
              m.FStar_Syntax_Syntax.is_interface &&
                (FStar_Ident.lid_equals m.FStar_Syntax_Syntax.name l)))
  
let (find_in_sigtab :
  env ->
    FStar_Ident.lident ->
      FStar_Syntax_Syntax.sigelt FStar_Pervasives_Native.option)
  =
  fun env  ->
    fun lid  ->
      let uu____10751 = FStar_Ident.text_of_lid lid  in
      FStar_Util.smap_try_find (sigtab env) uu____10751
  
let (name_not_found :
  FStar_Ident.lid ->
    (FStar_Errors.raw_error,Prims.string) FStar_Pervasives_Native.tuple2)
  =
  fun l  ->
    let uu____10761 =
      FStar_Util.format1 "Name \"%s\" not found" l.FStar_Ident.str  in
    (FStar_Errors.Fatal_NameNotFound, uu____10761)
  
let (variable_not_found :
  FStar_Syntax_Syntax.bv ->
    (FStar_Errors.raw_error,Prims.string) FStar_Pervasives_Native.tuple2)
  =
  fun v1  ->
    let uu____10771 =
      let uu____10772 = FStar_Syntax_Print.bv_to_string v1  in
      FStar_Util.format1 "Variable \"%s\" not found" uu____10772  in
    (FStar_Errors.Fatal_VariableNotFound, uu____10771)
  
let (new_u_univ : unit -> FStar_Syntax_Syntax.universe) =
  fun uu____10777  ->
    let uu____10778 = FStar_Syntax_Unionfind.univ_fresh ()  in
    FStar_Syntax_Syntax.U_unif uu____10778
  
let (inst_tscheme_with :
  FStar_Syntax_Syntax.tscheme ->
    FStar_Syntax_Syntax.universes ->
      (FStar_Syntax_Syntax.universes,FStar_Syntax_Syntax.term)
        FStar_Pervasives_Native.tuple2)
  =
  fun ts  ->
    fun us  ->
      match (ts, us) with
      | (([],t),[]) -> ([], t)
      | ((formals,t),uu____10834) ->
          let n1 = (FStar_List.length formals) - (Prims.parse_int "1")  in
          let vs =
            FStar_All.pipe_right us
              (FStar_List.mapi
                 (fun i  -> fun u  -> FStar_Syntax_Syntax.UN ((n1 - i), u)))
             in
          let uu____10868 = FStar_Syntax_Subst.subst vs t  in
          (us, uu____10868)
  
let (inst_tscheme :
  FStar_Syntax_Syntax.tscheme ->
    (FStar_Syntax_Syntax.universes,FStar_Syntax_Syntax.term)
      FStar_Pervasives_Native.tuple2)
  =
  fun uu___221_10884  ->
    match uu___221_10884 with
    | ([],t) -> ([], t)
    | (us,t) ->
        let us' =
          FStar_All.pipe_right us
            (FStar_List.map (fun uu____10910  -> new_u_univ ()))
           in
        inst_tscheme_with (us, t) us'
  
let (inst_tscheme_with_range :
  FStar_Range.range ->
    FStar_Syntax_Syntax.tscheme ->
      (FStar_Syntax_Syntax.universes,FStar_Syntax_Syntax.term)
        FStar_Pervasives_Native.tuple2)
  =
  fun r  ->
    fun t  ->
      let uu____10929 = inst_tscheme t  in
      match uu____10929 with
      | (us,t1) ->
          let uu____10940 = FStar_Syntax_Subst.set_use_range r t1  in
          (us, uu____10940)
  
let (inst_effect_fun_with :
  FStar_Syntax_Syntax.universes ->
    env ->
      FStar_Syntax_Syntax.eff_decl ->
        FStar_Syntax_Syntax.tscheme -> FStar_Syntax_Syntax.term)
  =
  fun insts  ->
    fun env  ->
      fun ed  ->
        fun uu____10960  ->
          match uu____10960 with
          | (us,t) ->
              (match ed.FStar_Syntax_Syntax.binders with
               | [] ->
                   let univs1 =
                     FStar_List.append ed.FStar_Syntax_Syntax.univs us  in
                   (if
                      (FStar_List.length insts) <> (FStar_List.length univs1)
                    then
                      (let uu____10979 =
                         let uu____10980 =
                           FStar_All.pipe_left FStar_Util.string_of_int
                             (FStar_List.length univs1)
                            in
                         let uu____10981 =
                           FStar_All.pipe_left FStar_Util.string_of_int
                             (FStar_List.length insts)
                            in
                         let uu____10982 =
                           FStar_Syntax_Print.lid_to_string
                             ed.FStar_Syntax_Syntax.mname
                            in
                         let uu____10983 =
                           FStar_Syntax_Print.term_to_string t  in
                         FStar_Util.format4
                           "Expected %s instantiations; got %s; failed universe instantiation in effect %s\n\t%s\n"
                           uu____10980 uu____10981 uu____10982 uu____10983
                          in
                       failwith uu____10979)
                    else ();
                    (let uu____10985 =
                       inst_tscheme_with
                         ((FStar_List.append ed.FStar_Syntax_Syntax.univs us),
                           t) insts
                        in
                     FStar_Pervasives_Native.snd uu____10985))
               | uu____10994 ->
                   let uu____10995 =
                     let uu____10996 =
                       FStar_Syntax_Print.lid_to_string
                         ed.FStar_Syntax_Syntax.mname
                        in
                     FStar_Util.format1
                       "Unexpected use of an uninstantiated effect: %s\n"
                       uu____10996
                      in
                   failwith uu____10995)
  
type tri =
  | Yes 
  | No 
  | Maybe 
let (uu___is_Yes : tri -> Prims.bool) =
  fun projectee  ->
    match projectee with | Yes  -> true | uu____11002 -> false
  
let (uu___is_No : tri -> Prims.bool) =
  fun projectee  -> match projectee with | No  -> true | uu____11008 -> false 
let (uu___is_Maybe : tri -> Prims.bool) =
  fun projectee  ->
    match projectee with | Maybe  -> true | uu____11014 -> false
  
let (in_cur_mod : env -> FStar_Ident.lident -> tri) =
  fun env  ->
    fun l  ->
      let cur = current_module env  in
      if l.FStar_Ident.nsstr = cur.FStar_Ident.str
      then Yes
      else
        if FStar_Util.starts_with l.FStar_Ident.nsstr cur.FStar_Ident.str
        then
          (let lns = FStar_List.append l.FStar_Ident.ns [l.FStar_Ident.ident]
              in
           let cur1 =
             FStar_List.append cur.FStar_Ident.ns [cur.FStar_Ident.ident]  in
           let rec aux c l1 =
             match (c, l1) with
             | ([],uu____11056) -> Maybe
             | (uu____11063,[]) -> No
             | (hd1::tl1,hd'::tl') when
                 hd1.FStar_Ident.idText = hd'.FStar_Ident.idText ->
                 aux tl1 tl'
             | uu____11082 -> No  in
           aux cur1 lns)
        else No
  
type qninfo =
  (((FStar_Syntax_Syntax.universes,FStar_Syntax_Syntax.typ)
      FStar_Pervasives_Native.tuple2,(FStar_Syntax_Syntax.sigelt,FStar_Syntax_Syntax.universes
                                                                   FStar_Pervasives_Native.option)
                                       FStar_Pervasives_Native.tuple2)
     FStar_Util.either,FStar_Range.range)
    FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option
let (lookup_qname : env -> FStar_Ident.lident -> qninfo) =
  fun env  ->
    fun lid  ->
      let cur_mod = in_cur_mod env lid  in
      let cache t =
        FStar_Util.smap_add (gamma_cache env) lid.FStar_Ident.str t;
        FStar_Pervasives_Native.Some t  in
      let found =
        if cur_mod <> No
        then
          let uu____11173 =
            FStar_Util.smap_try_find (gamma_cache env) lid.FStar_Ident.str
             in
          match uu____11173 with
          | FStar_Pervasives_Native.None  ->
              let uu____11196 =
                FStar_Util.find_map env.gamma
                  (fun uu___222_11240  ->
                     match uu___222_11240 with
                     | FStar_Syntax_Syntax.Binding_lid (l,t) ->
                         let uu____11279 = FStar_Ident.lid_equals lid l  in
                         if uu____11279
                         then
                           let uu____11300 =
                             let uu____11319 =
                               let uu____11334 = inst_tscheme t  in
                               FStar_Util.Inl uu____11334  in
                             let uu____11349 = FStar_Ident.range_of_lid l  in
                             (uu____11319, uu____11349)  in
                           FStar_Pervasives_Native.Some uu____11300
                         else FStar_Pervasives_Native.None
                     | uu____11401 -> FStar_Pervasives_Native.None)
                 in
              FStar_Util.catch_opt uu____11196
                (fun uu____11439  ->
                   FStar_Util.find_map env.gamma_sig
                     (fun uu___223_11448  ->
                        match uu___223_11448 with
                        | (uu____11451,{
                                         FStar_Syntax_Syntax.sigel =
                                           FStar_Syntax_Syntax.Sig_bundle
                                           (ses,uu____11453);
                                         FStar_Syntax_Syntax.sigrng =
                                           uu____11454;
                                         FStar_Syntax_Syntax.sigquals =
                                           uu____11455;
                                         FStar_Syntax_Syntax.sigmeta =
                                           uu____11456;
                                         FStar_Syntax_Syntax.sigattrs =
                                           uu____11457;_})
                            ->
                            FStar_Util.find_map ses
                              (fun se  ->
                                 let uu____11477 =
                                   FStar_All.pipe_right
                                     (FStar_Syntax_Util.lids_of_sigelt se)
                                     (FStar_Util.for_some
                                        (FStar_Ident.lid_equals lid))
                                    in
                                 if uu____11477
                                 then
                                   cache
                                     ((FStar_Util.Inr
                                         (se, FStar_Pervasives_Native.None)),
                                       (FStar_Syntax_Util.range_of_sigelt se))
                                 else FStar_Pervasives_Native.None)
                        | (lids,s) ->
                            let maybe_cache t =
                              match s.FStar_Syntax_Syntax.sigel with
                              | FStar_Syntax_Syntax.Sig_declare_typ
                                  uu____11525 ->
                                  FStar_Pervasives_Native.Some t
                              | uu____11532 -> cache t  in
                            let uu____11533 =
                              FStar_List.tryFind (FStar_Ident.lid_equals lid)
                                lids
                               in
                            (match uu____11533 with
                             | FStar_Pervasives_Native.None  ->
                                 FStar_Pervasives_Native.None
                             | FStar_Pervasives_Native.Some l ->
                                 let uu____11539 =
                                   let uu____11540 =
                                     FStar_Ident.range_of_lid l  in
                                   ((FStar_Util.Inr
                                       (s, FStar_Pervasives_Native.None)),
                                     uu____11540)
                                    in
                                 maybe_cache uu____11539)))
          | se -> se
        else FStar_Pervasives_Native.None  in
      if FStar_Util.is_some found
      then found
      else
        (let uu____11608 = find_in_sigtab env lid  in
         match uu____11608 with
         | FStar_Pervasives_Native.Some se ->
             FStar_Pervasives_Native.Some
               ((FStar_Util.Inr (se, FStar_Pervasives_Native.None)),
                 (FStar_Syntax_Util.range_of_sigelt se))
         | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.None)
  
let rec (add_sigelt : env -> FStar_Syntax_Syntax.sigelt -> unit) =
  fun env  ->
    fun se  ->
      match se.FStar_Syntax_Syntax.sigel with
      | FStar_Syntax_Syntax.Sig_bundle (ses,uu____11695) ->
          add_sigelts env ses
      | uu____11704 ->
          let lids = FStar_Syntax_Util.lids_of_sigelt se  in
          (FStar_List.iter
             (fun l  -> FStar_Util.smap_add (sigtab env) l.FStar_Ident.str se)
             lids;
           (match se.FStar_Syntax_Syntax.sigel with
            | FStar_Syntax_Syntax.Sig_new_effect ne ->
                FStar_All.pipe_right ne.FStar_Syntax_Syntax.actions
                  (FStar_List.iter
                     (fun a  ->
                        let se_let =
                          FStar_Syntax_Util.action_as_lb
                            ne.FStar_Syntax_Syntax.mname a
                            (a.FStar_Syntax_Syntax.action_defn).FStar_Syntax_Syntax.pos
                           in
                        FStar_Util.smap_add (sigtab env)
                          (a.FStar_Syntax_Syntax.action_name).FStar_Ident.str
                          se_let))
            | uu____11718 -> ()))

and (add_sigelts : env -> FStar_Syntax_Syntax.sigelt Prims.list -> unit) =
  fun env  ->
    fun ses  -> FStar_All.pipe_right ses (FStar_List.iter (add_sigelt env))

let (try_lookup_bv :
  env ->
    FStar_Syntax_Syntax.bv ->
      (FStar_Syntax_Syntax.typ,FStar_Range.range)
        FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun env  ->
    fun bv  ->
      FStar_Util.find_map env.gamma
        (fun uu___224_11749  ->
           match uu___224_11749 with
           | FStar_Syntax_Syntax.Binding_var id1 when
               FStar_Syntax_Syntax.bv_eq id1 bv ->
               FStar_Pervasives_Native.Some
                 ((id1.FStar_Syntax_Syntax.sort),
                   ((id1.FStar_Syntax_Syntax.ppname).FStar_Ident.idRange))
           | uu____11767 -> FStar_Pervasives_Native.None)
  
let (lookup_type_of_let :
  FStar_Syntax_Syntax.universes FStar_Pervasives_Native.option ->
    FStar_Syntax_Syntax.sigelt ->
      FStar_Ident.lident ->
        ((FStar_Syntax_Syntax.universes,FStar_Syntax_Syntax.term)
           FStar_Pervasives_Native.tuple2,FStar_Range.range)
          FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun us_opt  ->
    fun se  ->
      fun lid  ->
        let inst_tscheme1 ts =
          match us_opt with
          | FStar_Pervasives_Native.None  -> inst_tscheme ts
          | FStar_Pervasives_Native.Some us -> inst_tscheme_with ts us  in
        match se.FStar_Syntax_Syntax.sigel with
        | FStar_Syntax_Syntax.Sig_let ((uu____11828,lb::[]),uu____11830) ->
            let uu____11837 =
              let uu____11846 =
                inst_tscheme1
                  ((lb.FStar_Syntax_Syntax.lbunivs),
                    (lb.FStar_Syntax_Syntax.lbtyp))
                 in
              let uu____11855 =
                FStar_Syntax_Syntax.range_of_lbname
                  lb.FStar_Syntax_Syntax.lbname
                 in
              (uu____11846, uu____11855)  in
            FStar_Pervasives_Native.Some uu____11837
        | FStar_Syntax_Syntax.Sig_let ((uu____11868,lbs),uu____11870) ->
            FStar_Util.find_map lbs
              (fun lb  ->
                 match lb.FStar_Syntax_Syntax.lbname with
                 | FStar_Util.Inl uu____11900 -> failwith "impossible"
                 | FStar_Util.Inr fv ->
                     let uu____11912 = FStar_Syntax_Syntax.fv_eq_lid fv lid
                        in
                     if uu____11912
                     then
                       let uu____11923 =
                         let uu____11932 =
                           inst_tscheme1
                             ((lb.FStar_Syntax_Syntax.lbunivs),
                               (lb.FStar_Syntax_Syntax.lbtyp))
                            in
                         let uu____11941 = FStar_Syntax_Syntax.range_of_fv fv
                            in
                         (uu____11932, uu____11941)  in
                       FStar_Pervasives_Native.Some uu____11923
                     else FStar_Pervasives_Native.None)
        | uu____11963 -> FStar_Pervasives_Native.None
  
let (effect_signature :
  FStar_Syntax_Syntax.universes FStar_Pervasives_Native.option ->
    FStar_Syntax_Syntax.sigelt ->
      ((FStar_Syntax_Syntax.universes,FStar_Syntax_Syntax.term)
         FStar_Pervasives_Native.tuple2,FStar_Range.range)
        FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun us_opt  ->
    fun se  ->
      let inst_tscheme1 ts =
        match us_opt with
        | FStar_Pervasives_Native.None  -> inst_tscheme ts
        | FStar_Pervasives_Native.Some us -> inst_tscheme_with ts us  in
      match se.FStar_Syntax_Syntax.sigel with
      | FStar_Syntax_Syntax.Sig_new_effect ne ->
          let uu____12022 =
            let uu____12031 =
              let uu____12036 =
                let uu____12037 =
                  let uu____12040 =
                    FStar_Syntax_Syntax.mk_Total
                      ne.FStar_Syntax_Syntax.signature
                     in
                  FStar_Syntax_Util.arrow ne.FStar_Syntax_Syntax.binders
                    uu____12040
                   in
                ((ne.FStar_Syntax_Syntax.univs), uu____12037)  in
              inst_tscheme1 uu____12036  in
            (uu____12031, (se.FStar_Syntax_Syntax.sigrng))  in
          FStar_Pervasives_Native.Some uu____12022
      | FStar_Syntax_Syntax.Sig_effect_abbrev
          (lid,us,binders,uu____12062,uu____12063) ->
          let uu____12068 =
            let uu____12077 =
              let uu____12082 =
                let uu____12083 =
                  let uu____12086 =
                    FStar_Syntax_Syntax.mk_Total FStar_Syntax_Syntax.teff  in
                  FStar_Syntax_Util.arrow binders uu____12086  in
                (us, uu____12083)  in
              inst_tscheme1 uu____12082  in
            (uu____12077, (se.FStar_Syntax_Syntax.sigrng))  in
          FStar_Pervasives_Native.Some uu____12068
      | uu____12105 -> FStar_Pervasives_Native.None
  
let (try_lookup_lid_aux :
  FStar_Syntax_Syntax.universes FStar_Pervasives_Native.option ->
    env ->
      FStar_Ident.lident ->
        ((FStar_Syntax_Syntax.universes,FStar_Syntax_Syntax.term'
                                          FStar_Syntax_Syntax.syntax)
           FStar_Pervasives_Native.tuple2,FStar_Range.range)
          FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun us_opt  ->
    fun env  ->
      fun lid  ->
        let inst_tscheme1 ts =
          match us_opt with
          | FStar_Pervasives_Native.None  -> inst_tscheme ts
          | FStar_Pervasives_Native.Some us -> inst_tscheme_with ts us  in
        let mapper uu____12193 =
          match uu____12193 with
          | (lr,rng) ->
              (match lr with
               | FStar_Util.Inl t -> FStar_Pervasives_Native.Some (t, rng)
               | FStar_Util.Inr
                   ({
                      FStar_Syntax_Syntax.sigel =
                        FStar_Syntax_Syntax.Sig_datacon
                        (uu____12289,uvs,t,uu____12292,uu____12293,uu____12294);
                      FStar_Syntax_Syntax.sigrng = uu____12295;
                      FStar_Syntax_Syntax.sigquals = uu____12296;
                      FStar_Syntax_Syntax.sigmeta = uu____12297;
                      FStar_Syntax_Syntax.sigattrs = uu____12298;_},FStar_Pervasives_Native.None
                    )
                   ->
                   let uu____12319 =
                     let uu____12328 = inst_tscheme1 (uvs, t)  in
                     (uu____12328, rng)  in
                   FStar_Pervasives_Native.Some uu____12319
               | FStar_Util.Inr
                   ({
                      FStar_Syntax_Syntax.sigel =
                        FStar_Syntax_Syntax.Sig_declare_typ (l,uvs,t);
                      FStar_Syntax_Syntax.sigrng = uu____12352;
                      FStar_Syntax_Syntax.sigquals = qs;
                      FStar_Syntax_Syntax.sigmeta = uu____12354;
                      FStar_Syntax_Syntax.sigattrs = uu____12355;_},FStar_Pervasives_Native.None
                    )
                   ->
                   let uu____12372 =
                     let uu____12373 = in_cur_mod env l  in uu____12373 = Yes
                      in
                   if uu____12372
                   then
                     let uu____12384 =
                       (FStar_All.pipe_right qs
                          (FStar_List.contains FStar_Syntax_Syntax.Assumption))
                         || env.is_iface
                        in
                     (if uu____12384
                      then
                        let uu____12397 =
                          let uu____12406 = inst_tscheme1 (uvs, t)  in
                          (uu____12406, rng)  in
                        FStar_Pervasives_Native.Some uu____12397
                      else FStar_Pervasives_Native.None)
                   else
                     (let uu____12437 =
                        let uu____12446 = inst_tscheme1 (uvs, t)  in
                        (uu____12446, rng)  in
                      FStar_Pervasives_Native.Some uu____12437)
               | FStar_Util.Inr
                   ({
                      FStar_Syntax_Syntax.sigel =
                        FStar_Syntax_Syntax.Sig_inductive_typ
                        (lid1,uvs,tps,k,uu____12471,uu____12472);
                      FStar_Syntax_Syntax.sigrng = uu____12473;
                      FStar_Syntax_Syntax.sigquals = uu____12474;
                      FStar_Syntax_Syntax.sigmeta = uu____12475;
                      FStar_Syntax_Syntax.sigattrs = uu____12476;_},FStar_Pervasives_Native.None
                    )
                   ->
                   (match tps with
                    | [] ->
                        let uu____12515 =
                          let uu____12524 = inst_tscheme1 (uvs, k)  in
                          (uu____12524, rng)  in
                        FStar_Pervasives_Native.Some uu____12515
                    | uu____12545 ->
                        let uu____12546 =
                          let uu____12555 =
                            let uu____12560 =
                              let uu____12561 =
                                let uu____12564 =
                                  FStar_Syntax_Syntax.mk_Total k  in
                                FStar_Syntax_Util.flat_arrow tps uu____12564
                                 in
                              (uvs, uu____12561)  in
                            inst_tscheme1 uu____12560  in
                          (uu____12555, rng)  in
                        FStar_Pervasives_Native.Some uu____12546)
               | FStar_Util.Inr
                   ({
                      FStar_Syntax_Syntax.sigel =
                        FStar_Syntax_Syntax.Sig_inductive_typ
                        (lid1,uvs,tps,k,uu____12587,uu____12588);
                      FStar_Syntax_Syntax.sigrng = uu____12589;
                      FStar_Syntax_Syntax.sigquals = uu____12590;
                      FStar_Syntax_Syntax.sigmeta = uu____12591;
                      FStar_Syntax_Syntax.sigattrs = uu____12592;_},FStar_Pervasives_Native.Some
                    us)
                   ->
                   (match tps with
                    | [] ->
                        let uu____12632 =
                          let uu____12641 = inst_tscheme_with (uvs, k) us  in
                          (uu____12641, rng)  in
                        FStar_Pervasives_Native.Some uu____12632
                    | uu____12662 ->
                        let uu____12663 =
                          let uu____12672 =
                            let uu____12677 =
                              let uu____12678 =
                                let uu____12681 =
                                  FStar_Syntax_Syntax.mk_Total k  in
                                FStar_Syntax_Util.flat_arrow tps uu____12681
                                 in
                              (uvs, uu____12678)  in
                            inst_tscheme_with uu____12677 us  in
                          (uu____12672, rng)  in
                        FStar_Pervasives_Native.Some uu____12663)
               | FStar_Util.Inr se ->
                   let uu____12717 =
                     match se with
                     | ({
                          FStar_Syntax_Syntax.sigel =
                            FStar_Syntax_Syntax.Sig_let uu____12738;
                          FStar_Syntax_Syntax.sigrng = uu____12739;
                          FStar_Syntax_Syntax.sigquals = uu____12740;
                          FStar_Syntax_Syntax.sigmeta = uu____12741;
                          FStar_Syntax_Syntax.sigattrs = uu____12742;_},FStar_Pervasives_Native.None
                        ) ->
                         lookup_type_of_let us_opt
                           (FStar_Pervasives_Native.fst se) lid
                     | uu____12757 ->
                         effect_signature us_opt
                           (FStar_Pervasives_Native.fst se)
                      in
                   FStar_All.pipe_right uu____12717
                     (FStar_Util.map_option
                        (fun uu____12805  ->
                           match uu____12805 with
                           | (us_t,rng1) -> (us_t, rng1))))
           in
        let uu____12836 =
          let uu____12847 = lookup_qname env lid  in
          FStar_Util.bind_opt uu____12847 mapper  in
        match uu____12836 with
        | FStar_Pervasives_Native.Some ((us,t),r) ->
            let uu____12921 =
              let uu____12932 =
                let uu____12939 =
                  let uu___244_12942 = t  in
                  let uu____12943 = FStar_Ident.range_of_lid lid  in
                  {
                    FStar_Syntax_Syntax.n =
                      (uu___244_12942.FStar_Syntax_Syntax.n);
                    FStar_Syntax_Syntax.pos = uu____12943;
                    FStar_Syntax_Syntax.vars =
                      (uu___244_12942.FStar_Syntax_Syntax.vars)
                  }  in
                (us, uu____12939)  in
              (uu____12932, r)  in
            FStar_Pervasives_Native.Some uu____12921
        | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.None
  
let (lid_exists : env -> FStar_Ident.lident -> Prims.bool) =
  fun env  ->
    fun l  ->
      let uu____12990 = lookup_qname env l  in
      match uu____12990 with
      | FStar_Pervasives_Native.None  -> false
      | FStar_Pervasives_Native.Some uu____13009 -> true
  
let (lookup_bv :
  env ->
    FStar_Syntax_Syntax.bv ->
      (FStar_Syntax_Syntax.typ,FStar_Range.range)
        FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun bv  ->
      let bvr = FStar_Syntax_Syntax.range_of_bv bv  in
      let uu____13061 = try_lookup_bv env bv  in
      match uu____13061 with
      | FStar_Pervasives_Native.None  ->
          let uu____13076 = variable_not_found bv  in
          FStar_Errors.raise_error uu____13076 bvr
      | FStar_Pervasives_Native.Some (t,r) ->
          let uu____13091 = FStar_Syntax_Subst.set_use_range bvr t  in
          let uu____13092 =
            let uu____13093 = FStar_Range.use_range bvr  in
            FStar_Range.set_use_range r uu____13093  in
          (uu____13091, uu____13092)
  
let (try_lookup_lid :
  env ->
    FStar_Ident.lident ->
      ((FStar_Syntax_Syntax.universes,FStar_Syntax_Syntax.typ)
         FStar_Pervasives_Native.tuple2,FStar_Range.range)
        FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun env  ->
    fun l  ->
      let uu____13114 = try_lookup_lid_aux FStar_Pervasives_Native.None env l
         in
      match uu____13114 with
      | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.None
      | FStar_Pervasives_Native.Some ((us,t),r) ->
          let use_range1 = FStar_Ident.range_of_lid l  in
          let r1 =
            let uu____13180 = FStar_Range.use_range use_range1  in
            FStar_Range.set_use_range r uu____13180  in
          let uu____13181 =
            let uu____13190 =
              let uu____13195 = FStar_Syntax_Subst.set_use_range use_range1 t
                 in
              (us, uu____13195)  in
            (uu____13190, r1)  in
          FStar_Pervasives_Native.Some uu____13181
  
let (try_lookup_and_inst_lid :
  env ->
    FStar_Syntax_Syntax.universes ->
      FStar_Ident.lident ->
        (FStar_Syntax_Syntax.typ,FStar_Range.range)
          FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun env  ->
    fun us  ->
      fun l  ->
        let uu____13229 =
          try_lookup_lid_aux (FStar_Pervasives_Native.Some us) env l  in
        match uu____13229 with
        | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.None
        | FStar_Pervasives_Native.Some ((uu____13262,t),r) ->
            let use_range1 = FStar_Ident.range_of_lid l  in
            let r1 =
              let uu____13287 = FStar_Range.use_range use_range1  in
              FStar_Range.set_use_range r uu____13287  in
            let uu____13288 =
              let uu____13293 = FStar_Syntax_Subst.set_use_range use_range1 t
                 in
              (uu____13293, r1)  in
            FStar_Pervasives_Native.Some uu____13288
  
let (lookup_lid :
  env ->
    FStar_Ident.lident ->
      ((FStar_Syntax_Syntax.universes,FStar_Syntax_Syntax.typ)
         FStar_Pervasives_Native.tuple2,FStar_Range.range)
        FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun l  ->
      let uu____13316 = try_lookup_lid env l  in
      match uu____13316 with
      | FStar_Pervasives_Native.None  ->
          let uu____13343 = name_not_found l  in
          let uu____13348 = FStar_Ident.range_of_lid l  in
          FStar_Errors.raise_error uu____13343 uu____13348
      | FStar_Pervasives_Native.Some v1 -> v1
  
let (lookup_univ : env -> FStar_Syntax_Syntax.univ_name -> Prims.bool) =
  fun env  ->
    fun x  ->
      FStar_All.pipe_right
        (FStar_List.find
           (fun uu___225_13388  ->
              match uu___225_13388 with
              | FStar_Syntax_Syntax.Binding_univ y ->
                  x.FStar_Ident.idText = y.FStar_Ident.idText
              | uu____13390 -> false) env.gamma) FStar_Option.isSome
  
let (try_lookup_val_decl :
  env ->
    FStar_Ident.lident ->
      (FStar_Syntax_Syntax.tscheme,FStar_Syntax_Syntax.qualifier Prims.list)
        FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun env  ->
    fun lid  ->
      let uu____13409 = lookup_qname env lid  in
      match uu____13409 with
      | FStar_Pervasives_Native.Some
          (FStar_Util.Inr
           ({
              FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_declare_typ
                (uu____13418,uvs,t);
              FStar_Syntax_Syntax.sigrng = uu____13421;
              FStar_Syntax_Syntax.sigquals = q;
              FStar_Syntax_Syntax.sigmeta = uu____13423;
              FStar_Syntax_Syntax.sigattrs = uu____13424;_},FStar_Pervasives_Native.None
            ),uu____13425)
          ->
          let uu____13474 =
            let uu____13481 =
              let uu____13482 =
                let uu____13485 = FStar_Ident.range_of_lid lid  in
                FStar_Syntax_Subst.set_use_range uu____13485 t  in
              (uvs, uu____13482)  in
            (uu____13481, q)  in
          FStar_Pervasives_Native.Some uu____13474
      | uu____13498 -> FStar_Pervasives_Native.None
  
let (lookup_val_decl :
  env ->
    FStar_Ident.lident ->
      (FStar_Syntax_Syntax.universes,FStar_Syntax_Syntax.typ)
        FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun lid  ->
      let uu____13519 = lookup_qname env lid  in
      match uu____13519 with
      | FStar_Pervasives_Native.Some
          (FStar_Util.Inr
           ({
              FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_declare_typ
                (uu____13524,uvs,t);
              FStar_Syntax_Syntax.sigrng = uu____13527;
              FStar_Syntax_Syntax.sigquals = uu____13528;
              FStar_Syntax_Syntax.sigmeta = uu____13529;
              FStar_Syntax_Syntax.sigattrs = uu____13530;_},FStar_Pervasives_Native.None
            ),uu____13531)
          ->
          let uu____13580 = FStar_Ident.range_of_lid lid  in
          inst_tscheme_with_range uu____13580 (uvs, t)
      | uu____13585 ->
          let uu____13586 = name_not_found lid  in
          let uu____13591 = FStar_Ident.range_of_lid lid  in
          FStar_Errors.raise_error uu____13586 uu____13591
  
let (lookup_datacon :
  env ->
    FStar_Ident.lident ->
      (FStar_Syntax_Syntax.universes,FStar_Syntax_Syntax.typ)
        FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun lid  ->
      let uu____13610 = lookup_qname env lid  in
      match uu____13610 with
      | FStar_Pervasives_Native.Some
          (FStar_Util.Inr
           ({
              FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_datacon
                (uu____13615,uvs,t,uu____13618,uu____13619,uu____13620);
              FStar_Syntax_Syntax.sigrng = uu____13621;
              FStar_Syntax_Syntax.sigquals = uu____13622;
              FStar_Syntax_Syntax.sigmeta = uu____13623;
              FStar_Syntax_Syntax.sigattrs = uu____13624;_},FStar_Pervasives_Native.None
            ),uu____13625)
          ->
          let uu____13678 = FStar_Ident.range_of_lid lid  in
          inst_tscheme_with_range uu____13678 (uvs, t)
      | uu____13683 ->
          let uu____13684 = name_not_found lid  in
          let uu____13689 = FStar_Ident.range_of_lid lid  in
          FStar_Errors.raise_error uu____13684 uu____13689
  
let (datacons_of_typ :
  env ->
    FStar_Ident.lident ->
      (Prims.bool,FStar_Ident.lident Prims.list)
        FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun lid  ->
      let uu____13710 = lookup_qname env lid  in
      match uu____13710 with
      | FStar_Pervasives_Native.Some
          (FStar_Util.Inr
           ({
              FStar_Syntax_Syntax.sigel =
                FStar_Syntax_Syntax.Sig_inductive_typ
                (uu____13717,uu____13718,uu____13719,uu____13720,uu____13721,dcs);
              FStar_Syntax_Syntax.sigrng = uu____13723;
              FStar_Syntax_Syntax.sigquals = uu____13724;
              FStar_Syntax_Syntax.sigmeta = uu____13725;
              FStar_Syntax_Syntax.sigattrs = uu____13726;_},uu____13727),uu____13728)
          -> (true, dcs)
      | uu____13789 -> (false, [])
  
let (typ_of_datacon : env -> FStar_Ident.lident -> FStar_Ident.lident) =
  fun env  ->
    fun lid  ->
      let uu____13802 = lookup_qname env lid  in
      match uu____13802 with
      | FStar_Pervasives_Native.Some
          (FStar_Util.Inr
           ({
              FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_datacon
                (uu____13803,uu____13804,uu____13805,l,uu____13807,uu____13808);
              FStar_Syntax_Syntax.sigrng = uu____13809;
              FStar_Syntax_Syntax.sigquals = uu____13810;
              FStar_Syntax_Syntax.sigmeta = uu____13811;
              FStar_Syntax_Syntax.sigattrs = uu____13812;_},uu____13813),uu____13814)
          -> l
      | uu____13869 ->
          let uu____13870 =
            let uu____13871 = FStar_Syntax_Print.lid_to_string lid  in
            FStar_Util.format1 "Not a datacon: %s" uu____13871  in
          failwith uu____13870
  
let (lookup_definition_qninfo :
  delta_level Prims.list ->
    FStar_Ident.lident ->
      qninfo ->
        (FStar_Syntax_Syntax.univ_names,FStar_Syntax_Syntax.term)
          FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun delta_levels  ->
    fun lid  ->
      fun qninfo  ->
        let visible quals =
          FStar_All.pipe_right delta_levels
            (FStar_Util.for_some
               (fun dl  ->
                  FStar_All.pipe_right quals
                    (FStar_Util.for_some (visible_at dl))))
           in
        match qninfo with
        | FStar_Pervasives_Native.Some
            (FStar_Util.Inr (se,FStar_Pervasives_Native.None ),uu____13920)
            ->
            (match se.FStar_Syntax_Syntax.sigel with
             | FStar_Syntax_Syntax.Sig_let ((uu____13971,lbs),uu____13973)
                 when visible se.FStar_Syntax_Syntax.sigquals ->
                 FStar_Util.find_map lbs
                   (fun lb  ->
                      let fv = FStar_Util.right lb.FStar_Syntax_Syntax.lbname
                         in
                      let uu____13995 = FStar_Syntax_Syntax.fv_eq_lid fv lid
                         in
                      if uu____13995
                      then
                        FStar_Pervasives_Native.Some
                          ((lb.FStar_Syntax_Syntax.lbunivs),
                            (lb.FStar_Syntax_Syntax.lbdef))
                      else FStar_Pervasives_Native.None)
             | uu____14027 -> FStar_Pervasives_Native.None)
        | uu____14032 -> FStar_Pervasives_Native.None
  
let (lookup_definition :
  delta_level Prims.list ->
    env ->
      FStar_Ident.lident ->
        (FStar_Syntax_Syntax.univ_names,FStar_Syntax_Syntax.term)
          FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun delta_levels  ->
    fun env  ->
      fun lid  ->
        let uu____14062 = lookup_qname env lid  in
        FStar_All.pipe_left (lookup_definition_qninfo delta_levels lid)
          uu____14062
  
let (attrs_of_qninfo :
  qninfo ->
    FStar_Syntax_Syntax.attribute Prims.list FStar_Pervasives_Native.option)
  =
  fun qninfo  ->
    match qninfo with
    | FStar_Pervasives_Native.Some
        (FStar_Util.Inr (se,uu____14087),uu____14088) ->
        FStar_Pervasives_Native.Some (se.FStar_Syntax_Syntax.sigattrs)
    | uu____14137 -> FStar_Pervasives_Native.None
  
let (lookup_attrs_of_lid :
  env ->
    FStar_Ident.lid ->
      FStar_Syntax_Syntax.attribute Prims.list FStar_Pervasives_Native.option)
  =
  fun env  ->
    fun lid  ->
      let uu____14158 = lookup_qname env lid  in
      FStar_All.pipe_left attrs_of_qninfo uu____14158
  
let (try_lookup_effect_lid :
  env ->
    FStar_Ident.lident ->
      FStar_Syntax_Syntax.term FStar_Pervasives_Native.option)
  =
  fun env  ->
    fun ftv  ->
      let uu____14177 = lookup_qname env ftv  in
      match uu____14177 with
      | FStar_Pervasives_Native.Some
          (FStar_Util.Inr (se,FStar_Pervasives_Native.None ),uu____14181) ->
          let uu____14226 = effect_signature FStar_Pervasives_Native.None se
             in
          (match uu____14226 with
           | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.None
           | FStar_Pervasives_Native.Some ((uu____14247,t),r) ->
               let uu____14262 =
                 let uu____14263 = FStar_Ident.range_of_lid ftv  in
                 FStar_Syntax_Subst.set_use_range uu____14263 t  in
               FStar_Pervasives_Native.Some uu____14262)
      | uu____14264 -> FStar_Pervasives_Native.None
  
let (lookup_effect_lid :
  env -> FStar_Ident.lident -> FStar_Syntax_Syntax.term) =
  fun env  ->
    fun ftv  ->
      let uu____14275 = try_lookup_effect_lid env ftv  in
      match uu____14275 with
      | FStar_Pervasives_Native.None  ->
          let uu____14278 = name_not_found ftv  in
          let uu____14283 = FStar_Ident.range_of_lid ftv  in
          FStar_Errors.raise_error uu____14278 uu____14283
      | FStar_Pervasives_Native.Some k -> k
  
let (lookup_effect_abbrev :
  env ->
    FStar_Syntax_Syntax.universes ->
      FStar_Ident.lident ->
        (FStar_Syntax_Syntax.binders,FStar_Syntax_Syntax.comp)
          FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun env  ->
    fun univ_insts  ->
      fun lid0  ->
        let uu____14306 = lookup_qname env lid0  in
        match uu____14306 with
        | FStar_Pervasives_Native.Some
            (FStar_Util.Inr
             ({
                FStar_Syntax_Syntax.sigel =
                  FStar_Syntax_Syntax.Sig_effect_abbrev
                  (lid,univs1,binders,c,uu____14317);
                FStar_Syntax_Syntax.sigrng = uu____14318;
                FStar_Syntax_Syntax.sigquals = quals;
                FStar_Syntax_Syntax.sigmeta = uu____14320;
                FStar_Syntax_Syntax.sigattrs = uu____14321;_},FStar_Pervasives_Native.None
              ),uu____14322)
            ->
            let lid1 =
              let uu____14376 =
                let uu____14377 = FStar_Ident.range_of_lid lid  in
                let uu____14378 =
                  let uu____14379 = FStar_Ident.range_of_lid lid0  in
                  FStar_Range.use_range uu____14379  in
                FStar_Range.set_use_range uu____14377 uu____14378  in
              FStar_Ident.set_lid_range lid uu____14376  in
            let uu____14380 =
              FStar_All.pipe_right quals
                (FStar_Util.for_some
                   (fun uu___226_14384  ->
                      match uu___226_14384 with
                      | FStar_Syntax_Syntax.Irreducible  -> true
                      | uu____14385 -> false))
               in
            if uu____14380
            then FStar_Pervasives_Native.None
            else
              (let insts =
                 if
                   (FStar_List.length univ_insts) =
                     (FStar_List.length univs1)
                 then univ_insts
                 else
                   (let uu____14399 =
                      let uu____14400 =
                        let uu____14401 = get_range env  in
                        FStar_Range.string_of_range uu____14401  in
                      let uu____14402 = FStar_Syntax_Print.lid_to_string lid1
                         in
                      let uu____14403 =
                        FStar_All.pipe_right (FStar_List.length univ_insts)
                          FStar_Util.string_of_int
                         in
                      FStar_Util.format3
                        "(%s) Unexpected instantiation of effect %s with %s universes"
                        uu____14400 uu____14402 uu____14403
                       in
                    failwith uu____14399)
                  in
               match (binders, univs1) with
               | ([],uu____14418) ->
                   failwith
                     "Unexpected effect abbreviation with no arguments"
               | (uu____14439,uu____14440::uu____14441::uu____14442) ->
                   let uu____14459 =
                     let uu____14460 = FStar_Syntax_Print.lid_to_string lid1
                        in
                     let uu____14461 =
                       FStar_All.pipe_left FStar_Util.string_of_int
                         (FStar_List.length univs1)
                        in
                     FStar_Util.format2
                       "Unexpected effect abbreviation %s; polymorphic in %s universes"
                       uu____14460 uu____14461
                      in
                   failwith uu____14459
               | uu____14468 ->
                   let uu____14481 =
                     let uu____14486 =
                       let uu____14487 = FStar_Syntax_Util.arrow binders c
                          in
                       (univs1, uu____14487)  in
                     inst_tscheme_with uu____14486 insts  in
                   (match uu____14481 with
                    | (uu____14500,t) ->
                        let t1 =
                          let uu____14503 = FStar_Ident.range_of_lid lid1  in
                          FStar_Syntax_Subst.set_use_range uu____14503 t  in
                        let uu____14504 =
                          let uu____14505 = FStar_Syntax_Subst.compress t1
                             in
                          uu____14505.FStar_Syntax_Syntax.n  in
                        (match uu____14504 with
                         | FStar_Syntax_Syntax.Tm_arrow (binders1,c1) ->
                             FStar_Pervasives_Native.Some (binders1, c1)
                         | uu____14536 -> failwith "Impossible")))
        | uu____14543 -> FStar_Pervasives_Native.None
  
let (norm_eff_name : env -> FStar_Ident.lident -> FStar_Ident.lident) =
  fun env  ->
    fun l  ->
      let rec find1 l1 =
        let uu____14566 =
          lookup_effect_abbrev env [FStar_Syntax_Syntax.U_unknown] l1  in
        match uu____14566 with
        | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.None
        | FStar_Pervasives_Native.Some (uu____14579,c) ->
            let l2 = FStar_Syntax_Util.comp_effect_name c  in
            let uu____14586 = find1 l2  in
            (match uu____14586 with
             | FStar_Pervasives_Native.None  ->
                 FStar_Pervasives_Native.Some l2
             | FStar_Pervasives_Native.Some l' ->
                 FStar_Pervasives_Native.Some l')
         in
      let res =
        let uu____14593 =
          FStar_Util.smap_try_find env.normalized_eff_names l.FStar_Ident.str
           in
        match uu____14593 with
        | FStar_Pervasives_Native.Some l1 -> l1
        | FStar_Pervasives_Native.None  ->
            let uu____14597 = find1 l  in
            (match uu____14597 with
             | FStar_Pervasives_Native.None  -> l
             | FStar_Pervasives_Native.Some m ->
                 (FStar_Util.smap_add env.normalized_eff_names
                    l.FStar_Ident.str m;
                  m))
         in
      let uu____14602 = FStar_Ident.range_of_lid l  in
      FStar_Ident.set_lid_range res uu____14602
  
let (lookup_effect_quals :
  env -> FStar_Ident.lident -> FStar_Syntax_Syntax.qualifier Prims.list) =
  fun env  ->
    fun l  ->
      let l1 = norm_eff_name env l  in
      let uu____14616 = lookup_qname env l1  in
      match uu____14616 with
      | FStar_Pervasives_Native.Some
          (FStar_Util.Inr
           ({
              FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_new_effect
                uu____14619;
              FStar_Syntax_Syntax.sigrng = uu____14620;
              FStar_Syntax_Syntax.sigquals = q;
              FStar_Syntax_Syntax.sigmeta = uu____14622;
              FStar_Syntax_Syntax.sigattrs = uu____14623;_},uu____14624),uu____14625)
          -> q
      | uu____14676 -> []
  
let (lookup_projector :
  env -> FStar_Ident.lident -> Prims.int -> FStar_Ident.lident) =
  fun env  ->
    fun lid  ->
      fun i  ->
        let fail1 uu____14697 =
          let uu____14698 =
            let uu____14699 = FStar_Util.string_of_int i  in
            let uu____14700 = FStar_Syntax_Print.lid_to_string lid  in
            FStar_Util.format2
              "Impossible: projecting field #%s from constructor %s is undefined"
              uu____14699 uu____14700
             in
          failwith uu____14698  in
        let uu____14701 = lookup_datacon env lid  in
        match uu____14701 with
        | (uu____14706,t) ->
            let uu____14708 =
              let uu____14709 = FStar_Syntax_Subst.compress t  in
              uu____14709.FStar_Syntax_Syntax.n  in
            (match uu____14708 with
             | FStar_Syntax_Syntax.Tm_arrow (binders,uu____14713) ->
                 if
                   (i < (Prims.parse_int "0")) ||
                     (i >= (FStar_List.length binders))
                 then fail1 ()
                 else
                   (let b = FStar_List.nth binders i  in
                    let uu____14744 =
                      FStar_Syntax_Util.mk_field_projector_name lid
                        (FStar_Pervasives_Native.fst b) i
                       in
                    FStar_All.pipe_right uu____14744
                      FStar_Pervasives_Native.fst)
             | uu____14753 -> fail1 ())
  
let (is_projector : env -> FStar_Ident.lident -> Prims.bool) =
  fun env  ->
    fun l  ->
      let uu____14764 = lookup_qname env l  in
      match uu____14764 with
      | FStar_Pervasives_Native.Some
          (FStar_Util.Inr
           ({
              FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_declare_typ
                (uu____14765,uu____14766,uu____14767);
              FStar_Syntax_Syntax.sigrng = uu____14768;
              FStar_Syntax_Syntax.sigquals = quals;
              FStar_Syntax_Syntax.sigmeta = uu____14770;
              FStar_Syntax_Syntax.sigattrs = uu____14771;_},uu____14772),uu____14773)
          ->
          FStar_Util.for_some
            (fun uu___227_14826  ->
               match uu___227_14826 with
               | FStar_Syntax_Syntax.Projector uu____14827 -> true
               | uu____14832 -> false) quals
      | uu____14833 -> false
  
let (is_datacon : env -> FStar_Ident.lident -> Prims.bool) =
  fun env  ->
    fun lid  ->
      let uu____14844 = lookup_qname env lid  in
      match uu____14844 with
      | FStar_Pervasives_Native.Some
          (FStar_Util.Inr
           ({
              FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_datacon
                (uu____14845,uu____14846,uu____14847,uu____14848,uu____14849,uu____14850);
              FStar_Syntax_Syntax.sigrng = uu____14851;
              FStar_Syntax_Syntax.sigquals = uu____14852;
              FStar_Syntax_Syntax.sigmeta = uu____14853;
              FStar_Syntax_Syntax.sigattrs = uu____14854;_},uu____14855),uu____14856)
          -> true
      | uu____14911 -> false
  
let (is_record : env -> FStar_Ident.lident -> Prims.bool) =
  fun env  ->
    fun lid  ->
      let uu____14922 = lookup_qname env lid  in
      match uu____14922 with
      | FStar_Pervasives_Native.Some
          (FStar_Util.Inr
           ({
              FStar_Syntax_Syntax.sigel =
                FStar_Syntax_Syntax.Sig_inductive_typ
                (uu____14923,uu____14924,uu____14925,uu____14926,uu____14927,uu____14928);
              FStar_Syntax_Syntax.sigrng = uu____14929;
              FStar_Syntax_Syntax.sigquals = quals;
              FStar_Syntax_Syntax.sigmeta = uu____14931;
              FStar_Syntax_Syntax.sigattrs = uu____14932;_},uu____14933),uu____14934)
          ->
          FStar_Util.for_some
            (fun uu___228_14995  ->
               match uu___228_14995 with
               | FStar_Syntax_Syntax.RecordType uu____14996 -> true
               | FStar_Syntax_Syntax.RecordConstructor uu____15005 -> true
               | uu____15014 -> false) quals
      | uu____15015 -> false
  
let (qninfo_is_action : qninfo -> Prims.bool) =
  fun qninfo  ->
    match qninfo with
    | FStar_Pervasives_Native.Some
        (FStar_Util.Inr
         ({
            FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_let
              (uu____15021,uu____15022);
            FStar_Syntax_Syntax.sigrng = uu____15023;
            FStar_Syntax_Syntax.sigquals = quals;
            FStar_Syntax_Syntax.sigmeta = uu____15025;
            FStar_Syntax_Syntax.sigattrs = uu____15026;_},uu____15027),uu____15028)
        ->
        FStar_Util.for_some
          (fun uu___229_15085  ->
             match uu___229_15085 with
             | FStar_Syntax_Syntax.Action uu____15086 -> true
             | uu____15087 -> false) quals
    | uu____15088 -> false
  
let (is_action : env -> FStar_Ident.lident -> Prims.bool) =
  fun env  ->
    fun lid  ->
      let uu____15099 = lookup_qname env lid  in
      FStar_All.pipe_left qninfo_is_action uu____15099
  
let (is_interpreted : env -> FStar_Syntax_Syntax.term -> Prims.bool) =
  let interpreted_symbols =
    [FStar_Parser_Const.op_Eq;
    FStar_Parser_Const.op_notEq;
    FStar_Parser_Const.op_LT;
    FStar_Parser_Const.op_LTE;
    FStar_Parser_Const.op_GT;
    FStar_Parser_Const.op_GTE;
    FStar_Parser_Const.op_Subtraction;
    FStar_Parser_Const.op_Minus;
    FStar_Parser_Const.op_Addition;
    FStar_Parser_Const.op_Multiply;
    FStar_Parser_Const.op_Division;
    FStar_Parser_Const.op_Modulus;
    FStar_Parser_Const.op_And;
    FStar_Parser_Const.op_Or;
    FStar_Parser_Const.op_Negation]  in
  fun env  ->
    fun head1  ->
      let uu____15113 =
        let uu____15114 = FStar_Syntax_Util.un_uinst head1  in
        uu____15114.FStar_Syntax_Syntax.n  in
      match uu____15113 with
      | FStar_Syntax_Syntax.Tm_fvar fv ->
          (match fv.FStar_Syntax_Syntax.fv_delta with
           | FStar_Syntax_Syntax.Delta_equational_at_level uu____15118 ->
               true
           | uu____15119 -> false)
      | uu____15120 -> false
  
let (is_irreducible : env -> FStar_Ident.lident -> Prims.bool) =
  fun env  ->
    fun l  ->
      let uu____15131 = lookup_qname env l  in
      match uu____15131 with
      | FStar_Pervasives_Native.Some
          (FStar_Util.Inr (se,uu____15133),uu____15134) ->
          FStar_Util.for_some
            (fun uu___230_15182  ->
               match uu___230_15182 with
               | FStar_Syntax_Syntax.Irreducible  -> true
               | uu____15183 -> false) se.FStar_Syntax_Syntax.sigquals
      | uu____15184 -> false
  
let (is_type_constructor : env -> FStar_Ident.lident -> Prims.bool) =
  fun env  ->
    fun lid  ->
      let mapper x =
        match FStar_Pervasives_Native.fst x with
        | FStar_Util.Inl uu____15255 -> FStar_Pervasives_Native.Some false
        | FStar_Util.Inr (se,uu____15271) ->
            (match se.FStar_Syntax_Syntax.sigel with
             | FStar_Syntax_Syntax.Sig_declare_typ uu____15288 ->
                 FStar_Pervasives_Native.Some
                   (FStar_List.contains FStar_Syntax_Syntax.New
                      se.FStar_Syntax_Syntax.sigquals)
             | FStar_Syntax_Syntax.Sig_inductive_typ uu____15295 ->
                 FStar_Pervasives_Native.Some true
             | uu____15312 -> FStar_Pervasives_Native.Some false)
         in
      let uu____15313 =
        let uu____15316 = lookup_qname env lid  in
        FStar_Util.bind_opt uu____15316 mapper  in
      match uu____15313 with
      | FStar_Pervasives_Native.Some b -> b
      | FStar_Pervasives_Native.None  -> false
  
let (num_inductive_ty_params : env -> FStar_Ident.lident -> Prims.int) =
  fun env  ->
    fun lid  ->
      let uu____15366 = lookup_qname env lid  in
      match uu____15366 with
      | FStar_Pervasives_Native.Some
          (FStar_Util.Inr
           ({
              FStar_Syntax_Syntax.sigel =
                FStar_Syntax_Syntax.Sig_inductive_typ
                (uu____15367,uu____15368,tps,uu____15370,uu____15371,uu____15372);
              FStar_Syntax_Syntax.sigrng = uu____15373;
              FStar_Syntax_Syntax.sigquals = uu____15374;
              FStar_Syntax_Syntax.sigmeta = uu____15375;
              FStar_Syntax_Syntax.sigattrs = uu____15376;_},uu____15377),uu____15378)
          -> FStar_List.length tps
      | uu____15441 ->
          let uu____15442 = name_not_found lid  in
          let uu____15447 = FStar_Ident.range_of_lid lid  in
          FStar_Errors.raise_error uu____15442 uu____15447
  
let (effect_decl_opt :
  env ->
    FStar_Ident.lident ->
      (FStar_Syntax_Syntax.eff_decl,FStar_Syntax_Syntax.qualifier Prims.list)
        FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun env  ->
    fun l  ->
      FStar_All.pipe_right (env.effects).decls
        (FStar_Util.find_opt
           (fun uu____15491  ->
              match uu____15491 with
              | (d,uu____15499) ->
                  FStar_Ident.lid_equals d.FStar_Syntax_Syntax.mname l))
  
let (get_effect_decl :
  env -> FStar_Ident.lident -> FStar_Syntax_Syntax.eff_decl) =
  fun env  ->
    fun l  ->
      let uu____15514 = effect_decl_opt env l  in
      match uu____15514 with
      | FStar_Pervasives_Native.None  ->
          let uu____15529 = name_not_found l  in
          let uu____15534 = FStar_Ident.range_of_lid l  in
          FStar_Errors.raise_error uu____15529 uu____15534
      | FStar_Pervasives_Native.Some md -> FStar_Pervasives_Native.fst md
  
let (identity_mlift : mlift) =
  {
    mlift_wp = (fun uu____15556  -> fun t  -> fun wp  -> wp);
    mlift_term =
      (FStar_Pervasives_Native.Some
         (fun uu____15575  ->
            fun t  -> fun wp  -> fun e  -> FStar_Util.return_all e))
  } 
let (join :
  env ->
    FStar_Ident.lident ->
      FStar_Ident.lident ->
        (FStar_Ident.lident,mlift,mlift) FStar_Pervasives_Native.tuple3)
  =
  fun env  ->
    fun l1  ->
      fun l2  ->
        let uu____15606 = FStar_Ident.lid_equals l1 l2  in
        if uu____15606
        then (l1, identity_mlift, identity_mlift)
        else
          (let uu____15614 =
             ((FStar_Ident.lid_equals l1 FStar_Parser_Const.effect_GTot_lid)
                &&
                (FStar_Ident.lid_equals l2 FStar_Parser_Const.effect_Tot_lid))
               ||
               ((FStar_Ident.lid_equals l2 FStar_Parser_Const.effect_GTot_lid)
                  &&
                  (FStar_Ident.lid_equals l1
                     FStar_Parser_Const.effect_Tot_lid))
              in
           if uu____15614
           then
             (FStar_Parser_Const.effect_GTot_lid, identity_mlift,
               identity_mlift)
           else
             (let uu____15622 =
                FStar_All.pipe_right (env.effects).joins
                  (FStar_Util.find_opt
                     (fun uu____15675  ->
                        match uu____15675 with
                        | (m1,m2,uu____15688,uu____15689,uu____15690) ->
                            (FStar_Ident.lid_equals l1 m1) &&
                              (FStar_Ident.lid_equals l2 m2)))
                 in
              match uu____15622 with
              | FStar_Pervasives_Native.None  ->
                  let uu____15707 =
                    let uu____15712 =
                      let uu____15713 = FStar_Syntax_Print.lid_to_string l1
                         in
                      let uu____15714 = FStar_Syntax_Print.lid_to_string l2
                         in
                      FStar_Util.format2
                        "Effects %s and %s cannot be composed" uu____15713
                        uu____15714
                       in
                    (FStar_Errors.Fatal_EffectsCannotBeComposed, uu____15712)
                     in
                  FStar_Errors.raise_error uu____15707 env.range
              | FStar_Pervasives_Native.Some
                  (uu____15721,uu____15722,m3,j1,j2) -> (m3, j1, j2)))
  
let (monad_leq :
  env ->
    FStar_Ident.lident ->
      FStar_Ident.lident -> edge FStar_Pervasives_Native.option)
  =
  fun env  ->
    fun l1  ->
      fun l2  ->
        let uu____15755 =
          (FStar_Ident.lid_equals l1 l2) ||
            ((FStar_Ident.lid_equals l1 FStar_Parser_Const.effect_Tot_lid) &&
               (FStar_Ident.lid_equals l2 FStar_Parser_Const.effect_GTot_lid))
           in
        if uu____15755
        then
          FStar_Pervasives_Native.Some
            { msource = l1; mtarget = l2; mlift = identity_mlift }
        else
          FStar_All.pipe_right (env.effects).order
            (FStar_Util.find_opt
               (fun e  ->
                  (FStar_Ident.lid_equals l1 e.msource) &&
                    (FStar_Ident.lid_equals l2 e.mtarget)))
  
let wp_sig_aux :
  'Auu____15771 .
    (FStar_Syntax_Syntax.eff_decl,'Auu____15771)
      FStar_Pervasives_Native.tuple2 Prims.list ->
      FStar_Ident.lident ->
        (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.term'
                                  FStar_Syntax_Syntax.syntax)
          FStar_Pervasives_Native.tuple2
  =
  fun decls  ->
    fun m  ->
      let uu____15800 =
        FStar_All.pipe_right decls
          (FStar_Util.find_opt
             (fun uu____15826  ->
                match uu____15826 with
                | (d,uu____15832) ->
                    FStar_Ident.lid_equals d.FStar_Syntax_Syntax.mname m))
         in
      match uu____15800 with
      | FStar_Pervasives_Native.None  ->
          let uu____15843 =
            FStar_Util.format1
              "Impossible: declaration for monad %s not found"
              m.FStar_Ident.str
             in
          failwith uu____15843
      | FStar_Pervasives_Native.Some (md,_q) ->
          let uu____15856 =
            inst_tscheme
              ((md.FStar_Syntax_Syntax.univs),
                (md.FStar_Syntax_Syntax.signature))
             in
          (match uu____15856 with
           | (uu____15871,s) ->
               let s1 = FStar_Syntax_Subst.compress s  in
               (match ((md.FStar_Syntax_Syntax.binders),
                        (s1.FStar_Syntax_Syntax.n))
                with
                | ([],FStar_Syntax_Syntax.Tm_arrow
                   ((a,uu____15887)::(wp,uu____15889)::[],c)) when
                    FStar_Syntax_Syntax.is_teff
                      (FStar_Syntax_Util.comp_result c)
                    -> (a, (wp.FStar_Syntax_Syntax.sort))
                | uu____15925 -> failwith "Impossible"))
  
let (wp_signature :
  env ->
    FStar_Ident.lident ->
      (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.term)
        FStar_Pervasives_Native.tuple2)
  = fun env  -> fun m  -> wp_sig_aux (env.effects).decls m 
let (null_wp_for_eff :
  env ->
    FStar_Ident.lident ->
      FStar_Syntax_Syntax.universe ->
        FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.comp)
  =
  fun env  ->
    fun eff_name  ->
      fun res_u  ->
        fun res_t  ->
          let uu____15978 =
            FStar_Ident.lid_equals eff_name FStar_Parser_Const.effect_Tot_lid
             in
          if uu____15978
          then
            FStar_Syntax_Syntax.mk_Total' res_t
              (FStar_Pervasives_Native.Some res_u)
          else
            (let uu____15980 =
               FStar_Ident.lid_equals eff_name
                 FStar_Parser_Const.effect_GTot_lid
                in
             if uu____15980
             then
               FStar_Syntax_Syntax.mk_GTotal' res_t
                 (FStar_Pervasives_Native.Some res_u)
             else
               (let eff_name1 = norm_eff_name env eff_name  in
                let ed = get_effect_decl env eff_name1  in
                let null_wp =
                  inst_effect_fun_with [res_u] env ed
                    ed.FStar_Syntax_Syntax.null_wp
                   in
                let null_wp_res =
                  let uu____15988 = get_range env  in
                  let uu____15989 =
                    let uu____15996 =
                      let uu____15997 =
                        let uu____16012 =
                          let uu____16021 = FStar_Syntax_Syntax.as_arg res_t
                             in
                          [uu____16021]  in
                        (null_wp, uu____16012)  in
                      FStar_Syntax_Syntax.Tm_app uu____15997  in
                    FStar_Syntax_Syntax.mk uu____15996  in
                  uu____15989 FStar_Pervasives_Native.None uu____15988  in
                let uu____16053 =
                  let uu____16054 =
                    let uu____16063 = FStar_Syntax_Syntax.as_arg null_wp_res
                       in
                    [uu____16063]  in
                  {
                    FStar_Syntax_Syntax.comp_univs = [res_u];
                    FStar_Syntax_Syntax.effect_name = eff_name1;
                    FStar_Syntax_Syntax.result_typ = res_t;
                    FStar_Syntax_Syntax.effect_args = uu____16054;
                    FStar_Syntax_Syntax.flags = []
                  }  in
                FStar_Syntax_Syntax.mk_Comp uu____16053))
  
let (build_lattice : env -> FStar_Syntax_Syntax.sigelt -> env) =
  fun env  ->
    fun se  ->
      match se.FStar_Syntax_Syntax.sigel with
      | FStar_Syntax_Syntax.Sig_new_effect ne ->
          let effects =
            let uu___245_16094 = env.effects  in
            {
              decls = ((ne, (se.FStar_Syntax_Syntax.sigquals)) ::
                ((env.effects).decls));
              order = (uu___245_16094.order);
              joins = (uu___245_16094.joins)
            }  in
          let uu___246_16103 = env  in
          {
            solver = (uu___246_16103.solver);
            range = (uu___246_16103.range);
            curmodule = (uu___246_16103.curmodule);
            gamma = (uu___246_16103.gamma);
            gamma_sig = (uu___246_16103.gamma_sig);
            gamma_cache = (uu___246_16103.gamma_cache);
            modules = (uu___246_16103.modules);
            expected_typ = (uu___246_16103.expected_typ);
            sigtab = (uu___246_16103.sigtab);
            is_pattern = (uu___246_16103.is_pattern);
            instantiate_imp = (uu___246_16103.instantiate_imp);
            effects;
            generalize = (uu___246_16103.generalize);
            letrecs = (uu___246_16103.letrecs);
            top_level = (uu___246_16103.top_level);
            check_uvars = (uu___246_16103.check_uvars);
            use_eq = (uu___246_16103.use_eq);
            is_iface = (uu___246_16103.is_iface);
            admit = (uu___246_16103.admit);
            lax = (uu___246_16103.lax);
            lax_universes = (uu___246_16103.lax_universes);
            phase1 = (uu___246_16103.phase1);
            failhard = (uu___246_16103.failhard);
            nosynth = (uu___246_16103.nosynth);
            uvar_subtyping = (uu___246_16103.uvar_subtyping);
            weaken_comp_tys = (uu___246_16103.weaken_comp_tys);
            tc_term = (uu___246_16103.tc_term);
            type_of = (uu___246_16103.type_of);
            universe_of = (uu___246_16103.universe_of);
            check_type_of = (uu___246_16103.check_type_of);
            use_bv_sorts = (uu___246_16103.use_bv_sorts);
            qtbl_name_and_index = (uu___246_16103.qtbl_name_and_index);
            normalized_eff_names = (uu___246_16103.normalized_eff_names);
            proof_ns = (uu___246_16103.proof_ns);
            synth_hook = (uu___246_16103.synth_hook);
            splice = (uu___246_16103.splice);
            is_native_tactic = (uu___246_16103.is_native_tactic);
            identifier_info = (uu___246_16103.identifier_info);
            tc_hooks = (uu___246_16103.tc_hooks);
            dsenv = (uu___246_16103.dsenv);
            dep_graph = (uu___246_16103.dep_graph)
          }
      | FStar_Syntax_Syntax.Sig_sub_effect sub1 ->
          let compose_edges e1 e2 =
            let composed_lift =
              let mlift_wp u r wp1 =
                let uu____16133 = (e1.mlift).mlift_wp u r wp1  in
                (e2.mlift).mlift_wp u r uu____16133  in
              let mlift_term =
                match (((e1.mlift).mlift_term), ((e2.mlift).mlift_term)) with
                | (FStar_Pervasives_Native.Some
                   l1,FStar_Pervasives_Native.Some l2) ->
                    FStar_Pervasives_Native.Some
                      ((fun u  ->
                          fun t  ->
                            fun wp  ->
                              fun e  ->
                                let uu____16291 = (e1.mlift).mlift_wp u t wp
                                   in
                                let uu____16292 = l1 u t wp e  in
                                l2 u t uu____16291 uu____16292))
                | uu____16293 -> FStar_Pervasives_Native.None  in
              { mlift_wp; mlift_term }  in
            {
              msource = (e1.msource);
              mtarget = (e2.mtarget);
              mlift = composed_lift
            }  in
          let mk_mlift_wp lift_t u r wp1 =
            let uu____16365 = inst_tscheme_with lift_t [u]  in
            match uu____16365 with
            | (uu____16372,lift_t1) ->
                let uu____16374 =
                  let uu____16381 =
                    let uu____16382 =
                      let uu____16397 =
                        let uu____16406 = FStar_Syntax_Syntax.as_arg r  in
                        let uu____16413 =
                          let uu____16422 = FStar_Syntax_Syntax.as_arg wp1
                             in
                          [uu____16422]  in
                        uu____16406 :: uu____16413  in
                      (lift_t1, uu____16397)  in
                    FStar_Syntax_Syntax.Tm_app uu____16382  in
                  FStar_Syntax_Syntax.mk uu____16381  in
                uu____16374 FStar_Pervasives_Native.None
                  wp1.FStar_Syntax_Syntax.pos
             in
          let sub_mlift_wp =
            match sub1.FStar_Syntax_Syntax.lift_wp with
            | FStar_Pervasives_Native.Some sub_lift_wp ->
                mk_mlift_wp sub_lift_wp
            | FStar_Pervasives_Native.None  ->
                failwith "sub effect should've been elaborated at this stage"
             in
          let mk_mlift_term lift_t u r wp1 e =
            let uu____16524 = inst_tscheme_with lift_t [u]  in
            match uu____16524 with
            | (uu____16531,lift_t1) ->
                let uu____16533 =
                  let uu____16540 =
                    let uu____16541 =
                      let uu____16556 =
                        let uu____16565 = FStar_Syntax_Syntax.as_arg r  in
                        let uu____16572 =
                          let uu____16581 = FStar_Syntax_Syntax.as_arg wp1
                             in
                          let uu____16588 =
                            let uu____16597 = FStar_Syntax_Syntax.as_arg e
                               in
                            [uu____16597]  in
                          uu____16581 :: uu____16588  in
                        uu____16565 :: uu____16572  in
                      (lift_t1, uu____16556)  in
                    FStar_Syntax_Syntax.Tm_app uu____16541  in
                  FStar_Syntax_Syntax.mk uu____16540  in
                uu____16533 FStar_Pervasives_Native.None
                  e.FStar_Syntax_Syntax.pos
             in
          let sub_mlift_term =
            FStar_Util.map_opt sub1.FStar_Syntax_Syntax.lift mk_mlift_term
             in
          let edge =
            {
              msource = (sub1.FStar_Syntax_Syntax.source);
              mtarget = (sub1.FStar_Syntax_Syntax.target);
              mlift =
                { mlift_wp = sub_mlift_wp; mlift_term = sub_mlift_term }
            }  in
          let id_edge l =
            {
              msource = (sub1.FStar_Syntax_Syntax.source);
              mtarget = (sub1.FStar_Syntax_Syntax.target);
              mlift = identity_mlift
            }  in
          let print_mlift l =
            let bogus_term s =
              let uu____16687 =
                let uu____16688 =
                  FStar_Ident.lid_of_path [s] FStar_Range.dummyRange  in
                FStar_Syntax_Syntax.lid_as_fv uu____16688
                  FStar_Syntax_Syntax.delta_constant
                  FStar_Pervasives_Native.None
                 in
              FStar_Syntax_Syntax.fv_to_tm uu____16687  in
            let arg = bogus_term "ARG"  in
            let wp = bogus_term "WP"  in
            let e = bogus_term "COMP"  in
            let uu____16692 =
              let uu____16693 = l.mlift_wp FStar_Syntax_Syntax.U_zero arg wp
                 in
              FStar_Syntax_Print.term_to_string uu____16693  in
            let uu____16694 =
              let uu____16695 =
                FStar_Util.map_opt l.mlift_term
                  (fun l1  ->
                     let uu____16721 = l1 FStar_Syntax_Syntax.U_zero arg wp e
                        in
                     FStar_Syntax_Print.term_to_string uu____16721)
                 in
              FStar_Util.dflt "none" uu____16695  in
            FStar_Util.format2 "{ wp : %s ; term : %s }" uu____16692
              uu____16694
             in
          let order = edge :: ((env.effects).order)  in
          let ms =
            FStar_All.pipe_right (env.effects).decls
              (FStar_List.map
                 (fun uu____16747  ->
                    match uu____16747 with
                    | (e,uu____16755) -> e.FStar_Syntax_Syntax.mname))
             in
          let find_edge order1 uu____16778 =
            match uu____16778 with
            | (i,j) ->
                let uu____16789 = FStar_Ident.lid_equals i j  in
                if uu____16789
                then
                  FStar_All.pipe_right (id_edge i)
                    (fun _0_16  -> FStar_Pervasives_Native.Some _0_16)
                else
                  FStar_All.pipe_right order1
                    (FStar_Util.find_opt
                       (fun e  ->
                          (FStar_Ident.lid_equals e.msource i) &&
                            (FStar_Ident.lid_equals e.mtarget j)))
             in
          let order1 =
            let fold_fun order1 k =
              let uu____16821 =
                FStar_All.pipe_right ms
                  (FStar_List.collect
                     (fun i  ->
                        let uu____16831 = FStar_Ident.lid_equals i k  in
                        if uu____16831
                        then []
                        else
                          FStar_All.pipe_right ms
                            (FStar_List.collect
                               (fun j  ->
                                  let uu____16842 =
                                    FStar_Ident.lid_equals j k  in
                                  if uu____16842
                                  then []
                                  else
                                    (let uu____16846 =
                                       let uu____16855 =
                                         find_edge order1 (i, k)  in
                                       let uu____16858 =
                                         find_edge order1 (k, j)  in
                                       (uu____16855, uu____16858)  in
                                     match uu____16846 with
                                     | (FStar_Pervasives_Native.Some
                                        e1,FStar_Pervasives_Native.Some e2)
                                         ->
                                         let uu____16873 =
                                           compose_edges e1 e2  in
                                         [uu____16873]
                                     | uu____16874 -> [])))))
                 in
              FStar_List.append order1 uu____16821  in
            FStar_All.pipe_right ms (FStar_List.fold_left fold_fun order)  in
          let order2 =
            FStar_Util.remove_dups
              (fun e1  ->
                 fun e2  ->
                   (FStar_Ident.lid_equals e1.msource e2.msource) &&
                     (FStar_Ident.lid_equals e1.mtarget e2.mtarget)) order1
             in
          (FStar_All.pipe_right order2
             (FStar_List.iter
                (fun edge1  ->
                   let uu____16904 =
                     (FStar_Ident.lid_equals edge1.msource
                        FStar_Parser_Const.effect_DIV_lid)
                       &&
                       (let uu____16906 =
                          lookup_effect_quals env edge1.mtarget  in
                        FStar_All.pipe_right uu____16906
                          (FStar_List.contains
                             FStar_Syntax_Syntax.TotalEffect))
                      in
                   if uu____16904
                   then
                     let uu____16911 =
                       let uu____16916 =
                         FStar_Util.format1
                           "Divergent computations cannot be included in an effect %s marked 'total'"
                           (edge1.mtarget).FStar_Ident.str
                          in
                       (FStar_Errors.Fatal_DivergentComputationCannotBeIncludedInTotal,
                         uu____16916)
                        in
                     let uu____16917 = get_range env  in
                     FStar_Errors.raise_error uu____16911 uu____16917
                   else ()));
           (let joins =
              FStar_All.pipe_right ms
                (FStar_List.collect
                   (fun i  ->
                      FStar_All.pipe_right ms
                        (FStar_List.collect
                           (fun j  ->
                              let join_opt =
                                let uu____16994 = FStar_Ident.lid_equals i j
                                   in
                                if uu____16994
                                then
                                  FStar_Pervasives_Native.Some
                                    (i, (id_edge i), (id_edge i))
                                else
                                  FStar_All.pipe_right ms
                                    (FStar_List.fold_left
                                       (fun bopt  ->
                                          fun k  ->
                                            let uu____17043 =
                                              let uu____17052 =
                                                find_edge order2 (i, k)  in
                                              let uu____17055 =
                                                find_edge order2 (j, k)  in
                                              (uu____17052, uu____17055)  in
                                            match uu____17043 with
                                            | (FStar_Pervasives_Native.Some
                                               ik,FStar_Pervasives_Native.Some
                                               jk) ->
                                                (match bopt with
                                                 | FStar_Pervasives_Native.None
                                                      ->
                                                     FStar_Pervasives_Native.Some
                                                       (k, ik, jk)
                                                 | FStar_Pervasives_Native.Some
                                                     (ub,uu____17097,uu____17098)
                                                     ->
                                                     let uu____17105 =
                                                       let uu____17110 =
                                                         let uu____17111 =
                                                           find_edge order2
                                                             (k, ub)
                                                            in
                                                         FStar_Util.is_some
                                                           uu____17111
                                                          in
                                                       let uu____17114 =
                                                         let uu____17115 =
                                                           find_edge order2
                                                             (ub, k)
                                                            in
                                                         FStar_Util.is_some
                                                           uu____17115
                                                          in
                                                       (uu____17110,
                                                         uu____17114)
                                                        in
                                                     (match uu____17105 with
                                                      | (true ,true ) ->
                                                          let uu____17126 =
                                                            FStar_Ident.lid_equals
                                                              k ub
                                                             in
                                                          if uu____17126
                                                          then
                                                            (FStar_Errors.log_issue
                                                               FStar_Range.dummyRange
                                                               (FStar_Errors.Warning_UpperBoundCandidateAlreadyVisited,
                                                                 "Looking multiple times at the same upper bound candidate");
                                                             bopt)
                                                          else
                                                            failwith
                                                              "Found a cycle in the lattice"
                                                      | (false ,false ) ->
                                                          bopt
                                                      | (true ,false ) ->
                                                          FStar_Pervasives_Native.Some
                                                            (k, ik, jk)
                                                      | (false ,true ) ->
                                                          bopt))
                                            | uu____17151 -> bopt)
                                       FStar_Pervasives_Native.None)
                                 in
                              match join_opt with
                              | FStar_Pervasives_Native.None  -> []
                              | FStar_Pervasives_Native.Some (k,e1,e2) ->
                                  [(i, j, k, (e1.mlift), (e2.mlift))]))))
               in
            let effects =
              let uu___247_17224 = env.effects  in
              { decls = (uu___247_17224.decls); order = order2; joins }  in
            let uu___248_17225 = env  in
            {
              solver = (uu___248_17225.solver);
              range = (uu___248_17225.range);
              curmodule = (uu___248_17225.curmodule);
              gamma = (uu___248_17225.gamma);
              gamma_sig = (uu___248_17225.gamma_sig);
              gamma_cache = (uu___248_17225.gamma_cache);
              modules = (uu___248_17225.modules);
              expected_typ = (uu___248_17225.expected_typ);
              sigtab = (uu___248_17225.sigtab);
              is_pattern = (uu___248_17225.is_pattern);
              instantiate_imp = (uu___248_17225.instantiate_imp);
              effects;
              generalize = (uu___248_17225.generalize);
              letrecs = (uu___248_17225.letrecs);
              top_level = (uu___248_17225.top_level);
              check_uvars = (uu___248_17225.check_uvars);
              use_eq = (uu___248_17225.use_eq);
              is_iface = (uu___248_17225.is_iface);
              admit = (uu___248_17225.admit);
              lax = (uu___248_17225.lax);
              lax_universes = (uu___248_17225.lax_universes);
              phase1 = (uu___248_17225.phase1);
              failhard = (uu___248_17225.failhard);
              nosynth = (uu___248_17225.nosynth);
              uvar_subtyping = (uu___248_17225.uvar_subtyping);
              weaken_comp_tys = (uu___248_17225.weaken_comp_tys);
              tc_term = (uu___248_17225.tc_term);
              type_of = (uu___248_17225.type_of);
              universe_of = (uu___248_17225.universe_of);
              check_type_of = (uu___248_17225.check_type_of);
              use_bv_sorts = (uu___248_17225.use_bv_sorts);
              qtbl_name_and_index = (uu___248_17225.qtbl_name_and_index);
              normalized_eff_names = (uu___248_17225.normalized_eff_names);
              proof_ns = (uu___248_17225.proof_ns);
              synth_hook = (uu___248_17225.synth_hook);
              splice = (uu___248_17225.splice);
              is_native_tactic = (uu___248_17225.is_native_tactic);
              identifier_info = (uu___248_17225.identifier_info);
              tc_hooks = (uu___248_17225.tc_hooks);
              dsenv = (uu___248_17225.dsenv);
              dep_graph = (uu___248_17225.dep_graph)
            }))
      | uu____17226 -> env
  
let (comp_to_comp_typ :
  env -> FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.comp_typ) =
  fun env  ->
    fun c  ->
      let c1 =
        match c.FStar_Syntax_Syntax.n with
        | FStar_Syntax_Syntax.Total (t,FStar_Pervasives_Native.None ) ->
            let u = env.universe_of env t  in
            FStar_Syntax_Syntax.mk_Total' t (FStar_Pervasives_Native.Some u)
        | FStar_Syntax_Syntax.GTotal (t,FStar_Pervasives_Native.None ) ->
            let u = env.universe_of env t  in
            FStar_Syntax_Syntax.mk_GTotal' t (FStar_Pervasives_Native.Some u)
        | uu____17254 -> c  in
      FStar_Syntax_Util.comp_to_comp_typ c1
  
let rec (unfold_effect_abbrev :
  env -> FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.comp_typ) =
  fun env  ->
    fun comp  ->
      let c = comp_to_comp_typ env comp  in
      let uu____17266 =
        lookup_effect_abbrev env c.FStar_Syntax_Syntax.comp_univs
          c.FStar_Syntax_Syntax.effect_name
         in
      match uu____17266 with
      | FStar_Pervasives_Native.None  -> c
      | FStar_Pervasives_Native.Some (binders,cdef) ->
          let uu____17283 = FStar_Syntax_Subst.open_comp binders cdef  in
          (match uu____17283 with
           | (binders1,cdef1) ->
               (if
                  (FStar_List.length binders1) <>
                    ((FStar_List.length c.FStar_Syntax_Syntax.effect_args) +
                       (Prims.parse_int "1"))
                then
                  (let uu____17301 =
                     let uu____17306 =
                       let uu____17307 =
                         FStar_Util.string_of_int
                           (FStar_List.length binders1)
                          in
                       let uu____17312 =
                         FStar_Util.string_of_int
                           ((FStar_List.length
                               c.FStar_Syntax_Syntax.effect_args)
                              + (Prims.parse_int "1"))
                          in
                       let uu____17319 =
                         let uu____17320 = FStar_Syntax_Syntax.mk_Comp c  in
                         FStar_Syntax_Print.comp_to_string uu____17320  in
                       FStar_Util.format3
                         "Effect constructor is not fully applied; expected %s args, got %s args, i.e., %s"
                         uu____17307 uu____17312 uu____17319
                        in
                     (FStar_Errors.Fatal_ConstructorArgLengthMismatch,
                       uu____17306)
                      in
                   FStar_Errors.raise_error uu____17301
                     comp.FStar_Syntax_Syntax.pos)
                else ();
                (let inst1 =
                   let uu____17325 =
                     let uu____17334 =
                       FStar_Syntax_Syntax.as_arg
                         c.FStar_Syntax_Syntax.result_typ
                        in
                     uu____17334 :: (c.FStar_Syntax_Syntax.effect_args)  in
                   FStar_List.map2
                     (fun uu____17363  ->
                        fun uu____17364  ->
                          match (uu____17363, uu____17364) with
                          | ((x,uu____17386),(t,uu____17388)) ->
                              FStar_Syntax_Syntax.NT (x, t)) binders1
                     uu____17325
                    in
                 let c1 = FStar_Syntax_Subst.subst_comp inst1 cdef1  in
                 let c2 =
                   let uu____17407 =
                     let uu___249_17408 = comp_to_comp_typ env c1  in
                     {
                       FStar_Syntax_Syntax.comp_univs =
                         (uu___249_17408.FStar_Syntax_Syntax.comp_univs);
                       FStar_Syntax_Syntax.effect_name =
                         (uu___249_17408.FStar_Syntax_Syntax.effect_name);
                       FStar_Syntax_Syntax.result_typ =
                         (uu___249_17408.FStar_Syntax_Syntax.result_typ);
                       FStar_Syntax_Syntax.effect_args =
                         (uu___249_17408.FStar_Syntax_Syntax.effect_args);
                       FStar_Syntax_Syntax.flags =
                         (c.FStar_Syntax_Syntax.flags)
                     }  in
                   FStar_All.pipe_right uu____17407
                     FStar_Syntax_Syntax.mk_Comp
                    in
                 unfold_effect_abbrev env c2)))
  
let (effect_repr_aux :
  Prims.bool ->
    env ->
      FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.universe ->
          FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
            FStar_Pervasives_Native.option)
  =
  fun only_reifiable  ->
    fun env  ->
      fun c  ->
        fun u_c  ->
          let effect_name =
            norm_eff_name env (FStar_Syntax_Util.comp_effect_name c)  in
          let uu____17438 = effect_decl_opt env effect_name  in
          match uu____17438 with
          | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.None
          | FStar_Pervasives_Native.Some (ed,qualifiers) ->
              let uu____17471 =
                only_reifiable &&
                  (let uu____17473 =
                     FStar_All.pipe_right qualifiers
                       (FStar_List.contains FStar_Syntax_Syntax.Reifiable)
                      in
                   Prims.op_Negation uu____17473)
                 in
              if uu____17471
              then FStar_Pervasives_Native.None
              else
                (match (ed.FStar_Syntax_Syntax.repr).FStar_Syntax_Syntax.n
                 with
                 | FStar_Syntax_Syntax.Tm_unknown  ->
                     FStar_Pervasives_Native.None
                 | uu____17489 ->
                     let c1 = unfold_effect_abbrev env c  in
                     let res_typ = c1.FStar_Syntax_Syntax.result_typ  in
                     let wp =
                       match c1.FStar_Syntax_Syntax.effect_args with
                       | hd1::uu____17508 -> hd1
                       | [] ->
                           let name = FStar_Ident.string_of_lid effect_name
                              in
                           let message =
                             let uu____17537 =
                               FStar_Util.format1
                                 "Not enough arguments for effect %s. " name
                                in
                             Prims.strcat uu____17537
                               (Prims.strcat
                                  "This usually happens when you use a partially applied DM4F effect, "
                                  "like [TAC int] instead of [Tac int].")
                              in
                           let uu____17538 = get_range env  in
                           FStar_Errors.raise_error
                             (FStar_Errors.Fatal_NotEnoughArgumentsForEffect,
                               message) uu____17538
                        in
                     let repr =
                       inst_effect_fun_with [u_c] env ed
                         ([], (ed.FStar_Syntax_Syntax.repr))
                        in
                     let uu____17550 =
                       let uu____17553 = get_range env  in
                       let uu____17554 =
                         let uu____17561 =
                           let uu____17562 =
                             let uu____17577 =
                               let uu____17586 =
                                 FStar_Syntax_Syntax.as_arg res_typ  in
                               [uu____17586; wp]  in
                             (repr, uu____17577)  in
                           FStar_Syntax_Syntax.Tm_app uu____17562  in
                         FStar_Syntax_Syntax.mk uu____17561  in
                       uu____17554 FStar_Pervasives_Native.None uu____17553
                        in
                     FStar_Pervasives_Native.Some uu____17550)
  
let (effect_repr :
  env ->
    FStar_Syntax_Syntax.comp ->
      FStar_Syntax_Syntax.universe ->
        FStar_Syntax_Syntax.term FStar_Pervasives_Native.option)
  = fun env  -> fun c  -> fun u_c  -> effect_repr_aux false env c u_c 
let (reify_comp :
  env ->
    FStar_Syntax_Syntax.comp ->
      FStar_Syntax_Syntax.universe -> FStar_Syntax_Syntax.term)
  =
  fun env  ->
    fun c  ->
      fun u_c  ->
        let no_reify l =
          let uu____17666 =
            let uu____17671 =
              let uu____17672 = FStar_Ident.string_of_lid l  in
              FStar_Util.format1 "Effect %s cannot be reified" uu____17672
               in
            (FStar_Errors.Fatal_EffectCannotBeReified, uu____17671)  in
          let uu____17673 = get_range env  in
          FStar_Errors.raise_error uu____17666 uu____17673  in
        let uu____17674 = effect_repr_aux true env c u_c  in
        match uu____17674 with
        | FStar_Pervasives_Native.None  ->
            no_reify (FStar_Syntax_Util.comp_effect_name c)
        | FStar_Pervasives_Native.Some tm -> tm
  
let (is_reifiable_effect : env -> FStar_Ident.lident -> Prims.bool) =
  fun env  ->
    fun effect_lid  ->
      let quals = lookup_effect_quals env effect_lid  in
      FStar_List.contains FStar_Syntax_Syntax.Reifiable quals
  
let (is_reifiable : env -> FStar_Syntax_Syntax.residual_comp -> Prims.bool) =
  fun env  ->
    fun c  -> is_reifiable_effect env c.FStar_Syntax_Syntax.residual_effect
  
let (is_reifiable_comp : env -> FStar_Syntax_Syntax.comp -> Prims.bool) =
  fun env  ->
    fun c  ->
      match c.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Comp ct ->
          is_reifiable_effect env ct.FStar_Syntax_Syntax.effect_name
      | uu____17720 -> false
  
let (is_reifiable_function : env -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun env  ->
    fun t  ->
      let uu____17731 =
        let uu____17732 = FStar_Syntax_Subst.compress t  in
        uu____17732.FStar_Syntax_Syntax.n  in
      match uu____17731 with
      | FStar_Syntax_Syntax.Tm_arrow (uu____17735,c) ->
          is_reifiable_comp env c
      | uu____17753 -> false
  
let (push_sigelt : env -> FStar_Syntax_Syntax.sigelt -> env) =
  fun env  ->
    fun s  ->
      let sb = ((FStar_Syntax_Util.lids_of_sigelt s), s)  in
      let env1 =
        let uu___250_17774 = env  in
        {
          solver = (uu___250_17774.solver);
          range = (uu___250_17774.range);
          curmodule = (uu___250_17774.curmodule);
          gamma = (uu___250_17774.gamma);
          gamma_sig = (sb :: (env.gamma_sig));
          gamma_cache = (uu___250_17774.gamma_cache);
          modules = (uu___250_17774.modules);
          expected_typ = (uu___250_17774.expected_typ);
          sigtab = (uu___250_17774.sigtab);
          is_pattern = (uu___250_17774.is_pattern);
          instantiate_imp = (uu___250_17774.instantiate_imp);
          effects = (uu___250_17774.effects);
          generalize = (uu___250_17774.generalize);
          letrecs = (uu___250_17774.letrecs);
          top_level = (uu___250_17774.top_level);
          check_uvars = (uu___250_17774.check_uvars);
          use_eq = (uu___250_17774.use_eq);
          is_iface = (uu___250_17774.is_iface);
          admit = (uu___250_17774.admit);
          lax = (uu___250_17774.lax);
          lax_universes = (uu___250_17774.lax_universes);
          phase1 = (uu___250_17774.phase1);
          failhard = (uu___250_17774.failhard);
          nosynth = (uu___250_17774.nosynth);
          uvar_subtyping = (uu___250_17774.uvar_subtyping);
          weaken_comp_tys = (uu___250_17774.weaken_comp_tys);
          tc_term = (uu___250_17774.tc_term);
          type_of = (uu___250_17774.type_of);
          universe_of = (uu___250_17774.universe_of);
          check_type_of = (uu___250_17774.check_type_of);
          use_bv_sorts = (uu___250_17774.use_bv_sorts);
          qtbl_name_and_index = (uu___250_17774.qtbl_name_and_index);
          normalized_eff_names = (uu___250_17774.normalized_eff_names);
          proof_ns = (uu___250_17774.proof_ns);
          synth_hook = (uu___250_17774.synth_hook);
          splice = (uu___250_17774.splice);
          is_native_tactic = (uu___250_17774.is_native_tactic);
          identifier_info = (uu___250_17774.identifier_info);
          tc_hooks = (uu___250_17774.tc_hooks);
          dsenv = (uu___250_17774.dsenv);
          dep_graph = (uu___250_17774.dep_graph)
        }  in
      (env1.tc_hooks).tc_push_in_gamma_hook env1 (FStar_Util.Inr sb);
      build_lattice env1 s
  
let (push_local_binding : env -> FStar_Syntax_Syntax.binding -> env) =
  fun env  ->
    fun b  ->
      let uu___251_17786 = env  in
      {
        solver = (uu___251_17786.solver);
        range = (uu___251_17786.range);
        curmodule = (uu___251_17786.curmodule);
        gamma = (b :: (env.gamma));
        gamma_sig = (uu___251_17786.gamma_sig);
        gamma_cache = (uu___251_17786.gamma_cache);
        modules = (uu___251_17786.modules);
        expected_typ = (uu___251_17786.expected_typ);
        sigtab = (uu___251_17786.sigtab);
        is_pattern = (uu___251_17786.is_pattern);
        instantiate_imp = (uu___251_17786.instantiate_imp);
        effects = (uu___251_17786.effects);
        generalize = (uu___251_17786.generalize);
        letrecs = (uu___251_17786.letrecs);
        top_level = (uu___251_17786.top_level);
        check_uvars = (uu___251_17786.check_uvars);
        use_eq = (uu___251_17786.use_eq);
        is_iface = (uu___251_17786.is_iface);
        admit = (uu___251_17786.admit);
        lax = (uu___251_17786.lax);
        lax_universes = (uu___251_17786.lax_universes);
        phase1 = (uu___251_17786.phase1);
        failhard = (uu___251_17786.failhard);
        nosynth = (uu___251_17786.nosynth);
        uvar_subtyping = (uu___251_17786.uvar_subtyping);
        weaken_comp_tys = (uu___251_17786.weaken_comp_tys);
        tc_term = (uu___251_17786.tc_term);
        type_of = (uu___251_17786.type_of);
        universe_of = (uu___251_17786.universe_of);
        check_type_of = (uu___251_17786.check_type_of);
        use_bv_sorts = (uu___251_17786.use_bv_sorts);
        qtbl_name_and_index = (uu___251_17786.qtbl_name_and_index);
        normalized_eff_names = (uu___251_17786.normalized_eff_names);
        proof_ns = (uu___251_17786.proof_ns);
        synth_hook = (uu___251_17786.synth_hook);
        splice = (uu___251_17786.splice);
        is_native_tactic = (uu___251_17786.is_native_tactic);
        identifier_info = (uu___251_17786.identifier_info);
        tc_hooks = (uu___251_17786.tc_hooks);
        dsenv = (uu___251_17786.dsenv);
        dep_graph = (uu___251_17786.dep_graph)
      }
  
let (push_bv : env -> FStar_Syntax_Syntax.bv -> env) =
  fun env  ->
    fun x  -> push_local_binding env (FStar_Syntax_Syntax.Binding_var x)
  
let (push_bvs : env -> FStar_Syntax_Syntax.bv Prims.list -> env) =
  fun env  ->
    fun bvs  ->
      FStar_List.fold_left (fun env1  -> fun bv  -> push_bv env1 bv) env bvs
  
let (pop_bv :
  env ->
    (FStar_Syntax_Syntax.bv,env) FStar_Pervasives_Native.tuple2
      FStar_Pervasives_Native.option)
  =
  fun env  ->
    match env.gamma with
    | (FStar_Syntax_Syntax.Binding_var x)::rest ->
        FStar_Pervasives_Native.Some
          (x,
            (let uu___252_17841 = env  in
             {
               solver = (uu___252_17841.solver);
               range = (uu___252_17841.range);
               curmodule = (uu___252_17841.curmodule);
               gamma = rest;
               gamma_sig = (uu___252_17841.gamma_sig);
               gamma_cache = (uu___252_17841.gamma_cache);
               modules = (uu___252_17841.modules);
               expected_typ = (uu___252_17841.expected_typ);
               sigtab = (uu___252_17841.sigtab);
               is_pattern = (uu___252_17841.is_pattern);
               instantiate_imp = (uu___252_17841.instantiate_imp);
               effects = (uu___252_17841.effects);
               generalize = (uu___252_17841.generalize);
               letrecs = (uu___252_17841.letrecs);
               top_level = (uu___252_17841.top_level);
               check_uvars = (uu___252_17841.check_uvars);
               use_eq = (uu___252_17841.use_eq);
               is_iface = (uu___252_17841.is_iface);
               admit = (uu___252_17841.admit);
               lax = (uu___252_17841.lax);
               lax_universes = (uu___252_17841.lax_universes);
               phase1 = (uu___252_17841.phase1);
               failhard = (uu___252_17841.failhard);
               nosynth = (uu___252_17841.nosynth);
               uvar_subtyping = (uu___252_17841.uvar_subtyping);
               weaken_comp_tys = (uu___252_17841.weaken_comp_tys);
               tc_term = (uu___252_17841.tc_term);
               type_of = (uu___252_17841.type_of);
               universe_of = (uu___252_17841.universe_of);
               check_type_of = (uu___252_17841.check_type_of);
               use_bv_sorts = (uu___252_17841.use_bv_sorts);
               qtbl_name_and_index = (uu___252_17841.qtbl_name_and_index);
               normalized_eff_names = (uu___252_17841.normalized_eff_names);
               proof_ns = (uu___252_17841.proof_ns);
               synth_hook = (uu___252_17841.synth_hook);
               splice = (uu___252_17841.splice);
               is_native_tactic = (uu___252_17841.is_native_tactic);
               identifier_info = (uu___252_17841.identifier_info);
               tc_hooks = (uu___252_17841.tc_hooks);
               dsenv = (uu___252_17841.dsenv);
               dep_graph = (uu___252_17841.dep_graph)
             }))
    | uu____17842 -> FStar_Pervasives_Native.None
  
let (push_binders : env -> FStar_Syntax_Syntax.binders -> env) =
  fun env  ->
    fun bs  ->
      FStar_List.fold_left
        (fun env1  ->
           fun uu____17868  ->
             match uu____17868 with | (x,uu____17874) -> push_bv env1 x) env
        bs
  
let (binding_of_lb :
  FStar_Syntax_Syntax.lbname ->
    (FStar_Syntax_Syntax.univ_name Prims.list,FStar_Syntax_Syntax.term'
                                                FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple2 -> FStar_Syntax_Syntax.binding)
  =
  fun x  ->
    fun t  ->
      match x with
      | FStar_Util.Inl x1 ->
          let x2 =
            let uu___253_17904 = x1  in
            {
              FStar_Syntax_Syntax.ppname =
                (uu___253_17904.FStar_Syntax_Syntax.ppname);
              FStar_Syntax_Syntax.index =
                (uu___253_17904.FStar_Syntax_Syntax.index);
              FStar_Syntax_Syntax.sort = (FStar_Pervasives_Native.snd t)
            }  in
          FStar_Syntax_Syntax.Binding_var x2
      | FStar_Util.Inr fv ->
          FStar_Syntax_Syntax.Binding_lid
            (((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v), t)
  
let (push_let_binding :
  env -> FStar_Syntax_Syntax.lbname -> FStar_Syntax_Syntax.tscheme -> env) =
  fun env  ->
    fun lb  -> fun ts  -> push_local_binding env (binding_of_lb lb ts)
  
let (push_module : env -> FStar_Syntax_Syntax.modul -> env) =
  fun env  ->
    fun m  ->
      add_sigelts env m.FStar_Syntax_Syntax.exports;
      (let uu___254_17944 = env  in
       {
         solver = (uu___254_17944.solver);
         range = (uu___254_17944.range);
         curmodule = (uu___254_17944.curmodule);
         gamma = [];
         gamma_sig = [];
         gamma_cache = (uu___254_17944.gamma_cache);
         modules = (m :: (env.modules));
         expected_typ = FStar_Pervasives_Native.None;
         sigtab = (uu___254_17944.sigtab);
         is_pattern = (uu___254_17944.is_pattern);
         instantiate_imp = (uu___254_17944.instantiate_imp);
         effects = (uu___254_17944.effects);
         generalize = (uu___254_17944.generalize);
         letrecs = (uu___254_17944.letrecs);
         top_level = (uu___254_17944.top_level);
         check_uvars = (uu___254_17944.check_uvars);
         use_eq = (uu___254_17944.use_eq);
         is_iface = (uu___254_17944.is_iface);
         admit = (uu___254_17944.admit);
         lax = (uu___254_17944.lax);
         lax_universes = (uu___254_17944.lax_universes);
         phase1 = (uu___254_17944.phase1);
         failhard = (uu___254_17944.failhard);
         nosynth = (uu___254_17944.nosynth);
         uvar_subtyping = (uu___254_17944.uvar_subtyping);
         weaken_comp_tys = (uu___254_17944.weaken_comp_tys);
         tc_term = (uu___254_17944.tc_term);
         type_of = (uu___254_17944.type_of);
         universe_of = (uu___254_17944.universe_of);
         check_type_of = (uu___254_17944.check_type_of);
         use_bv_sorts = (uu___254_17944.use_bv_sorts);
         qtbl_name_and_index = (uu___254_17944.qtbl_name_and_index);
         normalized_eff_names = (uu___254_17944.normalized_eff_names);
         proof_ns = (uu___254_17944.proof_ns);
         synth_hook = (uu___254_17944.synth_hook);
         splice = (uu___254_17944.splice);
         is_native_tactic = (uu___254_17944.is_native_tactic);
         identifier_info = (uu___254_17944.identifier_info);
         tc_hooks = (uu___254_17944.tc_hooks);
         dsenv = (uu___254_17944.dsenv);
         dep_graph = (uu___254_17944.dep_graph)
       })
  
let (push_univ_vars : env -> FStar_Syntax_Syntax.univ_names -> env) =
  fun env  ->
    fun xs  ->
      FStar_List.fold_left
        (fun env1  ->
           fun x  ->
             push_local_binding env1 (FStar_Syntax_Syntax.Binding_univ x))
        env xs
  
let (open_universes_in :
  env ->
    FStar_Syntax_Syntax.univ_names ->
      FStar_Syntax_Syntax.term Prims.list ->
        (env,FStar_Syntax_Syntax.univ_names,FStar_Syntax_Syntax.term
                                              Prims.list)
          FStar_Pervasives_Native.tuple3)
  =
  fun env  ->
    fun uvs  ->
      fun terms  ->
        let uu____17986 = FStar_Syntax_Subst.univ_var_opening uvs  in
        match uu____17986 with
        | (univ_subst,univ_vars) ->
            let env' = push_univ_vars env univ_vars  in
            let uu____18014 =
              FStar_List.map (FStar_Syntax_Subst.subst univ_subst) terms  in
            (env', univ_vars, uu____18014)
  
let (set_expected_typ : env -> FStar_Syntax_Syntax.typ -> env) =
  fun env  ->
    fun t  ->
      let uu___255_18029 = env  in
      {
        solver = (uu___255_18029.solver);
        range = (uu___255_18029.range);
        curmodule = (uu___255_18029.curmodule);
        gamma = (uu___255_18029.gamma);
        gamma_sig = (uu___255_18029.gamma_sig);
        gamma_cache = (uu___255_18029.gamma_cache);
        modules = (uu___255_18029.modules);
        expected_typ = (FStar_Pervasives_Native.Some t);
        sigtab = (uu___255_18029.sigtab);
        is_pattern = (uu___255_18029.is_pattern);
        instantiate_imp = (uu___255_18029.instantiate_imp);
        effects = (uu___255_18029.effects);
        generalize = (uu___255_18029.generalize);
        letrecs = (uu___255_18029.letrecs);
        top_level = (uu___255_18029.top_level);
        check_uvars = (uu___255_18029.check_uvars);
        use_eq = false;
        is_iface = (uu___255_18029.is_iface);
        admit = (uu___255_18029.admit);
        lax = (uu___255_18029.lax);
        lax_universes = (uu___255_18029.lax_universes);
        phase1 = (uu___255_18029.phase1);
        failhard = (uu___255_18029.failhard);
        nosynth = (uu___255_18029.nosynth);
        uvar_subtyping = (uu___255_18029.uvar_subtyping);
        weaken_comp_tys = (uu___255_18029.weaken_comp_tys);
        tc_term = (uu___255_18029.tc_term);
        type_of = (uu___255_18029.type_of);
        universe_of = (uu___255_18029.universe_of);
        check_type_of = (uu___255_18029.check_type_of);
        use_bv_sorts = (uu___255_18029.use_bv_sorts);
        qtbl_name_and_index = (uu___255_18029.qtbl_name_and_index);
        normalized_eff_names = (uu___255_18029.normalized_eff_names);
        proof_ns = (uu___255_18029.proof_ns);
        synth_hook = (uu___255_18029.synth_hook);
        splice = (uu___255_18029.splice);
        is_native_tactic = (uu___255_18029.is_native_tactic);
        identifier_info = (uu___255_18029.identifier_info);
        tc_hooks = (uu___255_18029.tc_hooks);
        dsenv = (uu___255_18029.dsenv);
        dep_graph = (uu___255_18029.dep_graph)
      }
  
let (expected_typ :
  env -> FStar_Syntax_Syntax.typ FStar_Pervasives_Native.option) =
  fun env  ->
    match env.expected_typ with
    | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.None
    | FStar_Pervasives_Native.Some t -> FStar_Pervasives_Native.Some t
  
let (clear_expected_typ :
  env ->
    (env,FStar_Syntax_Syntax.typ FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple2)
  =
  fun env_  ->
    let uu____18057 = expected_typ env_  in
    ((let uu___256_18063 = env_  in
      {
        solver = (uu___256_18063.solver);
        range = (uu___256_18063.range);
        curmodule = (uu___256_18063.curmodule);
        gamma = (uu___256_18063.gamma);
        gamma_sig = (uu___256_18063.gamma_sig);
        gamma_cache = (uu___256_18063.gamma_cache);
        modules = (uu___256_18063.modules);
        expected_typ = FStar_Pervasives_Native.None;
        sigtab = (uu___256_18063.sigtab);
        is_pattern = (uu___256_18063.is_pattern);
        instantiate_imp = (uu___256_18063.instantiate_imp);
        effects = (uu___256_18063.effects);
        generalize = (uu___256_18063.generalize);
        letrecs = (uu___256_18063.letrecs);
        top_level = (uu___256_18063.top_level);
        check_uvars = (uu___256_18063.check_uvars);
        use_eq = false;
        is_iface = (uu___256_18063.is_iface);
        admit = (uu___256_18063.admit);
        lax = (uu___256_18063.lax);
        lax_universes = (uu___256_18063.lax_universes);
        phase1 = (uu___256_18063.phase1);
        failhard = (uu___256_18063.failhard);
        nosynth = (uu___256_18063.nosynth);
        uvar_subtyping = (uu___256_18063.uvar_subtyping);
        weaken_comp_tys = (uu___256_18063.weaken_comp_tys);
        tc_term = (uu___256_18063.tc_term);
        type_of = (uu___256_18063.type_of);
        universe_of = (uu___256_18063.universe_of);
        check_type_of = (uu___256_18063.check_type_of);
        use_bv_sorts = (uu___256_18063.use_bv_sorts);
        qtbl_name_and_index = (uu___256_18063.qtbl_name_and_index);
        normalized_eff_names = (uu___256_18063.normalized_eff_names);
        proof_ns = (uu___256_18063.proof_ns);
        synth_hook = (uu___256_18063.synth_hook);
        splice = (uu___256_18063.splice);
        is_native_tactic = (uu___256_18063.is_native_tactic);
        identifier_info = (uu___256_18063.identifier_info);
        tc_hooks = (uu___256_18063.tc_hooks);
        dsenv = (uu___256_18063.dsenv);
        dep_graph = (uu___256_18063.dep_graph)
      }), uu____18057)
  
let (finish_module : env -> FStar_Syntax_Syntax.modul -> env) =
  let empty_lid =
    let uu____18073 =
      let uu____18076 = FStar_Ident.id_of_text ""  in [uu____18076]  in
    FStar_Ident.lid_of_ids uu____18073  in
  fun env  ->
    fun m  ->
      let sigs =
        let uu____18082 =
          FStar_Ident.lid_equals m.FStar_Syntax_Syntax.name
            FStar_Parser_Const.prims_lid
           in
        if uu____18082
        then
          let uu____18085 =
            FStar_All.pipe_right env.gamma_sig
              (FStar_List.map FStar_Pervasives_Native.snd)
             in
          FStar_All.pipe_right uu____18085 FStar_List.rev
        else m.FStar_Syntax_Syntax.exports  in
      add_sigelts env sigs;
      (let uu___257_18112 = env  in
       {
         solver = (uu___257_18112.solver);
         range = (uu___257_18112.range);
         curmodule = empty_lid;
         gamma = [];
         gamma_sig = [];
         gamma_cache = (uu___257_18112.gamma_cache);
         modules = (m :: (env.modules));
         expected_typ = (uu___257_18112.expected_typ);
         sigtab = (uu___257_18112.sigtab);
         is_pattern = (uu___257_18112.is_pattern);
         instantiate_imp = (uu___257_18112.instantiate_imp);
         effects = (uu___257_18112.effects);
         generalize = (uu___257_18112.generalize);
         letrecs = (uu___257_18112.letrecs);
         top_level = (uu___257_18112.top_level);
         check_uvars = (uu___257_18112.check_uvars);
         use_eq = (uu___257_18112.use_eq);
         is_iface = (uu___257_18112.is_iface);
         admit = (uu___257_18112.admit);
         lax = (uu___257_18112.lax);
         lax_universes = (uu___257_18112.lax_universes);
         phase1 = (uu___257_18112.phase1);
         failhard = (uu___257_18112.failhard);
         nosynth = (uu___257_18112.nosynth);
         uvar_subtyping = (uu___257_18112.uvar_subtyping);
         weaken_comp_tys = (uu___257_18112.weaken_comp_tys);
         tc_term = (uu___257_18112.tc_term);
         type_of = (uu___257_18112.type_of);
         universe_of = (uu___257_18112.universe_of);
         check_type_of = (uu___257_18112.check_type_of);
         use_bv_sorts = (uu___257_18112.use_bv_sorts);
         qtbl_name_and_index = (uu___257_18112.qtbl_name_and_index);
         normalized_eff_names = (uu___257_18112.normalized_eff_names);
         proof_ns = (uu___257_18112.proof_ns);
         synth_hook = (uu___257_18112.synth_hook);
         splice = (uu___257_18112.splice);
         is_native_tactic = (uu___257_18112.is_native_tactic);
         identifier_info = (uu___257_18112.identifier_info);
         tc_hooks = (uu___257_18112.tc_hooks);
         dsenv = (uu___257_18112.dsenv);
         dep_graph = (uu___257_18112.dep_graph)
       })
  
let (uvars_in_env : env -> FStar_Syntax_Syntax.uvars) =
  fun env  ->
    let no_uvs = FStar_Syntax_Free.new_uv_set ()  in
    let ext out uvs = FStar_Util.set_union out uvs  in
    let rec aux out g =
      match g with
      | [] -> out
      | (FStar_Syntax_Syntax.Binding_univ uu____18163)::tl1 -> aux out tl1
      | (FStar_Syntax_Syntax.Binding_lid (uu____18167,(uu____18168,t)))::tl1
          ->
          let uu____18189 =
            let uu____18192 = FStar_Syntax_Free.uvars t  in
            ext out uu____18192  in
          aux uu____18189 tl1
      | (FStar_Syntax_Syntax.Binding_var
          { FStar_Syntax_Syntax.ppname = uu____18195;
            FStar_Syntax_Syntax.index = uu____18196;
            FStar_Syntax_Syntax.sort = t;_})::tl1
          ->
          let uu____18203 =
            let uu____18206 = FStar_Syntax_Free.uvars t  in
            ext out uu____18206  in
          aux uu____18203 tl1
       in
    aux no_uvs env.gamma
  
let (univ_vars : env -> FStar_Syntax_Syntax.universe_uvar FStar_Util.set) =
  fun env  ->
    let no_univs = FStar_Syntax_Free.new_universe_uvar_set ()  in
    let ext out uvs = FStar_Util.set_union out uvs  in
    let rec aux out g =
      match g with
      | [] -> out
      | (FStar_Syntax_Syntax.Binding_univ uu____18263)::tl1 -> aux out tl1
      | (FStar_Syntax_Syntax.Binding_lid (uu____18267,(uu____18268,t)))::tl1
          ->
          let uu____18289 =
            let uu____18292 = FStar_Syntax_Free.univs t  in
            ext out uu____18292  in
          aux uu____18289 tl1
      | (FStar_Syntax_Syntax.Binding_var
          { FStar_Syntax_Syntax.ppname = uu____18295;
            FStar_Syntax_Syntax.index = uu____18296;
            FStar_Syntax_Syntax.sort = t;_})::tl1
          ->
          let uu____18303 =
            let uu____18306 = FStar_Syntax_Free.univs t  in
            ext out uu____18306  in
          aux uu____18303 tl1
       in
    aux no_univs env.gamma
  
let (univnames : env -> FStar_Syntax_Syntax.univ_name FStar_Util.set) =
  fun env  ->
    let no_univ_names = FStar_Syntax_Syntax.no_universe_names  in
    let ext out uvs = FStar_Util.set_union out uvs  in
    let rec aux out g =
      match g with
      | [] -> out
      | (FStar_Syntax_Syntax.Binding_univ uname)::tl1 ->
          let uu____18367 = FStar_Util.set_add uname out  in
          aux uu____18367 tl1
      | (FStar_Syntax_Syntax.Binding_lid (uu____18370,(uu____18371,t)))::tl1
          ->
          let uu____18392 =
            let uu____18395 = FStar_Syntax_Free.univnames t  in
            ext out uu____18395  in
          aux uu____18392 tl1
      | (FStar_Syntax_Syntax.Binding_var
          { FStar_Syntax_Syntax.ppname = uu____18398;
            FStar_Syntax_Syntax.index = uu____18399;
            FStar_Syntax_Syntax.sort = t;_})::tl1
          ->
          let uu____18406 =
            let uu____18409 = FStar_Syntax_Free.univnames t  in
            ext out uu____18409  in
          aux uu____18406 tl1
       in
    aux no_univ_names env.gamma
  
let (bound_vars_of_bindings :
  FStar_Syntax_Syntax.binding Prims.list -> FStar_Syntax_Syntax.bv Prims.list)
  =
  fun bs  ->
    FStar_All.pipe_right bs
      (FStar_List.collect
         (fun uu___231_18429  ->
            match uu___231_18429 with
            | FStar_Syntax_Syntax.Binding_var x -> [x]
            | FStar_Syntax_Syntax.Binding_lid uu____18433 -> []
            | FStar_Syntax_Syntax.Binding_univ uu____18446 -> []))
  
let (binders_of_bindings :
  FStar_Syntax_Syntax.binding Prims.list -> FStar_Syntax_Syntax.binders) =
  fun bs  ->
    let uu____18456 =
      let uu____18463 = bound_vars_of_bindings bs  in
      FStar_All.pipe_right uu____18463
        (FStar_List.map FStar_Syntax_Syntax.mk_binder)
       in
    FStar_All.pipe_right uu____18456 FStar_List.rev
  
let (bound_vars : env -> FStar_Syntax_Syntax.bv Prims.list) =
  fun env  -> bound_vars_of_bindings env.gamma 
let (all_binders : env -> FStar_Syntax_Syntax.binders) =
  fun env  -> binders_of_bindings env.gamma 
let (print_gamma : FStar_Syntax_Syntax.gamma -> Prims.string) =
  fun gamma  ->
    let uu____18501 =
      FStar_All.pipe_right gamma
        (FStar_List.map
           (fun uu___232_18511  ->
              match uu___232_18511 with
              | FStar_Syntax_Syntax.Binding_var x ->
                  let uu____18513 = FStar_Syntax_Print.bv_to_string x  in
                  Prims.strcat "Binding_var " uu____18513
              | FStar_Syntax_Syntax.Binding_univ u ->
                  Prims.strcat "Binding_univ " u.FStar_Ident.idText
              | FStar_Syntax_Syntax.Binding_lid (l,uu____18516) ->
                  let uu____18533 = FStar_Ident.string_of_lid l  in
                  Prims.strcat "Binding_lid " uu____18533))
       in
    FStar_All.pipe_right uu____18501 (FStar_String.concat "::\n")
  
let (string_of_delta_level : delta_level -> Prims.string) =
  fun uu___233_18540  ->
    match uu___233_18540 with
    | NoDelta  -> "NoDelta"
    | Inlining  -> "Inlining"
    | Eager_unfolding_only  -> "Eager_unfolding_only"
    | Unfold d ->
        let uu____18542 = FStar_Syntax_Print.delta_depth_to_string d  in
        Prims.strcat "Unfold " uu____18542
  
let (lidents : env -> FStar_Ident.lident Prims.list) =
  fun env  ->
    let keys = FStar_List.collect FStar_Pervasives_Native.fst env.gamma_sig
       in
    FStar_Util.smap_fold (sigtab env)
      (fun uu____18562  ->
         fun v1  ->
           fun keys1  ->
             FStar_List.append (FStar_Syntax_Util.lids_of_sigelt v1) keys1)
      keys
  
let (should_enc_path : env -> Prims.string Prims.list -> Prims.bool) =
  fun env  ->
    fun path  ->
      let rec list_prefix xs ys =
        match (xs, ys) with
        | ([],uu____18604) -> true
        | (x::xs1,y::ys1) -> (x = y) && (list_prefix xs1 ys1)
        | (uu____18623,uu____18624) -> false  in
      let uu____18633 =
        FStar_List.tryFind
          (fun uu____18651  ->
             match uu____18651 with | (p,uu____18659) -> list_prefix p path)
          env.proof_ns
         in
      match uu____18633 with
      | FStar_Pervasives_Native.None  -> false
      | FStar_Pervasives_Native.Some (uu____18670,b) -> b
  
let (should_enc_lid : env -> FStar_Ident.lident -> Prims.bool) =
  fun env  ->
    fun lid  ->
      let uu____18692 = FStar_Ident.path_of_lid lid  in
      should_enc_path env uu____18692
  
let (cons_proof_ns : Prims.bool -> env -> name_prefix -> env) =
  fun b  ->
    fun e  ->
      fun path  ->
        let uu___258_18710 = e  in
        {
          solver = (uu___258_18710.solver);
          range = (uu___258_18710.range);
          curmodule = (uu___258_18710.curmodule);
          gamma = (uu___258_18710.gamma);
          gamma_sig = (uu___258_18710.gamma_sig);
          gamma_cache = (uu___258_18710.gamma_cache);
          modules = (uu___258_18710.modules);
          expected_typ = (uu___258_18710.expected_typ);
          sigtab = (uu___258_18710.sigtab);
          is_pattern = (uu___258_18710.is_pattern);
          instantiate_imp = (uu___258_18710.instantiate_imp);
          effects = (uu___258_18710.effects);
          generalize = (uu___258_18710.generalize);
          letrecs = (uu___258_18710.letrecs);
          top_level = (uu___258_18710.top_level);
          check_uvars = (uu___258_18710.check_uvars);
          use_eq = (uu___258_18710.use_eq);
          is_iface = (uu___258_18710.is_iface);
          admit = (uu___258_18710.admit);
          lax = (uu___258_18710.lax);
          lax_universes = (uu___258_18710.lax_universes);
          phase1 = (uu___258_18710.phase1);
          failhard = (uu___258_18710.failhard);
          nosynth = (uu___258_18710.nosynth);
          uvar_subtyping = (uu___258_18710.uvar_subtyping);
          weaken_comp_tys = (uu___258_18710.weaken_comp_tys);
          tc_term = (uu___258_18710.tc_term);
          type_of = (uu___258_18710.type_of);
          universe_of = (uu___258_18710.universe_of);
          check_type_of = (uu___258_18710.check_type_of);
          use_bv_sorts = (uu___258_18710.use_bv_sorts);
          qtbl_name_and_index = (uu___258_18710.qtbl_name_and_index);
          normalized_eff_names = (uu___258_18710.normalized_eff_names);
          proof_ns = ((path, b) :: (e.proof_ns));
          synth_hook = (uu___258_18710.synth_hook);
          splice = (uu___258_18710.splice);
          is_native_tactic = (uu___258_18710.is_native_tactic);
          identifier_info = (uu___258_18710.identifier_info);
          tc_hooks = (uu___258_18710.tc_hooks);
          dsenv = (uu___258_18710.dsenv);
          dep_graph = (uu___258_18710.dep_graph)
        }
  
let (add_proof_ns : env -> name_prefix -> env) =
  fun e  -> fun path  -> cons_proof_ns true e path 
let (rem_proof_ns : env -> name_prefix -> env) =
  fun e  -> fun path  -> cons_proof_ns false e path 
let (get_proof_ns : env -> proof_namespace) = fun e  -> e.proof_ns 
let (set_proof_ns : proof_namespace -> env -> env) =
  fun ns  ->
    fun e  ->
      let uu___259_18750 = e  in
      {
        solver = (uu___259_18750.solver);
        range = (uu___259_18750.range);
        curmodule = (uu___259_18750.curmodule);
        gamma = (uu___259_18750.gamma);
        gamma_sig = (uu___259_18750.gamma_sig);
        gamma_cache = (uu___259_18750.gamma_cache);
        modules = (uu___259_18750.modules);
        expected_typ = (uu___259_18750.expected_typ);
        sigtab = (uu___259_18750.sigtab);
        is_pattern = (uu___259_18750.is_pattern);
        instantiate_imp = (uu___259_18750.instantiate_imp);
        effects = (uu___259_18750.effects);
        generalize = (uu___259_18750.generalize);
        letrecs = (uu___259_18750.letrecs);
        top_level = (uu___259_18750.top_level);
        check_uvars = (uu___259_18750.check_uvars);
        use_eq = (uu___259_18750.use_eq);
        is_iface = (uu___259_18750.is_iface);
        admit = (uu___259_18750.admit);
        lax = (uu___259_18750.lax);
        lax_universes = (uu___259_18750.lax_universes);
        phase1 = (uu___259_18750.phase1);
        failhard = (uu___259_18750.failhard);
        nosynth = (uu___259_18750.nosynth);
        uvar_subtyping = (uu___259_18750.uvar_subtyping);
        weaken_comp_tys = (uu___259_18750.weaken_comp_tys);
        tc_term = (uu___259_18750.tc_term);
        type_of = (uu___259_18750.type_of);
        universe_of = (uu___259_18750.universe_of);
        check_type_of = (uu___259_18750.check_type_of);
        use_bv_sorts = (uu___259_18750.use_bv_sorts);
        qtbl_name_and_index = (uu___259_18750.qtbl_name_and_index);
        normalized_eff_names = (uu___259_18750.normalized_eff_names);
        proof_ns = ns;
        synth_hook = (uu___259_18750.synth_hook);
        splice = (uu___259_18750.splice);
        is_native_tactic = (uu___259_18750.is_native_tactic);
        identifier_info = (uu___259_18750.identifier_info);
        tc_hooks = (uu___259_18750.tc_hooks);
        dsenv = (uu___259_18750.dsenv);
        dep_graph = (uu___259_18750.dep_graph)
      }
  
let (unbound_vars :
  env -> FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.bv FStar_Util.set) =
  fun e  ->
    fun t  ->
      let uu____18765 = FStar_Syntax_Free.names t  in
      let uu____18768 = bound_vars e  in
      FStar_List.fold_left (fun s  -> fun bv  -> FStar_Util.set_remove bv s)
        uu____18765 uu____18768
  
let (closed : env -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun e  ->
    fun t  ->
      let uu____18789 = unbound_vars e t  in
      FStar_Util.set_is_empty uu____18789
  
let (closed' : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____18797 = FStar_Syntax_Free.names t  in
    FStar_Util.set_is_empty uu____18797
  
let (string_of_proof_ns : env -> Prims.string) =
  fun env  ->
    let aux uu____18814 =
      match uu____18814 with
      | (p,b) ->
          if (p = []) && b
          then "*"
          else
            (let uu____18824 = FStar_Ident.text_of_path p  in
             Prims.strcat (if b then "+" else "-") uu____18824)
       in
    let uu____18826 =
      let uu____18829 = FStar_List.map aux env.proof_ns  in
      FStar_All.pipe_right uu____18829 FStar_List.rev  in
    FStar_All.pipe_right uu____18826 (FStar_String.concat " ")
  
let (guard_of_guard_formula :
  FStar_TypeChecker_Common.guard_formula -> guard_t) =
  fun g  ->
    { guard_f = g; deferred = []; univ_ineqs = ([], []); implicits = [] }
  
let (guard_form : guard_t -> FStar_TypeChecker_Common.guard_formula) =
  fun g  -> g.guard_f 
let (is_trivial : guard_t -> Prims.bool) =
  fun g  ->
    match g with
    | { guard_f = FStar_TypeChecker_Common.Trivial ; deferred = [];
        univ_ineqs = ([],[]); implicits = i;_} ->
        FStar_All.pipe_right i
          (FStar_Util.for_all
             (fun uu____18915  ->
                match uu____18915 with
                | (uu____18924,uu____18925,ctx_uvar,uu____18927) ->
                    (ctx_uvar.FStar_Syntax_Syntax.ctx_uvar_should_check =
                       FStar_Syntax_Syntax.Allow_unresolved)
                      ||
                      (let uu____18930 =
                         FStar_Syntax_Unionfind.find
                           ctx_uvar.FStar_Syntax_Syntax.ctx_uvar_head
                          in
                       (match uu____18930 with
                        | FStar_Pervasives_Native.Some uu____18933 -> true
                        | FStar_Pervasives_Native.None  -> false))))
    | uu____18934 -> false
  
let (is_trivial_guard_formula : guard_t -> Prims.bool) =
  fun g  ->
    match g with
    | { guard_f = FStar_TypeChecker_Common.Trivial ; deferred = uu____18940;
        univ_ineqs = uu____18941; implicits = uu____18942;_} -> true
    | uu____18961 -> false
  
let (trivial_guard : guard_t) =
  {
    guard_f = FStar_TypeChecker_Common.Trivial;
    deferred = [];
    univ_ineqs = ([], []);
    implicits = []
  } 
let (abstract_guard_n :
  FStar_Syntax_Syntax.binder Prims.list -> guard_t -> guard_t) =
  fun bs  ->
    fun g  ->
      match g.guard_f with
      | FStar_TypeChecker_Common.Trivial  -> g
      | FStar_TypeChecker_Common.NonTrivial f ->
          let f' =
            FStar_Syntax_Util.abs bs f
              (FStar_Pervasives_Native.Some
                 (FStar_Syntax_Util.residual_tot FStar_Syntax_Util.ktype0))
             in
          let uu___260_18996 = g  in
          {
            guard_f = (FStar_TypeChecker_Common.NonTrivial f');
            deferred = (uu___260_18996.deferred);
            univ_ineqs = (uu___260_18996.univ_ineqs);
            implicits = (uu___260_18996.implicits)
          }
  
let (abstract_guard : FStar_Syntax_Syntax.binder -> guard_t -> guard_t) =
  fun b  -> fun g  -> abstract_guard_n [b] g 
let (def_check_vars_in_set :
  FStar_Range.range ->
    Prims.string ->
      FStar_Syntax_Syntax.bv FStar_Util.set ->
        FStar_Syntax_Syntax.term -> unit)
  =
  fun rng  ->
    fun msg  ->
      fun vset  ->
        fun t  ->
          let uu____19031 = FStar_Options.defensive ()  in
          if uu____19031
          then
            let s = FStar_Syntax_Free.names t  in
            let uu____19035 =
              let uu____19036 =
                let uu____19037 = FStar_Util.set_difference s vset  in
                FStar_All.pipe_left FStar_Util.set_is_empty uu____19037  in
              Prims.op_Negation uu____19036  in
            (if uu____19035
             then
               let uu____19042 =
                 let uu____19047 =
                   let uu____19048 = FStar_Syntax_Print.term_to_string t  in
                   let uu____19049 =
                     let uu____19050 = FStar_Util.set_elements s  in
                     FStar_All.pipe_right uu____19050
                       (FStar_Syntax_Print.bvs_to_string ",\n\t")
                      in
                   FStar_Util.format3
                     "Internal: term is not closed (%s).\nt = (%s)\nFVs = (%s)\n"
                     msg uu____19048 uu____19049
                    in
                 (FStar_Errors.Warning_Defensive, uu____19047)  in
               FStar_Errors.log_issue rng uu____19042
             else ())
          else ()
  
let (def_check_closed_in :
  FStar_Range.range ->
    Prims.string ->
      FStar_Syntax_Syntax.bv Prims.list -> FStar_Syntax_Syntax.term -> unit)
  =
  fun rng  ->
    fun msg  ->
      fun l  ->
        fun t  ->
          let uu____19081 =
            let uu____19082 = FStar_Options.defensive ()  in
            Prims.op_Negation uu____19082  in
          if uu____19081
          then ()
          else
            (let uu____19084 =
               FStar_Util.as_set l FStar_Syntax_Syntax.order_bv  in
             def_check_vars_in_set rng msg uu____19084 t)
  
let (def_check_closed_in_env :
  FStar_Range.range ->
    Prims.string -> env -> FStar_Syntax_Syntax.term -> unit)
  =
  fun rng  ->
    fun msg  ->
      fun e  ->
        fun t  ->
          let uu____19107 =
            let uu____19108 = FStar_Options.defensive ()  in
            Prims.op_Negation uu____19108  in
          if uu____19107
          then ()
          else
            (let uu____19110 = bound_vars e  in
             def_check_closed_in rng msg uu____19110 t)
  
let (def_check_guard_wf :
  FStar_Range.range -> Prims.string -> env -> guard_t -> unit) =
  fun rng  ->
    fun msg  ->
      fun env  ->
        fun g  ->
          match g.guard_f with
          | FStar_TypeChecker_Common.Trivial  -> ()
          | FStar_TypeChecker_Common.NonTrivial f ->
              def_check_closed_in_env rng msg env f
  
let (apply_guard : guard_t -> FStar_Syntax_Syntax.term -> guard_t) =
  fun g  ->
    fun e  ->
      match g.guard_f with
      | FStar_TypeChecker_Common.Trivial  -> g
      | FStar_TypeChecker_Common.NonTrivial f ->
          let uu___261_19145 = g  in
          let uu____19146 =
            let uu____19147 =
              let uu____19148 =
                let uu____19155 =
                  let uu____19156 =
                    let uu____19171 =
                      let uu____19180 = FStar_Syntax_Syntax.as_arg e  in
                      [uu____19180]  in
                    (f, uu____19171)  in
                  FStar_Syntax_Syntax.Tm_app uu____19156  in
                FStar_Syntax_Syntax.mk uu____19155  in
              uu____19148 FStar_Pervasives_Native.None
                f.FStar_Syntax_Syntax.pos
               in
            FStar_All.pipe_left
              (fun _0_17  -> FStar_TypeChecker_Common.NonTrivial _0_17)
              uu____19147
             in
          {
            guard_f = uu____19146;
            deferred = (uu___261_19145.deferred);
            univ_ineqs = (uu___261_19145.univ_ineqs);
            implicits = (uu___261_19145.implicits)
          }
  
let (map_guard :
  guard_t ->
    (FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) -> guard_t)
  =
  fun g  ->
    fun map1  ->
      match g.guard_f with
      | FStar_TypeChecker_Common.Trivial  -> g
      | FStar_TypeChecker_Common.NonTrivial f ->
          let uu___262_19228 = g  in
          let uu____19229 =
            let uu____19230 = map1 f  in
            FStar_TypeChecker_Common.NonTrivial uu____19230  in
          {
            guard_f = uu____19229;
            deferred = (uu___262_19228.deferred);
            univ_ineqs = (uu___262_19228.univ_ineqs);
            implicits = (uu___262_19228.implicits)
          }
  
let (trivial : FStar_TypeChecker_Common.guard_formula -> unit) =
  fun t  ->
    match t with
    | FStar_TypeChecker_Common.Trivial  -> ()
    | FStar_TypeChecker_Common.NonTrivial uu____19236 ->
        failwith "impossible"
  
let (conj_guard_f :
  FStar_TypeChecker_Common.guard_formula ->
    FStar_TypeChecker_Common.guard_formula ->
      FStar_TypeChecker_Common.guard_formula)
  =
  fun g1  ->
    fun g2  ->
      match (g1, g2) with
      | (FStar_TypeChecker_Common.Trivial ,g) -> g
      | (g,FStar_TypeChecker_Common.Trivial ) -> g
      | (FStar_TypeChecker_Common.NonTrivial
         f1,FStar_TypeChecker_Common.NonTrivial f2) ->
          let uu____19251 = FStar_Syntax_Util.mk_conj f1 f2  in
          FStar_TypeChecker_Common.NonTrivial uu____19251
  
let (check_trivial :
  FStar_Syntax_Syntax.term -> FStar_TypeChecker_Common.guard_formula) =
  fun t  ->
    let uu____19257 =
      let uu____19258 = FStar_Syntax_Util.unmeta t  in
      uu____19258.FStar_Syntax_Syntax.n  in
    match uu____19257 with
    | FStar_Syntax_Syntax.Tm_fvar tc when
        FStar_Syntax_Syntax.fv_eq_lid tc FStar_Parser_Const.true_lid ->
        FStar_TypeChecker_Common.Trivial
    | uu____19262 -> FStar_TypeChecker_Common.NonTrivial t
  
let (imp_guard_f :
  FStar_TypeChecker_Common.guard_formula ->
    FStar_TypeChecker_Common.guard_formula ->
      FStar_TypeChecker_Common.guard_formula)
  =
  fun g1  ->
    fun g2  ->
      match (g1, g2) with
      | (FStar_TypeChecker_Common.Trivial ,g) -> g
      | (g,FStar_TypeChecker_Common.Trivial ) ->
          FStar_TypeChecker_Common.Trivial
      | (FStar_TypeChecker_Common.NonTrivial
         f1,FStar_TypeChecker_Common.NonTrivial f2) ->
          let imp = FStar_Syntax_Util.mk_imp f1 f2  in check_trivial imp
  
let (binop_guard :
  (FStar_TypeChecker_Common.guard_formula ->
     FStar_TypeChecker_Common.guard_formula ->
       FStar_TypeChecker_Common.guard_formula)
    -> guard_t -> guard_t -> guard_t)
  =
  fun f  ->
    fun g1  ->
      fun g2  ->
        let uu____19303 = f g1.guard_f g2.guard_f  in
        {
          guard_f = uu____19303;
          deferred = (FStar_List.append g1.deferred g2.deferred);
          univ_ineqs =
            ((FStar_List.append (FStar_Pervasives_Native.fst g1.univ_ineqs)
                (FStar_Pervasives_Native.fst g2.univ_ineqs)),
              (FStar_List.append (FStar_Pervasives_Native.snd g1.univ_ineqs)
                 (FStar_Pervasives_Native.snd g2.univ_ineqs)));
          implicits = (FStar_List.append g1.implicits g2.implicits)
        }
  
let (conj_guard : guard_t -> guard_t -> guard_t) =
  fun g1  -> fun g2  -> binop_guard conj_guard_f g1 g2 
let (imp_guard : guard_t -> guard_t -> guard_t) =
  fun g1  -> fun g2  -> binop_guard imp_guard_f g1 g2 
let (close_guard_univs :
  FStar_Syntax_Syntax.universes ->
    FStar_Syntax_Syntax.binders -> guard_t -> guard_t)
  =
  fun us  ->
    fun bs  ->
      fun g  ->
        match g.guard_f with
        | FStar_TypeChecker_Common.Trivial  -> g
        | FStar_TypeChecker_Common.NonTrivial f ->
            let f1 =
              FStar_List.fold_right2
                (fun u  ->
                   fun b  ->
                     fun f1  ->
                       let uu____19388 = FStar_Syntax_Syntax.is_null_binder b
                          in
                       if uu____19388
                       then f1
                       else
                         FStar_Syntax_Util.mk_forall u
                           (FStar_Pervasives_Native.fst b) f1) us bs f
               in
            let uu___263_19390 = g  in
            {
              guard_f = (FStar_TypeChecker_Common.NonTrivial f1);
              deferred = (uu___263_19390.deferred);
              univ_ineqs = (uu___263_19390.univ_ineqs);
              implicits = (uu___263_19390.implicits)
            }
  
let (close_forall :
  env ->
    FStar_Syntax_Syntax.binders ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
  =
  fun env  ->
    fun bs  ->
      fun f  ->
        FStar_List.fold_right
          (fun b  ->
             fun f1  ->
               let uu____19419 = FStar_Syntax_Syntax.is_null_binder b  in
               if uu____19419
               then f1
               else
                 (let u =
                    env.universe_of env
                      (FStar_Pervasives_Native.fst b).FStar_Syntax_Syntax.sort
                     in
                  FStar_Syntax_Util.mk_forall u
                    (FStar_Pervasives_Native.fst b) f1)) bs f
  
let (close_guard : env -> FStar_Syntax_Syntax.binders -> guard_t -> guard_t)
  =
  fun env  ->
    fun binders  ->
      fun g  ->
        match g.guard_f with
        | FStar_TypeChecker_Common.Trivial  -> g
        | FStar_TypeChecker_Common.NonTrivial f ->
            let uu___264_19438 = g  in
            let uu____19439 =
              let uu____19440 = close_forall env binders f  in
              FStar_TypeChecker_Common.NonTrivial uu____19440  in
            {
              guard_f = uu____19439;
              deferred = (uu___264_19438.deferred);
              univ_ineqs = (uu___264_19438.univ_ineqs);
              implicits = (uu___264_19438.implicits)
            }
  
let (new_implicit_var_aux :
  Prims.string ->
    FStar_Range.range ->
      env ->
        FStar_Syntax_Syntax.typ ->
          FStar_Syntax_Syntax.should_check_uvar ->
            (FStar_Syntax_Syntax.term,(FStar_Syntax_Syntax.ctx_uvar,FStar_Range.range)
                                        FStar_Pervasives_Native.tuple2
                                        Prims.list,guard_t)
              FStar_Pervasives_Native.tuple3)
  =
  fun reason  ->
    fun r  ->
      fun env  ->
        fun k  ->
          fun should_check  ->
            let uu____19478 =
              FStar_Syntax_Util.destruct k FStar_Parser_Const.range_of_lid
               in
            match uu____19478 with
            | FStar_Pervasives_Native.Some
                (uu____19501::(tm,uu____19503)::[]) ->
                let t =
                  FStar_Syntax_Syntax.mk
                    (FStar_Syntax_Syntax.Tm_constant
                       (FStar_Const.Const_range (tm.FStar_Syntax_Syntax.pos)))
                    FStar_Pervasives_Native.None tm.FStar_Syntax_Syntax.pos
                   in
                (t, [], trivial_guard)
            | uu____19553 ->
                let binders = all_binders env  in
                let gamma = env.gamma  in
                let ctx_uvar =
                  let uu____19569 = FStar_Syntax_Unionfind.fresh ()  in
                  {
                    FStar_Syntax_Syntax.ctx_uvar_head = uu____19569;
                    FStar_Syntax_Syntax.ctx_uvar_gamma = gamma;
                    FStar_Syntax_Syntax.ctx_uvar_binders = binders;
                    FStar_Syntax_Syntax.ctx_uvar_typ = k;
                    FStar_Syntax_Syntax.ctx_uvar_reason = reason;
                    FStar_Syntax_Syntax.ctx_uvar_should_check = should_check;
                    FStar_Syntax_Syntax.ctx_uvar_range = r
                  }  in
                (FStar_TypeChecker_Common.check_uvar_ctx_invariant reason r
                   true gamma binders;
                 (let t =
                    FStar_Syntax_Syntax.mk
                      (FStar_Syntax_Syntax.Tm_uvar
                         (ctx_uvar, ([], FStar_Syntax_Syntax.NoUseRange)))
                      FStar_Pervasives_Native.None r
                     in
                  let g =
                    let uu___265_19599 = trivial_guard  in
                    {
                      guard_f = (uu___265_19599.guard_f);
                      deferred = (uu___265_19599.deferred);
                      univ_ineqs = (uu___265_19599.univ_ineqs);
                      implicits = [(reason, t, ctx_uvar, r)]
                    }  in
                  (t, [(ctx_uvar, r)], g)))
  
let (dummy_solver : solver_t) =
  {
    init = (fun uu____19632  -> ());
    push = (fun uu____19634  -> ());
    pop = (fun uu____19636  -> ());
    snapshot =
      (fun uu____19638  ->
         (((Prims.parse_int "0"), (Prims.parse_int "0"),
            (Prims.parse_int "0")), ()));
    rollback = (fun uu____19647  -> fun uu____19648  -> ());
    encode_modul = (fun uu____19659  -> fun uu____19660  -> ());
    encode_sig = (fun uu____19663  -> fun uu____19664  -> ());
    preprocess =
      (fun e  ->
         fun g  ->
           let uu____19670 =
             let uu____19677 = FStar_Options.peek ()  in (e, g, uu____19677)
              in
           [uu____19670]);
    solve = (fun uu____19693  -> fun uu____19694  -> fun uu____19695  -> ());
    finish = (fun uu____19701  -> ());
    refresh = (fun uu____19703  -> ())
  } 