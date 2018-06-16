open Prims
let (tts_f :
  (FStar_Syntax_Syntax.term -> Prims.string) FStar_Pervasives_Native.option
    FStar_ST.ref)
  = FStar_Util.mk_ref FStar_Pervasives_Native.None 
let (tts : FStar_Syntax_Syntax.term -> Prims.string) =
  fun t  ->
    let uu____32 = FStar_ST.op_Bang tts_f  in
    match uu____32 with
    | FStar_Pervasives_Native.None  -> "<<hook unset>>"
    | FStar_Pervasives_Native.Some f -> f t
  
let (qual_id : FStar_Ident.lident -> FStar_Ident.ident -> FStar_Ident.lident)
  =
  fun lid  ->
    fun id1  ->
      let uu____91 =
        FStar_Ident.lid_of_ids
          (FStar_List.append lid.FStar_Ident.ns [lid.FStar_Ident.ident; id1])
         in
      FStar_Ident.set_lid_range uu____91 id1.FStar_Ident.idRange
  
let (mk_discriminator : FStar_Ident.lident -> FStar_Ident.lident) =
  fun lid  ->
    let uu____97 =
      let uu____100 =
        let uu____103 =
          FStar_Ident.mk_ident
            ((Prims.strcat FStar_Ident.reserved_prefix
                (Prims.strcat "is_"
                   (lid.FStar_Ident.ident).FStar_Ident.idText)),
              ((lid.FStar_Ident.ident).FStar_Ident.idRange))
           in
        [uu____103]  in
      FStar_List.append lid.FStar_Ident.ns uu____100  in
    FStar_Ident.lid_of_ids uu____97
  
let (is_name : FStar_Ident.lident -> Prims.bool) =
  fun lid  ->
    let c =
      FStar_Util.char_at (lid.FStar_Ident.ident).FStar_Ident.idText
        (Prims.parse_int "0")
       in
    FStar_Util.is_upper c
  
let arg_of_non_null_binder :
  'Auu____115 .
    (FStar_Syntax_Syntax.bv,'Auu____115) FStar_Pervasives_Native.tuple2 ->
      (FStar_Syntax_Syntax.term,'Auu____115) FStar_Pervasives_Native.tuple2
  =
  fun uu____128  ->
    match uu____128 with
    | (b,imp) ->
        let uu____135 = FStar_Syntax_Syntax.bv_to_name b  in (uu____135, imp)
  
let (args_of_non_null_binders :
  FStar_Syntax_Syntax.binders ->
    (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 Prims.list)
  =
  fun binders  ->
    FStar_All.pipe_right binders
      (FStar_List.collect
         (fun b  ->
            let uu____174 = FStar_Syntax_Syntax.is_null_binder b  in
            if uu____174
            then []
            else (let uu____186 = arg_of_non_null_binder b  in [uu____186])))
  
let (args_of_binders :
  FStar_Syntax_Syntax.binders ->
    (FStar_Syntax_Syntax.binders,FStar_Syntax_Syntax.args)
      FStar_Pervasives_Native.tuple2)
  =
  fun binders  ->
    let uu____212 =
      FStar_All.pipe_right binders
        (FStar_List.map
           (fun b  ->
              let uu____276 = FStar_Syntax_Syntax.is_null_binder b  in
              if uu____276
              then
                let b1 =
                  let uu____294 =
                    FStar_Syntax_Syntax.new_bv FStar_Pervasives_Native.None
                      (FStar_Pervasives_Native.fst b).FStar_Syntax_Syntax.sort
                     in
                  (uu____294, (FStar_Pervasives_Native.snd b))  in
                let uu____295 = arg_of_non_null_binder b1  in (b1, uu____295)
              else
                (let uu____309 = arg_of_non_null_binder b  in (b, uu____309))))
       in
    FStar_All.pipe_right uu____212 FStar_List.unzip
  
let (name_binders :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 Prims.list)
  =
  fun binders  ->
    FStar_All.pipe_right binders
      (FStar_List.mapi
         (fun i  ->
            fun b  ->
              let uu____409 = FStar_Syntax_Syntax.is_null_binder b  in
              if uu____409
              then
                let uu____414 = b  in
                match uu____414 with
                | (a,imp) ->
                    let b1 =
                      let uu____426 =
                        let uu____427 = FStar_Util.string_of_int i  in
                        Prims.strcat "_" uu____427  in
                      FStar_Ident.id_of_text uu____426  in
                    let b2 =
                      {
                        FStar_Syntax_Syntax.ppname = b1;
                        FStar_Syntax_Syntax.index = (Prims.parse_int "0");
                        FStar_Syntax_Syntax.sort =
                          (a.FStar_Syntax_Syntax.sort)
                      }  in
                    (b2, imp)
              else b))
  
let (name_function_binders :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_arrow (binders,comp) ->
        let uu____461 =
          let uu____468 =
            let uu____469 =
              let uu____482 = name_binders binders  in (uu____482, comp)  in
            FStar_Syntax_Syntax.Tm_arrow uu____469  in
          FStar_Syntax_Syntax.mk uu____468  in
        uu____461 FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
    | uu____500 -> t
  
let (null_binders_of_tks :
  (FStar_Syntax_Syntax.typ,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list -> FStar_Syntax_Syntax.binders)
  =
  fun tks  ->
    FStar_All.pipe_right tks
      (FStar_List.map
         (fun uu____536  ->
            match uu____536 with
            | (t,imp) ->
                let uu____547 =
                  let uu____548 = FStar_Syntax_Syntax.null_binder t  in
                  FStar_All.pipe_left FStar_Pervasives_Native.fst uu____548
                   in
                (uu____547, imp)))
  
let (binders_of_tks :
  (FStar_Syntax_Syntax.typ,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list -> FStar_Syntax_Syntax.binders)
  =
  fun tks  ->
    FStar_All.pipe_right tks
      (FStar_List.map
         (fun uu____592  ->
            match uu____592 with
            | (t,imp) ->
                let uu____609 =
                  FStar_Syntax_Syntax.new_bv
                    (FStar_Pervasives_Native.Some (t.FStar_Syntax_Syntax.pos))
                    t
                   in
                (uu____609, imp)))
  
let (binders_of_freevars :
  FStar_Syntax_Syntax.bv FStar_Util.set ->
    FStar_Syntax_Syntax.binder Prims.list)
  =
  fun fvs  ->
    let uu____621 = FStar_Util.set_elements fvs  in
    FStar_All.pipe_right uu____621
      (FStar_List.map FStar_Syntax_Syntax.mk_binder)
  
let mk_subst : 'Auu____632 . 'Auu____632 -> 'Auu____632 Prims.list =
  fun s  -> [s] 
let (subst_of_list :
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.args -> FStar_Syntax_Syntax.subst_t)
  =
  fun formals  ->
    fun actuals  ->
      if (FStar_List.length formals) = (FStar_List.length actuals)
      then
        FStar_List.fold_right2
          (fun f  ->
             fun a  ->
               fun out  ->
                 (FStar_Syntax_Syntax.NT
                    ((FStar_Pervasives_Native.fst f),
                      (FStar_Pervasives_Native.fst a)))
                 :: out) formals actuals []
      else failwith "Ill-formed substitution"
  
let (rename_binders :
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.binders -> FStar_Syntax_Syntax.subst_t)
  =
  fun replace_xs  ->
    fun with_ys  ->
      if (FStar_List.length replace_xs) = (FStar_List.length with_ys)
      then
        FStar_List.map2
          (fun uu____728  ->
             fun uu____729  ->
               match (uu____728, uu____729) with
               | ((x,uu____747),(y,uu____749)) ->
                   let uu____758 =
                     let uu____765 = FStar_Syntax_Syntax.bv_to_name y  in
                     (x, uu____765)  in
                   FStar_Syntax_Syntax.NT uu____758) replace_xs with_ys
      else failwith "Ill-formed substitution"
  
let rec (unmeta : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_meta (e2,uu____776) -> unmeta e2
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____782,uu____783) -> unmeta e2
    | uu____824 -> e1
  
let rec (unmeta_safe : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
  =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_meta (e',m) ->
        (match m with
         | FStar_Syntax_Syntax.Meta_monadic uu____837 -> e1
         | FStar_Syntax_Syntax.Meta_monadic_lift uu____844 -> e1
         | uu____853 -> unmeta_safe e')
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____855,uu____856) ->
        unmeta_safe e2
    | uu____897 -> e1
  
let rec (univ_kernel :
  FStar_Syntax_Syntax.universe ->
    (FStar_Syntax_Syntax.universe,Prims.int) FStar_Pervasives_Native.tuple2)
  =
  fun u  ->
    match u with
    | FStar_Syntax_Syntax.U_unknown  -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_name uu____911 -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_unif uu____912 -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_zero  -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_succ u1 ->
        let uu____922 = univ_kernel u1  in
        (match uu____922 with | (k,n1) -> (k, (n1 + (Prims.parse_int "1"))))
    | FStar_Syntax_Syntax.U_max uu____933 ->
        failwith "Imposible: univ_kernel (U_max _)"
    | FStar_Syntax_Syntax.U_bvar uu____940 ->
        failwith "Imposible: univ_kernel (U_bvar _)"
  
let (constant_univ_as_nat : FStar_Syntax_Syntax.universe -> Prims.int) =
  fun u  ->
    let uu____950 = univ_kernel u  in FStar_Pervasives_Native.snd uu____950
  
let rec (compare_univs :
  FStar_Syntax_Syntax.universe -> FStar_Syntax_Syntax.universe -> Prims.int)
  =
  fun u1  ->
    fun u2  ->
      match (u1, u2) with
      | (FStar_Syntax_Syntax.U_bvar uu____965,uu____966) ->
          failwith "Impossible: compare_univs"
      | (uu____967,FStar_Syntax_Syntax.U_bvar uu____968) ->
          failwith "Impossible: compare_univs"
      | (FStar_Syntax_Syntax.U_unknown ,FStar_Syntax_Syntax.U_unknown ) ->
          (Prims.parse_int "0")
      | (FStar_Syntax_Syntax.U_unknown ,uu____969) ->
          ~- (Prims.parse_int "1")
      | (uu____970,FStar_Syntax_Syntax.U_unknown ) -> (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_zero ,FStar_Syntax_Syntax.U_zero ) ->
          (Prims.parse_int "0")
      | (FStar_Syntax_Syntax.U_zero ,uu____971) -> ~- (Prims.parse_int "1")
      | (uu____972,FStar_Syntax_Syntax.U_zero ) -> (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_name u11,FStar_Syntax_Syntax.U_name u21) ->
          FStar_String.compare u11.FStar_Ident.idText u21.FStar_Ident.idText
      | (FStar_Syntax_Syntax.U_name uu____975,FStar_Syntax_Syntax.U_unif
         uu____976) -> ~- (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_unif uu____985,FStar_Syntax_Syntax.U_name
         uu____986) -> (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_unif u11,FStar_Syntax_Syntax.U_unif u21) ->
          let uu____1013 = FStar_Syntax_Unionfind.univ_uvar_id u11  in
          let uu____1014 = FStar_Syntax_Unionfind.univ_uvar_id u21  in
          uu____1013 - uu____1014
      | (FStar_Syntax_Syntax.U_max us1,FStar_Syntax_Syntax.U_max us2) ->
          let n1 = FStar_List.length us1  in
          let n2 = FStar_List.length us2  in
          if n1 <> n2
          then n1 - n2
          else
            (let copt =
               let uu____1045 = FStar_List.zip us1 us2  in
               FStar_Util.find_map uu____1045
                 (fun uu____1060  ->
                    match uu____1060 with
                    | (u11,u21) ->
                        let c = compare_univs u11 u21  in
                        if c <> (Prims.parse_int "0")
                        then FStar_Pervasives_Native.Some c
                        else FStar_Pervasives_Native.None)
                in
             match copt with
             | FStar_Pervasives_Native.None  -> (Prims.parse_int "0")
             | FStar_Pervasives_Native.Some c -> c)
      | (FStar_Syntax_Syntax.U_max uu____1074,uu____1075) ->
          ~- (Prims.parse_int "1")
      | (uu____1078,FStar_Syntax_Syntax.U_max uu____1079) ->
          (Prims.parse_int "1")
      | uu____1082 ->
          let uu____1087 = univ_kernel u1  in
          (match uu____1087 with
           | (k1,n1) ->
               let uu____1094 = univ_kernel u2  in
               (match uu____1094 with
                | (k2,n2) ->
                    let r = compare_univs k1 k2  in
                    if r = (Prims.parse_int "0") then n1 - n2 else r))
  
let (eq_univs :
  FStar_Syntax_Syntax.universe -> FStar_Syntax_Syntax.universe -> Prims.bool)
  =
  fun u1  ->
    fun u2  ->
      let uu____1113 = compare_univs u1 u2  in
      uu____1113 = (Prims.parse_int "0")
  
let (ml_comp :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Range.range -> FStar_Syntax_Syntax.comp)
  =
  fun t  ->
    fun r  ->
      let uu____1128 =
        let uu____1129 =
          FStar_Ident.set_lid_range FStar_Parser_Const.effect_ML_lid r  in
        {
          FStar_Syntax_Syntax.comp_univs = [FStar_Syntax_Syntax.U_zero];
          FStar_Syntax_Syntax.effect_name = uu____1129;
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = [FStar_Syntax_Syntax.MLEFFECT]
        }  in
      FStar_Syntax_Syntax.mk_Comp uu____1128
  
let (comp_effect_name :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> FStar_Ident.lident)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 -> c1.FStar_Syntax_Syntax.effect_name
    | FStar_Syntax_Syntax.Total uu____1146 ->
        FStar_Parser_Const.effect_Tot_lid
    | FStar_Syntax_Syntax.GTotal uu____1155 ->
        FStar_Parser_Const.effect_GTot_lid
  
let (comp_flags :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.cflags Prims.list)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total uu____1177 -> [FStar_Syntax_Syntax.TOTAL]
    | FStar_Syntax_Syntax.GTotal uu____1186 ->
        [FStar_Syntax_Syntax.SOMETRIVIAL]
    | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.flags
  
let (comp_to_comp_typ_nouniv :
  FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.comp_typ) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 -> c1
    | FStar_Syntax_Syntax.Total (t,u_opt) ->
        let uu____1212 =
          let uu____1215 = FStar_Util.map_opt u_opt (fun x  -> [x])  in
          FStar_Util.dflt [] uu____1215  in
        {
          FStar_Syntax_Syntax.comp_univs = uu____1212;
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
    | FStar_Syntax_Syntax.GTotal (t,u_opt) ->
        let uu____1242 =
          let uu____1245 = FStar_Util.map_opt u_opt (fun x  -> [x])  in
          FStar_Util.dflt [] uu____1245  in
        {
          FStar_Syntax_Syntax.comp_univs = uu____1242;
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
  
let (comp_set_flags :
  FStar_Syntax_Syntax.comp ->
    FStar_Syntax_Syntax.cflags Prims.list ->
      FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax)
  =
  fun c  ->
    fun f  ->
      let uu___118_1278 = c  in
      let uu____1279 =
        let uu____1280 =
          let uu___119_1281 = comp_to_comp_typ_nouniv c  in
          {
            FStar_Syntax_Syntax.comp_univs =
              (uu___119_1281.FStar_Syntax_Syntax.comp_univs);
            FStar_Syntax_Syntax.effect_name =
              (uu___119_1281.FStar_Syntax_Syntax.effect_name);
            FStar_Syntax_Syntax.result_typ =
              (uu___119_1281.FStar_Syntax_Syntax.result_typ);
            FStar_Syntax_Syntax.effect_args =
              (uu___119_1281.FStar_Syntax_Syntax.effect_args);
            FStar_Syntax_Syntax.flags = f
          }  in
        FStar_Syntax_Syntax.Comp uu____1280  in
      {
        FStar_Syntax_Syntax.n = uu____1279;
        FStar_Syntax_Syntax.pos = (uu___118_1278.FStar_Syntax_Syntax.pos);
        FStar_Syntax_Syntax.vars = (uu___118_1278.FStar_Syntax_Syntax.vars)
      }
  
let (lcomp_set_flags :
  FStar_Syntax_Syntax.lcomp ->
    FStar_Syntax_Syntax.cflags Prims.list -> FStar_Syntax_Syntax.lcomp)
  =
  fun lc  ->
    fun fs  ->
      let comp_typ_set_flags c =
        match c.FStar_Syntax_Syntax.n with
        | FStar_Syntax_Syntax.Total uu____1306 -> c
        | FStar_Syntax_Syntax.GTotal uu____1315 -> c
        | FStar_Syntax_Syntax.Comp ct ->
            let ct1 =
              let uu___120_1326 = ct  in
              {
                FStar_Syntax_Syntax.comp_univs =
                  (uu___120_1326.FStar_Syntax_Syntax.comp_univs);
                FStar_Syntax_Syntax.effect_name =
                  (uu___120_1326.FStar_Syntax_Syntax.effect_name);
                FStar_Syntax_Syntax.result_typ =
                  (uu___120_1326.FStar_Syntax_Syntax.result_typ);
                FStar_Syntax_Syntax.effect_args =
                  (uu___120_1326.FStar_Syntax_Syntax.effect_args);
                FStar_Syntax_Syntax.flags = fs
              }  in
            let uu___121_1327 = c  in
            {
              FStar_Syntax_Syntax.n = (FStar_Syntax_Syntax.Comp ct1);
              FStar_Syntax_Syntax.pos =
                (uu___121_1327.FStar_Syntax_Syntax.pos);
              FStar_Syntax_Syntax.vars =
                (uu___121_1327.FStar_Syntax_Syntax.vars)
            }
         in
      FStar_Syntax_Syntax.mk_lcomp lc.FStar_Syntax_Syntax.eff_name
        lc.FStar_Syntax_Syntax.res_typ fs
        (fun uu____1330  ->
           let uu____1331 = FStar_Syntax_Syntax.lcomp_comp lc  in
           comp_typ_set_flags uu____1331)
  
let (comp_to_comp_typ :
  FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.comp_typ) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 -> c1
    | FStar_Syntax_Syntax.Total (t,FStar_Pervasives_Native.Some u) ->
        {
          FStar_Syntax_Syntax.comp_univs = [u];
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
    | FStar_Syntax_Syntax.GTotal (t,FStar_Pervasives_Native.Some u) ->
        {
          FStar_Syntax_Syntax.comp_univs = [u];
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
    | uu____1366 ->
        failwith "Assertion failed: Computation type without universe"
  
let (is_named_tot :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 ->
        FStar_Ident.lid_equals c1.FStar_Syntax_Syntax.effect_name
          FStar_Parser_Const.effect_Tot_lid
    | FStar_Syntax_Syntax.Total uu____1377 -> true
    | FStar_Syntax_Syntax.GTotal uu____1386 -> false
  
let (is_total_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    (FStar_Ident.lid_equals (comp_effect_name c)
       FStar_Parser_Const.effect_Tot_lid)
      ||
      (FStar_All.pipe_right (comp_flags c)
         (FStar_Util.for_some
            (fun uu___106_1407  ->
               match uu___106_1407 with
               | FStar_Syntax_Syntax.TOTAL  -> true
               | FStar_Syntax_Syntax.RETURN  -> true
               | uu____1408 -> false)))
  
let (is_total_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun c  ->
    (FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name
       FStar_Parser_Const.effect_Tot_lid)
      ||
      (FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
         (FStar_Util.for_some
            (fun uu___107_1417  ->
               match uu___107_1417 with
               | FStar_Syntax_Syntax.TOTAL  -> true
               | FStar_Syntax_Syntax.RETURN  -> true
               | uu____1418 -> false)))
  
let (is_tot_or_gtot_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun c  ->
    ((FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name
        FStar_Parser_Const.effect_Tot_lid)
       ||
       (FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name
          FStar_Parser_Const.effect_GTot_lid))
      ||
      (FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
         (FStar_Util.for_some
            (fun uu___108_1427  ->
               match uu___108_1427 with
               | FStar_Syntax_Syntax.TOTAL  -> true
               | FStar_Syntax_Syntax.RETURN  -> true
               | uu____1428 -> false)))
  
let (is_partial_return :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    FStar_All.pipe_right (comp_flags c)
      (FStar_Util.for_some
         (fun uu___109_1441  ->
            match uu___109_1441 with
            | FStar_Syntax_Syntax.RETURN  -> true
            | FStar_Syntax_Syntax.PARTIAL_RETURN  -> true
            | uu____1442 -> false))
  
let (is_lcomp_partial_return : FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun c  ->
    FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
      (FStar_Util.for_some
         (fun uu___110_1451  ->
            match uu___110_1451 with
            | FStar_Syntax_Syntax.RETURN  -> true
            | FStar_Syntax_Syntax.PARTIAL_RETURN  -> true
            | uu____1452 -> false))
  
let (is_tot_or_gtot_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    (is_total_comp c) ||
      (FStar_Ident.lid_equals FStar_Parser_Const.effect_GTot_lid
         (comp_effect_name c))
  
let (is_pure_effect : FStar_Ident.lident -> Prims.bool) =
  fun l  ->
    ((FStar_Ident.lid_equals l FStar_Parser_Const.effect_Tot_lid) ||
       (FStar_Ident.lid_equals l FStar_Parser_Const.effect_PURE_lid))
      || (FStar_Ident.lid_equals l FStar_Parser_Const.effect_Pure_lid)
  
let (is_pure_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total uu____1476 -> true
    | FStar_Syntax_Syntax.GTotal uu____1485 -> false
    | FStar_Syntax_Syntax.Comp ct ->
        ((is_total_comp c) ||
           (is_pure_effect ct.FStar_Syntax_Syntax.effect_name))
          ||
          (FStar_All.pipe_right ct.FStar_Syntax_Syntax.flags
             (FStar_Util.for_some
                (fun uu___111_1498  ->
                   match uu___111_1498 with
                   | FStar_Syntax_Syntax.LEMMA  -> true
                   | uu____1499 -> false)))
  
let (is_ghost_effect : FStar_Ident.lident -> Prims.bool) =
  fun l  ->
    ((FStar_Ident.lid_equals FStar_Parser_Const.effect_GTot_lid l) ||
       (FStar_Ident.lid_equals FStar_Parser_Const.effect_GHOST_lid l))
      || (FStar_Ident.lid_equals FStar_Parser_Const.effect_Ghost_lid l)
  
let (is_div_effect : FStar_Ident.lident -> Prims.bool) =
  fun l  ->
    ((FStar_Ident.lid_equals l FStar_Parser_Const.effect_DIV_lid) ||
       (FStar_Ident.lid_equals l FStar_Parser_Const.effect_Div_lid))
      || (FStar_Ident.lid_equals l FStar_Parser_Const.effect_Dv_lid)
  
let (is_pure_or_ghost_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  -> (is_pure_comp c) || (is_ghost_effect (comp_effect_name c)) 
let (is_pure_or_ghost_effect : FStar_Ident.lident -> Prims.bool) =
  fun l  -> (is_pure_effect l) || (is_ghost_effect l) 
let (is_pure_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun lc  ->
    ((is_total_lcomp lc) || (is_pure_effect lc.FStar_Syntax_Syntax.eff_name))
      ||
      (FStar_All.pipe_right lc.FStar_Syntax_Syntax.cflags
         (FStar_Util.for_some
            (fun uu___112_1532  ->
               match uu___112_1532 with
               | FStar_Syntax_Syntax.LEMMA  -> true
               | uu____1533 -> false)))
  
let (is_pure_or_ghost_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun lc  ->
    (is_pure_lcomp lc) || (is_ghost_effect lc.FStar_Syntax_Syntax.eff_name)
  
let (is_pure_or_ghost_function : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____1544 =
      let uu____1545 = FStar_Syntax_Subst.compress t  in
      uu____1545.FStar_Syntax_Syntax.n  in
    match uu____1544 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____1546,c) -> is_pure_or_ghost_comp c
    | uu____1564 -> true
  
let (is_lemma_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp ct ->
        FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
          FStar_Parser_Const.effect_Lemma_lid
    | uu____1575 -> false
  
let (is_lemma : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____1581 =
      let uu____1582 = FStar_Syntax_Subst.compress t  in
      uu____1582.FStar_Syntax_Syntax.n  in
    match uu____1581 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____1583,c) -> is_lemma_comp c
    | uu____1601 -> false
  
let rec (head_of : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let uu____1607 =
      let uu____1608 = FStar_Syntax_Subst.compress t  in
      uu____1608.FStar_Syntax_Syntax.n  in
    match uu____1607 with
    | FStar_Syntax_Syntax.Tm_app (t1,uu____1610) -> head_of t1
    | FStar_Syntax_Syntax.Tm_match (t1,uu____1632) -> head_of t1
    | FStar_Syntax_Syntax.Tm_abs (uu____1669,t1,uu____1671) -> head_of t1
    | FStar_Syntax_Syntax.Tm_ascribed (t1,uu____1693,uu____1694) ->
        head_of t1
    | FStar_Syntax_Syntax.Tm_meta (t1,uu____1736) -> head_of t1
    | uu____1741 -> t
  
let (head_and_args :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,(FStar_Syntax_Syntax.term'
                                                             FStar_Syntax_Syntax.syntax,
                                                            FStar_Syntax_Syntax.aqual)
                                                            FStar_Pervasives_Native.tuple2
                                                            Prims.list)
      FStar_Pervasives_Native.tuple2)
  =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_app (head1,args) -> (head1, args)
    | uu____1808 -> (t1, [])
  
let rec (head_and_args' :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.term,(FStar_Syntax_Syntax.term'
                                 FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.aqual)
                                FStar_Pervasives_Native.tuple2 Prims.list)
      FStar_Pervasives_Native.tuple2)
  =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_app (head1,args) ->
        let uu____1877 = head_and_args' head1  in
        (match uu____1877 with
         | (head2,args') -> (head2, (FStar_List.append args' args)))
    | uu____1934 -> (t1, [])
  
let (un_uinst : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_uinst (t2,uu____1956) ->
        FStar_Syntax_Subst.compress t2
    | uu____1961 -> t1
  
let (is_smt_lemma : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____1967 =
      let uu____1968 = FStar_Syntax_Subst.compress t  in
      uu____1968.FStar_Syntax_Syntax.n  in
    match uu____1967 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____1969,c) ->
        (match c.FStar_Syntax_Syntax.n with
         | FStar_Syntax_Syntax.Comp ct when
             FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
               FStar_Parser_Const.effect_Lemma_lid
             ->
             (match ct.FStar_Syntax_Syntax.effect_args with
              | _req::_ens::(pats,uu____1991)::uu____1992 ->
                  let pats' = unmeta pats  in
                  let uu____2036 = head_and_args pats'  in
                  (match uu____2036 with
                   | (head1,uu____2052) ->
                       let uu____2073 =
                         let uu____2074 = un_uinst head1  in
                         uu____2074.FStar_Syntax_Syntax.n  in
                       (match uu____2073 with
                        | FStar_Syntax_Syntax.Tm_fvar fv ->
                            FStar_Syntax_Syntax.fv_eq_lid fv
                              FStar_Parser_Const.cons_lid
                        | uu____2076 -> false))
              | uu____2077 -> false)
         | uu____2086 -> false)
    | uu____2087 -> false
  
let (is_ml_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 ->
        (FStar_Ident.lid_equals c1.FStar_Syntax_Syntax.effect_name
           FStar_Parser_Const.effect_ML_lid)
          ||
          (FStar_All.pipe_right c1.FStar_Syntax_Syntax.flags
             (FStar_Util.for_some
                (fun uu___113_2101  ->
                   match uu___113_2101 with
                   | FStar_Syntax_Syntax.MLEFFECT  -> true
                   | uu____2102 -> false)))
    | uu____2103 -> false
  
let (comp_result :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total (t,uu____2118) -> t
    | FStar_Syntax_Syntax.GTotal (t,uu____2128) -> t
    | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.result_typ
  
let (set_result_typ :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.comp)
  =
  fun c  ->
    fun t  ->
      match c.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Total uu____2156 ->
          FStar_Syntax_Syntax.mk_Total t
      | FStar_Syntax_Syntax.GTotal uu____2165 ->
          FStar_Syntax_Syntax.mk_GTotal t
      | FStar_Syntax_Syntax.Comp ct ->
          FStar_Syntax_Syntax.mk_Comp
            (let uu___122_2177 = ct  in
             {
               FStar_Syntax_Syntax.comp_univs =
                 (uu___122_2177.FStar_Syntax_Syntax.comp_univs);
               FStar_Syntax_Syntax.effect_name =
                 (uu___122_2177.FStar_Syntax_Syntax.effect_name);
               FStar_Syntax_Syntax.result_typ = t;
               FStar_Syntax_Syntax.effect_args =
                 (uu___122_2177.FStar_Syntax_Syntax.effect_args);
               FStar_Syntax_Syntax.flags =
                 (uu___122_2177.FStar_Syntax_Syntax.flags)
             })
  
let (set_result_typ_lc :
  FStar_Syntax_Syntax.lcomp ->
    FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.lcomp)
  =
  fun lc  ->
    fun t  ->
      FStar_Syntax_Syntax.mk_lcomp lc.FStar_Syntax_Syntax.eff_name t
        lc.FStar_Syntax_Syntax.cflags
        (fun uu____2190  ->
           let uu____2191 = FStar_Syntax_Syntax.lcomp_comp lc  in
           set_result_typ uu____2191 t)
  
let (is_trivial_wp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    FStar_All.pipe_right (comp_flags c)
      (FStar_Util.for_some
         (fun uu___114_2204  ->
            match uu___114_2204 with
            | FStar_Syntax_Syntax.TOTAL  -> true
            | FStar_Syntax_Syntax.RETURN  -> true
            | uu____2205 -> false))
  
let (comp_effect_args : FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.args)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total uu____2211 -> []
    | FStar_Syntax_Syntax.GTotal uu____2226 -> []
    | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.effect_args
  
let (primops : FStar_Ident.lident Prims.list) =
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
  FStar_Parser_Const.op_Negation] 
let (is_primop_lid : FStar_Ident.lident -> Prims.bool) =
  fun l  ->
    FStar_All.pipe_right primops
      (FStar_Util.for_some (FStar_Ident.lid_equals l))
  
let (is_primop :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun f  ->
    match f.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        is_primop_lid (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
    | uu____2261 -> false
  
let rec (unascribe : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____2269,uu____2270) ->
        unascribe e2
    | uu____2311 -> e1
  
let rec (ascribe :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    ((FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.comp'
                                                             FStar_Syntax_Syntax.syntax)
       FStar_Util.either,FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
                           FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple2 ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    fun k  ->
      match t.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_ascribed (t',uu____2363,uu____2364) ->
          ascribe t' k
      | uu____2405 ->
          FStar_Syntax_Syntax.mk
            (FStar_Syntax_Syntax.Tm_ascribed
               (t, k, FStar_Pervasives_Native.None))
            FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
  
let (unfold_lazy : FStar_Syntax_Syntax.lazyinfo -> FStar_Syntax_Syntax.term)
  =
  fun i  ->
    let uu____2431 =
      let uu____2440 = FStar_ST.op_Bang FStar_Syntax_Syntax.lazy_chooser  in
      FStar_Util.must uu____2440  in
    uu____2431 i.FStar_Syntax_Syntax.lkind i
  
let rec (unlazy : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let uu____2499 =
      let uu____2500 = FStar_Syntax_Subst.compress t  in
      uu____2500.FStar_Syntax_Syntax.n  in
    match uu____2499 with
    | FStar_Syntax_Syntax.Tm_lazy i ->
        let uu____2502 = unfold_lazy i  in
        FStar_All.pipe_left unlazy uu____2502
    | uu____2503 -> t
  
let rec unlazy_as_t :
  'Auu____2510 .
    FStar_Syntax_Syntax.lazy_kind -> FStar_Syntax_Syntax.term -> 'Auu____2510
  =
  fun k  ->
    fun t  ->
      let uu____2521 =
        let uu____2522 = FStar_Syntax_Subst.compress t  in
        uu____2522.FStar_Syntax_Syntax.n  in
      match uu____2521 with
      | FStar_Syntax_Syntax.Tm_lazy
          { FStar_Syntax_Syntax.blob = v1; FStar_Syntax_Syntax.lkind = k';
            FStar_Syntax_Syntax.typ = uu____2525;
            FStar_Syntax_Syntax.rng = uu____2526;_}
          when k = k' -> FStar_Dyn.undyn v1
      | uu____2529 -> failwith "Not a Tm_lazy of the expected kind"
  
let mk_lazy :
  'a .
    'a ->
      FStar_Syntax_Syntax.typ ->
        FStar_Syntax_Syntax.lazy_kind ->
          FStar_Range.range FStar_Pervasives_Native.option ->
            FStar_Syntax_Syntax.term
  =
  fun t  ->
    fun typ  ->
      fun k  ->
        fun r  ->
          let rng =
            match r with
            | FStar_Pervasives_Native.Some r1 -> r1
            | FStar_Pervasives_Native.None  -> FStar_Range.dummyRange  in
          let i =
            let uu____2568 = FStar_Dyn.mkdyn t  in
            {
              FStar_Syntax_Syntax.blob = uu____2568;
              FStar_Syntax_Syntax.lkind = k;
              FStar_Syntax_Syntax.typ = typ;
              FStar_Syntax_Syntax.rng = rng
            }  in
          FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_lazy i)
            FStar_Pervasives_Native.None rng
  
let (canon_app :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    let uu____2580 =
      let uu____2593 = unascribe t  in head_and_args' uu____2593  in
    match uu____2580 with
    | (hd1,args) ->
        FStar_Syntax_Syntax.mk_Tm_app hd1 args FStar_Pervasives_Native.None
          t.FStar_Syntax_Syntax.pos
  
type eq_result =
  | Equal 
  | NotEqual 
  | Unknown 
let (uu___is_Equal : eq_result -> Prims.bool) =
  fun projectee  ->
    match projectee with | Equal  -> true | uu____2619 -> false
  
let (uu___is_NotEqual : eq_result -> Prims.bool) =
  fun projectee  ->
    match projectee with | NotEqual  -> true | uu____2625 -> false
  
let (uu___is_Unknown : eq_result -> Prims.bool) =
  fun projectee  ->
    match projectee with | Unknown  -> true | uu____2631 -> false
  
let (injectives : Prims.string Prims.list) =
  ["FStar.Int8.int_to_t";
  "FStar.Int16.int_to_t";
  "FStar.Int32.int_to_t";
  "FStar.Int64.int_to_t";
  "FStar.UInt8.uint_to_t";
  "FStar.UInt16.uint_to_t";
  "FStar.UInt32.uint_to_t";
  "FStar.UInt64.uint_to_t";
  "FStar.Int8.__int_to_t";
  "FStar.Int16.__int_to_t";
  "FStar.Int32.__int_to_t";
  "FStar.Int64.__int_to_t";
  "FStar.UInt8.__uint_to_t";
  "FStar.UInt16.__uint_to_t";
  "FStar.UInt32.__uint_to_t";
  "FStar.UInt64.__uint_to_t"] 
let rec (eq_tm :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> eq_result) =
  fun t1  ->
    fun t2  ->
      let t11 = canon_app t1  in
      let t21 = canon_app t2  in
      let equal_if uu___115_2707 = if uu___115_2707 then Equal else Unknown
         in
      let equal_iff uu___116_2714 = if uu___116_2714 then Equal else NotEqual
         in
      let eq_and f g = match f with | Equal  -> g () | uu____2732 -> Unknown
         in
      let eq_inj f g =
        match (f, g) with
        | (Equal ,Equal ) -> Equal
        | (NotEqual ,uu____2744) -> NotEqual
        | (uu____2745,NotEqual ) -> NotEqual
        | (Unknown ,uu____2746) -> Unknown
        | (uu____2747,Unknown ) -> Unknown  in
      let equal_data f1 args1 f2 args2 =
        let uu____2793 = FStar_Syntax_Syntax.fv_eq f1 f2  in
        if uu____2793
        then
          let uu____2795 = FStar_List.zip args1 args2  in
          FStar_All.pipe_left
            (FStar_List.fold_left
               (fun acc  ->
                  fun uu____2853  ->
                    match uu____2853 with
                    | ((a1,q1),(a2,q2)) ->
                        let uu____2879 = eq_tm a1 a2  in
                        eq_inj acc uu____2879) Equal) uu____2795
        else NotEqual  in
      let uu____2881 =
        let uu____2886 =
          let uu____2887 = unmeta t11  in uu____2887.FStar_Syntax_Syntax.n
           in
        let uu____2888 =
          let uu____2889 = unmeta t21  in uu____2889.FStar_Syntax_Syntax.n
           in
        (uu____2886, uu____2888)  in
      match uu____2881 with
      | (FStar_Syntax_Syntax.Tm_bvar bv1,FStar_Syntax_Syntax.Tm_bvar bv2) ->
          equal_if
            (bv1.FStar_Syntax_Syntax.index = bv2.FStar_Syntax_Syntax.index)
      | (FStar_Syntax_Syntax.Tm_lazy uu____2892,uu____2893) ->
          let uu____2894 = unlazy t11  in eq_tm uu____2894 t21
      | (uu____2895,FStar_Syntax_Syntax.Tm_lazy uu____2896) ->
          let uu____2897 = unlazy t21  in eq_tm t11 uu____2897
      | (FStar_Syntax_Syntax.Tm_name a,FStar_Syntax_Syntax.Tm_name b) ->
          equal_if (FStar_Syntax_Syntax.bv_eq a b)
      | (FStar_Syntax_Syntax.Tm_fvar f,FStar_Syntax_Syntax.Tm_fvar g) ->
          if
            (f.FStar_Syntax_Syntax.fv_qual =
               (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor))
              &&
              (g.FStar_Syntax_Syntax.fv_qual =
                 (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor))
          then equal_data f [] g []
          else
            (let uu____2915 = FStar_Syntax_Syntax.fv_eq f g  in
             equal_if uu____2915)
      | (FStar_Syntax_Syntax.Tm_uinst (f,us),FStar_Syntax_Syntax.Tm_uinst
         (g,vs)) ->
          let uu____2928 = eq_tm f g  in
          eq_and uu____2928
            (fun uu____2931  ->
               let uu____2932 = eq_univs_list us vs  in equal_if uu____2932)
      | (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_range
         uu____2933),uu____2934) -> Unknown
      | (uu____2935,FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_range
         uu____2936)) -> Unknown
      | (FStar_Syntax_Syntax.Tm_constant c,FStar_Syntax_Syntax.Tm_constant d)
          ->
          let uu____2939 = FStar_Const.eq_const c d  in equal_iff uu____2939
      | (FStar_Syntax_Syntax.Tm_uvar
         (u1,([],uu____2941)),FStar_Syntax_Syntax.Tm_uvar
         (u2,([],uu____2943))) ->
          let uu____2972 =
            FStar_Syntax_Unionfind.equiv u1.FStar_Syntax_Syntax.ctx_uvar_head
              u2.FStar_Syntax_Syntax.ctx_uvar_head
             in
          equal_if uu____2972
      | (FStar_Syntax_Syntax.Tm_app (h1,args1),FStar_Syntax_Syntax.Tm_app
         (h2,args2)) ->
          let uu____3017 =
            let uu____3022 =
              let uu____3023 = un_uinst h1  in
              uu____3023.FStar_Syntax_Syntax.n  in
            let uu____3024 =
              let uu____3025 = un_uinst h2  in
              uu____3025.FStar_Syntax_Syntax.n  in
            (uu____3022, uu____3024)  in
          (match uu____3017 with
           | (FStar_Syntax_Syntax.Tm_fvar f1,FStar_Syntax_Syntax.Tm_fvar f2)
               when
               (f1.FStar_Syntax_Syntax.fv_qual =
                  (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor))
                 &&
                 (f2.FStar_Syntax_Syntax.fv_qual =
                    (FStar_Pervasives_Native.Some
                       FStar_Syntax_Syntax.Data_ctor))
               -> equal_data f1 args1 f2 args2
           | (FStar_Syntax_Syntax.Tm_fvar f1,FStar_Syntax_Syntax.Tm_fvar f2)
               when
               (FStar_Syntax_Syntax.fv_eq f1 f2) &&
                 (let uu____3035 =
                    let uu____3036 = FStar_Syntax_Syntax.lid_of_fv f1  in
                    FStar_Ident.string_of_lid uu____3036  in
                  FStar_List.mem uu____3035 injectives)
               -> equal_data f1 args1 f2 args2
           | uu____3037 ->
               let uu____3042 = eq_tm h1 h2  in
               eq_and uu____3042 (fun uu____3044  -> eq_args args1 args2))
      | (FStar_Syntax_Syntax.Tm_match (t12,bs1),FStar_Syntax_Syntax.Tm_match
         (t22,bs2)) ->
          if (FStar_List.length bs1) = (FStar_List.length bs2)
          then
            let uu____3149 = FStar_List.zip bs1 bs2  in
            let uu____3212 = eq_tm t12 t22  in
            FStar_List.fold_right
              (fun uu____3249  ->
                 fun a  ->
                   match uu____3249 with
                   | (b1,b2) ->
                       eq_and a (fun uu____3342  -> branch_matches b1 b2))
              uu____3149 uu____3212
          else Unknown
      | (FStar_Syntax_Syntax.Tm_type u,FStar_Syntax_Syntax.Tm_type v1) ->
          let uu____3346 = eq_univs u v1  in equal_if uu____3346
      | (FStar_Syntax_Syntax.Tm_quoted (t12,q1),FStar_Syntax_Syntax.Tm_quoted
         (t22,q2)) -> if q1 = q2 then eq_tm t12 t22 else Unknown
      | (FStar_Syntax_Syntax.Tm_refine
         (t12,phi1),FStar_Syntax_Syntax.Tm_refine (t22,phi2)) ->
          let uu____3372 =
            eq_tm t12.FStar_Syntax_Syntax.sort t22.FStar_Syntax_Syntax.sort
             in
          eq_and uu____3372 (fun uu____3374  -> eq_tm phi1 phi2)
      | uu____3375 -> Unknown

and (branch_matches :
  (FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t,FStar_Syntax_Syntax.term'
                                                             FStar_Syntax_Syntax.syntax
                                                             FStar_Pervasives_Native.option,
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
    FStar_Pervasives_Native.tuple3 ->
    (FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t,FStar_Syntax_Syntax.term'
                                                               FStar_Syntax_Syntax.syntax
                                                               FStar_Pervasives_Native.option,
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple3 -> eq_result)
  =
  fun b1  ->
    fun b2  ->
      let related_by f o1 o2 =
        match (o1, o2) with
        | (FStar_Pervasives_Native.None ,FStar_Pervasives_Native.None ) ->
            true
        | (FStar_Pervasives_Native.Some x,FStar_Pervasives_Native.Some y) ->
            f x y
        | (uu____3458,uu____3459) -> false  in
      let uu____3468 = b1  in
      match uu____3468 with
      | (p1,w1,t1) ->
          let uu____3502 = b2  in
          (match uu____3502 with
           | (p2,w2,t2) ->
               let uu____3536 = FStar_Syntax_Syntax.eq_pat p1 p2  in
               if uu____3536
               then
                 let uu____3537 =
                   (let uu____3540 = eq_tm t1 t2  in uu____3540 = Equal) &&
                     (related_by
                        (fun t11  ->
                           fun t21  ->
                             let uu____3549 = eq_tm t11 t21  in
                             uu____3549 = Equal) w1 w2)
                    in
                 (if uu____3537 then Equal else Unknown)
               else Unknown)

and (eq_args :
  FStar_Syntax_Syntax.args -> FStar_Syntax_Syntax.args -> eq_result) =
  fun a1  ->
    fun a2  ->
      match (a1, a2) with
      | ([],[]) -> Equal
      | ((a,uu____3599)::a11,(b,uu____3602)::b1) ->
          let uu____3656 = eq_tm a b  in
          (match uu____3656 with
           | Equal  -> eq_args a11 b1
           | uu____3657 -> Unknown)
      | uu____3658 -> Unknown

and (eq_univs_list :
  FStar_Syntax_Syntax.universes ->
    FStar_Syntax_Syntax.universes -> Prims.bool)
  =
  fun us  ->
    fun vs  ->
      ((FStar_List.length us) = (FStar_List.length vs)) &&
        (FStar_List.forall2 eq_univs us vs)

let rec (unrefine : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_refine (x,uu____3688) ->
        unrefine x.FStar_Syntax_Syntax.sort
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____3694,uu____3695) ->
        unrefine t2
    | uu____3736 -> t1
  
let rec (is_uvar : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____3742 =
      let uu____3743 = FStar_Syntax_Subst.compress t  in
      uu____3743.FStar_Syntax_Syntax.n  in
    match uu____3742 with
    | FStar_Syntax_Syntax.Tm_uvar uu____3744 -> true
    | FStar_Syntax_Syntax.Tm_uinst (t1,uu____3758) -> is_uvar t1
    | FStar_Syntax_Syntax.Tm_app uu____3763 ->
        let uu____3778 =
          let uu____3779 = FStar_All.pipe_right t head_and_args  in
          FStar_All.pipe_right uu____3779 FStar_Pervasives_Native.fst  in
        FStar_All.pipe_right uu____3778 is_uvar
    | FStar_Syntax_Syntax.Tm_ascribed (t1,uu____3833,uu____3834) ->
        is_uvar t1
    | uu____3875 -> false
  
let rec (is_unit : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____3881 =
      let uu____3882 = unrefine t  in uu____3882.FStar_Syntax_Syntax.n  in
    match uu____3881 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        ((FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.unit_lid) ||
           (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid))
          ||
          (FStar_Syntax_Syntax.fv_eq_lid fv
             FStar_Parser_Const.auto_squash_lid)
    | FStar_Syntax_Syntax.Tm_uinst (t1,uu____3885) -> is_unit t1
    | uu____3890 -> false
  
let rec (non_informative : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____3896 =
      let uu____3897 = unrefine t  in uu____3897.FStar_Syntax_Syntax.n  in
    match uu____3896 with
    | FStar_Syntax_Syntax.Tm_type uu____3898 -> true
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        ((FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.unit_lid) ||
           (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid))
          || (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.erased_lid)
    | FStar_Syntax_Syntax.Tm_app (head1,uu____3901) -> non_informative head1
    | FStar_Syntax_Syntax.Tm_uinst (t1,uu____3923) -> non_informative t1
    | FStar_Syntax_Syntax.Tm_arrow (uu____3928,c) ->
        (is_tot_or_gtot_comp c) && (non_informative (comp_result c))
    | uu____3946 -> false
  
let (is_fun : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun e  ->
    let uu____3952 =
      let uu____3953 = FStar_Syntax_Subst.compress e  in
      uu____3953.FStar_Syntax_Syntax.n  in
    match uu____3952 with
    | FStar_Syntax_Syntax.Tm_abs uu____3954 -> true
    | uu____3971 -> false
  
let (is_function_typ : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____3977 =
      let uu____3978 = FStar_Syntax_Subst.compress t  in
      uu____3978.FStar_Syntax_Syntax.n  in
    match uu____3977 with
    | FStar_Syntax_Syntax.Tm_arrow uu____3979 -> true
    | uu____3992 -> false
  
let rec (pre_typ : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_refine (x,uu____4000) ->
        pre_typ x.FStar_Syntax_Syntax.sort
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____4006,uu____4007) ->
        pre_typ t2
    | uu____4048 -> t1
  
let (destruct :
  FStar_Syntax_Syntax.term ->
    FStar_Ident.lident ->
      (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.aqual)
        FStar_Pervasives_Native.tuple2 Prims.list
        FStar_Pervasives_Native.option)
  =
  fun typ  ->
    fun lid  ->
      let typ1 = FStar_Syntax_Subst.compress typ  in
      let uu____4070 =
        let uu____4071 = un_uinst typ1  in uu____4071.FStar_Syntax_Syntax.n
         in
      match uu____4070 with
      | FStar_Syntax_Syntax.Tm_app (head1,args) ->
          let head2 = un_uinst head1  in
          (match head2.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Tm_fvar tc when
               FStar_Syntax_Syntax.fv_eq_lid tc lid ->
               FStar_Pervasives_Native.Some args
           | uu____4124 -> FStar_Pervasives_Native.None)
      | FStar_Syntax_Syntax.Tm_fvar tc when
          FStar_Syntax_Syntax.fv_eq_lid tc lid ->
          FStar_Pervasives_Native.Some []
      | uu____4148 -> FStar_Pervasives_Native.None
  
let (lids_of_sigelt :
  FStar_Syntax_Syntax.sigelt -> FStar_Ident.lident Prims.list) =
  fun se  ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_let (uu____4166,lids) -> lids
    | FStar_Syntax_Syntax.Sig_splice (lids,uu____4173) -> lids
    | FStar_Syntax_Syntax.Sig_bundle (uu____4178,lids) -> lids
    | FStar_Syntax_Syntax.Sig_inductive_typ
        (lid,uu____4189,uu____4190,uu____4191,uu____4192,uu____4193) -> 
        [lid]
    | FStar_Syntax_Syntax.Sig_effect_abbrev
        (lid,uu____4203,uu____4204,uu____4205,uu____4206) -> [lid]
    | FStar_Syntax_Syntax.Sig_datacon
        (lid,uu____4212,uu____4213,uu____4214,uu____4215,uu____4216) -> 
        [lid]
    | FStar_Syntax_Syntax.Sig_declare_typ (lid,uu____4222,uu____4223) ->
        [lid]
    | FStar_Syntax_Syntax.Sig_assume (lid,uu____4225,uu____4226) -> [lid]
    | FStar_Syntax_Syntax.Sig_new_effect_for_free n1 ->
        [n1.FStar_Syntax_Syntax.mname]
    | FStar_Syntax_Syntax.Sig_new_effect n1 -> [n1.FStar_Syntax_Syntax.mname]
    | FStar_Syntax_Syntax.Sig_sub_effect uu____4229 -> []
    | FStar_Syntax_Syntax.Sig_pragma uu____4230 -> []
    | FStar_Syntax_Syntax.Sig_main uu____4231 -> []
  
let (lid_of_sigelt :
  FStar_Syntax_Syntax.sigelt ->
    FStar_Ident.lident FStar_Pervasives_Native.option)
  =
  fun se  ->
    match lids_of_sigelt se with
    | l::[] -> FStar_Pervasives_Native.Some l
    | uu____4244 -> FStar_Pervasives_Native.None
  
let (quals_of_sigelt :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.qualifier Prims.list) =
  fun x  -> x.FStar_Syntax_Syntax.sigquals 
let (range_of_sigelt : FStar_Syntax_Syntax.sigelt -> FStar_Range.range) =
  fun x  -> x.FStar_Syntax_Syntax.sigrng 
let (range_of_lbname :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
    FStar_Range.range)
  =
  fun uu___117_4267  ->
    match uu___117_4267 with
    | FStar_Util.Inl x -> FStar_Syntax_Syntax.range_of_bv x
    | FStar_Util.Inr fv ->
        FStar_Ident.range_of_lid
          (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
  
let range_of_arg :
  'Auu____4280 'Auu____4281 .
    ('Auu____4280 FStar_Syntax_Syntax.syntax,'Auu____4281)
      FStar_Pervasives_Native.tuple2 -> FStar_Range.range
  =
  fun uu____4292  ->
    match uu____4292 with | (hd1,uu____4300) -> hd1.FStar_Syntax_Syntax.pos
  
let range_of_args :
  'Auu____4313 'Auu____4314 .
    ('Auu____4313 FStar_Syntax_Syntax.syntax,'Auu____4314)
      FStar_Pervasives_Native.tuple2 Prims.list ->
      FStar_Range.range -> FStar_Range.range
  =
  fun args  ->
    fun r  ->
      FStar_All.pipe_right args
        (FStar_List.fold_left
           (fun r1  -> fun a  -> FStar_Range.union_ranges r1 (range_of_arg a))
           r)
  
let (mk_app :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 Prims.list ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun f  ->
    fun args  ->
      match args with
      | [] -> f
      | uu____4405 ->
          let r = range_of_args args f.FStar_Syntax_Syntax.pos  in
          FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app (f, args))
            FStar_Pervasives_Native.None r
  
let (mk_data :
  FStar_Ident.lident ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 Prims.list ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
        FStar_Syntax_Syntax.syntax)
  =
  fun l  ->
    fun args  ->
      match args with
      | [] ->
          let uu____4465 = FStar_Ident.range_of_lid l  in
          let uu____4466 =
            let uu____4475 =
              FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.delta_constant
                (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
               in
            FStar_Syntax_Syntax.mk uu____4475  in
          uu____4466 FStar_Pervasives_Native.None uu____4465
      | uu____4481 ->
          let e =
            let uu____4493 =
              FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.delta_constant
                (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
               in
            mk_app uu____4493 args  in
          FStar_Syntax_Syntax.mk e FStar_Pervasives_Native.None
            e.FStar_Syntax_Syntax.pos
  
let (mangle_field_name : FStar_Ident.ident -> FStar_Ident.ident) =
  fun x  ->
    FStar_Ident.mk_ident
      ((Prims.strcat "__fname__" x.FStar_Ident.idText),
        (x.FStar_Ident.idRange))
  
let (unmangle_field_name : FStar_Ident.ident -> FStar_Ident.ident) =
  fun x  ->
    if FStar_Util.starts_with x.FStar_Ident.idText "__fname__"
    then
      let uu____4506 =
        let uu____4511 =
          FStar_Util.substring_from x.FStar_Ident.idText
            (Prims.parse_int "9")
           in
        (uu____4511, (x.FStar_Ident.idRange))  in
      FStar_Ident.mk_ident uu____4506
    else x
  
let (field_projector_prefix : Prims.string) = "__proj__" 
let (field_projector_sep : Prims.string) = "__item__" 
let (field_projector_contains_constructor : Prims.string -> Prims.bool) =
  fun s  -> FStar_Util.starts_with s field_projector_prefix 
let (mk_field_projector_name_from_string :
  Prims.string -> Prims.string -> Prims.string) =
  fun constr  ->
    fun field  ->
      Prims.strcat field_projector_prefix
        (Prims.strcat constr (Prims.strcat field_projector_sep field))
  
let (mk_field_projector_name_from_ident :
  FStar_Ident.lident -> FStar_Ident.ident -> FStar_Ident.lident) =
  fun lid  ->
    fun i  ->
      let j = unmangle_field_name i  in
      let jtext = j.FStar_Ident.idText  in
      let newi =
        if field_projector_contains_constructor jtext
        then j
        else
          FStar_Ident.mk_ident
            ((mk_field_projector_name_from_string
                (lid.FStar_Ident.ident).FStar_Ident.idText jtext),
              (i.FStar_Ident.idRange))
         in
      FStar_Ident.lid_of_ids (FStar_List.append lid.FStar_Ident.ns [newi])
  
let (mk_field_projector_name :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.bv ->
      Prims.int ->
        (FStar_Ident.lident,FStar_Syntax_Syntax.bv)
          FStar_Pervasives_Native.tuple2)
  =
  fun lid  ->
    fun x  ->
      fun i  ->
        let nm =
          let uu____4562 = FStar_Syntax_Syntax.is_null_bv x  in
          if uu____4562
          then
            let uu____4563 =
              let uu____4568 =
                let uu____4569 = FStar_Util.string_of_int i  in
                Prims.strcat "_" uu____4569  in
              let uu____4570 = FStar_Syntax_Syntax.range_of_bv x  in
              (uu____4568, uu____4570)  in
            FStar_Ident.mk_ident uu____4563
          else x.FStar_Syntax_Syntax.ppname  in
        let y =
          let uu___123_4573 = x  in
          {
            FStar_Syntax_Syntax.ppname = nm;
            FStar_Syntax_Syntax.index =
              (uu___123_4573.FStar_Syntax_Syntax.index);
            FStar_Syntax_Syntax.sort =
              (uu___123_4573.FStar_Syntax_Syntax.sort)
          }  in
        let uu____4574 = mk_field_projector_name_from_ident lid nm  in
        (uu____4574, y)
  
let (ses_of_sigbundle :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.sigelt Prims.list) =
  fun se  ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_bundle (ses,uu____4585) -> ses
    | uu____4594 -> failwith "ses_of_sigbundle: not a Sig_bundle"
  
let (eff_decl_of_new_effect :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.eff_decl) =
  fun se  ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_new_effect ne -> ne
    | uu____4603 -> failwith "eff_decl_of_new_effect: not a Sig_new_effect"
  
let (set_uvar : FStar_Syntax_Syntax.uvar -> FStar_Syntax_Syntax.term -> unit)
  =
  fun uv  ->
    fun t  ->
      let uu____4614 = FStar_Syntax_Unionfind.find uv  in
      match uu____4614 with
      | FStar_Pervasives_Native.Some uu____4617 ->
          let uu____4618 =
            let uu____4619 =
              let uu____4620 = FStar_Syntax_Unionfind.uvar_id uv  in
              FStar_All.pipe_left FStar_Util.string_of_int uu____4620  in
            FStar_Util.format1 "Changing a fixed uvar! ?%s\n" uu____4619  in
          failwith uu____4618
      | uu____4621 -> FStar_Syntax_Unionfind.change uv t
  
let (qualifier_equal :
  FStar_Syntax_Syntax.qualifier ->
    FStar_Syntax_Syntax.qualifier -> Prims.bool)
  =
  fun q1  ->
    fun q2  ->
      match (q1, q2) with
      | (FStar_Syntax_Syntax.Discriminator
         l1,FStar_Syntax_Syntax.Discriminator l2) ->
          FStar_Ident.lid_equals l1 l2
      | (FStar_Syntax_Syntax.Projector
         (l1a,l1b),FStar_Syntax_Syntax.Projector (l2a,l2b)) ->
          (FStar_Ident.lid_equals l1a l2a) &&
            (l1b.FStar_Ident.idText = l2b.FStar_Ident.idText)
      | (FStar_Syntax_Syntax.RecordType
         (ns1,f1),FStar_Syntax_Syntax.RecordType (ns2,f2)) ->
          ((((FStar_List.length ns1) = (FStar_List.length ns2)) &&
              (FStar_List.forall2
                 (fun x1  ->
                    fun x2  -> x1.FStar_Ident.idText = x2.FStar_Ident.idText)
                 f1 f2))
             && ((FStar_List.length f1) = (FStar_List.length f2)))
            &&
            (FStar_List.forall2
               (fun x1  ->
                  fun x2  -> x1.FStar_Ident.idText = x2.FStar_Ident.idText)
               f1 f2)
      | (FStar_Syntax_Syntax.RecordConstructor
         (ns1,f1),FStar_Syntax_Syntax.RecordConstructor (ns2,f2)) ->
          ((((FStar_List.length ns1) = (FStar_List.length ns2)) &&
              (FStar_List.forall2
                 (fun x1  ->
                    fun x2  -> x1.FStar_Ident.idText = x2.FStar_Ident.idText)
                 f1 f2))
             && ((FStar_List.length f1) = (FStar_List.length f2)))
            &&
            (FStar_List.forall2
               (fun x1  ->
                  fun x2  -> x1.FStar_Ident.idText = x2.FStar_Ident.idText)
               f1 f2)
      | uu____4696 -> q1 = q2
  
let (abs :
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.residual_comp FStar_Pervasives_Native.option ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun bs  ->
    fun t  ->
      fun lopt  ->
        let close_lopt lopt1 =
          match lopt1 with
          | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.None
          | FStar_Pervasives_Native.Some rc ->
              let uu____4741 =
                let uu___124_4742 = rc  in
                let uu____4743 =
                  FStar_Util.map_opt rc.FStar_Syntax_Syntax.residual_typ
                    (FStar_Syntax_Subst.close bs)
                   in
                {
                  FStar_Syntax_Syntax.residual_effect =
                    (uu___124_4742.FStar_Syntax_Syntax.residual_effect);
                  FStar_Syntax_Syntax.residual_typ = uu____4743;
                  FStar_Syntax_Syntax.residual_flags =
                    (uu___124_4742.FStar_Syntax_Syntax.residual_flags)
                }  in
              FStar_Pervasives_Native.Some uu____4741
           in
        match bs with
        | [] -> t
        | uu____4758 ->
            let body =
              let uu____4760 = FStar_Syntax_Subst.close bs t  in
              FStar_Syntax_Subst.compress uu____4760  in
            (match ((body.FStar_Syntax_Syntax.n), lopt) with
             | (FStar_Syntax_Syntax.Tm_abs
                (bs',t1,lopt'),FStar_Pervasives_Native.None ) ->
                 let uu____4790 =
                   let uu____4797 =
                     let uu____4798 =
                       let uu____4815 =
                         let uu____4822 = FStar_Syntax_Subst.close_binders bs
                            in
                         FStar_List.append uu____4822 bs'  in
                       let uu____4827 = close_lopt lopt'  in
                       (uu____4815, t1, uu____4827)  in
                     FStar_Syntax_Syntax.Tm_abs uu____4798  in
                   FStar_Syntax_Syntax.mk uu____4797  in
                 uu____4790 FStar_Pervasives_Native.None
                   t1.FStar_Syntax_Syntax.pos
             | uu____4843 ->
                 let uu____4850 =
                   let uu____4857 =
                     let uu____4858 =
                       let uu____4875 = FStar_Syntax_Subst.close_binders bs
                          in
                       let uu____4876 = close_lopt lopt  in
                       (uu____4875, body, uu____4876)  in
                     FStar_Syntax_Syntax.Tm_abs uu____4858  in
                   FStar_Syntax_Syntax.mk uu____4857  in
                 uu____4850 FStar_Pervasives_Native.None
                   t.FStar_Syntax_Syntax.pos)
  
let (arrow :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun bs  ->
    fun c  ->
      match bs with
      | [] -> comp_result c
      | uu____4926 ->
          let uu____4933 =
            let uu____4940 =
              let uu____4941 =
                let uu____4954 = FStar_Syntax_Subst.close_binders bs  in
                let uu____4955 = FStar_Syntax_Subst.close_comp bs c  in
                (uu____4954, uu____4955)  in
              FStar_Syntax_Syntax.Tm_arrow uu____4941  in
            FStar_Syntax_Syntax.mk uu____4940  in
          uu____4933 FStar_Pervasives_Native.None c.FStar_Syntax_Syntax.pos
  
let (flat_arrow :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun bs  ->
    fun c  ->
      let t = arrow bs c  in
      let uu____4998 =
        let uu____4999 = FStar_Syntax_Subst.compress t  in
        uu____4999.FStar_Syntax_Syntax.n  in
      match uu____4998 with
      | FStar_Syntax_Syntax.Tm_arrow (bs1,c1) ->
          (match c1.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Total (tres,uu____5023) ->
               let uu____5032 =
                 let uu____5033 = FStar_Syntax_Subst.compress tres  in
                 uu____5033.FStar_Syntax_Syntax.n  in
               (match uu____5032 with
                | FStar_Syntax_Syntax.Tm_arrow (bs',c') ->
                    FStar_Syntax_Syntax.mk
                      (FStar_Syntax_Syntax.Tm_arrow
                         ((FStar_List.append bs1 bs'), c'))
                      FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
                | uu____5066 -> t)
           | uu____5067 -> t)
      | uu____5068 -> t
  
let (refine :
  FStar_Syntax_Syntax.bv ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun b  ->
    fun t  ->
      let uu____5085 =
        let uu____5086 = FStar_Syntax_Syntax.range_of_bv b  in
        FStar_Range.union_ranges uu____5086 t.FStar_Syntax_Syntax.pos  in
      let uu____5087 =
        let uu____5094 =
          let uu____5095 =
            let uu____5102 =
              let uu____5103 =
                let uu____5110 = FStar_Syntax_Syntax.mk_binder b  in
                [uu____5110]  in
              FStar_Syntax_Subst.close uu____5103 t  in
            (b, uu____5102)  in
          FStar_Syntax_Syntax.Tm_refine uu____5095  in
        FStar_Syntax_Syntax.mk uu____5094  in
      uu____5087 FStar_Pervasives_Native.None uu____5085
  
let (branch : FStar_Syntax_Syntax.branch -> FStar_Syntax_Syntax.branch) =
  fun b  -> FStar_Syntax_Subst.close_branch b 
let rec (arrow_formals_comp :
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
       FStar_Pervasives_Native.tuple2 Prims.list,FStar_Syntax_Syntax.comp)
      FStar_Pervasives_Native.tuple2)
  =
  fun k  ->
    let k1 = FStar_Syntax_Subst.compress k  in
    match k1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
        let uu____5173 = FStar_Syntax_Subst.open_comp bs c  in
        (match uu____5173 with
         | (bs1,c1) ->
             let uu____5190 = is_total_comp c1  in
             if uu____5190
             then
               let uu____5201 = arrow_formals_comp (comp_result c1)  in
               (match uu____5201 with
                | (bs',k2) -> ((FStar_List.append bs1 bs'), k2))
             else (bs1, c1))
    | FStar_Syntax_Syntax.Tm_refine
        ({ FStar_Syntax_Syntax.ppname = uu____5253;
           FStar_Syntax_Syntax.index = uu____5254;
           FStar_Syntax_Syntax.sort = k2;_},uu____5256)
        -> arrow_formals_comp k2
    | uu____5263 ->
        let uu____5264 = FStar_Syntax_Syntax.mk_Total k1  in ([], uu____5264)
  
let rec (arrow_formals :
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
       FStar_Pervasives_Native.tuple2 Prims.list,FStar_Syntax_Syntax.term'
                                                   FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple2)
  =
  fun k  ->
    let uu____5292 = arrow_formals_comp k  in
    match uu____5292 with | (bs,c) -> (bs, (comp_result c))
  
let (abs_formals :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.binders,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.residual_comp
                                                            FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple3)
  =
  fun t  ->
    let subst_lcomp_opt s l =
      match l with
      | FStar_Pervasives_Native.Some rc ->
          let uu____5374 =
            let uu___125_5375 = rc  in
            let uu____5376 =
              FStar_Util.map_opt rc.FStar_Syntax_Syntax.residual_typ
                (FStar_Syntax_Subst.subst s)
               in
            {
              FStar_Syntax_Syntax.residual_effect =
                (uu___125_5375.FStar_Syntax_Syntax.residual_effect);
              FStar_Syntax_Syntax.residual_typ = uu____5376;
              FStar_Syntax_Syntax.residual_flags =
                (uu___125_5375.FStar_Syntax_Syntax.residual_flags)
            }  in
          FStar_Pervasives_Native.Some uu____5374
      | uu____5385 -> l  in
    let rec aux t1 abs_body_lcomp =
      let uu____5417 =
        let uu____5418 =
          let uu____5421 = FStar_Syntax_Subst.compress t1  in
          FStar_All.pipe_left unascribe uu____5421  in
        uu____5418.FStar_Syntax_Syntax.n  in
      match uu____5417 with
      | FStar_Syntax_Syntax.Tm_abs (bs,t2,what) ->
          let uu____5461 = aux t2 what  in
          (match uu____5461 with
           | (bs',t3,what1) -> ((FStar_List.append bs bs'), t3, what1))
      | uu____5521 -> ([], t1, abs_body_lcomp)  in
    let uu____5534 = aux t FStar_Pervasives_Native.None  in
    match uu____5534 with
    | (bs,t1,abs_body_lcomp) ->
        let uu____5576 = FStar_Syntax_Subst.open_term' bs t1  in
        (match uu____5576 with
         | (bs1,t2,opening) ->
             let abs_body_lcomp1 = subst_lcomp_opt opening abs_body_lcomp  in
             (bs1, t2, abs_body_lcomp1))
  
let (mk_letbinding :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
    FStar_Syntax_Syntax.univ_name Prims.list ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Ident.lident ->
          FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
            FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax Prims.list
              -> FStar_Range.range -> FStar_Syntax_Syntax.letbinding)
  =
  fun lbname  ->
    fun univ_vars  ->
      fun typ  ->
        fun eff  ->
          fun def  ->
            fun lbattrs  ->
              fun pos  ->
                {
                  FStar_Syntax_Syntax.lbname = lbname;
                  FStar_Syntax_Syntax.lbunivs = univ_vars;
                  FStar_Syntax_Syntax.lbtyp = typ;
                  FStar_Syntax_Syntax.lbeff = eff;
                  FStar_Syntax_Syntax.lbdef = def;
                  FStar_Syntax_Syntax.lbattrs = lbattrs;
                  FStar_Syntax_Syntax.lbpos = pos
                }
  
let (close_univs_and_mk_letbinding :
  FStar_Syntax_Syntax.fv Prims.list FStar_Pervasives_Native.option ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
      FStar_Syntax_Syntax.univ_name Prims.list ->
        FStar_Syntax_Syntax.term ->
          FStar_Ident.lident ->
            FStar_Syntax_Syntax.term ->
              FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax Prims.list
                -> FStar_Range.range -> FStar_Syntax_Syntax.letbinding)
  =
  fun recs  ->
    fun lbname  ->
      fun univ_vars  ->
        fun typ  ->
          fun eff  ->
            fun def  ->
              fun attrs  ->
                fun pos  ->
                  let def1 =
                    match (recs, univ_vars) with
                    | (FStar_Pervasives_Native.None ,uu____5737) -> def
                    | (uu____5748,[]) -> def
                    | (FStar_Pervasives_Native.Some fvs,uu____5760) ->
                        let universes =
                          FStar_All.pipe_right univ_vars
                            (FStar_List.map
                               (fun _0_4  -> FStar_Syntax_Syntax.U_name _0_4))
                           in
                        let inst1 =
                          FStar_All.pipe_right fvs
                            (FStar_List.map
                               (fun fv  ->
                                  (((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v),
                                    universes)))
                           in
                        FStar_Syntax_InstFV.instantiate inst1 def
                     in
                  let typ1 = FStar_Syntax_Subst.close_univ_vars univ_vars typ
                     in
                  let def2 =
                    FStar_Syntax_Subst.close_univ_vars univ_vars def1  in
                  mk_letbinding lbname univ_vars typ1 eff def2 attrs pos
  
let (open_univ_vars_binders_and_comp :
  FStar_Syntax_Syntax.univ_names ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 Prims.list ->
      FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
        (FStar_Syntax_Syntax.univ_names,(FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
                                          FStar_Pervasives_Native.tuple2
                                          Prims.list,FStar_Syntax_Syntax.comp)
          FStar_Pervasives_Native.tuple3)
  =
  fun uvs  ->
    fun binders  ->
      fun c  ->
        match binders with
        | [] ->
            let uu____5846 = FStar_Syntax_Subst.open_univ_vars_comp uvs c  in
            (match uu____5846 with | (uvs1,c1) -> (uvs1, [], c1))
        | uu____5875 ->
            let t' = arrow binders c  in
            let uu____5885 = FStar_Syntax_Subst.open_univ_vars uvs t'  in
            (match uu____5885 with
             | (uvs1,t'1) ->
                 let uu____5904 =
                   let uu____5905 = FStar_Syntax_Subst.compress t'1  in
                   uu____5905.FStar_Syntax_Syntax.n  in
                 (match uu____5904 with
                  | FStar_Syntax_Syntax.Tm_arrow (binders1,c1) ->
                      (uvs1, binders1, c1)
                  | uu____5944 -> failwith "Impossible"))
  
let (is_tuple_constructor : FStar_Syntax_Syntax.typ -> Prims.bool) =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Parser_Const.is_tuple_constructor_string
          ((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v).FStar_Ident.str
    | uu____5963 -> false
  
let (is_dtuple_constructor : FStar_Syntax_Syntax.typ -> Prims.bool) =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Parser_Const.is_dtuple_constructor_lid
          (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
    | uu____5970 -> false
  
let (is_lid_equality : FStar_Ident.lident -> Prims.bool) =
  fun x  -> FStar_Ident.lid_equals x FStar_Parser_Const.eq2_lid 
let (is_forall : FStar_Ident.lident -> Prims.bool) =
  fun lid  -> FStar_Ident.lid_equals lid FStar_Parser_Const.forall_lid 
let (is_exists : FStar_Ident.lident -> Prims.bool) =
  fun lid  -> FStar_Ident.lid_equals lid FStar_Parser_Const.exists_lid 
let (is_qlid : FStar_Ident.lident -> Prims.bool) =
  fun lid  -> (is_forall lid) || (is_exists lid) 
let (is_equality :
  FStar_Ident.lident FStar_Syntax_Syntax.withinfo_t -> Prims.bool) =
  fun x  -> is_lid_equality x.FStar_Syntax_Syntax.v 
let (lid_is_connective : FStar_Ident.lident -> Prims.bool) =
  let lst =
    [FStar_Parser_Const.and_lid;
    FStar_Parser_Const.or_lid;
    FStar_Parser_Const.not_lid;
    FStar_Parser_Const.iff_lid;
    FStar_Parser_Const.imp_lid]  in
  fun lid  -> FStar_Util.for_some (FStar_Ident.lid_equals lid) lst 
let (is_constructor :
  FStar_Syntax_Syntax.term -> FStar_Ident.lident -> Prims.bool) =
  fun t  ->
    fun lid  ->
      let uu____6018 =
        let uu____6019 = pre_typ t  in uu____6019.FStar_Syntax_Syntax.n  in
      match uu____6018 with
      | FStar_Syntax_Syntax.Tm_fvar tc ->
          FStar_Ident.lid_equals
            (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v lid
      | uu____6021 -> false
  
let rec (is_constructed_typ :
  FStar_Syntax_Syntax.term -> FStar_Ident.lident -> Prims.bool) =
  fun t  ->
    fun lid  ->
      let uu____6032 =
        let uu____6033 = pre_typ t  in uu____6033.FStar_Syntax_Syntax.n  in
      match uu____6032 with
      | FStar_Syntax_Syntax.Tm_fvar uu____6034 -> is_constructor t lid
      | FStar_Syntax_Syntax.Tm_app (t1,uu____6036) ->
          is_constructed_typ t1 lid
      | FStar_Syntax_Syntax.Tm_uinst (t1,uu____6058) ->
          is_constructed_typ t1 lid
      | uu____6063 -> false
  
let rec (get_tycon :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term FStar_Pervasives_Native.option)
  =
  fun t  ->
    let t1 = pre_typ t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_bvar uu____6074 ->
        FStar_Pervasives_Native.Some t1
    | FStar_Syntax_Syntax.Tm_name uu____6075 ->
        FStar_Pervasives_Native.Some t1
    | FStar_Syntax_Syntax.Tm_fvar uu____6076 ->
        FStar_Pervasives_Native.Some t1
    | FStar_Syntax_Syntax.Tm_app (t2,uu____6078) -> get_tycon t2
    | uu____6099 -> FStar_Pervasives_Native.None
  
let (is_fstar_tactics_by_tactic : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____6105 =
      let uu____6106 = un_uinst t  in uu____6106.FStar_Syntax_Syntax.n  in
    match uu____6105 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.by_tactic_lid
    | uu____6108 -> false
  
let (is_builtin_tactic : FStar_Ident.lident -> Prims.bool) =
  fun md  ->
    let path = FStar_Ident.path_of_lid md  in
    if (FStar_List.length path) > (Prims.parse_int "2")
    then
      let uu____6115 =
        let uu____6118 = FStar_List.splitAt (Prims.parse_int "2") path  in
        FStar_Pervasives_Native.fst uu____6118  in
      match uu____6115 with
      | "FStar"::"Tactics"::[] -> true
      | "FStar"::"Reflection"::[] -> true
      | uu____6131 -> false
    else false
  
let (ktype : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_type FStar_Syntax_Syntax.U_unknown)
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (ktype0 : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_type FStar_Syntax_Syntax.U_zero)
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (type_u :
  unit ->
    (FStar_Syntax_Syntax.typ,FStar_Syntax_Syntax.universe)
      FStar_Pervasives_Native.tuple2)
  =
  fun uu____6143  ->
    let u =
      let uu____6149 = FStar_Syntax_Unionfind.univ_fresh ()  in
      FStar_All.pipe_left (fun _0_5  -> FStar_Syntax_Syntax.U_unif _0_5)
        uu____6149
       in
    let uu____6158 =
      FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type u)
        FStar_Pervasives_Native.None FStar_Range.dummyRange
       in
    (uu____6158, u)
  
let (attr_eq :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun a  ->
    fun a'  ->
      let uu____6171 = eq_tm a a'  in
      match uu____6171 with | Equal  -> true | uu____6172 -> false
  
let (attr_substitute : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  let uu____6175 =
    let uu____6182 =
      let uu____6183 =
        let uu____6184 =
          FStar_Ident.lid_of_path ["FStar"; "Pervasives"; "Substitute"]
            FStar_Range.dummyRange
           in
        FStar_Syntax_Syntax.lid_as_fv uu____6184
          FStar_Syntax_Syntax.delta_constant FStar_Pervasives_Native.None
         in
      FStar_Syntax_Syntax.Tm_fvar uu____6183  in
    FStar_Syntax_Syntax.mk uu____6182  in
  uu____6175 FStar_Pervasives_Native.None FStar_Range.dummyRange 
let (exp_true_bool : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_bool true))
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_false_bool : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_bool false))
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_unit : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_constant FStar_Const.Const_unit)
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_int : Prims.string -> FStar_Syntax_Syntax.term) =
  fun s  ->
    FStar_Syntax_Syntax.mk
      (FStar_Syntax_Syntax.Tm_constant
         (FStar_Const.Const_int (s, FStar_Pervasives_Native.None)))
      FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_char : FStar_BaseTypes.char -> FStar_Syntax_Syntax.term) =
  fun c  ->
    FStar_Syntax_Syntax.mk
      (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_char c))
      FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_string : Prims.string -> FStar_Syntax_Syntax.term) =
  fun s  ->
    FStar_Syntax_Syntax.mk
      (FStar_Syntax_Syntax.Tm_constant
         (FStar_Const.Const_string (s, FStar_Range.dummyRange)))
      FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (fvar_const : FStar_Ident.lident -> FStar_Syntax_Syntax.term) =
  fun l  ->
    FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.delta_constant
      FStar_Pervasives_Native.None
  
let (tand : FStar_Syntax_Syntax.term) = fvar_const FStar_Parser_Const.and_lid 
let (tor : FStar_Syntax_Syntax.term) = fvar_const FStar_Parser_Const.or_lid 
let (timp : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.imp_lid
    (FStar_Syntax_Syntax.Delta_constant_at_level (Prims.parse_int "1"))
    FStar_Pervasives_Native.None
  
let (tiff : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.iff_lid
    (FStar_Syntax_Syntax.Delta_constant_at_level (Prims.parse_int "2"))
    FStar_Pervasives_Native.None
  
let (t_bool : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.bool_lid 
let (b2t_v : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.b2t_lid 
let (t_not : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.not_lid 
let (t_false : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.false_lid 
let (t_true : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.true_lid 
let (tac_opaque_attr : FStar_Syntax_Syntax.term) = exp_string "tac_opaque" 
let (dm4f_bind_range_attr : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.dm4f_bind_range_attr 
let (t_ctx_uvar_and_sust : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.ctx_uvar_and_subst_lid 
let (mk_conj_opt :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
    FStar_Pervasives_Native.option ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
        FStar_Pervasives_Native.option)
  =
  fun phi1  ->
    fun phi2  ->
      match phi1 with
      | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.Some phi2
      | FStar_Pervasives_Native.Some phi11 ->
          let uu____6259 =
            let uu____6262 =
              FStar_Range.union_ranges phi11.FStar_Syntax_Syntax.pos
                phi2.FStar_Syntax_Syntax.pos
               in
            let uu____6263 =
              let uu____6270 =
                let uu____6271 =
                  let uu____6286 =
                    let uu____6295 = FStar_Syntax_Syntax.as_arg phi11  in
                    let uu____6296 =
                      let uu____6305 = FStar_Syntax_Syntax.as_arg phi2  in
                      [uu____6305]  in
                    uu____6295 :: uu____6296  in
                  (tand, uu____6286)  in
                FStar_Syntax_Syntax.Tm_app uu____6271  in
              FStar_Syntax_Syntax.mk uu____6270  in
            uu____6263 FStar_Pervasives_Native.None uu____6262  in
          FStar_Pervasives_Native.Some uu____6259
  
let (mk_binop :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun op_t  ->
    fun phi1  ->
      fun phi2  ->
        let uu____6368 =
          FStar_Range.union_ranges phi1.FStar_Syntax_Syntax.pos
            phi2.FStar_Syntax_Syntax.pos
           in
        let uu____6369 =
          let uu____6376 =
            let uu____6377 =
              let uu____6392 =
                let uu____6401 = FStar_Syntax_Syntax.as_arg phi1  in
                let uu____6402 =
                  let uu____6411 = FStar_Syntax_Syntax.as_arg phi2  in
                  [uu____6411]  in
                uu____6401 :: uu____6402  in
              (op_t, uu____6392)  in
            FStar_Syntax_Syntax.Tm_app uu____6377  in
          FStar_Syntax_Syntax.mk uu____6376  in
        uu____6369 FStar_Pervasives_Native.None uu____6368
  
let (mk_neg :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun phi  ->
    let uu____6454 =
      let uu____6461 =
        let uu____6462 =
          let uu____6477 =
            let uu____6486 = FStar_Syntax_Syntax.as_arg phi  in [uu____6486]
             in
          (t_not, uu____6477)  in
        FStar_Syntax_Syntax.Tm_app uu____6462  in
      FStar_Syntax_Syntax.mk uu____6461  in
    uu____6454 FStar_Pervasives_Native.None phi.FStar_Syntax_Syntax.pos
  
let (mk_conj :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  = fun phi1  -> fun phi2  -> mk_binop tand phi1 phi2 
let (mk_conj_l :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax Prims.list ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun phi  ->
    match phi with
    | [] ->
        FStar_Syntax_Syntax.fvar FStar_Parser_Const.true_lid
          FStar_Syntax_Syntax.delta_constant FStar_Pervasives_Native.None
    | hd1::tl1 -> FStar_List.fold_right mk_conj tl1 hd1
  
let (mk_disj :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  = fun phi1  -> fun phi2  -> mk_binop tor phi1 phi2 
let (mk_disj_l :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax Prims.list ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun phi  ->
    match phi with
    | [] -> t_false
    | hd1::tl1 -> FStar_List.fold_right mk_disj tl1 hd1
  
let (mk_imp :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term)
  = fun phi1  -> fun phi2  -> mk_binop timp phi1 phi2 
let (mk_iff :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term)
  = fun phi1  -> fun phi2  -> mk_binop tiff phi1 phi2 
let (b2t :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun e  ->
    let uu____6665 =
      let uu____6672 =
        let uu____6673 =
          let uu____6688 =
            let uu____6697 = FStar_Syntax_Syntax.as_arg e  in [uu____6697]
             in
          (b2t_v, uu____6688)  in
        FStar_Syntax_Syntax.Tm_app uu____6673  in
      FStar_Syntax_Syntax.mk uu____6672  in
    uu____6665 FStar_Pervasives_Native.None e.FStar_Syntax_Syntax.pos
  
let (is_t_true : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____6728 =
      let uu____6729 = unmeta t  in uu____6729.FStar_Syntax_Syntax.n  in
    match uu____6728 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.true_lid
    | uu____6731 -> false
  
let (mk_conj_simp :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t1  ->
    fun t2  ->
      let uu____6752 = is_t_true t1  in
      if uu____6752
      then t2
      else
        (let uu____6756 = is_t_true t2  in
         if uu____6756 then t1 else mk_conj t1 t2)
  
let (mk_disj_simp :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t1  ->
    fun t2  ->
      let uu____6780 = is_t_true t1  in
      if uu____6780
      then t_true
      else
        (let uu____6784 = is_t_true t2  in
         if uu____6784 then t_true else mk_disj t1 t2)
  
let (teq : FStar_Syntax_Syntax.term) = fvar_const FStar_Parser_Const.eq2_lid 
let (mk_untyped_eq2 :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun e1  ->
    fun e2  ->
      let uu____6808 =
        FStar_Range.union_ranges e1.FStar_Syntax_Syntax.pos
          e2.FStar_Syntax_Syntax.pos
         in
      let uu____6809 =
        let uu____6816 =
          let uu____6817 =
            let uu____6832 =
              let uu____6841 = FStar_Syntax_Syntax.as_arg e1  in
              let uu____6842 =
                let uu____6851 = FStar_Syntax_Syntax.as_arg e2  in
                [uu____6851]  in
              uu____6841 :: uu____6842  in
            (teq, uu____6832)  in
          FStar_Syntax_Syntax.Tm_app uu____6817  in
        FStar_Syntax_Syntax.mk uu____6816  in
      uu____6809 FStar_Pervasives_Native.None uu____6808
  
let (mk_eq2 :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.typ ->
      FStar_Syntax_Syntax.term ->
        FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
  =
  fun u  ->
    fun t  ->
      fun e1  ->
        fun e2  ->
          let eq_inst = FStar_Syntax_Syntax.mk_Tm_uinst teq [u]  in
          let uu____6904 =
            FStar_Range.union_ranges e1.FStar_Syntax_Syntax.pos
              e2.FStar_Syntax_Syntax.pos
             in
          let uu____6905 =
            let uu____6912 =
              let uu____6913 =
                let uu____6928 =
                  let uu____6937 = FStar_Syntax_Syntax.iarg t  in
                  let uu____6938 =
                    let uu____6947 = FStar_Syntax_Syntax.as_arg e1  in
                    let uu____6948 =
                      let uu____6957 = FStar_Syntax_Syntax.as_arg e2  in
                      [uu____6957]  in
                    uu____6947 :: uu____6948  in
                  uu____6937 :: uu____6938  in
                (eq_inst, uu____6928)  in
              FStar_Syntax_Syntax.Tm_app uu____6913  in
            FStar_Syntax_Syntax.mk uu____6912  in
          uu____6905 FStar_Pervasives_Native.None uu____6904
  
let (mk_has_type :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    fun x  ->
      fun t'  ->
        let t_has_type = fvar_const FStar_Parser_Const.has_type_lid  in
        let t_has_type1 =
          FStar_Syntax_Syntax.mk
            (FStar_Syntax_Syntax.Tm_uinst
               (t_has_type,
                 [FStar_Syntax_Syntax.U_zero; FStar_Syntax_Syntax.U_zero]))
            FStar_Pervasives_Native.None FStar_Range.dummyRange
           in
        let uu____7018 =
          let uu____7025 =
            let uu____7026 =
              let uu____7041 =
                let uu____7050 = FStar_Syntax_Syntax.iarg t  in
                let uu____7051 =
                  let uu____7060 = FStar_Syntax_Syntax.as_arg x  in
                  let uu____7061 =
                    let uu____7070 = FStar_Syntax_Syntax.as_arg t'  in
                    [uu____7070]  in
                  uu____7060 :: uu____7061  in
                uu____7050 :: uu____7051  in
              (t_has_type1, uu____7041)  in
            FStar_Syntax_Syntax.Tm_app uu____7026  in
          FStar_Syntax_Syntax.mk uu____7025  in
        uu____7018 FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (mk_with_type :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun u  ->
    fun t  ->
      fun e  ->
        let t_with_type =
          FStar_Syntax_Syntax.fvar FStar_Parser_Const.with_type_lid
            FStar_Syntax_Syntax.delta_equational FStar_Pervasives_Native.None
           in
        let t_with_type1 =
          FStar_Syntax_Syntax.mk
            (FStar_Syntax_Syntax.Tm_uinst (t_with_type, [u]))
            FStar_Pervasives_Native.None FStar_Range.dummyRange
           in
        let uu____7131 =
          let uu____7138 =
            let uu____7139 =
              let uu____7154 =
                let uu____7163 = FStar_Syntax_Syntax.iarg t  in
                let uu____7164 =
                  let uu____7173 = FStar_Syntax_Syntax.as_arg e  in
                  [uu____7173]  in
                uu____7163 :: uu____7164  in
              (t_with_type1, uu____7154)  in
            FStar_Syntax_Syntax.Tm_app uu____7139  in
          FStar_Syntax_Syntax.mk uu____7138  in
        uu____7131 FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (lex_t : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.lex_t_lid 
let (lex_top : FStar_Syntax_Syntax.term) =
  let uu____7205 =
    let uu____7212 =
      let uu____7213 =
        let uu____7220 =
          FStar_Syntax_Syntax.fvar FStar_Parser_Const.lextop_lid
            FStar_Syntax_Syntax.delta_constant
            (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
           in
        (uu____7220, [FStar_Syntax_Syntax.U_zero])  in
      FStar_Syntax_Syntax.Tm_uinst uu____7213  in
    FStar_Syntax_Syntax.mk uu____7212  in
  uu____7205 FStar_Pervasives_Native.None FStar_Range.dummyRange 
let (lex_pair : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.lexcons_lid
    FStar_Syntax_Syntax.delta_constant
    (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
  
let (tforall : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.forall_lid
    (FStar_Syntax_Syntax.Delta_constant_at_level (Prims.parse_int "1"))
    FStar_Pervasives_Native.None
  
let (t_haseq : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.haseq_lid
    FStar_Syntax_Syntax.delta_constant FStar_Pervasives_Native.None
  
let (lcomp_of_comp : FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.lcomp) =
  fun c0  ->
    let uu____7231 =
      match c0.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Total uu____7244 ->
          (FStar_Parser_Const.effect_Tot_lid, [FStar_Syntax_Syntax.TOTAL])
      | FStar_Syntax_Syntax.GTotal uu____7255 ->
          (FStar_Parser_Const.effect_GTot_lid,
            [FStar_Syntax_Syntax.SOMETRIVIAL])
      | FStar_Syntax_Syntax.Comp c ->
          ((c.FStar_Syntax_Syntax.effect_name),
            (c.FStar_Syntax_Syntax.flags))
       in
    match uu____7231 with
    | (eff_name,flags1) ->
        FStar_Syntax_Syntax.mk_lcomp eff_name (comp_result c0) flags1
          (fun uu____7276  -> c0)
  
let (mk_residual_comp :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
      FStar_Pervasives_Native.option ->
      FStar_Syntax_Syntax.cflags Prims.list ->
        FStar_Syntax_Syntax.residual_comp)
  =
  fun l  ->
    fun t  ->
      fun f  ->
        {
          FStar_Syntax_Syntax.residual_effect = l;
          FStar_Syntax_Syntax.residual_typ = t;
          FStar_Syntax_Syntax.residual_flags = f
        }
  
let (residual_tot :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.residual_comp)
  =
  fun t  ->
    {
      FStar_Syntax_Syntax.residual_effect = FStar_Parser_Const.effect_Tot_lid;
      FStar_Syntax_Syntax.residual_typ = (FStar_Pervasives_Native.Some t);
      FStar_Syntax_Syntax.residual_flags = [FStar_Syntax_Syntax.TOTAL]
    }
  
let (residual_comp_of_comp :
  FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.residual_comp) =
  fun c  ->
    {
      FStar_Syntax_Syntax.residual_effect = (comp_effect_name c);
      FStar_Syntax_Syntax.residual_typ =
        (FStar_Pervasives_Native.Some (comp_result c));
      FStar_Syntax_Syntax.residual_flags = (comp_flags c)
    }
  
let (residual_comp_of_lcomp :
  FStar_Syntax_Syntax.lcomp -> FStar_Syntax_Syntax.residual_comp) =
  fun lc  ->
    {
      FStar_Syntax_Syntax.residual_effect = (lc.FStar_Syntax_Syntax.eff_name);
      FStar_Syntax_Syntax.residual_typ =
        (FStar_Pervasives_Native.Some (lc.FStar_Syntax_Syntax.res_typ));
      FStar_Syntax_Syntax.residual_flags = (lc.FStar_Syntax_Syntax.cflags)
    }
  
let (mk_forall_aux :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.bv ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun fa  ->
    fun x  ->
      fun body  ->
        let uu____7354 =
          let uu____7361 =
            let uu____7362 =
              let uu____7377 =
                let uu____7386 =
                  FStar_Syntax_Syntax.iarg x.FStar_Syntax_Syntax.sort  in
                let uu____7387 =
                  let uu____7396 =
                    let uu____7397 =
                      let uu____7400 =
                        let uu____7407 = FStar_Syntax_Syntax.mk_binder x  in
                        [uu____7407]  in
                      abs uu____7400 body
                        (FStar_Pervasives_Native.Some (residual_tot ktype0))
                       in
                    FStar_Syntax_Syntax.as_arg uu____7397  in
                  [uu____7396]  in
                uu____7386 :: uu____7387  in
              (fa, uu____7377)  in
            FStar_Syntax_Syntax.Tm_app uu____7362  in
          FStar_Syntax_Syntax.mk uu____7361  in
        uu____7354 FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (mk_forall_no_univ :
  FStar_Syntax_Syntax.bv ->
    FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ)
  = fun x  -> fun body  -> mk_forall_aux tforall x body 
let (mk_forall :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.bv ->
      FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ)
  =
  fun u  ->
    fun x  ->
      fun body  ->
        let tforall1 = FStar_Syntax_Syntax.mk_Tm_uinst tforall [u]  in
        mk_forall_aux tforall1 x body
  
let (close_forall_no_univs :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ)
  =
  fun bs  ->
    fun f  ->
      FStar_List.fold_right
        (fun b  ->
           fun f1  ->
             let uu____7508 = FStar_Syntax_Syntax.is_null_binder b  in
             if uu____7508
             then f1
             else mk_forall_no_univ (FStar_Pervasives_Native.fst b) f1) bs f
  
let rec (is_wild_pat :
  FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t -> Prims.bool) =
  fun p  ->
    match p.FStar_Syntax_Syntax.v with
    | FStar_Syntax_Syntax.Pat_wild uu____7519 -> true
    | uu____7520 -> false
  
let (if_then_else :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun b  ->
    fun t1  ->
      fun t2  ->
        let then_branch =
          let uu____7565 =
            FStar_Syntax_Syntax.withinfo
              (FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_bool true))
              t1.FStar_Syntax_Syntax.pos
             in
          (uu____7565, FStar_Pervasives_Native.None, t1)  in
        let else_branch =
          let uu____7593 =
            FStar_Syntax_Syntax.withinfo
              (FStar_Syntax_Syntax.Pat_constant
                 (FStar_Const.Const_bool false)) t2.FStar_Syntax_Syntax.pos
             in
          (uu____7593, FStar_Pervasives_Native.None, t2)  in
        let uu____7606 =
          let uu____7607 =
            FStar_Range.union_ranges t1.FStar_Syntax_Syntax.pos
              t2.FStar_Syntax_Syntax.pos
             in
          FStar_Range.union_ranges b.FStar_Syntax_Syntax.pos uu____7607  in
        FStar_Syntax_Syntax.mk
          (FStar_Syntax_Syntax.Tm_match (b, [then_branch; else_branch]))
          FStar_Pervasives_Native.None uu____7606
  
let (mk_squash :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun u  ->
    fun p  ->
      let sq =
        FStar_Syntax_Syntax.fvar FStar_Parser_Const.squash_lid
          (FStar_Syntax_Syntax.Delta_constant_at_level (Prims.parse_int "1"))
          FStar_Pervasives_Native.None
         in
      let uu____7681 = FStar_Syntax_Syntax.mk_Tm_uinst sq [u]  in
      let uu____7682 =
        let uu____7691 = FStar_Syntax_Syntax.as_arg p  in [uu____7691]  in
      mk_app uu____7681 uu____7682
  
let (mk_auto_squash :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun u  ->
    fun p  ->
      let sq =
        FStar_Syntax_Syntax.fvar FStar_Parser_Const.auto_squash_lid
          (FStar_Syntax_Syntax.Delta_constant_at_level (Prims.parse_int "2"))
          FStar_Pervasives_Native.None
         in
      let uu____7717 = FStar_Syntax_Syntax.mk_Tm_uinst sq [u]  in
      let uu____7718 =
        let uu____7727 = FStar_Syntax_Syntax.as_arg p  in [uu____7727]  in
      mk_app uu____7717 uu____7718
  
let (un_squash :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
      FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____7749 = head_and_args t  in
    match uu____7749 with
    | (head1,args) ->
        let uu____7790 =
          let uu____7803 =
            let uu____7804 = un_uinst head1  in
            uu____7804.FStar_Syntax_Syntax.n  in
          (uu____7803, args)  in
        (match uu____7790 with
         | (FStar_Syntax_Syntax.Tm_fvar fv,(p,uu____7819)::[]) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid
             -> FStar_Pervasives_Native.Some p
         | (FStar_Syntax_Syntax.Tm_refine (b,p),[]) ->
             (match (b.FStar_Syntax_Syntax.sort).FStar_Syntax_Syntax.n with
              | FStar_Syntax_Syntax.Tm_fvar fv when
                  FStar_Syntax_Syntax.fv_eq_lid fv
                    FStar_Parser_Const.unit_lid
                  ->
                  let uu____7871 =
                    let uu____7876 =
                      let uu____7883 = FStar_Syntax_Syntax.mk_binder b  in
                      [uu____7883]  in
                    FStar_Syntax_Subst.open_term uu____7876 p  in
                  (match uu____7871 with
                   | (bs,p1) ->
                       let b1 =
                         match bs with
                         | b1::[] -> b1
                         | uu____7920 -> failwith "impossible"  in
                       let uu____7925 =
                         let uu____7926 = FStar_Syntax_Free.names p1  in
                         FStar_Util.set_mem (FStar_Pervasives_Native.fst b1)
                           uu____7926
                          in
                       if uu____7925
                       then FStar_Pervasives_Native.None
                       else FStar_Pervasives_Native.Some p1)
              | uu____7938 -> FStar_Pervasives_Native.None)
         | uu____7941 -> FStar_Pervasives_Native.None)
  
let (is_squash :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.universe,FStar_Syntax_Syntax.term'
                                    FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____7969 = head_and_args t  in
    match uu____7969 with
    | (head1,args) ->
        let uu____8014 =
          let uu____8027 =
            let uu____8028 = FStar_Syntax_Subst.compress head1  in
            uu____8028.FStar_Syntax_Syntax.n  in
          (uu____8027, args)  in
        (match uu____8014 with
         | (FStar_Syntax_Syntax.Tm_uinst
            ({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar fv;
               FStar_Syntax_Syntax.pos = uu____8046;
               FStar_Syntax_Syntax.vars = uu____8047;_},u::[]),(t1,uu____8050)::[])
             when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid
             -> FStar_Pervasives_Native.Some (u, t1)
         | uu____8087 -> FStar_Pervasives_Native.None)
  
let (is_auto_squash :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.universe,FStar_Syntax_Syntax.term'
                                    FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____8119 = head_and_args t  in
    match uu____8119 with
    | (head1,args) ->
        let uu____8164 =
          let uu____8177 =
            let uu____8178 = FStar_Syntax_Subst.compress head1  in
            uu____8178.FStar_Syntax_Syntax.n  in
          (uu____8177, args)  in
        (match uu____8164 with
         | (FStar_Syntax_Syntax.Tm_uinst
            ({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar fv;
               FStar_Syntax_Syntax.pos = uu____8196;
               FStar_Syntax_Syntax.vars = uu____8197;_},u::[]),(t1,uu____8200)::[])
             when
             FStar_Syntax_Syntax.fv_eq_lid fv
               FStar_Parser_Const.auto_squash_lid
             -> FStar_Pervasives_Native.Some (u, t1)
         | uu____8237 -> FStar_Pervasives_Native.None)
  
let (is_sub_singleton : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____8261 = let uu____8276 = unmeta t  in head_and_args uu____8276
       in
    match uu____8261 with
    | (head1,uu____8278) ->
        let uu____8299 =
          let uu____8300 = un_uinst head1  in
          uu____8300.FStar_Syntax_Syntax.n  in
        (match uu____8299 with
         | FStar_Syntax_Syntax.Tm_fvar fv ->
             (((((((((((((((((FStar_Syntax_Syntax.fv_eq_lid fv
                                FStar_Parser_Const.squash_lid)
                               ||
                               (FStar_Syntax_Syntax.fv_eq_lid fv
                                  FStar_Parser_Const.auto_squash_lid))
                              ||
                              (FStar_Syntax_Syntax.fv_eq_lid fv
                                 FStar_Parser_Const.and_lid))
                             ||
                             (FStar_Syntax_Syntax.fv_eq_lid fv
                                FStar_Parser_Const.or_lid))
                            ||
                            (FStar_Syntax_Syntax.fv_eq_lid fv
                               FStar_Parser_Const.not_lid))
                           ||
                           (FStar_Syntax_Syntax.fv_eq_lid fv
                              FStar_Parser_Const.imp_lid))
                          ||
                          (FStar_Syntax_Syntax.fv_eq_lid fv
                             FStar_Parser_Const.iff_lid))
                         ||
                         (FStar_Syntax_Syntax.fv_eq_lid fv
                            FStar_Parser_Const.ite_lid))
                        ||
                        (FStar_Syntax_Syntax.fv_eq_lid fv
                           FStar_Parser_Const.exists_lid))
                       ||
                       (FStar_Syntax_Syntax.fv_eq_lid fv
                          FStar_Parser_Const.forall_lid))
                      ||
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.true_lid))
                     ||
                     (FStar_Syntax_Syntax.fv_eq_lid fv
                        FStar_Parser_Const.false_lid))
                    ||
                    (FStar_Syntax_Syntax.fv_eq_lid fv
                       FStar_Parser_Const.eq2_lid))
                   ||
                   (FStar_Syntax_Syntax.fv_eq_lid fv
                      FStar_Parser_Const.eq3_lid))
                  ||
                  (FStar_Syntax_Syntax.fv_eq_lid fv
                     FStar_Parser_Const.b2t_lid))
                 ||
                 (FStar_Syntax_Syntax.fv_eq_lid fv
                    FStar_Parser_Const.haseq_lid))
                ||
                (FStar_Syntax_Syntax.fv_eq_lid fv
                   FStar_Parser_Const.has_type_lid))
               ||
               (FStar_Syntax_Syntax.fv_eq_lid fv
                  FStar_Parser_Const.precedes_lid)
         | uu____8302 -> false)
  
let (arrow_one :
  FStar_Syntax_Syntax.typ ->
    (FStar_Syntax_Syntax.binder,FStar_Syntax_Syntax.comp)
      FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____8320 =
      let uu____8331 =
        let uu____8332 = FStar_Syntax_Subst.compress t  in
        uu____8332.FStar_Syntax_Syntax.n  in
      match uu____8331 with
      | FStar_Syntax_Syntax.Tm_arrow ([],c) ->
          failwith "fatal: empty binders on arrow?"
      | FStar_Syntax_Syntax.Tm_arrow (b::[],c) ->
          FStar_Pervasives_Native.Some (b, c)
      | FStar_Syntax_Syntax.Tm_arrow (b::bs,c) ->
          let uu____8431 =
            let uu____8440 =
              let uu____8441 = arrow bs c  in
              FStar_Syntax_Syntax.mk_Total uu____8441  in
            (b, uu____8440)  in
          FStar_Pervasives_Native.Some uu____8431
      | uu____8456 -> FStar_Pervasives_Native.None  in
    FStar_Util.bind_opt uu____8320
      (fun uu____8488  ->
         match uu____8488 with
         | (b,c) ->
             let uu____8517 = FStar_Syntax_Subst.open_comp [b] c  in
             (match uu____8517 with
              | (bs,c1) ->
                  let b1 =
                    match bs with
                    | b1::[] -> b1
                    | uu____8564 ->
                        failwith
                          "impossible: open_comp returned different amount of binders"
                     in
                  FStar_Pervasives_Native.Some (b1, c1)))
  
let (is_free_in :
  FStar_Syntax_Syntax.bv -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun bv  ->
    fun t  ->
      let uu____8591 = FStar_Syntax_Free.names t  in
      FStar_Util.set_mem bv uu____8591
  
type qpats = FStar_Syntax_Syntax.args Prims.list
type connective =
  | QAll of (FStar_Syntax_Syntax.binders,qpats,FStar_Syntax_Syntax.typ)
  FStar_Pervasives_Native.tuple3 
  | QEx of (FStar_Syntax_Syntax.binders,qpats,FStar_Syntax_Syntax.typ)
  FStar_Pervasives_Native.tuple3 
  | BaseConn of (FStar_Ident.lident,FStar_Syntax_Syntax.args)
  FStar_Pervasives_Native.tuple2 
let (uu___is_QAll : connective -> Prims.bool) =
  fun projectee  ->
    match projectee with | QAll _0 -> true | uu____8639 -> false
  
let (__proj__QAll__item___0 :
  connective ->
    (FStar_Syntax_Syntax.binders,qpats,FStar_Syntax_Syntax.typ)
      FStar_Pervasives_Native.tuple3)
  = fun projectee  -> match projectee with | QAll _0 -> _0 
let (uu___is_QEx : connective -> Prims.bool) =
  fun projectee  ->
    match projectee with | QEx _0 -> true | uu____8677 -> false
  
let (__proj__QEx__item___0 :
  connective ->
    (FStar_Syntax_Syntax.binders,qpats,FStar_Syntax_Syntax.typ)
      FStar_Pervasives_Native.tuple3)
  = fun projectee  -> match projectee with | QEx _0 -> _0 
let (uu___is_BaseConn : connective -> Prims.bool) =
  fun projectee  ->
    match projectee with | BaseConn _0 -> true | uu____8713 -> false
  
let (__proj__BaseConn__item___0 :
  connective ->
    (FStar_Ident.lident,FStar_Syntax_Syntax.args)
      FStar_Pervasives_Native.tuple2)
  = fun projectee  -> match projectee with | BaseConn _0 -> _0 
let (destruct_typ_as_formula :
  FStar_Syntax_Syntax.term -> connective FStar_Pervasives_Native.option) =
  fun f  ->
    let rec unmeta_monadic f1 =
      let f2 = FStar_Syntax_Subst.compress f1  in
      match f2.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_meta
          (t,FStar_Syntax_Syntax.Meta_monadic uu____8750) -> unmeta_monadic t
      | FStar_Syntax_Syntax.Tm_meta
          (t,FStar_Syntax_Syntax.Meta_monadic_lift uu____8762) ->
          unmeta_monadic t
      | uu____8775 -> f2  in
    let destruct_base_conn f1 =
      let connectives =
        [(FStar_Parser_Const.true_lid, (Prims.parse_int "0"));
        (FStar_Parser_Const.false_lid, (Prims.parse_int "0"));
        (FStar_Parser_Const.and_lid, (Prims.parse_int "2"));
        (FStar_Parser_Const.or_lid, (Prims.parse_int "2"));
        (FStar_Parser_Const.imp_lid, (Prims.parse_int "2"));
        (FStar_Parser_Const.iff_lid, (Prims.parse_int "2"));
        (FStar_Parser_Const.ite_lid, (Prims.parse_int "3"));
        (FStar_Parser_Const.not_lid, (Prims.parse_int "1"));
        (FStar_Parser_Const.eq2_lid, (Prims.parse_int "3"));
        (FStar_Parser_Const.eq2_lid, (Prims.parse_int "2"));
        (FStar_Parser_Const.eq3_lid, (Prims.parse_int "4"));
        (FStar_Parser_Const.eq3_lid, (Prims.parse_int "2"))]  in
      let aux f2 uu____8859 =
        match uu____8859 with
        | (lid,arity) ->
            let uu____8868 =
              let uu____8883 = unmeta_monadic f2  in head_and_args uu____8883
               in
            (match uu____8868 with
             | (t,args) ->
                 let t1 = un_uinst t  in
                 let uu____8909 =
                   (is_constructor t1 lid) &&
                     ((FStar_List.length args) = arity)
                    in
                 if uu____8909
                 then FStar_Pervasives_Native.Some (BaseConn (lid, args))
                 else FStar_Pervasives_Native.None)
         in
      FStar_Util.find_map connectives (aux f1)  in
    let patterns t =
      let t1 = FStar_Syntax_Subst.compress t  in
      match t1.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_meta
          (t2,FStar_Syntax_Syntax.Meta_pattern pats) ->
          let uu____8978 = FStar_Syntax_Subst.compress t2  in
          (pats, uu____8978)
      | uu____8989 -> ([], t1)  in
    let destruct_q_conn t =
      let is_q fa fv =
        if fa
        then is_forall (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
        else is_exists (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
         in
      let flat t1 =
        let uu____9044 = head_and_args t1  in
        match uu____9044 with
        | (t2,args) ->
            let uu____9091 = un_uinst t2  in
            let uu____9092 =
              FStar_All.pipe_right args
                (FStar_List.map
                   (fun uu____9123  ->
                      match uu____9123 with
                      | (t3,imp) ->
                          let uu____9134 = unascribe t3  in (uu____9134, imp)))
               in
            (uu____9091, uu____9092)
         in
      let rec aux qopt out t1 =
        let uu____9175 = let uu____9196 = flat t1  in (qopt, uu____9196)  in
        match uu____9175 with
        | (FStar_Pervasives_Native.Some
           fa,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
                 FStar_Syntax_Syntax.pos = uu____9227;
                 FStar_Syntax_Syntax.vars = uu____9228;_},({
                                                             FStar_Syntax_Syntax.n
                                                               =
                                                               FStar_Syntax_Syntax.Tm_abs
                                                               (b::[],t2,uu____9231);
                                                             FStar_Syntax_Syntax.pos
                                                               = uu____9232;
                                                             FStar_Syntax_Syntax.vars
                                                               = uu____9233;_},uu____9234)::[]))
            when is_q fa tc -> aux qopt (b :: out) t2
        | (FStar_Pervasives_Native.Some
           fa,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
                 FStar_Syntax_Syntax.pos = uu____9311;
                 FStar_Syntax_Syntax.vars = uu____9312;_},uu____9313::
               ({
                  FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_abs
                    (b::[],t2,uu____9316);
                  FStar_Syntax_Syntax.pos = uu____9317;
                  FStar_Syntax_Syntax.vars = uu____9318;_},uu____9319)::[]))
            when is_q fa tc -> aux qopt (b :: out) t2
        | (FStar_Pervasives_Native.None
           ,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
               FStar_Syntax_Syntax.pos = uu____9407;
               FStar_Syntax_Syntax.vars = uu____9408;_},({
                                                           FStar_Syntax_Syntax.n
                                                             =
                                                             FStar_Syntax_Syntax.Tm_abs
                                                             (b::[],t2,uu____9411);
                                                           FStar_Syntax_Syntax.pos
                                                             = uu____9412;
                                                           FStar_Syntax_Syntax.vars
                                                             = uu____9413;_},uu____9414)::[]))
            when
            is_qlid (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v ->
            let uu____9485 =
              let uu____9488 =
                is_forall
                  (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                 in
              FStar_Pervasives_Native.Some uu____9488  in
            aux uu____9485 (b :: out) t2
        | (FStar_Pervasives_Native.None
           ,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
               FStar_Syntax_Syntax.pos = uu____9494;
               FStar_Syntax_Syntax.vars = uu____9495;_},uu____9496::({
                                                                    FStar_Syntax_Syntax.n
                                                                    =
                                                                    FStar_Syntax_Syntax.Tm_abs
                                                                    (b::[],t2,uu____9499);
                                                                    FStar_Syntax_Syntax.pos
                                                                    =
                                                                    uu____9500;
                                                                    FStar_Syntax_Syntax.vars
                                                                    =
                                                                    uu____9501;_},uu____9502)::[]))
            when
            is_qlid (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v ->
            let uu____9585 =
              let uu____9588 =
                is_forall
                  (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                 in
              FStar_Pervasives_Native.Some uu____9588  in
            aux uu____9585 (b :: out) t2
        | (FStar_Pervasives_Native.Some b,uu____9594) ->
            let bs = FStar_List.rev out  in
            let uu____9636 = FStar_Syntax_Subst.open_term bs t1  in
            (match uu____9636 with
             | (bs1,t2) ->
                 let uu____9645 = patterns t2  in
                 (match uu____9645 with
                  | (pats,body) ->
                      if b
                      then
                        FStar_Pervasives_Native.Some (QAll (bs1, pats, body))
                      else
                        FStar_Pervasives_Native.Some (QEx (bs1, pats, body))))
        | uu____9687 -> FStar_Pervasives_Native.None  in
      aux FStar_Pervasives_Native.None [] t  in
    let u_connectives =
      [(FStar_Parser_Const.true_lid, FStar_Parser_Const.c_true_lid,
         (Prims.parse_int "0"));
      (FStar_Parser_Const.false_lid, FStar_Parser_Const.c_false_lid,
        (Prims.parse_int "0"));
      (FStar_Parser_Const.and_lid, FStar_Parser_Const.c_and_lid,
        (Prims.parse_int "2"));
      (FStar_Parser_Const.or_lid, FStar_Parser_Const.c_or_lid,
        (Prims.parse_int "2"))]
       in
    let destruct_sq_base_conn t =
      let uu____9759 = un_squash t  in
      FStar_Util.bind_opt uu____9759
        (fun t1  ->
           let uu____9775 = head_and_args' t1  in
           match uu____9775 with
           | (hd1,args) ->
               let uu____9808 =
                 let uu____9813 =
                   let uu____9814 = un_uinst hd1  in
                   uu____9814.FStar_Syntax_Syntax.n  in
                 (uu____9813, (FStar_List.length args))  in
               (match uu____9808 with
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_6) when
                    (_0_6 = (Prims.parse_int "2")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_and_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.and_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_7) when
                    (_0_7 = (Prims.parse_int "2")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_or_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.or_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_8) when
                    (_0_8 = (Prims.parse_int "2")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_eq2_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.eq2_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_9) when
                    (_0_9 = (Prims.parse_int "3")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_eq2_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.eq2_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_10) when
                    (_0_10 = (Prims.parse_int "2")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_eq3_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.eq3_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_11) when
                    (_0_11 = (Prims.parse_int "4")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_eq3_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.eq3_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_12) when
                    (_0_12 = (Prims.parse_int "0")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_true_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.true_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_13) when
                    (_0_13 = (Prims.parse_int "0")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_false_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.false_lid, args))
                | uu____9831 -> FStar_Pervasives_Native.None))
       in
    let rec destruct_sq_forall t =
      let uu____9860 = un_squash t  in
      FStar_Util.bind_opt uu____9860
        (fun t1  ->
           let uu____9875 = arrow_one t1  in
           match uu____9875 with
           | FStar_Pervasives_Native.Some (b,c) ->
               let uu____9890 =
                 let uu____9891 = is_tot_or_gtot_comp c  in
                 Prims.op_Negation uu____9891  in
               if uu____9890
               then FStar_Pervasives_Native.None
               else
                 (let q =
                    let uu____9898 = comp_to_comp_typ_nouniv c  in
                    uu____9898.FStar_Syntax_Syntax.result_typ  in
                  let uu____9899 =
                    is_free_in (FStar_Pervasives_Native.fst b) q  in
                  if uu____9899
                  then
                    let uu____9902 = patterns q  in
                    match uu____9902 with
                    | (pats,q1) ->
                        FStar_All.pipe_left maybe_collect
                          (FStar_Pervasives_Native.Some
                             (QAll ([b], pats, q1)))
                  else
                    (let uu____9954 =
                       let uu____9955 =
                         let uu____9960 =
                           let uu____9969 =
                             FStar_Syntax_Syntax.as_arg
                               (FStar_Pervasives_Native.fst b).FStar_Syntax_Syntax.sort
                              in
                           let uu____9970 =
                             let uu____9979 = FStar_Syntax_Syntax.as_arg q
                                in
                             [uu____9979]  in
                           uu____9969 :: uu____9970  in
                         (FStar_Parser_Const.imp_lid, uu____9960)  in
                       BaseConn uu____9955  in
                     FStar_Pervasives_Native.Some uu____9954))
           | uu____9998 -> FStar_Pervasives_Native.None)
    
    and destruct_sq_exists t =
      let uu____10006 = un_squash t  in
      FStar_Util.bind_opt uu____10006
        (fun t1  ->
           let uu____10037 = head_and_args' t1  in
           match uu____10037 with
           | (hd1,args) ->
               let uu____10070 =
                 let uu____10083 =
                   let uu____10084 = un_uinst hd1  in
                   uu____10084.FStar_Syntax_Syntax.n  in
                 (uu____10083, args)  in
               (match uu____10070 with
                | (FStar_Syntax_Syntax.Tm_fvar
                   fv,(a1,uu____10097)::(a2,uu____10099)::[]) when
                    FStar_Syntax_Syntax.fv_eq_lid fv
                      FStar_Parser_Const.dtuple2_lid
                    ->
                    let uu____10134 =
                      let uu____10135 = FStar_Syntax_Subst.compress a2  in
                      uu____10135.FStar_Syntax_Syntax.n  in
                    (match uu____10134 with
                     | FStar_Syntax_Syntax.Tm_abs (b::[],q,uu____10140) ->
                         let uu____10167 = FStar_Syntax_Subst.open_term [b] q
                            in
                         (match uu____10167 with
                          | (bs,q1) ->
                              let b1 =
                                match bs with
                                | b1::[] -> b1
                                | uu____10206 -> failwith "impossible"  in
                              let uu____10211 = patterns q1  in
                              (match uu____10211 with
                               | (pats,q2) ->
                                   FStar_All.pipe_left maybe_collect
                                     (FStar_Pervasives_Native.Some
                                        (QEx ([b1], pats, q2)))))
                     | uu____10262 -> FStar_Pervasives_Native.None)
                | uu____10263 -> FStar_Pervasives_Native.None))
    
    and maybe_collect f1 =
      match f1 with
      | FStar_Pervasives_Native.Some (QAll (bs,pats,phi)) ->
          let uu____10284 = destruct_sq_forall phi  in
          (match uu____10284 with
           | FStar_Pervasives_Native.Some (QAll (bs',pats',psi)) ->
               FStar_All.pipe_left
                 (fun _0_14  -> FStar_Pervasives_Native.Some _0_14)
                 (QAll
                    ((FStar_List.append bs bs'),
                      (FStar_List.append pats pats'), psi))
           | uu____10298 -> f1)
      | FStar_Pervasives_Native.Some (QEx (bs,pats,phi)) ->
          let uu____10304 = destruct_sq_exists phi  in
          (match uu____10304 with
           | FStar_Pervasives_Native.Some (QEx (bs',pats',psi)) ->
               FStar_All.pipe_left
                 (fun _0_15  -> FStar_Pervasives_Native.Some _0_15)
                 (QEx
                    ((FStar_List.append bs bs'),
                      (FStar_List.append pats pats'), psi))
           | uu____10318 -> f1)
      | uu____10321 -> f1
     in
    let phi = unmeta_monadic f  in
    let uu____10325 = destruct_base_conn phi  in
    FStar_Util.catch_opt uu____10325
      (fun uu____10330  ->
         let uu____10331 = destruct_q_conn phi  in
         FStar_Util.catch_opt uu____10331
           (fun uu____10336  ->
              let uu____10337 = destruct_sq_base_conn phi  in
              FStar_Util.catch_opt uu____10337
                (fun uu____10342  ->
                   let uu____10343 = destruct_sq_forall phi  in
                   FStar_Util.catch_opt uu____10343
                     (fun uu____10348  ->
                        let uu____10349 = destruct_sq_exists phi  in
                        FStar_Util.catch_opt uu____10349
                          (fun uu____10353  -> FStar_Pervasives_Native.None)))))
  
let (unthunk_lemma_post :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    let uu____10365 =
      let uu____10366 = FStar_Syntax_Subst.compress t  in
      uu____10366.FStar_Syntax_Syntax.n  in
    match uu____10365 with
    | FStar_Syntax_Syntax.Tm_abs (b::[],e,uu____10371) ->
        let uu____10398 = FStar_Syntax_Subst.open_term [b] e  in
        (match uu____10398 with
         | (bs,e1) ->
             let b1 = FStar_List.hd bs  in
             let uu____10424 = is_free_in (FStar_Pervasives_Native.fst b1) e1
                in
             if uu____10424
             then
               let uu____10427 =
                 let uu____10436 = FStar_Syntax_Syntax.as_arg exp_unit  in
                 [uu____10436]  in
               mk_app t uu____10427
             else e1)
    | uu____10450 ->
        let uu____10451 =
          let uu____10460 = FStar_Syntax_Syntax.as_arg exp_unit  in
          [uu____10460]  in
        mk_app t uu____10451
  
let (action_as_lb :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.action ->
      FStar_Range.range -> FStar_Syntax_Syntax.sigelt)
  =
  fun eff_lid  ->
    fun a  ->
      fun pos  ->
        let lb =
          let uu____10489 =
            let uu____10494 =
              FStar_Syntax_Syntax.lid_as_fv a.FStar_Syntax_Syntax.action_name
                FStar_Syntax_Syntax.delta_equational
                FStar_Pervasives_Native.None
               in
            FStar_Util.Inr uu____10494  in
          let uu____10495 =
            let uu____10498 =
              FStar_Syntax_Syntax.mk_Total a.FStar_Syntax_Syntax.action_typ
               in
            arrow a.FStar_Syntax_Syntax.action_params uu____10498  in
          let uu____10499 =
            abs a.FStar_Syntax_Syntax.action_params
              a.FStar_Syntax_Syntax.action_defn FStar_Pervasives_Native.None
             in
          close_univs_and_mk_letbinding FStar_Pervasives_Native.None
            uu____10489 a.FStar_Syntax_Syntax.action_univs uu____10495
            FStar_Parser_Const.effect_Tot_lid uu____10499 [] pos
           in
        {
          FStar_Syntax_Syntax.sigel =
            (FStar_Syntax_Syntax.Sig_let
               ((false, [lb]), [a.FStar_Syntax_Syntax.action_name]));
          FStar_Syntax_Syntax.sigrng =
            ((a.FStar_Syntax_Syntax.action_defn).FStar_Syntax_Syntax.pos);
          FStar_Syntax_Syntax.sigquals =
            [FStar_Syntax_Syntax.Visible_default;
            FStar_Syntax_Syntax.Action eff_lid];
          FStar_Syntax_Syntax.sigmeta = FStar_Syntax_Syntax.default_sigmeta;
          FStar_Syntax_Syntax.sigattrs = []
        }
  
let (mk_reify :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    let reify_ =
      FStar_Syntax_Syntax.mk
        (FStar_Syntax_Syntax.Tm_constant FStar_Const.Const_reify)
        FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
       in
    let uu____10524 =
      let uu____10531 =
        let uu____10532 =
          let uu____10547 =
            let uu____10556 = FStar_Syntax_Syntax.as_arg t  in [uu____10556]
             in
          (reify_, uu____10547)  in
        FStar_Syntax_Syntax.Tm_app uu____10532  in
      FStar_Syntax_Syntax.mk uu____10531  in
    uu____10524 FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
  
let rec (delta_qualifier :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.delta_depth) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____10588 -> failwith "Impossible"
    | FStar_Syntax_Syntax.Tm_lazy i ->
        let uu____10612 = unfold_lazy i  in delta_qualifier uu____10612
    | FStar_Syntax_Syntax.Tm_fvar fv -> fv.FStar_Syntax_Syntax.fv_delta
    | FStar_Syntax_Syntax.Tm_bvar uu____10614 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_name uu____10615 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_match uu____10616 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_uvar uu____10639 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_unknown  -> FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_type uu____10652 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_quoted uu____10653 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_constant uu____10660 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_arrow uu____10661 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_uinst (t2,uu____10675) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_refine
        ({ FStar_Syntax_Syntax.ppname = uu____10680;
           FStar_Syntax_Syntax.index = uu____10681;
           FStar_Syntax_Syntax.sort = t2;_},uu____10683)
        -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_meta (t2,uu____10691) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____10697,uu____10698) ->
        delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_app (t2,uu____10740) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_abs (uu____10761,t2,uu____10763) ->
        delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_let (uu____10784,t2) -> delta_qualifier t2
  
let rec (incr_delta_depth :
  FStar_Syntax_Syntax.delta_depth -> FStar_Syntax_Syntax.delta_depth) =
  fun d  ->
    match d with
    | FStar_Syntax_Syntax.Delta_constant_at_level i ->
        FStar_Syntax_Syntax.Delta_constant_at_level
          (i + (Prims.parse_int "1"))
    | FStar_Syntax_Syntax.Delta_equational_at_level i ->
        FStar_Syntax_Syntax.Delta_equational_at_level
          (i + (Prims.parse_int "1"))
    | FStar_Syntax_Syntax.Delta_abstract d1 -> incr_delta_depth d1
  
let (incr_delta_qualifier :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.delta_depth) =
  fun t  ->
    let uu____10815 = delta_qualifier t  in incr_delta_depth uu____10815
  
let (is_unknown : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____10821 =
      let uu____10822 = FStar_Syntax_Subst.compress t  in
      uu____10822.FStar_Syntax_Syntax.n  in
    match uu____10821 with
    | FStar_Syntax_Syntax.Tm_unknown  -> true
    | uu____10823 -> false
  
let rec (list_elements :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term Prims.list FStar_Pervasives_Native.option)
  =
  fun e  ->
    let uu____10837 =
      let uu____10852 = unmeta e  in head_and_args uu____10852  in
    match uu____10837 with
    | (head1,args) ->
        let uu____10879 =
          let uu____10892 =
            let uu____10893 = un_uinst head1  in
            uu____10893.FStar_Syntax_Syntax.n  in
          (uu____10892, args)  in
        (match uu____10879 with
         | (FStar_Syntax_Syntax.Tm_fvar fv,uu____10907) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.nil_lid ->
             FStar_Pervasives_Native.Some []
         | (FStar_Syntax_Syntax.Tm_fvar
            fv,uu____10927::(hd1,uu____10929)::(tl1,uu____10931)::[]) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.cons_lid ->
             let uu____10978 =
               let uu____10981 =
                 let uu____10984 = list_elements tl1  in
                 FStar_Util.must uu____10984  in
               hd1 :: uu____10981  in
             FStar_Pervasives_Native.Some uu____10978
         | uu____10993 -> FStar_Pervasives_Native.None)
  
let rec apply_last :
  'Auu____11014 .
    ('Auu____11014 -> 'Auu____11014) ->
      'Auu____11014 Prims.list -> 'Auu____11014 Prims.list
  =
  fun f  ->
    fun l  ->
      match l with
      | [] -> failwith "apply_last: got empty list"
      | a::[] -> let uu____11039 = f a  in [uu____11039]
      | x::xs -> let uu____11044 = apply_last f xs  in x :: uu____11044
  
let (dm4f_lid :
  FStar_Syntax_Syntax.eff_decl -> Prims.string -> FStar_Ident.lident) =
  fun ed  ->
    fun name  ->
      let p = FStar_Ident.path_of_lid ed.FStar_Syntax_Syntax.mname  in
      let p' =
        apply_last
          (fun s  ->
             Prims.strcat "_dm4f_" (Prims.strcat s (Prims.strcat "_" name)))
          p
         in
      FStar_Ident.lid_of_path p' FStar_Range.dummyRange
  
let rec (mk_list :
  FStar_Syntax_Syntax.term ->
    FStar_Range.range ->
      FStar_Syntax_Syntax.term Prims.list -> FStar_Syntax_Syntax.term)
  =
  fun typ  ->
    fun rng  ->
      fun l  ->
        let ctor l1 =
          let uu____11090 =
            let uu____11097 =
              let uu____11098 =
                FStar_Syntax_Syntax.lid_as_fv l1
                  FStar_Syntax_Syntax.delta_constant
                  (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
                 in
              FStar_Syntax_Syntax.Tm_fvar uu____11098  in
            FStar_Syntax_Syntax.mk uu____11097  in
          uu____11090 FStar_Pervasives_Native.None rng  in
        let cons1 args pos =
          let uu____11115 =
            let uu____11120 =
              let uu____11121 = ctor FStar_Parser_Const.cons_lid  in
              FStar_Syntax_Syntax.mk_Tm_uinst uu____11121
                [FStar_Syntax_Syntax.U_zero]
               in
            FStar_Syntax_Syntax.mk_Tm_app uu____11120 args  in
          uu____11115 FStar_Pervasives_Native.None pos  in
        let nil args pos =
          let uu____11139 =
            let uu____11144 =
              let uu____11145 = ctor FStar_Parser_Const.nil_lid  in
              FStar_Syntax_Syntax.mk_Tm_uinst uu____11145
                [FStar_Syntax_Syntax.U_zero]
               in
            FStar_Syntax_Syntax.mk_Tm_app uu____11144 args  in
          uu____11139 FStar_Pervasives_Native.None pos  in
        let uu____11150 =
          let uu____11153 =
            let uu____11162 = FStar_Syntax_Syntax.iarg typ  in [uu____11162]
             in
          nil uu____11153 rng  in
        FStar_List.fold_right
          (fun t  ->
             fun a  ->
               let uu____11184 =
                 let uu____11193 = FStar_Syntax_Syntax.iarg typ  in
                 let uu____11194 =
                   let uu____11203 = FStar_Syntax_Syntax.as_arg t  in
                   let uu____11204 =
                     let uu____11213 = FStar_Syntax_Syntax.as_arg a  in
                     [uu____11213]  in
                   uu____11203 :: uu____11204  in
                 uu____11193 :: uu____11194  in
               cons1 uu____11184 t.FStar_Syntax_Syntax.pos) l uu____11150
  
let rec eqlist :
  'a .
    ('a -> 'a -> Prims.bool) -> 'a Prims.list -> 'a Prims.list -> Prims.bool
  =
  fun eq1  ->
    fun xs  ->
      fun ys  ->
        match (xs, ys) with
        | ([],[]) -> true
        | (x::xs1,y::ys1) -> (eq1 x y) && (eqlist eq1 xs1 ys1)
        | uu____11301 -> false
  
let eqsum :
  'a 'b .
    ('a -> 'a -> Prims.bool) ->
      ('b -> 'b -> Prims.bool) ->
        ('a,'b) FStar_Util.either -> ('a,'b) FStar_Util.either -> Prims.bool
  =
  fun e1  ->
    fun e2  ->
      fun x  ->
        fun y  ->
          match (x, y) with
          | (FStar_Util.Inl x1,FStar_Util.Inl y1) -> e1 x1 y1
          | (FStar_Util.Inr x1,FStar_Util.Inr y1) -> e2 x1 y1
          | uu____11408 -> false
  
let eqprod :
  'a 'b .
    ('a -> 'a -> Prims.bool) ->
      ('b -> 'b -> Prims.bool) ->
        ('a,'b) FStar_Pervasives_Native.tuple2 ->
          ('a,'b) FStar_Pervasives_Native.tuple2 -> Prims.bool
  =
  fun e1  ->
    fun e2  ->
      fun x  ->
        fun y  ->
          match (x, y) with | ((x1,x2),(y1,y2)) -> (e1 x1 y1) && (e2 x2 y2)
  
let eqopt :
  'a .
    ('a -> 'a -> Prims.bool) ->
      'a FStar_Pervasives_Native.option ->
        'a FStar_Pervasives_Native.option -> Prims.bool
  =
  fun e  ->
    fun x  ->
      fun y  ->
        match (x, y) with
        | (FStar_Pervasives_Native.Some x1,FStar_Pervasives_Native.Some y1)
            -> e x1 y1
        | uu____11563 -> false
  
let (debug_term_eq : Prims.bool FStar_ST.ref) = FStar_Util.mk_ref false 
let (check : Prims.string -> Prims.bool -> Prims.bool) =
  fun msg  ->
    fun cond  ->
      if cond
      then true
      else
        ((let uu____11597 = FStar_ST.op_Bang debug_term_eq  in
          if uu____11597
          then FStar_Util.print1 ">>> term_eq failing: %s\n" msg
          else ());
         false)
  
let (fail : Prims.string -> Prims.bool) = fun msg  -> check msg false 
let rec (term_eq_dbg :
  Prims.bool ->
    FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.bool)
  =
  fun dbg  ->
    fun t1  ->
      fun t2  ->
        let t11 = let uu____11785 = unmeta_safe t1  in canon_app uu____11785
           in
        let t21 = let uu____11789 = unmeta_safe t2  in canon_app uu____11789
           in
        let uu____11790 =
          let uu____11795 =
            let uu____11796 =
              let uu____11797 = un_uinst t11  in
              FStar_Syntax_Subst.compress uu____11797  in
            uu____11796.FStar_Syntax_Syntax.n  in
          let uu____11798 =
            let uu____11799 =
              let uu____11800 = un_uinst t21  in
              FStar_Syntax_Subst.compress uu____11800  in
            uu____11799.FStar_Syntax_Syntax.n  in
          (uu____11795, uu____11798)  in
        match uu____11790 with
        | (FStar_Syntax_Syntax.Tm_uinst uu____11801,uu____11802) ->
            failwith "term_eq: impossible, should have been removed"
        | (uu____11809,FStar_Syntax_Syntax.Tm_uinst uu____11810) ->
            failwith "term_eq: impossible, should have been removed"
        | (FStar_Syntax_Syntax.Tm_delayed uu____11817,uu____11818) ->
            failwith "term_eq: impossible, should have been removed"
        | (uu____11841,FStar_Syntax_Syntax.Tm_delayed uu____11842) ->
            failwith "term_eq: impossible, should have been removed"
        | (FStar_Syntax_Syntax.Tm_ascribed uu____11865,uu____11866) ->
            failwith "term_eq: impossible, should have been removed"
        | (uu____11893,FStar_Syntax_Syntax.Tm_ascribed uu____11894) ->
            failwith "term_eq: impossible, should have been removed"
        | (FStar_Syntax_Syntax.Tm_bvar x,FStar_Syntax_Syntax.Tm_bvar y) ->
            check "bvar"
              (x.FStar_Syntax_Syntax.index = y.FStar_Syntax_Syntax.index)
        | (FStar_Syntax_Syntax.Tm_name x,FStar_Syntax_Syntax.Tm_name y) ->
            check "name"
              (x.FStar_Syntax_Syntax.index = y.FStar_Syntax_Syntax.index)
        | (FStar_Syntax_Syntax.Tm_fvar x,FStar_Syntax_Syntax.Tm_fvar y) ->
            let uu____11927 = FStar_Syntax_Syntax.fv_eq x y  in
            check "fvar" uu____11927
        | (FStar_Syntax_Syntax.Tm_constant c1,FStar_Syntax_Syntax.Tm_constant
           c2) ->
            let uu____11930 = FStar_Const.eq_const c1 c2  in
            check "const" uu____11930
        | (FStar_Syntax_Syntax.Tm_type
           uu____11931,FStar_Syntax_Syntax.Tm_type uu____11932) -> true
        | (FStar_Syntax_Syntax.Tm_abs (b1,t12,k1),FStar_Syntax_Syntax.Tm_abs
           (b2,t22,k2)) ->
            (let uu____11981 = eqlist (binder_eq_dbg dbg) b1 b2  in
             check "abs binders" uu____11981) &&
              (let uu____11987 = term_eq_dbg dbg t12 t22  in
               check "abs bodies" uu____11987)
        | (FStar_Syntax_Syntax.Tm_arrow (b1,c1),FStar_Syntax_Syntax.Tm_arrow
           (b2,c2)) ->
            (let uu____12026 = eqlist (binder_eq_dbg dbg) b1 b2  in
             check "arrow binders" uu____12026) &&
              (let uu____12032 = comp_eq_dbg dbg c1 c2  in
               check "arrow comp" uu____12032)
        | (FStar_Syntax_Syntax.Tm_refine
           (b1,t12),FStar_Syntax_Syntax.Tm_refine (b2,t22)) ->
            (check "refine bv"
               (b1.FStar_Syntax_Syntax.index = b2.FStar_Syntax_Syntax.index))
              &&
              (let uu____12046 = term_eq_dbg dbg t12 t22  in
               check "refine formula" uu____12046)
        | (FStar_Syntax_Syntax.Tm_app (f1,a1),FStar_Syntax_Syntax.Tm_app
           (f2,a2)) ->
            (let uu____12093 = term_eq_dbg dbg f1 f2  in
             check "app head" uu____12093) &&
              (let uu____12095 = eqlist (arg_eq_dbg dbg) a1 a2  in
               check "app args" uu____12095)
        | (FStar_Syntax_Syntax.Tm_match
           (t12,bs1),FStar_Syntax_Syntax.Tm_match (t22,bs2)) ->
            (let uu____12180 = term_eq_dbg dbg t12 t22  in
             check "match head" uu____12180) &&
              (let uu____12182 = eqlist (branch_eq_dbg dbg) bs1 bs2  in
               check "match branches" uu____12182)
        | (FStar_Syntax_Syntax.Tm_lazy uu____12197,uu____12198) ->
            let uu____12199 =
              let uu____12200 = unlazy t11  in
              term_eq_dbg dbg uu____12200 t21  in
            check "lazy_l" uu____12199
        | (uu____12201,FStar_Syntax_Syntax.Tm_lazy uu____12202) ->
            let uu____12203 =
              let uu____12204 = unlazy t21  in
              term_eq_dbg dbg t11 uu____12204  in
            check "lazy_r" uu____12203
        | (FStar_Syntax_Syntax.Tm_let
           ((b1,lbs1),t12),FStar_Syntax_Syntax.Tm_let ((b2,lbs2),t22)) ->
            ((check "let flag" (b1 = b2)) &&
               (let uu____12240 = eqlist (letbinding_eq_dbg dbg) lbs1 lbs2
                   in
                check "let lbs" uu____12240))
              &&
              (let uu____12242 = term_eq_dbg dbg t12 t22  in
               check "let body" uu____12242)
        | (FStar_Syntax_Syntax.Tm_uvar
           (u1,uu____12244),FStar_Syntax_Syntax.Tm_uvar (u2,uu____12246)) ->
            check "uvar"
              (u1.FStar_Syntax_Syntax.ctx_uvar_head =
                 u2.FStar_Syntax_Syntax.ctx_uvar_head)
        | (FStar_Syntax_Syntax.Tm_quoted
           (qt1,qi1),FStar_Syntax_Syntax.Tm_quoted (qt2,qi2)) ->
            (check "tm_quoted qi" (qi1 = qi2)) &&
              (let uu____12302 = term_eq_dbg dbg qt1 qt2  in
               check "tm_quoted payload" uu____12302)
        | (FStar_Syntax_Syntax.Tm_meta (t12,m1),FStar_Syntax_Syntax.Tm_meta
           (t22,m2)) ->
            (match (m1, m2) with
             | (FStar_Syntax_Syntax.Meta_monadic
                (n1,ty1),FStar_Syntax_Syntax.Meta_monadic (n2,ty2)) ->
                 (let uu____12329 = FStar_Ident.lid_equals n1 n2  in
                  check "meta_monadic lid" uu____12329) &&
                   (let uu____12331 = term_eq_dbg dbg ty1 ty2  in
                    check "meta_monadic type" uu____12331)
             | (FStar_Syntax_Syntax.Meta_monadic_lift
                (s1,t13,ty1),FStar_Syntax_Syntax.Meta_monadic_lift
                (s2,t23,ty2)) ->
                 ((let uu____12348 = FStar_Ident.lid_equals s1 s2  in
                   check "meta_monadic_lift src" uu____12348) &&
                    (let uu____12350 = FStar_Ident.lid_equals t13 t23  in
                     check "meta_monadic_lift tgt" uu____12350))
                   &&
                   (let uu____12352 = term_eq_dbg dbg ty1 ty2  in
                    check "meta_monadic_lift type" uu____12352)
             | uu____12353 -> fail "metas")
        | (FStar_Syntax_Syntax.Tm_unknown ,uu____12358) -> fail "unk"
        | (uu____12359,FStar_Syntax_Syntax.Tm_unknown ) -> fail "unk"
        | (FStar_Syntax_Syntax.Tm_bvar uu____12360,uu____12361) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_name uu____12362,uu____12363) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_fvar uu____12364,uu____12365) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_constant uu____12366,uu____12367) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_type uu____12368,uu____12369) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_abs uu____12370,uu____12371) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_arrow uu____12388,uu____12389) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_refine uu____12402,uu____12403) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_app uu____12410,uu____12411) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_match uu____12426,uu____12427) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_let uu____12450,uu____12451) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_uvar uu____12464,uu____12465) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_meta uu____12478,uu____12479) ->
            fail "bottom"
        | (uu____12486,FStar_Syntax_Syntax.Tm_bvar uu____12487) ->
            fail "bottom"
        | (uu____12488,FStar_Syntax_Syntax.Tm_name uu____12489) ->
            fail "bottom"
        | (uu____12490,FStar_Syntax_Syntax.Tm_fvar uu____12491) ->
            fail "bottom"
        | (uu____12492,FStar_Syntax_Syntax.Tm_constant uu____12493) ->
            fail "bottom"
        | (uu____12494,FStar_Syntax_Syntax.Tm_type uu____12495) ->
            fail "bottom"
        | (uu____12496,FStar_Syntax_Syntax.Tm_abs uu____12497) ->
            fail "bottom"
        | (uu____12514,FStar_Syntax_Syntax.Tm_arrow uu____12515) ->
            fail "bottom"
        | (uu____12528,FStar_Syntax_Syntax.Tm_refine uu____12529) ->
            fail "bottom"
        | (uu____12536,FStar_Syntax_Syntax.Tm_app uu____12537) ->
            fail "bottom"
        | (uu____12552,FStar_Syntax_Syntax.Tm_match uu____12553) ->
            fail "bottom"
        | (uu____12576,FStar_Syntax_Syntax.Tm_let uu____12577) ->
            fail "bottom"
        | (uu____12590,FStar_Syntax_Syntax.Tm_uvar uu____12591) ->
            fail "bottom"
        | (uu____12604,FStar_Syntax_Syntax.Tm_meta uu____12605) ->
            fail "bottom"

and (arg_eq_dbg :
  Prims.bool ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 ->
      (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.aqual)
        FStar_Pervasives_Native.tuple2 -> Prims.bool)
  =
  fun dbg  ->
    fun a1  ->
      fun a2  ->
        eqprod
          (fun t1  ->
             fun t2  ->
               let uu____12632 = term_eq_dbg dbg t1 t2  in
               check "arg tm" uu____12632)
          (fun q1  -> fun q2  -> check "arg qual" (q1 = q2)) a1 a2

and (binder_eq_dbg :
  Prims.bool ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 ->
      (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
        FStar_Pervasives_Native.tuple2 -> Prims.bool)
  =
  fun dbg  ->
    fun b1  ->
      fun b2  ->
        eqprod
          (fun b11  ->
             fun b21  ->
               let uu____12653 =
                 term_eq_dbg dbg b11.FStar_Syntax_Syntax.sort
                   b21.FStar_Syntax_Syntax.sort
                  in
               check "binder sort" uu____12653)
          (fun q1  -> fun q2  -> check "binder qual" (q1 = q2)) b1 b2

and (lcomp_eq_dbg :
  FStar_Syntax_Syntax.lcomp -> FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun c1  -> fun c2  -> fail "lcomp"

and (residual_eq_dbg :
  FStar_Syntax_Syntax.residual_comp ->
    FStar_Syntax_Syntax.residual_comp -> Prims.bool)
  = fun r1  -> fun r2  -> fail "residual"

and (comp_eq_dbg :
  Prims.bool ->
    FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool)
  =
  fun dbg  ->
    fun c1  ->
      fun c2  ->
        let c11 = comp_to_comp_typ_nouniv c1  in
        let c21 = comp_to_comp_typ_nouniv c2  in
        ((let uu____12673 =
            FStar_Ident.lid_equals c11.FStar_Syntax_Syntax.effect_name
              c21.FStar_Syntax_Syntax.effect_name
             in
          check "comp eff" uu____12673) &&
           (let uu____12675 =
              term_eq_dbg dbg c11.FStar_Syntax_Syntax.result_typ
                c21.FStar_Syntax_Syntax.result_typ
               in
            check "comp result typ" uu____12675))
          && true

and (eq_flags_dbg :
  Prims.bool ->
    FStar_Syntax_Syntax.cflags -> FStar_Syntax_Syntax.cflags -> Prims.bool)
  = fun dbg  -> fun f1  -> fun f2  -> true

and (branch_eq_dbg :
  Prims.bool ->
    (FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t,FStar_Syntax_Syntax.term'
                                                               FStar_Syntax_Syntax.syntax
                                                               FStar_Pervasives_Native.option,
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple3 ->
      (FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t,FStar_Syntax_Syntax.term'
                                                                 FStar_Syntax_Syntax.syntax
                                                                 FStar_Pervasives_Native.option,
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
        FStar_Pervasives_Native.tuple3 -> Prims.bool)
  =
  fun dbg  ->
    fun uu____12680  ->
      fun uu____12681  ->
        match (uu____12680, uu____12681) with
        | ((p1,w1,t1),(p2,w2,t2)) ->
            ((let uu____12806 = FStar_Syntax_Syntax.eq_pat p1 p2  in
              check "branch pat" uu____12806) &&
               (let uu____12808 = term_eq_dbg dbg t1 t2  in
                check "branch body" uu____12808))
              &&
              (let uu____12810 =
                 match (w1, w2) with
                 | (FStar_Pervasives_Native.Some
                    x,FStar_Pervasives_Native.Some y) -> term_eq_dbg dbg x y
                 | (FStar_Pervasives_Native.None
                    ,FStar_Pervasives_Native.None ) -> true
                 | uu____12849 -> false  in
               check "branch when" uu____12810)

and (letbinding_eq_dbg :
  Prims.bool ->
    FStar_Syntax_Syntax.letbinding ->
      FStar_Syntax_Syntax.letbinding -> Prims.bool)
  =
  fun dbg  ->
    fun lb1  ->
      fun lb2  ->
        ((let uu____12867 =
            eqsum (fun bv1  -> fun bv2  -> true) FStar_Syntax_Syntax.fv_eq
              lb1.FStar_Syntax_Syntax.lbname lb2.FStar_Syntax_Syntax.lbname
             in
          check "lb bv" uu____12867) &&
           (let uu____12873 =
              term_eq_dbg dbg lb1.FStar_Syntax_Syntax.lbtyp
                lb2.FStar_Syntax_Syntax.lbtyp
               in
            check "lb typ" uu____12873))
          &&
          (let uu____12875 =
             term_eq_dbg dbg lb1.FStar_Syntax_Syntax.lbdef
               lb2.FStar_Syntax_Syntax.lbdef
              in
           check "lb def" uu____12875)

let (term_eq :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t1  ->
    fun t2  ->
      let r =
        let uu____12887 = FStar_ST.op_Bang debug_term_eq  in
        term_eq_dbg uu____12887 t1 t2  in
      FStar_ST.op_Colon_Equals debug_term_eq false; r
  
let rec (sizeof : FStar_Syntax_Syntax.term -> Prims.int) =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____12940 ->
        let uu____12963 =
          let uu____12964 = FStar_Syntax_Subst.compress t  in
          sizeof uu____12964  in
        (Prims.parse_int "1") + uu____12963
    | FStar_Syntax_Syntax.Tm_bvar bv ->
        let uu____12966 = sizeof bv.FStar_Syntax_Syntax.sort  in
        (Prims.parse_int "1") + uu____12966
    | FStar_Syntax_Syntax.Tm_name bv ->
        let uu____12968 = sizeof bv.FStar_Syntax_Syntax.sort  in
        (Prims.parse_int "1") + uu____12968
    | FStar_Syntax_Syntax.Tm_uinst (t1,us) ->
        let uu____12975 = sizeof t1  in (FStar_List.length us) + uu____12975
    | FStar_Syntax_Syntax.Tm_abs (bs,t1,uu____12978) ->
        let uu____12999 = sizeof t1  in
        let uu____13000 =
          FStar_List.fold_left
            (fun acc  ->
               fun uu____13011  ->
                 match uu____13011 with
                 | (bv,uu____13017) ->
                     let uu____13018 = sizeof bv.FStar_Syntax_Syntax.sort  in
                     acc + uu____13018) (Prims.parse_int "0") bs
           in
        uu____12999 + uu____13000
    | FStar_Syntax_Syntax.Tm_app (hd1,args) ->
        let uu____13041 = sizeof hd1  in
        let uu____13042 =
          FStar_List.fold_left
            (fun acc  ->
               fun uu____13053  ->
                 match uu____13053 with
                 | (arg,uu____13059) ->
                     let uu____13060 = sizeof arg  in acc + uu____13060)
            (Prims.parse_int "0") args
           in
        uu____13041 + uu____13042
    | uu____13061 -> (Prims.parse_int "1")
  
let (is_fvar : FStar_Ident.lident -> FStar_Syntax_Syntax.term -> Prims.bool)
  =
  fun lid  ->
    fun t  ->
      let uu____13072 =
        let uu____13073 = un_uinst t  in uu____13073.FStar_Syntax_Syntax.n
         in
      match uu____13072 with
      | FStar_Syntax_Syntax.Tm_fvar fv ->
          FStar_Syntax_Syntax.fv_eq_lid fv lid
      | uu____13075 -> false
  
let (is_synth_by_tactic : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  -> is_fvar FStar_Parser_Const.synth_lid t 
let (has_attribute :
  FStar_Syntax_Syntax.attribute Prims.list ->
    FStar_Ident.lident -> Prims.bool)
  = fun attrs  -> fun attr  -> FStar_Util.for_some (is_fvar attr) attrs 
let (process_pragma :
  FStar_Syntax_Syntax.pragma -> FStar_Range.range -> unit) =
  fun p  ->
    fun r  ->
      let set_options1 t s =
        let uu____13116 = FStar_Options.set_options t s  in
        match uu____13116 with
        | FStar_Getopt.Success  -> ()
        | FStar_Getopt.Help  ->
            FStar_Errors.raise_error
              (FStar_Errors.Fatal_FailToProcessPragma,
                "Failed to process pragma: use 'fstar --help' to see which options are available")
              r
        | FStar_Getopt.Error s1 ->
            FStar_Errors.raise_error
              (FStar_Errors.Fatal_FailToProcessPragma,
                (Prims.strcat "Failed to process pragma: " s1)) r
         in
      match p with
      | FStar_Syntax_Syntax.LightOff  ->
          if p = FStar_Syntax_Syntax.LightOff
          then FStar_Options.set_ml_ish ()
          else ()
      | FStar_Syntax_Syntax.SetOptions o -> set_options1 FStar_Options.Set o
      | FStar_Syntax_Syntax.ResetOptions sopt ->
          ((let uu____13124 = FStar_Options.restore_cmd_line_options false
               in
            FStar_All.pipe_right uu____13124 (fun a236  -> ()));
           (match sopt with
            | FStar_Pervasives_Native.None  -> ()
            | FStar_Pervasives_Native.Some s ->
                set_options1 FStar_Options.Reset s))
  
let rec (unbound_variables :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.bv Prims.list)
  =
  fun tm  ->
    let t = FStar_Syntax_Subst.compress tm  in
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____13150 -> failwith "Impossible"
    | FStar_Syntax_Syntax.Tm_name x -> []
    | FStar_Syntax_Syntax.Tm_uvar uu____13176 -> []
    | FStar_Syntax_Syntax.Tm_type u -> []
    | FStar_Syntax_Syntax.Tm_bvar x -> [x]
    | FStar_Syntax_Syntax.Tm_fvar uu____13191 -> []
    | FStar_Syntax_Syntax.Tm_constant uu____13192 -> []
    | FStar_Syntax_Syntax.Tm_lazy uu____13193 -> []
    | FStar_Syntax_Syntax.Tm_unknown  -> []
    | FStar_Syntax_Syntax.Tm_uinst (t1,us) -> unbound_variables t1
    | FStar_Syntax_Syntax.Tm_abs (bs,t1,uu____13202) ->
        let uu____13223 = FStar_Syntax_Subst.open_term bs t1  in
        (match uu____13223 with
         | (bs1,t2) ->
             let uu____13232 =
               FStar_List.collect
                 (fun uu____13242  ->
                    match uu____13242 with
                    | (b,uu____13250) ->
                        unbound_variables b.FStar_Syntax_Syntax.sort) bs1
                in
             let uu____13251 = unbound_variables t2  in
             FStar_List.append uu____13232 uu____13251)
    | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
        let uu____13272 = FStar_Syntax_Subst.open_comp bs c  in
        (match uu____13272 with
         | (bs1,c1) ->
             let uu____13281 =
               FStar_List.collect
                 (fun uu____13291  ->
                    match uu____13291 with
                    | (b,uu____13299) ->
                        unbound_variables b.FStar_Syntax_Syntax.sort) bs1
                in
             let uu____13300 = unbound_variables_comp c1  in
             FStar_List.append uu____13281 uu____13300)
    | FStar_Syntax_Syntax.Tm_refine (b,t1) ->
        let uu____13309 =
          FStar_Syntax_Subst.open_term [(b, FStar_Pervasives_Native.None)] t1
           in
        (match uu____13309 with
         | (bs,t2) ->
             let uu____13326 =
               FStar_List.collect
                 (fun uu____13336  ->
                    match uu____13336 with
                    | (b1,uu____13344) ->
                        unbound_variables b1.FStar_Syntax_Syntax.sort) bs
                in
             let uu____13345 = unbound_variables t2  in
             FStar_List.append uu____13326 uu____13345)
    | FStar_Syntax_Syntax.Tm_app (t1,args) ->
        let uu____13370 =
          FStar_List.collect
            (fun uu____13382  ->
               match uu____13382 with
               | (x,uu____13392) -> unbound_variables x) args
           in
        let uu____13397 = unbound_variables t1  in
        FStar_List.append uu____13370 uu____13397
    | FStar_Syntax_Syntax.Tm_match (t1,pats) ->
        let uu____13438 = unbound_variables t1  in
        let uu____13441 =
          FStar_All.pipe_right pats
            (FStar_List.collect
               (fun br  ->
                  let uu____13456 = FStar_Syntax_Subst.open_branch br  in
                  match uu____13456 with
                  | (p,wopt,t2) ->
                      let uu____13478 = unbound_variables t2  in
                      let uu____13481 =
                        match wopt with
                        | FStar_Pervasives_Native.None  -> []
                        | FStar_Pervasives_Native.Some t3 ->
                            unbound_variables t3
                         in
                      FStar_List.append uu____13478 uu____13481))
           in
        FStar_List.append uu____13438 uu____13441
    | FStar_Syntax_Syntax.Tm_ascribed (t1,asc,uu____13495) ->
        let uu____13536 = unbound_variables t1  in
        let uu____13539 =
          let uu____13542 =
            match FStar_Pervasives_Native.fst asc with
            | FStar_Util.Inl t2 -> unbound_variables t2
            | FStar_Util.Inr c2 -> unbound_variables_comp c2  in
          let uu____13573 =
            match FStar_Pervasives_Native.snd asc with
            | FStar_Pervasives_Native.None  -> []
            | FStar_Pervasives_Native.Some tac -> unbound_variables tac  in
          FStar_List.append uu____13542 uu____13573  in
        FStar_List.append uu____13536 uu____13539
    | FStar_Syntax_Syntax.Tm_let ((false ,lb::[]),t1) ->
        let uu____13611 = unbound_variables lb.FStar_Syntax_Syntax.lbtyp  in
        let uu____13614 =
          let uu____13617 = unbound_variables lb.FStar_Syntax_Syntax.lbdef
             in
          let uu____13620 =
            match lb.FStar_Syntax_Syntax.lbname with
            | FStar_Util.Inr uu____13625 -> unbound_variables t1
            | FStar_Util.Inl bv ->
                let uu____13627 =
                  FStar_Syntax_Subst.open_term
                    [(bv, FStar_Pervasives_Native.None)] t1
                   in
                (match uu____13627 with
                 | (uu____13642,t2) -> unbound_variables t2)
             in
          FStar_List.append uu____13617 uu____13620  in
        FStar_List.append uu____13611 uu____13614
    | FStar_Syntax_Syntax.Tm_let ((uu____13644,lbs),t1) ->
        let uu____13661 = FStar_Syntax_Subst.open_let_rec lbs t1  in
        (match uu____13661 with
         | (lbs1,t2) ->
             let uu____13676 = unbound_variables t2  in
             let uu____13679 =
               FStar_List.collect
                 (fun lb  ->
                    let uu____13686 =
                      unbound_variables lb.FStar_Syntax_Syntax.lbtyp  in
                    let uu____13689 =
                      unbound_variables lb.FStar_Syntax_Syntax.lbdef  in
                    FStar_List.append uu____13686 uu____13689) lbs1
                in
             FStar_List.append uu____13676 uu____13679)
    | FStar_Syntax_Syntax.Tm_quoted (tm1,qi) ->
        (match qi.FStar_Syntax_Syntax.qkind with
         | FStar_Syntax_Syntax.Quote_static  -> []
         | FStar_Syntax_Syntax.Quote_dynamic  -> unbound_variables tm1)
    | FStar_Syntax_Syntax.Tm_meta (t1,m) ->
        let uu____13706 = unbound_variables t1  in
        let uu____13709 =
          match m with
          | FStar_Syntax_Syntax.Meta_pattern args ->
              FStar_List.collect
                (FStar_List.collect
                   (fun uu____13742  ->
                      match uu____13742 with
                      | (a,uu____13752) -> unbound_variables a)) args
          | FStar_Syntax_Syntax.Meta_monadic_lift
              (uu____13757,uu____13758,t') -> unbound_variables t'
          | FStar_Syntax_Syntax.Meta_monadic (uu____13764,t') ->
              unbound_variables t'
          | FStar_Syntax_Syntax.Meta_labeled uu____13770 -> []
          | FStar_Syntax_Syntax.Meta_desugared uu____13777 -> []
          | FStar_Syntax_Syntax.Meta_named uu____13778 -> []  in
        FStar_List.append uu____13706 uu____13709

and (unbound_variables_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.bv Prims.list)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.GTotal (t,uu____13785) -> unbound_variables t
    | FStar_Syntax_Syntax.Total (t,uu____13795) -> unbound_variables t
    | FStar_Syntax_Syntax.Comp ct ->
        let uu____13805 = unbound_variables ct.FStar_Syntax_Syntax.result_typ
           in
        let uu____13808 =
          FStar_List.collect
            (fun uu____13820  ->
               match uu____13820 with
               | (a,uu____13830) -> unbound_variables a)
            ct.FStar_Syntax_Syntax.effect_args
           in
        FStar_List.append uu____13805 uu____13808
