open Prims
type ty_or_exp_b =
  ((FStar_Extraction_ML_Syntax.mlident* FStar_Extraction_ML_Syntax.mlty),
    (FStar_Extraction_ML_Syntax.mlsymbol* FStar_Extraction_ML_Syntax.mlexpr*
      FStar_Extraction_ML_Syntax.mltyscheme* Prims.bool))
    FStar_Util.either
type binding =
  | Bv of (FStar_Syntax_Syntax.bv* ty_or_exp_b)
  | Fv of (FStar_Syntax_Syntax.fv* ty_or_exp_b)
let uu___is_Bv: binding -> Prims.bool =
  fun projectee  -> match projectee with | Bv _0 -> true | uu____27 -> false
let __proj__Bv__item___0: binding -> (FStar_Syntax_Syntax.bv* ty_or_exp_b) =
  fun projectee  -> match projectee with | Bv _0 -> _0
let uu___is_Fv: binding -> Prims.bool =
  fun projectee  -> match projectee with | Fv _0 -> true | uu____47 -> false
let __proj__Fv__item___0: binding -> (FStar_Syntax_Syntax.fv* ty_or_exp_b) =
  fun projectee  -> match projectee with | Fv _0 -> _0
type env =
  {
  tcenv: FStar_TypeChecker_Env.env;
  gamma: binding Prims.list;
  tydefs:
    (FStar_Extraction_ML_Syntax.mlsymbol Prims.list*
      FStar_Extraction_ML_Syntax.mltydecl) Prims.list;
  currentModule: FStar_Extraction_ML_Syntax.mlpath;}
let __proj__Mkenv__item__tcenv: env -> FStar_TypeChecker_Env.env =
  fun projectee  ->
    match projectee with
    | { tcenv = __fname__tcenv; gamma = __fname__gamma;
        tydefs = __fname__tydefs; currentModule = __fname__currentModule;_}
        -> __fname__tcenv
let __proj__Mkenv__item__gamma: env -> binding Prims.list =
  fun projectee  ->
    match projectee with
    | { tcenv = __fname__tcenv; gamma = __fname__gamma;
        tydefs = __fname__tydefs; currentModule = __fname__currentModule;_}
        -> __fname__gamma
let __proj__Mkenv__item__tydefs:
  env ->
    (FStar_Extraction_ML_Syntax.mlsymbol Prims.list*
      FStar_Extraction_ML_Syntax.mltydecl) Prims.list
  =
  fun projectee  ->
    match projectee with
    | { tcenv = __fname__tcenv; gamma = __fname__gamma;
        tydefs = __fname__tydefs; currentModule = __fname__currentModule;_}
        -> __fname__tydefs
let __proj__Mkenv__item__currentModule:
  env -> FStar_Extraction_ML_Syntax.mlpath =
  fun projectee  ->
    match projectee with
    | { tcenv = __fname__tcenv; gamma = __fname__gamma;
        tydefs = __fname__tydefs; currentModule = __fname__currentModule;_}
        -> __fname__currentModule
let debug: env -> (Prims.unit -> Prims.unit) -> Prims.unit =
  fun g  ->
    fun f  ->
      let c = FStar_Extraction_ML_Syntax.string_of_mlpath g.currentModule in
      let uu____152 =
        FStar_Options.debug_at_level c (FStar_Options.Other "Extraction") in
      if uu____152 then f () else ()
let mkFvvar:
  FStar_Ident.lident -> FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.fv =
  fun l  ->
    fun t  ->
      FStar_Syntax_Syntax.lid_as_fv l FStar_Syntax_Syntax.Delta_constant None
let erasedContent: FStar_Extraction_ML_Syntax.mlty =
  FStar_Extraction_ML_Syntax.ml_unit_ty
let erasableTypeNoDelta: FStar_Extraction_ML_Syntax.mlty -> Prims.bool =
  fun t  ->
    if t = FStar_Extraction_ML_Syntax.ml_unit_ty
    then true
    else
      (match t with
       | FStar_Extraction_ML_Syntax.MLTY_Named
           (uu____164,("FStar"::"Ghost"::[],"erased")) -> true
       | uu____171 -> false)
let unknownType: FStar_Extraction_ML_Syntax.mlty =
  FStar_Extraction_ML_Syntax.MLTY_Top
let prependTick uu____182 =
  match uu____182 with
  | (x,n1) ->
      if FStar_Util.starts_with x "'"
      then (x, n1)
      else ((Prims.strcat "'A" x), n1)
let removeTick uu____200 =
  match uu____200 with
  | (x,n1) ->
      if FStar_Util.starts_with x "'"
      then
        let uu____207 = FStar_Util.substring_from x (Prims.parse_int "1") in
        (uu____207, n1)
      else (x, n1)
let convRange: FStar_Range.range -> Prims.int = fun r  -> Prims.parse_int "0"
let convIdent: FStar_Ident.ident -> (Prims.string* Prims.int) =
  fun id  -> ((id.FStar_Ident.idText), (Prims.parse_int "0"))
let bv_as_ml_tyvar: FStar_Syntax_Syntax.bv -> (Prims.string* Prims.int) =
  fun x  ->
    let uu____220 = FStar_Extraction_ML_Syntax.bv_as_mlident x in
    prependTick uu____220
let bv_as_ml_termvar: FStar_Syntax_Syntax.bv -> (Prims.string* Prims.int) =
  fun x  ->
    let uu____228 = FStar_Extraction_ML_Syntax.bv_as_mlident x in
    removeTick uu____228
let rec lookup_ty_local:
  binding Prims.list ->
    FStar_Syntax_Syntax.bv -> FStar_Extraction_ML_Syntax.mlty
  =
  fun gamma  ->
    fun b  ->
      match gamma with
      | (Bv (b',FStar_Util.Inl (mli,mlt)))::tl1 ->
          if FStar_Syntax_Syntax.bv_eq b b'
          then mlt
          else lookup_ty_local tl1 b
      | (Bv (b',FStar_Util.Inr uu____260))::tl1 ->
          if FStar_Syntax_Syntax.bv_eq b b'
          then
            failwith
              (Prims.strcat "Type/Expr clash: "
                 (b.FStar_Syntax_Syntax.ppname).FStar_Ident.idText)
          else lookup_ty_local tl1 b
      | uu____282::tl1 -> lookup_ty_local tl1 b
      | [] ->
          failwith
            (Prims.strcat "extraction: unbound type var "
               (b.FStar_Syntax_Syntax.ppname).FStar_Ident.idText)
let tyscheme_of_td uu____302 =
  match uu____302 with
  | (uu____309,uu____310,uu____311,vars,body_opt) ->
      (match body_opt with
       | Some (FStar_Extraction_ML_Syntax.MLTD_Abbrev t) -> Some (vars, t)
       | uu____321 -> None)
let lookup_ty_const:
  env ->
    FStar_Extraction_ML_Syntax.mlpath ->
      FStar_Extraction_ML_Syntax.mltyscheme option
  =
  fun env  ->
    fun uu____329  ->
      match uu____329 with
      | (module_name,ty_name) ->
          FStar_Util.find_map env.tydefs
            (fun uu____339  ->
               match uu____339 with
               | (m,tds) ->
                   if module_name = m
                   then
                     FStar_Util.find_map tds
                       (fun td  ->
                          let uu____351 = td in
                          match uu____351 with
                          | (uu____353,n1,uu____355,uu____356,uu____357) ->
                              if n1 = ty_name
                              then tyscheme_of_td td
                              else None)
                   else None)
let module_name_of_fv: FStar_Syntax_Syntax.fv -> Prims.string Prims.list =
  fun fv  ->
    FStar_All.pipe_right
      ((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v).FStar_Ident.ns
      (FStar_List.map (fun i  -> i.FStar_Ident.idText))
let maybe_mangle_type_projector:
  env ->
    FStar_Syntax_Syntax.fv ->
      (FStar_Extraction_ML_Syntax.mlsymbol Prims.list*
        FStar_Extraction_ML_Syntax.mlsymbol) option
  =
  fun env  ->
    fun fv  ->
      let mname = module_name_of_fv fv in
      let ty_name =
        (((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v).FStar_Ident.ident).FStar_Ident.idText in
      FStar_Util.find_map env.tydefs
        (fun uu____398  ->
           match uu____398 with
           | (m,tds) ->
               FStar_Util.find_map tds
                 (fun uu____413  ->
                    match uu____413 with
                    | (uu____418,n1,mangle_opt,uu____421,uu____422) ->
                        if m = mname
                        then
                          (if n1 = ty_name
                           then
                             match mangle_opt with
                             | None  -> Some (m, n1)
                             | Some mangled ->
                                 let modul = m in Some (modul, mangled)
                           else None)
                        else None))
let lookup_tyvar:
  env -> FStar_Syntax_Syntax.bv -> FStar_Extraction_ML_Syntax.mlty =
  fun g  -> fun bt  -> lookup_ty_local g.gamma bt
let lookup_fv_by_lid: env -> FStar_Ident.lident -> ty_or_exp_b =
  fun g  ->
    fun lid  ->
      let x =
        FStar_Util.find_map g.gamma
          (fun uu___104_473  ->
             match uu___104_473 with
             | Fv (fv',x) when FStar_Syntax_Syntax.fv_eq_lid fv' lid ->
                 Some x
             | uu____477 -> None) in
      match x with
      | None  ->
          let uu____478 =
            FStar_Util.format1 "free Variable %s not found\n"
              lid.FStar_Ident.nsstr in
          failwith uu____478
      | Some y -> y
let lookup_fv: env -> FStar_Syntax_Syntax.fv -> ty_or_exp_b =
  fun g  ->
    fun fv  ->
      let x =
        FStar_Util.find_map g.gamma
          (fun uu___105_488  ->
             match uu___105_488 with
             | Fv (fv',t) when FStar_Syntax_Syntax.fv_eq fv fv' -> Some t
             | uu____492 -> None) in
      match x with
      | None  ->
          let uu____493 =
            let uu____494 =
              FStar_Range.string_of_range
                (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.p in
            let uu____499 =
              FStar_Syntax_Print.lid_to_string
                (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v in
            FStar_Util.format2 "(%s) free Variable %s not found\n" uu____494
              uu____499 in
          failwith uu____493
      | Some y -> y
let lookup_bv: env -> FStar_Syntax_Syntax.bv -> ty_or_exp_b =
  fun g  ->
    fun bv  ->
      let x =
        FStar_Util.find_map g.gamma
          (fun uu___106_513  ->
             match uu___106_513 with
             | Bv (bv',r) when FStar_Syntax_Syntax.bv_eq bv bv' -> Some r
             | uu____517 -> None) in
      match x with
      | None  ->
          let uu____518 =
            let uu____519 =
              FStar_Range.string_of_range
                (bv.FStar_Syntax_Syntax.ppname).FStar_Ident.idRange in
            let uu____520 = FStar_Syntax_Print.bv_to_string bv in
            FStar_Util.format2 "(%s) bound Variable %s not found\n" uu____519
              uu____520 in
          failwith uu____518
      | Some y -> y
let lookup:
  env ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
      (ty_or_exp_b* FStar_Syntax_Syntax.fv_qual option)
  =
  fun g  ->
    fun x  ->
      match x with
      | FStar_Util.Inl x1 ->
          let uu____542 = lookup_bv g x1 in (uu____542, None)
      | FStar_Util.Inr x1 ->
          let uu____545 = lookup_fv g x1 in
          (uu____545, (x1.FStar_Syntax_Syntax.fv_qual))
let lookup_term:
  env ->
    FStar_Syntax_Syntax.term ->
      (ty_or_exp_b* FStar_Syntax_Syntax.fv_qual option)
  =
  fun g  ->
    fun t  ->
      match t.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_name x -> lookup g (FStar_Util.Inl x)
      | FStar_Syntax_Syntax.Tm_fvar x -> lookup g (FStar_Util.Inr x)
      | uu____561 -> failwith "Impossible: lookup_term for a non-name"
let extend_ty:
  env ->
    FStar_Syntax_Syntax.bv -> FStar_Extraction_ML_Syntax.mlty option -> env
  =
  fun g  ->
    fun a  ->
      fun mapped_to  ->
        let ml_a = bv_as_ml_tyvar a in
        let mapped_to1 =
          match mapped_to with
          | None  -> FStar_Extraction_ML_Syntax.MLTY_Var ml_a
          | Some t -> t in
        let gamma = (Bv (a, (FStar_Util.Inl (ml_a, mapped_to1)))) ::
          (g.gamma) in
        let tcenv = FStar_TypeChecker_Env.push_bv g.tcenv a in
        let uu___108_604 = g in
        {
          tcenv;
          gamma;
          tydefs = (uu___108_604.tydefs);
          currentModule = (uu___108_604.currentModule)
        }
let sanitize: Prims.string -> Prims.string =
  fun s  ->
    let cs = FStar_String.list_of_string s in
    let valid c =
      ((FStar_Util.is_letter_or_digit c) || (c = '_')) || (c = '\'') in
    let cs' =
      FStar_List.fold_right
        (fun c  ->
           fun cs1  ->
             let uu____620 =
               let uu____622 = valid c in
               if uu____622 then [c] else ['_'; '_'] in
             FStar_List.append uu____620 cs1) cs [] in
    let cs'1 =
      match cs' with
      | c::cs1 when (FStar_Util.is_digit c) || (c = '\'') -> '_' :: c :: cs1
      | uu____631 -> cs in
    FStar_String.string_of_list cs'1
let find_uniq: binding Prims.list -> Prims.string -> Prims.string =
  fun gamma  ->
    fun mlident  ->
      let rec find_uniq mlident1 i =
        let suffix =
          if i = (Prims.parse_int "0")
          then ""
          else FStar_Util.string_of_int i in
        let target_mlident = Prims.strcat mlident1 suffix in
        let has_collision =
          FStar_List.existsb
            (fun uu___107_652  ->
               match uu___107_652 with
               | Bv (uu____653,FStar_Util.Inl (mlident',uu____655)) ->
                   target_mlident = (fst mlident')
               | Fv (uu____670,FStar_Util.Inl (mlident',uu____672)) ->
                   target_mlident = (fst mlident')
               | Fv
                   (uu____687,FStar_Util.Inr
                    (mlident',uu____689,uu____690,uu____691))
                   -> target_mlident = mlident'
               | Bv
                   (uu____706,FStar_Util.Inr
                    (mlident',uu____708,uu____709,uu____710))
                   -> target_mlident = mlident') gamma in
        if has_collision
        then find_uniq mlident1 (i + (Prims.parse_int "1"))
        else target_mlident in
      let mlident1 = sanitize mlident in
      find_uniq mlident1 (Prims.parse_int "0")
let extend_bv:
  env ->
    FStar_Syntax_Syntax.bv ->
      FStar_Extraction_ML_Syntax.mltyscheme ->
        Prims.bool ->
          Prims.bool ->
            Prims.bool -> (env* FStar_Extraction_ML_Syntax.mlident)
  =
  fun g  ->
    fun x  ->
      fun t_x  ->
        fun add_unit  ->
          fun is_rec  ->
            fun mk_unit  ->
              let ml_ty =
                match t_x with
                | ([],t) -> t
                | uu____752 -> FStar_Extraction_ML_Syntax.MLTY_Top in
              let uu____753 = FStar_Extraction_ML_Syntax.bv_as_mlident x in
              match uu____753 with
              | (mlident,nocluewhat) ->
                  let mlsymbol = find_uniq g.gamma mlident in
                  let mlident1 = (mlsymbol, nocluewhat) in
                  let mlx = FStar_Extraction_ML_Syntax.MLE_Var mlident1 in
                  let mlx1 =
                    if mk_unit
                    then FStar_Extraction_ML_Syntax.ml_unit
                    else
                      if add_unit
                      then
                        FStar_All.pipe_left
                          (FStar_Extraction_ML_Syntax.with_ty
                             FStar_Extraction_ML_Syntax.MLTY_Top)
                          (FStar_Extraction_ML_Syntax.MLE_App
                             ((FStar_Extraction_ML_Syntax.with_ty
                                 FStar_Extraction_ML_Syntax.MLTY_Top mlx),
                               [FStar_Extraction_ML_Syntax.ml_unit]))
                      else FStar_Extraction_ML_Syntax.with_ty ml_ty mlx in
                  let gamma =
                    (Bv (x, (FStar_Util.Inr (mlsymbol, mlx1, t_x, is_rec))))
                    :: (g.gamma) in
                  let tcenv =
                    let uu____784 = FStar_Syntax_Syntax.binders_of_list [x] in
                    FStar_TypeChecker_Env.push_binders g.tcenv uu____784 in
                  ((let uu___109_787 = g in
                    {
                      tcenv;
                      gamma;
                      tydefs = (uu___109_787.tydefs);
                      currentModule = (uu___109_787.currentModule)
                    }), mlident1)
let rec mltyFvars:
  FStar_Extraction_ML_Syntax.mlty ->
    FStar_Extraction_ML_Syntax.mlident Prims.list
  =
  fun t  ->
    match t with
    | FStar_Extraction_ML_Syntax.MLTY_Var x -> [x]
    | FStar_Extraction_ML_Syntax.MLTY_Fun (t1,f,t2) ->
        let uu____798 = mltyFvars t1 in
        let uu____800 = mltyFvars t2 in FStar_List.append uu____798 uu____800
    | FStar_Extraction_ML_Syntax.MLTY_Named (args,path) ->
        FStar_List.collect mltyFvars args
    | FStar_Extraction_ML_Syntax.MLTY_Tuple ts ->
        FStar_List.collect mltyFvars ts
    | FStar_Extraction_ML_Syntax.MLTY_Top  -> []
let rec subsetMlidents:
  FStar_Extraction_ML_Syntax.mlident Prims.list ->
    FStar_Extraction_ML_Syntax.mlident Prims.list -> Prims.bool
  =
  fun la  ->
    fun lb  ->
      match la with
      | h::tla -> (FStar_List.contains h lb) && (subsetMlidents tla lb)
      | [] -> true
let tySchemeIsClosed: FStar_Extraction_ML_Syntax.mltyscheme -> Prims.bool =
  fun tys  ->
    let uu____824 = mltyFvars (snd tys) in subsetMlidents uu____824 (fst tys)
let extend_fv':
  env ->
    FStar_Syntax_Syntax.fv ->
      FStar_Extraction_ML_Syntax.mlpath ->
        FStar_Extraction_ML_Syntax.mltyscheme ->
          Prims.bool ->
            Prims.bool -> (env* FStar_Extraction_ML_Syntax.mlident)
  =
  fun g  ->
    fun x  ->
      fun y  ->
        fun t_x  ->
          fun add_unit  ->
            fun is_rec  ->
              let uu____848 = tySchemeIsClosed t_x in
              if uu____848
              then
                let ml_ty =
                  match t_x with
                  | ([],t) -> t
                  | uu____854 -> FStar_Extraction_ML_Syntax.MLTY_Top in
                let uu____855 =
                  let uu____861 = y in
                  match uu____861 with
                  | (ns,i) ->
                      let mlsymbol =
                        FStar_Extraction_ML_Syntax.avoid_keyword i in
                      ((ns, mlsymbol), mlsymbol) in
                match uu____855 with
                | (mlpath,mlsymbol) ->
                    let mly = FStar_Extraction_ML_Syntax.MLE_Name mlpath in
                    let mly1 =
                      if add_unit
                      then
                        FStar_All.pipe_left
                          (FStar_Extraction_ML_Syntax.with_ty
                             FStar_Extraction_ML_Syntax.MLTY_Top)
                          (FStar_Extraction_ML_Syntax.MLE_App
                             ((FStar_Extraction_ML_Syntax.with_ty
                                 FStar_Extraction_ML_Syntax.MLTY_Top mly),
                               [FStar_Extraction_ML_Syntax.ml_unit]))
                      else FStar_Extraction_ML_Syntax.with_ty ml_ty mly in
                    let gamma =
                      (Fv (x, (FStar_Util.Inr (mlsymbol, mly1, t_x, is_rec))))
                      :: (g.gamma) in
                    ((let uu___110_908 = g in
                      {
                        tcenv = (uu___110_908.tcenv);
                        gamma;
                        tydefs = (uu___110_908.tydefs);
                        currentModule = (uu___110_908.currentModule)
                      }), (mlsymbol, (Prims.parse_int "0")))
              else failwith "freevars found"
let extend_fv:
  env ->
    FStar_Syntax_Syntax.fv ->
      FStar_Extraction_ML_Syntax.mltyscheme ->
        Prims.bool -> Prims.bool -> (env* FStar_Extraction_ML_Syntax.mlident)
  =
  fun g  ->
    fun x  ->
      fun t_x  ->
        fun add_unit  ->
          fun is_rec  ->
            let mlp =
              FStar_Extraction_ML_Syntax.mlpath_of_lident
                (x.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v in
            extend_fv' g x mlp t_x add_unit is_rec
let extend_lb:
  env ->
    FStar_Syntax_Syntax.lbname ->
      FStar_Syntax_Syntax.typ ->
        FStar_Extraction_ML_Syntax.mltyscheme ->
          Prims.bool ->
            Prims.bool -> (env* FStar_Extraction_ML_Syntax.mlident)
  =
  fun g  ->
    fun l  ->
      fun t  ->
        fun t_x  ->
          fun add_unit  ->
            fun is_rec  ->
              match l with
              | FStar_Util.Inl x -> extend_bv g x t_x add_unit is_rec false
              | FStar_Util.Inr f ->
                  let uu____962 =
                    FStar_Extraction_ML_Syntax.mlpath_of_lident
                      (f.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v in
                  (match uu____962 with
                   | (p,y) -> extend_fv' g f (p, y) t_x add_unit is_rec)
let extend_tydef:
  env -> FStar_Syntax_Syntax.fv -> FStar_Extraction_ML_Syntax.mltydecl -> env
  =
  fun g  ->
    fun fv  ->
      fun td  ->
        let m = module_name_of_fv fv in
        let uu___111_985 = g in
        {
          tcenv = (uu___111_985.tcenv);
          gamma = (uu___111_985.gamma);
          tydefs = ((m, td) :: (g.tydefs));
          currentModule = (uu___111_985.currentModule)
        }
let emptyMlPath:
  (FStar_Extraction_ML_Syntax.mlsymbol Prims.list* Prims.string) = ([], "")
let mkContext: FStar_TypeChecker_Env.env -> env =
  fun e  ->
    let env =
      { tcenv = e; gamma = []; tydefs = []; currentModule = emptyMlPath } in
    let a = ("'a", (- (Prims.parse_int "1"))) in
    let failwith_ty =
      ([a],
        (FStar_Extraction_ML_Syntax.MLTY_Fun
           ((FStar_Extraction_ML_Syntax.MLTY_Named
               ([], (["Prims"], "string"))),
             FStar_Extraction_ML_Syntax.E_IMPURE,
             (FStar_Extraction_ML_Syntax.MLTY_Var a)))) in
    let uu____1022 =
      let uu____1025 =
        let uu____1026 =
          FStar_Syntax_Syntax.lid_as_fv FStar_Syntax_Const.failwith_lid
            FStar_Syntax_Syntax.Delta_constant None in
        FStar_Util.Inr uu____1026 in
      extend_lb env uu____1025 FStar_Syntax_Syntax.tun failwith_ty false
        false in
    FStar_All.pipe_right uu____1022 FStar_Pervasives.fst
let monad_op_name:
  FStar_Syntax_Syntax.eff_decl ->
    Prims.string -> (FStar_Extraction_ML_Syntax.mlpath* FStar_Ident.lident)
  =
  fun ed  ->
    fun nm  ->
      let lid =
        FStar_Syntax_Util.mk_field_projector_name_from_ident
          ed.FStar_Syntax_Syntax.mname (FStar_Ident.id_of_text nm) in
      let uu____1038 = FStar_Extraction_ML_Syntax.mlpath_of_lident lid in
      (uu____1038, lid)
let action_name:
  FStar_Syntax_Syntax.eff_decl ->
    FStar_Syntax_Syntax.action ->
      (FStar_Extraction_ML_Syntax.mlpath* FStar_Ident.lident)
  =
  fun ed  ->
    fun a  ->
      let nm =
        ((a.FStar_Syntax_Syntax.action_name).FStar_Ident.ident).FStar_Ident.idText in
      let module_name = (ed.FStar_Syntax_Syntax.mname).FStar_Ident.ns in
      let lid =
        FStar_Ident.lid_of_ids
          (FStar_List.append module_name [FStar_Ident.id_of_text nm]) in
      let uu____1051 = FStar_Extraction_ML_Syntax.mlpath_of_lident lid in
      (uu____1051, lid)