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
    (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.arg_qualifier
                                FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple2 Prims.list)
  =
  fun binders  ->
    FStar_All.pipe_right binders
      (FStar_List.collect
         (fun b  ->
            let uu____186 = FStar_Syntax_Syntax.is_null_binder b  in
            if uu____186
            then []
            else (let uu____202 = arg_of_non_null_binder b  in [uu____202])))
  
let (args_of_binders :
  FStar_Syntax_Syntax.binders ->
    (FStar_Syntax_Syntax.binders,FStar_Syntax_Syntax.args)
      FStar_Pervasives_Native.tuple2)
  =
  fun binders  ->
    let uu____236 =
      FStar_All.pipe_right binders
        (FStar_List.map
           (fun b  ->
              let uu____318 = FStar_Syntax_Syntax.is_null_binder b  in
              if uu____318
              then
                let b1 =
                  let uu____342 =
                    FStar_Syntax_Syntax.new_bv FStar_Pervasives_Native.None
                      (FStar_Pervasives_Native.fst b).FStar_Syntax_Syntax.sort
                     in
                  (uu____342, (FStar_Pervasives_Native.snd b))  in
                let uu____349 = arg_of_non_null_binder b1  in (b1, uu____349)
              else
                (let uu____371 = arg_of_non_null_binder b  in (b, uu____371))))
       in
    FStar_All.pipe_right uu____236 FStar_List.unzip
  
let (name_binders :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.arg_qualifier
                            FStar_Pervasives_Native.option)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.arg_qualifier
                              FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple2 Prims.list)
  =
  fun binders  ->
    FStar_All.pipe_right binders
      (FStar_List.mapi
         (fun i  ->
            fun b  ->
              let uu____503 = FStar_Syntax_Syntax.is_null_binder b  in
              if uu____503
              then
                let uu____510 = b  in
                match uu____510 with
                | (a,imp) ->
                    let b1 =
                      let uu____530 =
                        let uu____531 = FStar_Util.string_of_int i  in
                        Prims.strcat "_" uu____531  in
                      FStar_Ident.id_of_text uu____530  in
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
        let uu____571 =
          let uu____578 =
            let uu____579 =
              let uu____594 = name_binders binders  in (uu____594, comp)  in
            FStar_Syntax_Syntax.Tm_arrow uu____579  in
          FStar_Syntax_Syntax.mk uu____578  in
        uu____571 FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
    | uu____616 -> t
  
let (null_binders_of_tks :
  (FStar_Syntax_Syntax.typ,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list -> FStar_Syntax_Syntax.binders)
  =
  fun tks  ->
    FStar_All.pipe_right tks
      (FStar_List.map
         (fun uu____652  ->
            match uu____652 with
            | (t,imp) ->
                let uu____663 =
                  let uu____664 = FStar_Syntax_Syntax.null_binder t  in
                  FStar_All.pipe_left FStar_Pervasives_Native.fst uu____664
                   in
                (uu____663, imp)))
  
let (binders_of_tks :
  (FStar_Syntax_Syntax.typ,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list -> FStar_Syntax_Syntax.binders)
  =
  fun tks  ->
    FStar_All.pipe_right tks
      (FStar_List.map
         (fun uu____718  ->
            match uu____718 with
            | (t,imp) ->
                let uu____735 =
                  FStar_Syntax_Syntax.new_bv
                    (FStar_Pervasives_Native.Some (t.FStar_Syntax_Syntax.pos))
                    t
                   in
                (uu____735, imp)))
  
let (binders_of_freevars :
  FStar_Syntax_Syntax.bv FStar_Util.set ->
    FStar_Syntax_Syntax.binder Prims.list)
  =
  fun fvs  ->
    let uu____747 = FStar_Util.set_elements fvs  in
    FStar_All.pipe_right uu____747
      (FStar_List.map FStar_Syntax_Syntax.mk_binder)
  
let mk_subst : 'Auu____758 . 'Auu____758 -> 'Auu____758 Prims.list =
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
          (fun uu____878  ->
             fun uu____879  ->
               match (uu____878, uu____879) with
               | ((x,uu____905),(y,uu____907)) ->
                   let uu____928 =
                     let uu____935 = FStar_Syntax_Syntax.bv_to_name y  in
                     (x, uu____935)  in
                   FStar_Syntax_Syntax.NT uu____928) replace_xs with_ys
      else failwith "Ill-formed substitution"
  
let rec (unmeta : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_meta (e2,uu____948) -> unmeta e2
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____954,uu____955) -> unmeta e2
    | uu____996 -> e1
  
let rec (unmeta_safe : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
  =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_meta (e',m) ->
        (match m with
         | FStar_Syntax_Syntax.Meta_monadic uu____1009 -> e1
         | FStar_Syntax_Syntax.Meta_monadic_lift uu____1016 -> e1
         | uu____1025 -> unmeta_safe e')
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____1027,uu____1028) ->
        unmeta_safe e2
    | uu____1069 -> e1
  
let rec (univ_kernel :
  FStar_Syntax_Syntax.universe ->
    (FStar_Syntax_Syntax.universe,Prims.int) FStar_Pervasives_Native.tuple2)
  =
  fun u  ->
    match u with
    | FStar_Syntax_Syntax.U_unknown  -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_name uu____1083 -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_unif uu____1084 -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_zero  -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_succ u1 ->
        let uu____1094 = univ_kernel u1  in
        (match uu____1094 with | (k,n1) -> (k, (n1 + (Prims.parse_int "1"))))
    | FStar_Syntax_Syntax.U_max uu____1105 ->
        failwith "Imposible: univ_kernel (U_max _)"
    | FStar_Syntax_Syntax.U_bvar uu____1112 ->
        failwith "Imposible: univ_kernel (U_bvar _)"
  
let (constant_univ_as_nat : FStar_Syntax_Syntax.universe -> Prims.int) =
  fun u  ->
    let uu____1122 = univ_kernel u  in FStar_Pervasives_Native.snd uu____1122
  
let rec (compare_univs :
  FStar_Syntax_Syntax.universe -> FStar_Syntax_Syntax.universe -> Prims.int)
  =
  fun u1  ->
    fun u2  ->
      match (u1, u2) with
      | (FStar_Syntax_Syntax.U_bvar uu____1137,uu____1138) ->
          failwith "Impossible: compare_univs"
      | (uu____1139,FStar_Syntax_Syntax.U_bvar uu____1140) ->
          failwith "Impossible: compare_univs"
      | (FStar_Syntax_Syntax.U_unknown ,FStar_Syntax_Syntax.U_unknown ) ->
          (Prims.parse_int "0")
      | (FStar_Syntax_Syntax.U_unknown ,uu____1141) ->
          ~- (Prims.parse_int "1")
      | (uu____1142,FStar_Syntax_Syntax.U_unknown ) -> (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_zero ,FStar_Syntax_Syntax.U_zero ) ->
          (Prims.parse_int "0")
      | (FStar_Syntax_Syntax.U_zero ,uu____1143) -> ~- (Prims.parse_int "1")
      | (uu____1144,FStar_Syntax_Syntax.U_zero ) -> (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_name u11,FStar_Syntax_Syntax.U_name u21) ->
          FStar_String.compare u11.FStar_Ident.idText u21.FStar_Ident.idText
      | (FStar_Syntax_Syntax.U_name uu____1147,FStar_Syntax_Syntax.U_unif
         uu____1148) -> ~- (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_unif uu____1157,FStar_Syntax_Syntax.U_name
         uu____1158) -> (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_unif u11,FStar_Syntax_Syntax.U_unif u21) ->
          let uu____1185 = FStar_Syntax_Unionfind.univ_uvar_id u11  in
          let uu____1186 = FStar_Syntax_Unionfind.univ_uvar_id u21  in
          uu____1185 - uu____1186
      | (FStar_Syntax_Syntax.U_max us1,FStar_Syntax_Syntax.U_max us2) ->
          let n1 = FStar_List.length us1  in
          let n2 = FStar_List.length us2  in
          if n1 <> n2
          then n1 - n2
          else
            (let copt =
               let uu____1217 = FStar_List.zip us1 us2  in
               FStar_Util.find_map uu____1217
                 (fun uu____1232  ->
                    match uu____1232 with
                    | (u11,u21) ->
                        let c = compare_univs u11 u21  in
                        if c <> (Prims.parse_int "0")
                        then FStar_Pervasives_Native.Some c
                        else FStar_Pervasives_Native.None)
                in
             match copt with
             | FStar_Pervasives_Native.None  -> (Prims.parse_int "0")
             | FStar_Pervasives_Native.Some c -> c)
      | (FStar_Syntax_Syntax.U_max uu____1246,uu____1247) ->
          ~- (Prims.parse_int "1")
      | (uu____1250,FStar_Syntax_Syntax.U_max uu____1251) ->
          (Prims.parse_int "1")
      | uu____1254 ->
          let uu____1259 = univ_kernel u1  in
          (match uu____1259 with
           | (k1,n1) ->
               let uu____1266 = univ_kernel u2  in
               (match uu____1266 with
                | (k2,n2) ->
                    let r = compare_univs k1 k2  in
                    if r = (Prims.parse_int "0") then n1 - n2 else r))
  
let (eq_univs :
  FStar_Syntax_Syntax.universe -> FStar_Syntax_Syntax.universe -> Prims.bool)
  =
  fun u1  ->
    fun u2  ->
      let uu____1285 = compare_univs u1 u2  in
      uu____1285 = (Prims.parse_int "0")
  
let (ml_comp :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Range.range -> FStar_Syntax_Syntax.comp)
  =
  fun t  ->
    fun r  ->
      let uu____1300 =
        let uu____1301 =
          FStar_Ident.set_lid_range FStar_Parser_Const.effect_ML_lid r  in
        {
          FStar_Syntax_Syntax.comp_univs = [FStar_Syntax_Syntax.U_zero];
          FStar_Syntax_Syntax.effect_name = uu____1301;
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = [FStar_Syntax_Syntax.MLEFFECT]
        }  in
      FStar_Syntax_Syntax.mk_Comp uu____1300
  
let (comp_effect_name :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> FStar_Ident.lident)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 -> c1.FStar_Syntax_Syntax.effect_name
    | FStar_Syntax_Syntax.Total uu____1320 ->
        FStar_Parser_Const.effect_Tot_lid
    | FStar_Syntax_Syntax.GTotal uu____1329 ->
        FStar_Parser_Const.effect_GTot_lid
  
let (comp_flags :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.cflags Prims.list)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total uu____1351 -> [FStar_Syntax_Syntax.TOTAL]
    | FStar_Syntax_Syntax.GTotal uu____1360 ->
        [FStar_Syntax_Syntax.SOMETRIVIAL]
    | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.flags
  
let (comp_to_comp_typ_nouniv :
  FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.comp_typ) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 -> c1
    | FStar_Syntax_Syntax.Total (t,u_opt) ->
        let uu____1386 =
          let uu____1387 = FStar_Util.map_opt u_opt (fun x  -> [x])  in
          FStar_Util.dflt [] uu____1387  in
        {
          FStar_Syntax_Syntax.comp_univs = uu____1386;
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
    | FStar_Syntax_Syntax.GTotal (t,u_opt) ->
        let uu____1416 =
          let uu____1417 = FStar_Util.map_opt u_opt (fun x  -> [x])  in
          FStar_Util.dflt [] uu____1417  in
        {
          FStar_Syntax_Syntax.comp_univs = uu____1416;
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
      let uu___118_1452 = c  in
      let uu____1453 =
        let uu____1454 =
          let uu___119_1455 = comp_to_comp_typ_nouniv c  in
          {
            FStar_Syntax_Syntax.comp_univs =
              (uu___119_1455.FStar_Syntax_Syntax.comp_univs);
            FStar_Syntax_Syntax.effect_name =
              (uu___119_1455.FStar_Syntax_Syntax.effect_name);
            FStar_Syntax_Syntax.result_typ =
              (uu___119_1455.FStar_Syntax_Syntax.result_typ);
            FStar_Syntax_Syntax.effect_args =
              (uu___119_1455.FStar_Syntax_Syntax.effect_args);
            FStar_Syntax_Syntax.flags = f
          }  in
        FStar_Syntax_Syntax.Comp uu____1454  in
      {
        FStar_Syntax_Syntax.n = uu____1453;
        FStar_Syntax_Syntax.pos = (uu___118_1452.FStar_Syntax_Syntax.pos);
        FStar_Syntax_Syntax.vars = (uu___118_1452.FStar_Syntax_Syntax.vars)
      }
  
let (lcomp_set_flags :
  FStar_Syntax_Syntax.lcomp ->
    FStar_Syntax_Syntax.cflags Prims.list -> FStar_Syntax_Syntax.lcomp)
  =
  fun lc  ->
    fun fs  ->
      let comp_typ_set_flags c =
        match c.FStar_Syntax_Syntax.n with
        | FStar_Syntax_Syntax.Total uu____1480 -> c
        | FStar_Syntax_Syntax.GTotal uu____1489 -> c
        | FStar_Syntax_Syntax.Comp ct ->
            let ct1 =
              let uu___120_1500 = ct  in
              {
                FStar_Syntax_Syntax.comp_univs =
                  (uu___120_1500.FStar_Syntax_Syntax.comp_univs);
                FStar_Syntax_Syntax.effect_name =
                  (uu___120_1500.FStar_Syntax_Syntax.effect_name);
                FStar_Syntax_Syntax.result_typ =
                  (uu___120_1500.FStar_Syntax_Syntax.result_typ);
                FStar_Syntax_Syntax.effect_args =
                  (uu___120_1500.FStar_Syntax_Syntax.effect_args);
                FStar_Syntax_Syntax.flags = fs
              }  in
            let uu___121_1501 = c  in
            {
              FStar_Syntax_Syntax.n = (FStar_Syntax_Syntax.Comp ct1);
              FStar_Syntax_Syntax.pos =
                (uu___121_1501.FStar_Syntax_Syntax.pos);
              FStar_Syntax_Syntax.vars =
                (uu___121_1501.FStar_Syntax_Syntax.vars)
            }
         in
      FStar_Syntax_Syntax.mk_lcomp lc.FStar_Syntax_Syntax.eff_name
        lc.FStar_Syntax_Syntax.res_typ fs
        (fun uu____1504  ->
           let uu____1505 = FStar_Syntax_Syntax.lcomp_comp lc  in
           comp_typ_set_flags uu____1505)
  
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
    | uu____1544 ->
        failwith "Assertion failed: Computation type without universe"
  
let (is_named_tot :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 ->
        FStar_Ident.lid_equals c1.FStar_Syntax_Syntax.effect_name
          FStar_Parser_Const.effect_Tot_lid
    | FStar_Syntax_Syntax.Total uu____1555 -> true
    | FStar_Syntax_Syntax.GTotal uu____1564 -> false
  
let (is_total_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    (FStar_Ident.lid_equals (comp_effect_name c)
       FStar_Parser_Const.effect_Tot_lid)
      ||
      (FStar_All.pipe_right (comp_flags c)
         (FStar_Util.for_some
            (fun uu___106_1585  ->
               match uu___106_1585 with
               | FStar_Syntax_Syntax.TOTAL  -> true
               | FStar_Syntax_Syntax.RETURN  -> true
               | uu____1586 -> false)))
  
let (is_total_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun c  ->
    (FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name
       FStar_Parser_Const.effect_Tot_lid)
      ||
      (FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
         (FStar_Util.for_some
            (fun uu___107_1595  ->
               match uu___107_1595 with
               | FStar_Syntax_Syntax.TOTAL  -> true
               | FStar_Syntax_Syntax.RETURN  -> true
               | uu____1596 -> false)))
  
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
            (fun uu___108_1605  ->
               match uu___108_1605 with
               | FStar_Syntax_Syntax.TOTAL  -> true
               | FStar_Syntax_Syntax.RETURN  -> true
               | uu____1606 -> false)))
  
let (is_partial_return :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    FStar_All.pipe_right (comp_flags c)
      (FStar_Util.for_some
         (fun uu___109_1619  ->
            match uu___109_1619 with
            | FStar_Syntax_Syntax.RETURN  -> true
            | FStar_Syntax_Syntax.PARTIAL_RETURN  -> true
            | uu____1620 -> false))
  
let (is_lcomp_partial_return : FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun c  ->
    FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
      (FStar_Util.for_some
         (fun uu___110_1629  ->
            match uu___110_1629 with
            | FStar_Syntax_Syntax.RETURN  -> true
            | FStar_Syntax_Syntax.PARTIAL_RETURN  -> true
            | uu____1630 -> false))
  
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
    | FStar_Syntax_Syntax.Total uu____1654 -> true
    | FStar_Syntax_Syntax.GTotal uu____1663 -> false
    | FStar_Syntax_Syntax.Comp ct ->
        ((is_total_comp c) ||
           (is_pure_effect ct.FStar_Syntax_Syntax.effect_name))
          ||
          (FStar_All.pipe_right ct.FStar_Syntax_Syntax.flags
             (FStar_Util.for_some
                (fun uu___111_1676  ->
                   match uu___111_1676 with
                   | FStar_Syntax_Syntax.LEMMA  -> true
                   | uu____1677 -> false)))
  
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
            (fun uu___112_1710  ->
               match uu___112_1710 with
               | FStar_Syntax_Syntax.LEMMA  -> true
               | uu____1711 -> false)))
  
let (is_pure_or_ghost_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun lc  ->
    (is_pure_lcomp lc) || (is_ghost_effect lc.FStar_Syntax_Syntax.eff_name)
  
let (is_pure_or_ghost_function : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____1722 =
      let uu____1723 = FStar_Syntax_Subst.compress t  in
      uu____1723.FStar_Syntax_Syntax.n  in
    match uu____1722 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____1726,c) -> is_pure_or_ghost_comp c
    | uu____1748 -> true
  
let (is_lemma_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp ct ->
        FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
          FStar_Parser_Const.effect_Lemma_lid
    | uu____1759 -> false
  
let (is_lemma : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____1765 =
      let uu____1766 = FStar_Syntax_Subst.compress t  in
      uu____1766.FStar_Syntax_Syntax.n  in
    match uu____1765 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____1769,c) -> is_lemma_comp c
    | uu____1791 -> false
  
let rec (head_of : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let uu____1797 =
      let uu____1798 = FStar_Syntax_Subst.compress t  in
      uu____1798.FStar_Syntax_Syntax.n  in
    match uu____1797 with
    | FStar_Syntax_Syntax.Tm_app (t1,uu____1802) -> head_of t1
    | FStar_Syntax_Syntax.Tm_match (t1,uu____1828) -> head_of t1
    | FStar_Syntax_Syntax.Tm_abs (uu____1865,t1,uu____1867) -> head_of t1
    | FStar_Syntax_Syntax.Tm_ascribed (t1,uu____1893,uu____1894) ->
        head_of t1
    | FStar_Syntax_Syntax.Tm_meta (t1,uu____1936) -> head_of t1
    | uu____1941 -> t
  
let (head_and_args :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,(FStar_Syntax_Syntax.term'
                                                             FStar_Syntax_Syntax.syntax,
                                                            FStar_Syntax_Syntax.arg_qualifier
                                                              FStar_Pervasives_Native.option)
                                                            FStar_Pervasives_Native.tuple2
                                                            Prims.list)
      FStar_Pervasives_Native.tuple2)
  =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_app (head1,args) -> (head1, args)
    | uu____2018 -> (t1, [])
  
let rec (head_and_args' :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.term,(FStar_Syntax_Syntax.term'
                                 FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.arg_qualifier
                                                              FStar_Pervasives_Native.option)
                                FStar_Pervasives_Native.tuple2 Prims.list)
      FStar_Pervasives_Native.tuple2)
  =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_app (head1,args) ->
        let uu____2099 = head_and_args' head1  in
        (match uu____2099 with
         | (head2,args') -> (head2, (FStar_List.append args' args)))
    | uu____2168 -> (t1, [])
  
let (un_uinst : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_uinst (t2,uu____2194) ->
        FStar_Syntax_Subst.compress t2
    | uu____2199 -> t1
  
let (is_smt_lemma : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____2205 =
      let uu____2206 = FStar_Syntax_Subst.compress t  in
      uu____2206.FStar_Syntax_Syntax.n  in
    match uu____2205 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____2209,c) ->
        (match c.FStar_Syntax_Syntax.n with
         | FStar_Syntax_Syntax.Comp ct when
             FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
               FStar_Parser_Const.effect_Lemma_lid
             ->
             (match ct.FStar_Syntax_Syntax.effect_args with
              | _req::_ens::(pats,uu____2235)::uu____2236 ->
                  let pats' = unmeta pats  in
                  let uu____2296 = head_and_args pats'  in
                  (match uu____2296 with
                   | (head1,uu____2314) ->
                       let uu____2339 =
                         let uu____2340 = un_uinst head1  in
                         uu____2340.FStar_Syntax_Syntax.n  in
                       (match uu____2339 with
                        | FStar_Syntax_Syntax.Tm_fvar fv ->
                            FStar_Syntax_Syntax.fv_eq_lid fv
                              FStar_Parser_Const.cons_lid
                        | uu____2344 -> false))
              | uu____2345 -> false)
         | uu____2356 -> false)
    | uu____2357 -> false
  
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
                (fun uu___113_2371  ->
                   match uu___113_2371 with
                   | FStar_Syntax_Syntax.MLEFFECT  -> true
                   | uu____2372 -> false)))
    | uu____2373 -> false
  
let (comp_result :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total (t,uu____2388) -> t
    | FStar_Syntax_Syntax.GTotal (t,uu____2398) -> t
    | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.result_typ
  
let (set_result_typ :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.comp)
  =
  fun c  ->
    fun t  ->
      match c.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Total uu____2426 ->
          FStar_Syntax_Syntax.mk_Total t
      | FStar_Syntax_Syntax.GTotal uu____2435 ->
          FStar_Syntax_Syntax.mk_GTotal t
      | FStar_Syntax_Syntax.Comp ct ->
          FStar_Syntax_Syntax.mk_Comp
            (let uu___122_2447 = ct  in
             {
               FStar_Syntax_Syntax.comp_univs =
                 (uu___122_2447.FStar_Syntax_Syntax.comp_univs);
               FStar_Syntax_Syntax.effect_name =
                 (uu___122_2447.FStar_Syntax_Syntax.effect_name);
               FStar_Syntax_Syntax.result_typ = t;
               FStar_Syntax_Syntax.effect_args =
                 (uu___122_2447.FStar_Syntax_Syntax.effect_args);
               FStar_Syntax_Syntax.flags =
                 (uu___122_2447.FStar_Syntax_Syntax.flags)
             })
  
let (set_result_typ_lc :
  FStar_Syntax_Syntax.lcomp ->
    FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.lcomp)
  =
  fun lc  ->
    fun t  ->
      FStar_Syntax_Syntax.mk_lcomp lc.FStar_Syntax_Syntax.eff_name t
        lc.FStar_Syntax_Syntax.cflags
        (fun uu____2460  ->
           let uu____2461 = FStar_Syntax_Syntax.lcomp_comp lc  in
           set_result_typ uu____2461 t)
  
let (is_trivial_wp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    FStar_All.pipe_right (comp_flags c)
      (FStar_Util.for_some
         (fun uu___114_2476  ->
            match uu___114_2476 with
            | FStar_Syntax_Syntax.TOTAL  -> true
            | FStar_Syntax_Syntax.RETURN  -> true
            | uu____2477 -> false))
  
let (comp_effect_args : FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.args)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total uu____2483 -> []
    | FStar_Syntax_Syntax.GTotal uu____2500 -> []
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
    | uu____2537 -> false
  
let rec (unascribe : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____2545,uu____2546) ->
        unascribe e2
    | uu____2587 -> e1
  
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
      | FStar_Syntax_Syntax.Tm_ascribed (t',uu____2639,uu____2640) ->
          ascribe t' k
      | uu____2681 ->
          FStar_Syntax_Syntax.mk
            (FStar_Syntax_Syntax.Tm_ascribed
               (t, k, FStar_Pervasives_Native.None))
            FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
  
let (unfold_lazy : FStar_Syntax_Syntax.lazyinfo -> FStar_Syntax_Syntax.term)
  =
  fun i  ->
    let uu____2707 =
      let uu____2716 = FStar_ST.op_Bang FStar_Syntax_Syntax.lazy_chooser  in
      FStar_Util.must uu____2716  in
    uu____2707 i.FStar_Syntax_Syntax.lkind i
  
let rec (unlazy : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let uu____2775 =
      let uu____2776 = FStar_Syntax_Subst.compress t  in
      uu____2776.FStar_Syntax_Syntax.n  in
    match uu____2775 with
    | FStar_Syntax_Syntax.Tm_lazy i ->
        let uu____2780 = unfold_lazy i  in
        FStar_All.pipe_left unlazy uu____2780
    | uu____2781 -> t
  
let rec unlazy_as_t :
  'Auu____2788 .
    FStar_Syntax_Syntax.lazy_kind -> FStar_Syntax_Syntax.term -> 'Auu____2788
  =
  fun k  ->
    fun t  ->
      let uu____2799 =
        let uu____2800 = FStar_Syntax_Subst.compress t  in
        uu____2800.FStar_Syntax_Syntax.n  in
      match uu____2799 with
      | FStar_Syntax_Syntax.Tm_lazy
          { FStar_Syntax_Syntax.blob = v1; FStar_Syntax_Syntax.lkind = k';
            FStar_Syntax_Syntax.typ = uu____2805;
            FStar_Syntax_Syntax.rng = uu____2806;_}
          when k = k' -> FStar_Dyn.undyn v1
      | uu____2809 -> failwith "Not a Tm_lazy of the expected kind"
  
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
            let uu____2848 = FStar_Dyn.mkdyn t  in
            {
              FStar_Syntax_Syntax.blob = uu____2848;
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
    let uu____2860 =
      let uu____2875 = unascribe t  in head_and_args' uu____2875  in
    match uu____2860 with
    | (hd1,args) ->
        FStar_Syntax_Syntax.mk_Tm_app hd1 args FStar_Pervasives_Native.None
          t.FStar_Syntax_Syntax.pos
  
type eq_result =
  | Equal 
  | NotEqual 
  | Unknown 
let (uu___is_Equal : eq_result -> Prims.bool) =
  fun projectee  ->
    match projectee with | Equal  -> true | uu____2905 -> false
  
let (uu___is_NotEqual : eq_result -> Prims.bool) =
  fun projectee  ->
    match projectee with | NotEqual  -> true | uu____2911 -> false
  
let (uu___is_Unknown : eq_result -> Prims.bool) =
  fun projectee  ->
    match projectee with | Unknown  -> true | uu____2917 -> false
  
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
      let equal_if uu___115_2993 = if uu___115_2993 then Equal else Unknown
         in
      let equal_iff uu___116_3000 = if uu___116_3000 then Equal else NotEqual
         in
      let eq_and f g = match f with | Equal  -> g () | uu____3018 -> Unknown
         in
      let eq_inj f g =
        match (f, g) with
        | (Equal ,Equal ) -> Equal
        | (NotEqual ,uu____3030) -> NotEqual
        | (uu____3031,NotEqual ) -> NotEqual
        | (Unknown ,uu____3032) -> Unknown
        | (uu____3033,Unknown ) -> Unknown  in
      let equal_data f1 args1 f2 args2 =
        let uu____3087 = FStar_Syntax_Syntax.fv_eq f1 f2  in
        if uu____3087
        then
          let uu____3089 = FStar_List.zip args1 args2  in
          FStar_All.pipe_left
            (FStar_List.fold_left
               (fun acc  ->
                  fun uu____3163  ->
                    match uu____3163 with
                    | ((a1,q1),(a2,q2)) ->
                        let uu____3205 = eq_tm a1 a2  in
                        eq_inj acc uu____3205) Equal) uu____3089
        else NotEqual  in
      let uu____3207 =
        let uu____3212 =
          let uu____3213 = unmeta t11  in uu____3213.FStar_Syntax_Syntax.n
           in
        let uu____3216 =
          let uu____3217 = unmeta t21  in uu____3217.FStar_Syntax_Syntax.n
           in
        (uu____3212, uu____3216)  in
      match uu____3207 with
      | (FStar_Syntax_Syntax.Tm_bvar bv1,FStar_Syntax_Syntax.Tm_bvar bv2) ->
          equal_if
            (bv1.FStar_Syntax_Syntax.index = bv2.FStar_Syntax_Syntax.index)
      | (FStar_Syntax_Syntax.Tm_lazy uu____3222,uu____3223) ->
          let uu____3224 = unlazy t11  in eq_tm uu____3224 t21
      | (uu____3225,FStar_Syntax_Syntax.Tm_lazy uu____3226) ->
          let uu____3227 = unlazy t21  in eq_tm t11 uu____3227
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
            (let uu____3249 = FStar_Syntax_Syntax.fv_eq f g  in
             equal_if uu____3249)
      | (FStar_Syntax_Syntax.Tm_uinst (f,us),FStar_Syntax_Syntax.Tm_uinst
         (g,vs)) ->
          let uu____3262 = eq_tm f g  in
          eq_and uu____3262
            (fun uu____3265  ->
               let uu____3266 = eq_univs_list us vs  in equal_if uu____3266)
      | (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_range
         uu____3267),uu____3268) -> Unknown
      | (uu____3269,FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_range
         uu____3270)) -> Unknown
      | (FStar_Syntax_Syntax.Tm_constant c,FStar_Syntax_Syntax.Tm_constant d)
          ->
          let uu____3273 = FStar_Const.eq_const c d  in equal_iff uu____3273
      | (FStar_Syntax_Syntax.Tm_uvar
         (u1,([],uu____3275)),FStar_Syntax_Syntax.Tm_uvar
         (u2,([],uu____3277))) ->
          let uu____3306 =
            FStar_Syntax_Unionfind.equiv u1.FStar_Syntax_Syntax.ctx_uvar_head
              u2.FStar_Syntax_Syntax.ctx_uvar_head
             in
          equal_if uu____3306
      | (FStar_Syntax_Syntax.Tm_app (h1,args1),FStar_Syntax_Syntax.Tm_app
         (h2,args2)) ->
          let uu____3359 =
            let uu____3364 =
              let uu____3365 = un_uinst h1  in
              uu____3365.FStar_Syntax_Syntax.n  in
            let uu____3368 =
              let uu____3369 = un_uinst h2  in
              uu____3369.FStar_Syntax_Syntax.n  in
            (uu____3364, uu____3368)  in
          (match uu____3359 with
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
                 (let uu____3381 =
                    let uu____3382 = FStar_Syntax_Syntax.lid_of_fv f1  in
                    FStar_Ident.string_of_lid uu____3382  in
                  FStar_List.mem uu____3381 injectives)
               -> equal_data f1 args1 f2 args2
           | uu____3383 ->
               let uu____3388 = eq_tm h1 h2  in
               eq_and uu____3388 (fun uu____3390  -> eq_args args1 args2))
      | (FStar_Syntax_Syntax.Tm_match (t12,bs1),FStar_Syntax_Syntax.Tm_match
         (t22,bs2)) ->
          if (FStar_List.length bs1) = (FStar_List.length bs2)
          then
            let uu____3495 = FStar_List.zip bs1 bs2  in
            let uu____3558 = eq_tm t12 t22  in
            FStar_List.fold_right
              (fun uu____3595  ->
                 fun a  ->
                   match uu____3595 with
                   | (b1,b2) ->
                       eq_and a (fun uu____3688  -> branch_matches b1 b2))
              uu____3495 uu____3558
          else Unknown
      | (FStar_Syntax_Syntax.Tm_type u,FStar_Syntax_Syntax.Tm_type v1) ->
          let uu____3692 = eq_univs u v1  in equal_if uu____3692
      | (FStar_Syntax_Syntax.Tm_quoted (t12,q1),FStar_Syntax_Syntax.Tm_quoted
         (t22,q2)) -> if q1 = q2 then eq_tm t12 t22 else Unknown
      | (FStar_Syntax_Syntax.Tm_refine
         (t12,phi1),FStar_Syntax_Syntax.Tm_refine (t22,phi2)) ->
          let uu____3718 =
            eq_tm t12.FStar_Syntax_Syntax.sort t22.FStar_Syntax_Syntax.sort
             in
          eq_and uu____3718 (fun uu____3720  -> eq_tm phi1 phi2)
      | uu____3721 -> Unknown

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
        | (uu____3804,uu____3805) -> false  in
      let uu____3814 = b1  in
      match uu____3814 with
      | (p1,w1,t1) ->
          let uu____3848 = b2  in
          (match uu____3848 with
           | (p2,w2,t2) ->
               let uu____3882 = FStar_Syntax_Syntax.eq_pat p1 p2  in
               if uu____3882
               then
                 let uu____3883 =
                   (let uu____3886 = eq_tm t1 t2  in uu____3886 = Equal) &&
                     (related_by
                        (fun t11  ->
                           fun t21  ->
                             let uu____3895 = eq_tm t11 t21  in
                             uu____3895 = Equal) w1 w2)
                    in
                 (if uu____3883 then Equal else Unknown)
               else Unknown)

and (eq_args :
  FStar_Syntax_Syntax.args -> FStar_Syntax_Syntax.args -> eq_result) =
  fun a1  ->
    fun a2  ->
      match (a1, a2) with
      | ([],[]) -> Equal
      | ((a,uu____3957)::a11,(b,uu____3960)::b1) ->
          let uu____4034 = eq_tm a b  in
          (match uu____4034 with
           | Equal  -> eq_args a11 b1
           | uu____4035 -> Unknown)
      | uu____4036 -> Unknown

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
    | FStar_Syntax_Syntax.Tm_refine (x,uu____4070) ->
        unrefine x.FStar_Syntax_Syntax.sort
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____4076,uu____4077) ->
        unrefine t2
    | uu____4118 -> t1
  
let rec (is_uvar : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____4124 =
      let uu____4125 = FStar_Syntax_Subst.compress t  in
      uu____4125.FStar_Syntax_Syntax.n  in
    match uu____4124 with
    | FStar_Syntax_Syntax.Tm_uvar uu____4128 -> true
    | FStar_Syntax_Syntax.Tm_uinst (t1,uu____4142) -> is_uvar t1
    | FStar_Syntax_Syntax.Tm_app uu____4147 ->
        let uu____4164 =
          let uu____4165 = FStar_All.pipe_right t head_and_args  in
          FStar_All.pipe_right uu____4165 FStar_Pervasives_Native.fst  in
        FStar_All.pipe_right uu____4164 is_uvar
    | FStar_Syntax_Syntax.Tm_ascribed (t1,uu____4227,uu____4228) ->
        is_uvar t1
    | uu____4269 -> false
  
let rec (is_unit : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____4275 =
      let uu____4276 = unrefine t  in uu____4276.FStar_Syntax_Syntax.n  in
    match uu____4275 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        ((FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.unit_lid) ||
           (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid))
          ||
          (FStar_Syntax_Syntax.fv_eq_lid fv
             FStar_Parser_Const.auto_squash_lid)
    | FStar_Syntax_Syntax.Tm_uinst (t1,uu____4281) -> is_unit t1
    | uu____4286 -> false
  
let rec (non_informative : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____4292 =
      let uu____4293 = unrefine t  in uu____4293.FStar_Syntax_Syntax.n  in
    match uu____4292 with
    | FStar_Syntax_Syntax.Tm_type uu____4296 -> true
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        ((FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.unit_lid) ||
           (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid))
          || (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.erased_lid)
    | FStar_Syntax_Syntax.Tm_app (head1,uu____4299) -> non_informative head1
    | FStar_Syntax_Syntax.Tm_uinst (t1,uu____4325) -> non_informative t1
    | FStar_Syntax_Syntax.Tm_arrow (uu____4330,c) ->
        (is_tot_or_gtot_comp c) && (non_informative (comp_result c))
    | uu____4352 -> false
  
let (is_fun : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun e  ->
    let uu____4358 =
      let uu____4359 = FStar_Syntax_Subst.compress e  in
      uu____4359.FStar_Syntax_Syntax.n  in
    match uu____4358 with
    | FStar_Syntax_Syntax.Tm_abs uu____4362 -> true
    | uu____4381 -> false
  
let (is_function_typ : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____4387 =
      let uu____4388 = FStar_Syntax_Subst.compress t  in
      uu____4388.FStar_Syntax_Syntax.n  in
    match uu____4387 with
    | FStar_Syntax_Syntax.Tm_arrow uu____4391 -> true
    | uu____4406 -> false
  
let rec (pre_typ : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_refine (x,uu____4414) ->
        pre_typ x.FStar_Syntax_Syntax.sort
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____4420,uu____4421) ->
        pre_typ t2
    | uu____4462 -> t1
  
let (destruct :
  FStar_Syntax_Syntax.term ->
    FStar_Ident.lident ->
      (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.arg_qualifier
                                                              FStar_Pervasives_Native.option)
        FStar_Pervasives_Native.tuple2 Prims.list
        FStar_Pervasives_Native.option)
  =
  fun typ  ->
    fun lid  ->
      let typ1 = FStar_Syntax_Subst.compress typ  in
      let uu____4486 =
        let uu____4487 = un_uinst typ1  in uu____4487.FStar_Syntax_Syntax.n
         in
      match uu____4486 with
      | FStar_Syntax_Syntax.Tm_app (head1,args) ->
          let head2 = un_uinst head1  in
          (match head2.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Tm_fvar tc when
               FStar_Syntax_Syntax.fv_eq_lid tc lid ->
               FStar_Pervasives_Native.Some args
           | uu____4552 -> FStar_Pervasives_Native.None)
      | FStar_Syntax_Syntax.Tm_fvar tc when
          FStar_Syntax_Syntax.fv_eq_lid tc lid ->
          FStar_Pervasives_Native.Some []
      | uu____4582 -> FStar_Pervasives_Native.None
  
let (lids_of_sigelt :
  FStar_Syntax_Syntax.sigelt -> FStar_Ident.lident Prims.list) =
  fun se  ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_let (uu____4602,lids) -> lids
    | FStar_Syntax_Syntax.Sig_splice (lids,uu____4609) -> lids
    | FStar_Syntax_Syntax.Sig_bundle (uu____4614,lids) -> lids
    | FStar_Syntax_Syntax.Sig_inductive_typ
        (lid,uu____4625,uu____4626,uu____4627,uu____4628,uu____4629) -> 
        [lid]
    | FStar_Syntax_Syntax.Sig_effect_abbrev
        (lid,uu____4639,uu____4640,uu____4641,uu____4642) -> [lid]
    | FStar_Syntax_Syntax.Sig_datacon
        (lid,uu____4648,uu____4649,uu____4650,uu____4651,uu____4652) -> 
        [lid]
    | FStar_Syntax_Syntax.Sig_declare_typ (lid,uu____4658,uu____4659) ->
        [lid]
    | FStar_Syntax_Syntax.Sig_assume (lid,uu____4661,uu____4662) -> [lid]
    | FStar_Syntax_Syntax.Sig_new_effect_for_free n1 ->
        [n1.FStar_Syntax_Syntax.mname]
    | FStar_Syntax_Syntax.Sig_new_effect n1 -> [n1.FStar_Syntax_Syntax.mname]
    | FStar_Syntax_Syntax.Sig_sub_effect uu____4665 -> []
    | FStar_Syntax_Syntax.Sig_pragma uu____4666 -> []
    | FStar_Syntax_Syntax.Sig_main uu____4667 -> []
  
let (lid_of_sigelt :
  FStar_Syntax_Syntax.sigelt ->
    FStar_Ident.lident FStar_Pervasives_Native.option)
  =
  fun se  ->
    match lids_of_sigelt se with
    | l::[] -> FStar_Pervasives_Native.Some l
    | uu____4680 -> FStar_Pervasives_Native.None
  
let (quals_of_sigelt :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.qualifier Prims.list) =
  fun x  -> x.FStar_Syntax_Syntax.sigquals 
let (range_of_sigelt : FStar_Syntax_Syntax.sigelt -> FStar_Range.range) =
  fun x  -> x.FStar_Syntax_Syntax.sigrng 
let (range_of_lbname :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
    FStar_Range.range)
  =
  fun uu___117_4703  ->
    match uu___117_4703 with
    | FStar_Util.Inl x -> FStar_Syntax_Syntax.range_of_bv x
    | FStar_Util.Inr fv ->
        FStar_Ident.range_of_lid
          (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
  
let range_of_arg :
  'Auu____4716 'Auu____4717 .
    ('Auu____4716 FStar_Syntax_Syntax.syntax,'Auu____4717)
      FStar_Pervasives_Native.tuple2 -> FStar_Range.range
  =
  fun uu____4728  ->
    match uu____4728 with | (hd1,uu____4736) -> hd1.FStar_Syntax_Syntax.pos
  
let range_of_args :
  'Auu____4749 'Auu____4750 .
    ('Auu____4749 FStar_Syntax_Syntax.syntax,'Auu____4750)
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
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.arg_qualifier
                                                            FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple2 Prims.list ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun f  ->
    fun args  ->
      match args with
      | [] -> f
      | uu____4847 ->
          let r = range_of_args args f.FStar_Syntax_Syntax.pos  in
          FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app (f, args))
            FStar_Pervasives_Native.None r
  
let (mk_data :
  FStar_Ident.lident ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.arg_qualifier
                                                            FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple2 Prims.list ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
        FStar_Syntax_Syntax.syntax)
  =
  fun l  ->
    fun args  ->
      match args with
      | [] ->
          let uu____4919 = FStar_Ident.range_of_lid l  in
          let uu____4920 =
            let uu____4929 =
              FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.delta_constant
                (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
               in
            FStar_Syntax_Syntax.mk uu____4929  in
          uu____4920 FStar_Pervasives_Native.None uu____4919
      | uu____4937 ->
          let e =
            let uu____4951 =
              FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.delta_constant
                (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
               in
            mk_app uu____4951 args  in
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
      let uu____4966 =
        let uu____4971 =
          FStar_Util.substring_from x.FStar_Ident.idText
            (Prims.parse_int "9")
           in
        (uu____4971, (x.FStar_Ident.idRange))  in
      FStar_Ident.mk_ident uu____4966
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
          let uu____5022 = FStar_Syntax_Syntax.is_null_bv x  in
          if uu____5022
          then
            let uu____5023 =
              let uu____5028 =
                let uu____5029 = FStar_Util.string_of_int i  in
                Prims.strcat "_" uu____5029  in
              let uu____5030 = FStar_Syntax_Syntax.range_of_bv x  in
              (uu____5028, uu____5030)  in
            FStar_Ident.mk_ident uu____5023
          else x.FStar_Syntax_Syntax.ppname  in
        let y =
          let uu___123_5033 = x  in
          {
            FStar_Syntax_Syntax.ppname = nm;
            FStar_Syntax_Syntax.index =
              (uu___123_5033.FStar_Syntax_Syntax.index);
            FStar_Syntax_Syntax.sort =
              (uu___123_5033.FStar_Syntax_Syntax.sort)
          }  in
        let uu____5034 = mk_field_projector_name_from_ident lid nm  in
        (uu____5034, y)
  
let (ses_of_sigbundle :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.sigelt Prims.list) =
  fun se  ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_bundle (ses,uu____5045) -> ses
    | uu____5054 -> failwith "ses_of_sigbundle: not a Sig_bundle"
  
let (eff_decl_of_new_effect :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.eff_decl) =
  fun se  ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_new_effect ne -> ne
    | uu____5063 -> failwith "eff_decl_of_new_effect: not a Sig_new_effect"
  
let (set_uvar : FStar_Syntax_Syntax.uvar -> FStar_Syntax_Syntax.term -> unit)
  =
  fun uv  ->
    fun t  ->
      let uu____5074 = FStar_Syntax_Unionfind.find uv  in
      match uu____5074 with
      | FStar_Pervasives_Native.Some uu____5077 ->
          let uu____5078 =
            let uu____5079 =
              let uu____5080 = FStar_Syntax_Unionfind.uvar_id uv  in
              FStar_All.pipe_left FStar_Util.string_of_int uu____5080  in
            FStar_Util.format1 "Changing a fixed uvar! ?%s\n" uu____5079  in
          failwith uu____5078
      | uu____5081 -> FStar_Syntax_Unionfind.change uv t
  
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
      | uu____5156 -> q1 = q2
  
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
              let uu____5201 =
                let uu___124_5202 = rc  in
                let uu____5203 =
                  FStar_Util.map_opt rc.FStar_Syntax_Syntax.residual_typ
                    (FStar_Syntax_Subst.close bs)
                   in
                {
                  FStar_Syntax_Syntax.residual_effect =
                    (uu___124_5202.FStar_Syntax_Syntax.residual_effect);
                  FStar_Syntax_Syntax.residual_typ = uu____5203;
                  FStar_Syntax_Syntax.residual_flags =
                    (uu___124_5202.FStar_Syntax_Syntax.residual_flags)
                }  in
              FStar_Pervasives_Native.Some uu____5201
           in
        match bs with
        | [] -> t
        | uu____5220 ->
            let body =
              let uu____5222 = FStar_Syntax_Subst.close bs t  in
              FStar_Syntax_Subst.compress uu____5222  in
            (match ((body.FStar_Syntax_Syntax.n), lopt) with
             | (FStar_Syntax_Syntax.Tm_abs
                (bs',t1,lopt'),FStar_Pervasives_Native.None ) ->
                 let uu____5256 =
                   let uu____5263 =
                     let uu____5264 =
                       let uu____5283 =
                         let uu____5292 = FStar_Syntax_Subst.close_binders bs
                            in
                         FStar_List.append uu____5292 bs'  in
                       let uu____5307 = close_lopt lopt'  in
                       (uu____5283, t1, uu____5307)  in
                     FStar_Syntax_Syntax.Tm_abs uu____5264  in
                   FStar_Syntax_Syntax.mk uu____5263  in
                 uu____5256 FStar_Pervasives_Native.None
                   t1.FStar_Syntax_Syntax.pos
             | uu____5325 ->
                 let uu____5332 =
                   let uu____5339 =
                     let uu____5340 =
                       let uu____5359 = FStar_Syntax_Subst.close_binders bs
                          in
                       let uu____5368 = close_lopt lopt  in
                       (uu____5359, body, uu____5368)  in
                     FStar_Syntax_Syntax.Tm_abs uu____5340  in
                   FStar_Syntax_Syntax.mk uu____5339  in
                 uu____5332 FStar_Pervasives_Native.None
                   t.FStar_Syntax_Syntax.pos)
  
let (arrow :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.arg_qualifier
                            FStar_Pervasives_Native.option)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun bs  ->
    fun c  ->
      match bs with
      | [] -> comp_result c
      | uu____5426 ->
          let uu____5435 =
            let uu____5442 =
              let uu____5443 =
                let uu____5458 = FStar_Syntax_Subst.close_binders bs  in
                let uu____5467 = FStar_Syntax_Subst.close_comp bs c  in
                (uu____5458, uu____5467)  in
              FStar_Syntax_Syntax.Tm_arrow uu____5443  in
            FStar_Syntax_Syntax.mk uu____5442  in
          uu____5435 FStar_Pervasives_Native.None c.FStar_Syntax_Syntax.pos
  
let (flat_arrow :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.arg_qualifier
                            FStar_Pervasives_Native.option)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun bs  ->
    fun c  ->
      let t = arrow bs c  in
      let uu____5518 =
        let uu____5519 = FStar_Syntax_Subst.compress t  in
        uu____5519.FStar_Syntax_Syntax.n  in
      match uu____5518 with
      | FStar_Syntax_Syntax.Tm_arrow (bs1,c1) ->
          (match c1.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Total (tres,uu____5549) ->
               let uu____5558 =
                 let uu____5559 = FStar_Syntax_Subst.compress tres  in
                 uu____5559.FStar_Syntax_Syntax.n  in
               (match uu____5558 with
                | FStar_Syntax_Syntax.Tm_arrow (bs',c') ->
                    FStar_Syntax_Syntax.mk
                      (FStar_Syntax_Syntax.Tm_arrow
                         ((FStar_List.append bs1 bs'), c'))
                      FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
                | uu____5602 -> t)
           | uu____5603 -> t)
      | uu____5604 -> t
  
let (refine :
  FStar_Syntax_Syntax.bv ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun b  ->
    fun t  ->
      let uu____5621 =
        let uu____5622 = FStar_Syntax_Syntax.range_of_bv b  in
        FStar_Range.union_ranges uu____5622 t.FStar_Syntax_Syntax.pos  in
      let uu____5623 =
        let uu____5630 =
          let uu____5631 =
            let uu____5638 =
              let uu____5641 =
                let uu____5642 = FStar_Syntax_Syntax.mk_binder b  in
                [uu____5642]  in
              FStar_Syntax_Subst.close uu____5641 t  in
            (b, uu____5638)  in
          FStar_Syntax_Syntax.Tm_refine uu____5631  in
        FStar_Syntax_Syntax.mk uu____5630  in
      uu____5623 FStar_Pervasives_Native.None uu____5621
  
let (branch : FStar_Syntax_Syntax.branch -> FStar_Syntax_Syntax.branch) =
  fun b  -> FStar_Syntax_Subst.close_branch b 
let rec (arrow_formals_comp :
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.arg_qualifier
                               FStar_Pervasives_Native.option)
       FStar_Pervasives_Native.tuple2 Prims.list,FStar_Syntax_Syntax.comp)
      FStar_Pervasives_Native.tuple2)
  =
  fun k  ->
    let k1 = FStar_Syntax_Subst.compress k  in
    match k1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
        let uu____5723 = FStar_Syntax_Subst.open_comp bs c  in
        (match uu____5723 with
         | (bs1,c1) ->
             let uu____5742 = is_total_comp c1  in
             if uu____5742
             then
               let uu____5755 = arrow_formals_comp (comp_result c1)  in
               (match uu____5755 with
                | (bs',k2) -> ((FStar_List.append bs1 bs'), k2))
             else (bs1, c1))
    | FStar_Syntax_Syntax.Tm_refine
        ({ FStar_Syntax_Syntax.ppname = uu____5821;
           FStar_Syntax_Syntax.index = uu____5822;
           FStar_Syntax_Syntax.sort = k2;_},uu____5824)
        -> arrow_formals_comp k2
    | uu____5831 ->
        let uu____5832 = FStar_Syntax_Syntax.mk_Total k1  in ([], uu____5832)
  
let rec (arrow_formals :
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.arg_qualifier
                               FStar_Pervasives_Native.option)
       FStar_Pervasives_Native.tuple2 Prims.list,FStar_Syntax_Syntax.term'
                                                   FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple2)
  =
  fun k  ->
    let uu____5866 = arrow_formals_comp k  in
    match uu____5866 with | (bs,c) -> (bs, (comp_result c))
  
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
          let uu____5958 =
            let uu___125_5959 = rc  in
            let uu____5960 =
              FStar_Util.map_opt rc.FStar_Syntax_Syntax.residual_typ
                (FStar_Syntax_Subst.subst s)
               in
            {
              FStar_Syntax_Syntax.residual_effect =
                (uu___125_5959.FStar_Syntax_Syntax.residual_effect);
              FStar_Syntax_Syntax.residual_typ = uu____5960;
              FStar_Syntax_Syntax.residual_flags =
                (uu___125_5959.FStar_Syntax_Syntax.residual_flags)
            }  in
          FStar_Pervasives_Native.Some uu____5958
      | uu____5969 -> l  in
    let rec aux t1 abs_body_lcomp =
      let uu____6003 =
        let uu____6004 =
          let uu____6007 = FStar_Syntax_Subst.compress t1  in
          FStar_All.pipe_left unascribe uu____6007  in
        uu____6004.FStar_Syntax_Syntax.n  in
      match uu____6003 with
      | FStar_Syntax_Syntax.Tm_abs (bs,t2,what) ->
          let uu____6053 = aux t2 what  in
          (match uu____6053 with
           | (bs',t3,what1) -> ((FStar_List.append bs bs'), t3, what1))
      | uu____6125 -> ([], t1, abs_body_lcomp)  in
    let uu____6142 = aux t FStar_Pervasives_Native.None  in
    match uu____6142 with
    | (bs,t1,abs_body_lcomp) ->
        let uu____6190 = FStar_Syntax_Subst.open_term' bs t1  in
        (match uu____6190 with
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
                    | (FStar_Pervasives_Native.None ,uu____6351) -> def
                    | (uu____6362,[]) -> def
                    | (FStar_Pervasives_Native.Some fvs,uu____6374) ->
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
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.arg_qualifier
                              FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple2 Prims.list ->
      FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
        (FStar_Syntax_Syntax.univ_names,(FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.arg_qualifier
                                                                  FStar_Pervasives_Native.option)
                                          FStar_Pervasives_Native.tuple2
                                          Prims.list,FStar_Syntax_Syntax.comp)
          FStar_Pervasives_Native.tuple3)
  =
  fun uvs  ->
    fun binders  ->
      fun c  ->
        match binders with
        | [] ->
            let uu____6470 = FStar_Syntax_Subst.open_univ_vars_comp uvs c  in
            (match uu____6470 with | (uvs1,c1) -> (uvs1, [], c1))
        | uu____6505 ->
            let t' = arrow binders c  in
            let uu____6517 = FStar_Syntax_Subst.open_univ_vars uvs t'  in
            (match uu____6517 with
             | (uvs1,t'1) ->
                 let uu____6538 =
                   let uu____6539 = FStar_Syntax_Subst.compress t'1  in
                   uu____6539.FStar_Syntax_Syntax.n  in
                 (match uu____6538 with
                  | FStar_Syntax_Syntax.Tm_arrow (binders1,c1) ->
                      (uvs1, binders1, c1)
                  | uu____6588 -> failwith "Impossible"))
  
let (is_tuple_constructor : FStar_Syntax_Syntax.typ -> Prims.bool) =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Parser_Const.is_tuple_constructor_string
          ((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v).FStar_Ident.str
    | uu____6609 -> false
  
let (is_dtuple_constructor : FStar_Syntax_Syntax.typ -> Prims.bool) =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Parser_Const.is_dtuple_constructor_lid
          (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
    | uu____6616 -> false
  
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
      let uu____6664 =
        let uu____6665 = pre_typ t  in uu____6665.FStar_Syntax_Syntax.n  in
      match uu____6664 with
      | FStar_Syntax_Syntax.Tm_fvar tc ->
          FStar_Ident.lid_equals
            (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v lid
      | uu____6669 -> false
  
let rec (is_constructed_typ :
  FStar_Syntax_Syntax.term -> FStar_Ident.lident -> Prims.bool) =
  fun t  ->
    fun lid  ->
      let uu____6680 =
        let uu____6681 = pre_typ t  in uu____6681.FStar_Syntax_Syntax.n  in
      match uu____6680 with
      | FStar_Syntax_Syntax.Tm_fvar uu____6684 -> is_constructor t lid
      | FStar_Syntax_Syntax.Tm_app (t1,uu____6686) ->
          is_constructed_typ t1 lid
      | FStar_Syntax_Syntax.Tm_uinst (t1,uu____6712) ->
          is_constructed_typ t1 lid
      | uu____6717 -> false
  
let rec (get_tycon :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term FStar_Pervasives_Native.option)
  =
  fun t  ->
    let t1 = pre_typ t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_bvar uu____6728 ->
        FStar_Pervasives_Native.Some t1
    | FStar_Syntax_Syntax.Tm_name uu____6729 ->
        FStar_Pervasives_Native.Some t1
    | FStar_Syntax_Syntax.Tm_fvar uu____6730 ->
        FStar_Pervasives_Native.Some t1
    | FStar_Syntax_Syntax.Tm_app (t2,uu____6732) -> get_tycon t2
    | uu____6757 -> FStar_Pervasives_Native.None
  
let (is_fstar_tactics_by_tactic : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____6763 =
      let uu____6764 = un_uinst t  in uu____6764.FStar_Syntax_Syntax.n  in
    match uu____6763 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.by_tactic_lid
    | uu____6768 -> false
  
let (is_builtin_tactic : FStar_Ident.lident -> Prims.bool) =
  fun md  ->
    let path = FStar_Ident.path_of_lid md  in
    if (FStar_List.length path) > (Prims.parse_int "2")
    then
      let uu____6775 =
        let uu____6778 = FStar_List.splitAt (Prims.parse_int "2") path  in
        FStar_Pervasives_Native.fst uu____6778  in
      match uu____6775 with
      | "FStar"::"Tactics"::[] -> true
      | "FStar"::"Reflection"::[] -> true
      | uu____6791 -> false
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
  fun uu____6803  ->
    let u =
      let uu____6809 = FStar_Syntax_Unionfind.univ_fresh ()  in
      FStar_All.pipe_left (fun _0_5  -> FStar_Syntax_Syntax.U_unif _0_5)
        uu____6809
       in
    let uu____6826 =
      FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type u)
        FStar_Pervasives_Native.None FStar_Range.dummyRange
       in
    (uu____6826, u)
  
let (attr_eq :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun a  ->
    fun a'  ->
      let uu____6837 = eq_tm a a'  in
      match uu____6837 with | Equal  -> true | uu____6838 -> false
  
let (attr_substitute : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  let uu____6841 =
    let uu____6848 =
      let uu____6849 =
        let uu____6850 =
          FStar_Ident.lid_of_path ["FStar"; "Pervasives"; "Substitute"]
            FStar_Range.dummyRange
           in
        FStar_Syntax_Syntax.lid_as_fv uu____6850
          FStar_Syntax_Syntax.delta_constant FStar_Pervasives_Native.None
         in
      FStar_Syntax_Syntax.Tm_fvar uu____6849  in
    FStar_Syntax_Syntax.mk uu____6848  in
  uu____6841 FStar_Pervasives_Native.None FStar_Range.dummyRange 
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
          let uu____6925 =
            let uu____6928 =
              FStar_Range.union_ranges phi11.FStar_Syntax_Syntax.pos
                phi2.FStar_Syntax_Syntax.pos
               in
            let uu____6929 =
              let uu____6936 =
                let uu____6937 =
                  let uu____6954 =
                    let uu____6965 = FStar_Syntax_Syntax.as_arg phi11  in
                    let uu____6974 =
                      let uu____6985 = FStar_Syntax_Syntax.as_arg phi2  in
                      [uu____6985]  in
                    uu____6965 :: uu____6974  in
                  (tand, uu____6954)  in
                FStar_Syntax_Syntax.Tm_app uu____6937  in
              FStar_Syntax_Syntax.mk uu____6936  in
            uu____6929 FStar_Pervasives_Native.None uu____6928  in
          FStar_Pervasives_Native.Some uu____6925
  
let (mk_binop :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun op_t  ->
    fun phi1  ->
      fun phi2  ->
        let uu____7064 =
          FStar_Range.union_ranges phi1.FStar_Syntax_Syntax.pos
            phi2.FStar_Syntax_Syntax.pos
           in
        let uu____7065 =
          let uu____7072 =
            let uu____7073 =
              let uu____7090 =
                let uu____7101 = FStar_Syntax_Syntax.as_arg phi1  in
                let uu____7110 =
                  let uu____7121 = FStar_Syntax_Syntax.as_arg phi2  in
                  [uu____7121]  in
                uu____7101 :: uu____7110  in
              (op_t, uu____7090)  in
            FStar_Syntax_Syntax.Tm_app uu____7073  in
          FStar_Syntax_Syntax.mk uu____7072  in
        uu____7065 FStar_Pervasives_Native.None uu____7064
  
let (mk_neg :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun phi  ->
    let uu____7180 =
      let uu____7187 =
        let uu____7188 =
          let uu____7205 =
            let uu____7216 = FStar_Syntax_Syntax.as_arg phi  in [uu____7216]
             in
          (t_not, uu____7205)  in
        FStar_Syntax_Syntax.Tm_app uu____7188  in
      FStar_Syntax_Syntax.mk uu____7187  in
    uu____7180 FStar_Pervasives_Native.None phi.FStar_Syntax_Syntax.pos
  
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
    let uu____7409 =
      let uu____7416 =
        let uu____7417 =
          let uu____7434 =
            let uu____7445 = FStar_Syntax_Syntax.as_arg e  in [uu____7445]
             in
          (b2t_v, uu____7434)  in
        FStar_Syntax_Syntax.Tm_app uu____7417  in
      FStar_Syntax_Syntax.mk uu____7416  in
    uu____7409 FStar_Pervasives_Native.None e.FStar_Syntax_Syntax.pos
  
let (is_t_true : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____7490 =
      let uu____7491 = unmeta t  in uu____7491.FStar_Syntax_Syntax.n  in
    match uu____7490 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.true_lid
    | uu____7495 -> false
  
let (mk_conj_simp :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t1  ->
    fun t2  ->
      let uu____7516 = is_t_true t1  in
      if uu____7516
      then t2
      else
        (let uu____7520 = is_t_true t2  in
         if uu____7520 then t1 else mk_conj t1 t2)
  
let (mk_disj_simp :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t1  ->
    fun t2  ->
      let uu____7544 = is_t_true t1  in
      if uu____7544
      then t_true
      else
        (let uu____7548 = is_t_true t2  in
         if uu____7548 then t_true else mk_disj t1 t2)
  
let (teq : FStar_Syntax_Syntax.term) = fvar_const FStar_Parser_Const.eq2_lid 
let (mk_untyped_eq2 :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun e1  ->
    fun e2  ->
      let uu____7572 =
        FStar_Range.union_ranges e1.FStar_Syntax_Syntax.pos
          e2.FStar_Syntax_Syntax.pos
         in
      let uu____7573 =
        let uu____7580 =
          let uu____7581 =
            let uu____7598 =
              let uu____7609 = FStar_Syntax_Syntax.as_arg e1  in
              let uu____7618 =
                let uu____7629 = FStar_Syntax_Syntax.as_arg e2  in
                [uu____7629]  in
              uu____7609 :: uu____7618  in
            (teq, uu____7598)  in
          FStar_Syntax_Syntax.Tm_app uu____7581  in
        FStar_Syntax_Syntax.mk uu____7580  in
      uu____7573 FStar_Pervasives_Native.None uu____7572
  
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
          let uu____7698 =
            FStar_Range.union_ranges e1.FStar_Syntax_Syntax.pos
              e2.FStar_Syntax_Syntax.pos
             in
          let uu____7699 =
            let uu____7706 =
              let uu____7707 =
                let uu____7724 =
                  let uu____7735 = FStar_Syntax_Syntax.iarg t  in
                  let uu____7744 =
                    let uu____7755 = FStar_Syntax_Syntax.as_arg e1  in
                    let uu____7764 =
                      let uu____7775 = FStar_Syntax_Syntax.as_arg e2  in
                      [uu____7775]  in
                    uu____7755 :: uu____7764  in
                  uu____7735 :: uu____7744  in
                (eq_inst, uu____7724)  in
              FStar_Syntax_Syntax.Tm_app uu____7707  in
            FStar_Syntax_Syntax.mk uu____7706  in
          uu____7699 FStar_Pervasives_Native.None uu____7698
  
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
        let uu____7854 =
          let uu____7861 =
            let uu____7862 =
              let uu____7879 =
                let uu____7890 = FStar_Syntax_Syntax.iarg t  in
                let uu____7899 =
                  let uu____7910 = FStar_Syntax_Syntax.as_arg x  in
                  let uu____7919 =
                    let uu____7930 = FStar_Syntax_Syntax.as_arg t'  in
                    [uu____7930]  in
                  uu____7910 :: uu____7919  in
                uu____7890 :: uu____7899  in
              (t_has_type1, uu____7879)  in
            FStar_Syntax_Syntax.Tm_app uu____7862  in
          FStar_Syntax_Syntax.mk uu____7861  in
        uu____7854 FStar_Pervasives_Native.None FStar_Range.dummyRange
  
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
        let uu____8009 =
          let uu____8016 =
            let uu____8017 =
              let uu____8034 =
                let uu____8045 = FStar_Syntax_Syntax.iarg t  in
                let uu____8054 =
                  let uu____8065 = FStar_Syntax_Syntax.as_arg e  in
                  [uu____8065]  in
                uu____8045 :: uu____8054  in
              (t_with_type1, uu____8034)  in
            FStar_Syntax_Syntax.Tm_app uu____8017  in
          FStar_Syntax_Syntax.mk uu____8016  in
        uu____8009 FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (lex_t : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.lex_t_lid 
let (lex_top : FStar_Syntax_Syntax.term) =
  let uu____8113 =
    let uu____8120 =
      let uu____8121 =
        let uu____8128 =
          FStar_Syntax_Syntax.fvar FStar_Parser_Const.lextop_lid
            FStar_Syntax_Syntax.delta_constant
            (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
           in
        (uu____8128, [FStar_Syntax_Syntax.U_zero])  in
      FStar_Syntax_Syntax.Tm_uinst uu____8121  in
    FStar_Syntax_Syntax.mk uu____8120  in
  uu____8113 FStar_Pervasives_Native.None FStar_Range.dummyRange 
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
    let uu____8141 =
      match c0.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Total uu____8154 ->
          (FStar_Parser_Const.effect_Tot_lid, [FStar_Syntax_Syntax.TOTAL])
      | FStar_Syntax_Syntax.GTotal uu____8165 ->
          (FStar_Parser_Const.effect_GTot_lid,
            [FStar_Syntax_Syntax.SOMETRIVIAL])
      | FStar_Syntax_Syntax.Comp c ->
          ((c.FStar_Syntax_Syntax.effect_name),
            (c.FStar_Syntax_Syntax.flags))
       in
    match uu____8141 with
    | (eff_name,flags1) ->
        FStar_Syntax_Syntax.mk_lcomp eff_name (comp_result c0) flags1
          (fun uu____8186  -> c0)
  
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
        let uu____8264 =
          let uu____8271 =
            let uu____8272 =
              let uu____8289 =
                let uu____8300 =
                  FStar_Syntax_Syntax.iarg x.FStar_Syntax_Syntax.sort  in
                let uu____8309 =
                  let uu____8320 =
                    let uu____8329 =
                      let uu____8330 =
                        let uu____8331 = FStar_Syntax_Syntax.mk_binder x  in
                        [uu____8331]  in
                      abs uu____8330 body
                        (FStar_Pervasives_Native.Some (residual_tot ktype0))
                       in
                    FStar_Syntax_Syntax.as_arg uu____8329  in
                  [uu____8320]  in
                uu____8300 :: uu____8309  in
              (fa, uu____8289)  in
            FStar_Syntax_Syntax.Tm_app uu____8272  in
          FStar_Syntax_Syntax.mk uu____8271  in
        uu____8264 FStar_Pervasives_Native.None FStar_Range.dummyRange
  
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
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.arg_qualifier
                            FStar_Pervasives_Native.option)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ)
  =
  fun bs  ->
    fun f  ->
      FStar_List.fold_right
        (fun b  ->
           fun f1  ->
             let uu____8458 = FStar_Syntax_Syntax.is_null_binder b  in
             if uu____8458
             then f1
             else mk_forall_no_univ (FStar_Pervasives_Native.fst b) f1) bs f
  
let rec (is_wild_pat :
  FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t -> Prims.bool) =
  fun p  ->
    match p.FStar_Syntax_Syntax.v with
    | FStar_Syntax_Syntax.Pat_wild uu____8471 -> true
    | uu____8472 -> false
  
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
          let uu____8517 =
            FStar_Syntax_Syntax.withinfo
              (FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_bool true))
              t1.FStar_Syntax_Syntax.pos
             in
          (uu____8517, FStar_Pervasives_Native.None, t1)  in
        let else_branch =
          let uu____8545 =
            FStar_Syntax_Syntax.withinfo
              (FStar_Syntax_Syntax.Pat_constant
                 (FStar_Const.Const_bool false)) t2.FStar_Syntax_Syntax.pos
             in
          (uu____8545, FStar_Pervasives_Native.None, t2)  in
        let uu____8558 =
          let uu____8559 =
            FStar_Range.union_ranges t1.FStar_Syntax_Syntax.pos
              t2.FStar_Syntax_Syntax.pos
             in
          FStar_Range.union_ranges b.FStar_Syntax_Syntax.pos uu____8559  in
        FStar_Syntax_Syntax.mk
          (FStar_Syntax_Syntax.Tm_match (b, [then_branch; else_branch]))
          FStar_Pervasives_Native.None uu____8558
  
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
      let uu____8633 = FStar_Syntax_Syntax.mk_Tm_uinst sq [u]  in
      let uu____8636 =
        let uu____8647 = FStar_Syntax_Syntax.as_arg p  in [uu____8647]  in
      mk_app uu____8633 uu____8636
  
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
      let uu____8685 = FStar_Syntax_Syntax.mk_Tm_uinst sq [u]  in
      let uu____8688 =
        let uu____8699 = FStar_Syntax_Syntax.as_arg p  in [uu____8699]  in
      mk_app uu____8685 uu____8688
  
let (un_squash :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
      FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____8733 = head_and_args t  in
    match uu____8733 with
    | (head1,args) ->
        let uu____8780 =
          let uu____8795 =
            let uu____8796 = un_uinst head1  in
            uu____8796.FStar_Syntax_Syntax.n  in
          (uu____8795, args)  in
        (match uu____8780 with
         | (FStar_Syntax_Syntax.Tm_fvar fv,(p,uu____8815)::[]) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid
             -> FStar_Pervasives_Native.Some p
         | (FStar_Syntax_Syntax.Tm_refine (b,p),[]) ->
             (match (b.FStar_Syntax_Syntax.sort).FStar_Syntax_Syntax.n with
              | FStar_Syntax_Syntax.Tm_fvar fv when
                  FStar_Syntax_Syntax.fv_eq_lid fv
                    FStar_Parser_Const.unit_lid
                  ->
                  let uu____8881 =
                    let uu____8886 =
                      let uu____8887 = FStar_Syntax_Syntax.mk_binder b  in
                      [uu____8887]  in
                    FStar_Syntax_Subst.open_term uu____8886 p  in
                  (match uu____8881 with
                   | (bs,p1) ->
                       let b1 =
                         match bs with
                         | b1::[] -> b1
                         | uu____8944 -> failwith "impossible"  in
                       let uu____8951 =
                         let uu____8952 = FStar_Syntax_Free.names p1  in
                         FStar_Util.set_mem (FStar_Pervasives_Native.fst b1)
                           uu____8952
                          in
                       if uu____8951
                       then FStar_Pervasives_Native.None
                       else FStar_Pervasives_Native.Some p1)
              | uu____8966 -> FStar_Pervasives_Native.None)
         | uu____8969 -> FStar_Pervasives_Native.None)
  
let (is_squash :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.universe,FStar_Syntax_Syntax.term'
                                    FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____8999 = head_and_args t  in
    match uu____8999 with
    | (head1,args) ->
        let uu____9050 =
          let uu____9065 =
            let uu____9066 = FStar_Syntax_Subst.compress head1  in
            uu____9066.FStar_Syntax_Syntax.n  in
          (uu____9065, args)  in
        (match uu____9050 with
         | (FStar_Syntax_Syntax.Tm_uinst
            ({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar fv;
               FStar_Syntax_Syntax.pos = uu____9088;
               FStar_Syntax_Syntax.vars = uu____9089;_},u::[]),(t1,uu____9092)::[])
             when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid
             -> FStar_Pervasives_Native.Some (u, t1)
         | uu____9139 -> FStar_Pervasives_Native.None)
  
let (is_auto_squash :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.universe,FStar_Syntax_Syntax.term'
                                    FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____9173 = head_and_args t  in
    match uu____9173 with
    | (head1,args) ->
        let uu____9224 =
          let uu____9239 =
            let uu____9240 = FStar_Syntax_Subst.compress head1  in
            uu____9240.FStar_Syntax_Syntax.n  in
          (uu____9239, args)  in
        (match uu____9224 with
         | (FStar_Syntax_Syntax.Tm_uinst
            ({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar fv;
               FStar_Syntax_Syntax.pos = uu____9262;
               FStar_Syntax_Syntax.vars = uu____9263;_},u::[]),(t1,uu____9266)::[])
             when
             FStar_Syntax_Syntax.fv_eq_lid fv
               FStar_Parser_Const.auto_squash_lid
             -> FStar_Pervasives_Native.Some (u, t1)
         | uu____9313 -> FStar_Pervasives_Native.None)
  
let (is_sub_singleton : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____9339 = let uu____9356 = unmeta t  in head_and_args uu____9356
       in
    match uu____9339 with
    | (head1,uu____9358) ->
        let uu____9383 =
          let uu____9384 = un_uinst head1  in
          uu____9384.FStar_Syntax_Syntax.n  in
        (match uu____9383 with
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
         | uu____9388 -> false)
  
let (arrow_one :
  FStar_Syntax_Syntax.typ ->
    (FStar_Syntax_Syntax.binder,FStar_Syntax_Syntax.comp)
      FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____9406 =
      let uu____9419 =
        let uu____9420 = FStar_Syntax_Subst.compress t  in
        uu____9420.FStar_Syntax_Syntax.n  in
      match uu____9419 with
      | FStar_Syntax_Syntax.Tm_arrow ([],c) ->
          failwith "fatal: empty binders on arrow?"
      | FStar_Syntax_Syntax.Tm_arrow (b::[],c) ->
          FStar_Pervasives_Native.Some (b, c)
      | FStar_Syntax_Syntax.Tm_arrow (b::bs,c) ->
          let uu____9549 =
            let uu____9560 =
              let uu____9561 = arrow bs c  in
              FStar_Syntax_Syntax.mk_Total uu____9561  in
            (b, uu____9560)  in
          FStar_Pervasives_Native.Some uu____9549
      | uu____9578 -> FStar_Pervasives_Native.None  in
    FStar_Util.bind_opt uu____9406
      (fun uu____9616  ->
         match uu____9616 with
         | (b,c) ->
             let uu____9653 = FStar_Syntax_Subst.open_comp [b] c  in
             (match uu____9653 with
              | (bs,c1) ->
                  let b1 =
                    match bs with
                    | b1::[] -> b1
                    | uu____9716 ->
                        failwith
                          "impossible: open_comp returned different amount of binders"
                     in
                  FStar_Pervasives_Native.Some (b1, c1)))
  
let (is_free_in :
  FStar_Syntax_Syntax.bv -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun bv  ->
    fun t  ->
      let uu____9749 = FStar_Syntax_Free.names t  in
      FStar_Util.set_mem bv uu____9749
  
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
    match projectee with | QAll _0 -> true | uu____9797 -> false
  
let (__proj__QAll__item___0 :
  connective ->
    (FStar_Syntax_Syntax.binders,qpats,FStar_Syntax_Syntax.typ)
      FStar_Pervasives_Native.tuple3)
  = fun projectee  -> match projectee with | QAll _0 -> _0 
let (uu___is_QEx : connective -> Prims.bool) =
  fun projectee  ->
    match projectee with | QEx _0 -> true | uu____9835 -> false
  
let (__proj__QEx__item___0 :
  connective ->
    (FStar_Syntax_Syntax.binders,qpats,FStar_Syntax_Syntax.typ)
      FStar_Pervasives_Native.tuple3)
  = fun projectee  -> match projectee with | QEx _0 -> _0 
let (uu___is_BaseConn : connective -> Prims.bool) =
  fun projectee  ->
    match projectee with | BaseConn _0 -> true | uu____9871 -> false
  
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
          (t,FStar_Syntax_Syntax.Meta_monadic uu____9908) -> unmeta_monadic t
      | FStar_Syntax_Syntax.Tm_meta
          (t,FStar_Syntax_Syntax.Meta_monadic_lift uu____9920) ->
          unmeta_monadic t
      | uu____9933 -> f2  in
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
      let aux f2 uu____10017 =
        match uu____10017 with
        | (lid,arity) ->
            let uu____10026 =
              let uu____10043 = unmeta_monadic f2  in
              head_and_args uu____10043  in
            (match uu____10026 with
             | (t,args) ->
                 let t1 = un_uinst t  in
                 let uu____10073 =
                   (is_constructor t1 lid) &&
                     ((FStar_List.length args) = arity)
                    in
                 if uu____10073
                 then FStar_Pervasives_Native.Some (BaseConn (lid, args))
                 else FStar_Pervasives_Native.None)
         in
      FStar_Util.find_map connectives (aux f1)  in
    let patterns t =
      let t1 = FStar_Syntax_Subst.compress t  in
      match t1.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_meta
          (t2,FStar_Syntax_Syntax.Meta_pattern pats) ->
          let uu____10150 = FStar_Syntax_Subst.compress t2  in
          (pats, uu____10150)
      | uu____10163 -> ([], t1)  in
    let destruct_q_conn t =
      let is_q fa fv =
        if fa
        then is_forall (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
        else is_exists (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
         in
      let flat t1 =
        let uu____10224 = head_and_args t1  in
        match uu____10224 with
        | (t2,args) ->
            let uu____10279 = un_uinst t2  in
            let uu____10280 =
              FStar_All.pipe_right args
                (FStar_List.map
                   (fun uu____10321  ->
                      match uu____10321 with
                      | (t3,imp) ->
                          let uu____10340 = unascribe t3  in
                          (uu____10340, imp)))
               in
            (uu____10279, uu____10280)
         in
      let rec aux qopt out t1 =
        let uu____10389 = let uu____10412 = flat t1  in (qopt, uu____10412)
           in
        match uu____10389 with
        | (FStar_Pervasives_Native.Some
           fa,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
                 FStar_Syntax_Syntax.pos = uu____10451;
                 FStar_Syntax_Syntax.vars = uu____10452;_},({
                                                              FStar_Syntax_Syntax.n
                                                                =
                                                                FStar_Syntax_Syntax.Tm_abs
                                                                (b::[],t2,uu____10455);
                                                              FStar_Syntax_Syntax.pos
                                                                = uu____10456;
                                                              FStar_Syntax_Syntax.vars
                                                                = uu____10457;_},uu____10458)::[]))
            when is_q fa tc -> aux qopt (b :: out) t2
        | (FStar_Pervasives_Native.Some
           fa,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
                 FStar_Syntax_Syntax.pos = uu____10557;
                 FStar_Syntax_Syntax.vars = uu____10558;_},uu____10559::
               ({
                  FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_abs
                    (b::[],t2,uu____10562);
                  FStar_Syntax_Syntax.pos = uu____10563;
                  FStar_Syntax_Syntax.vars = uu____10564;_},uu____10565)::[]))
            when is_q fa tc -> aux qopt (b :: out) t2
        | (FStar_Pervasives_Native.None
           ,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
               FStar_Syntax_Syntax.pos = uu____10679;
               FStar_Syntax_Syntax.vars = uu____10680;_},({
                                                            FStar_Syntax_Syntax.n
                                                              =
                                                              FStar_Syntax_Syntax.Tm_abs
                                                              (b::[],t2,uu____10683);
                                                            FStar_Syntax_Syntax.pos
                                                              = uu____10684;
                                                            FStar_Syntax_Syntax.vars
                                                              = uu____10685;_},uu____10686)::[]))
            when
            is_qlid (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v ->
            let uu____10777 =
              let uu____10780 =
                is_forall
                  (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                 in
              FStar_Pervasives_Native.Some uu____10780  in
            aux uu____10777 (b :: out) t2
        | (FStar_Pervasives_Native.None
           ,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
               FStar_Syntax_Syntax.pos = uu____10788;
               FStar_Syntax_Syntax.vars = uu____10789;_},uu____10790::
             ({
                FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_abs
                  (b::[],t2,uu____10793);
                FStar_Syntax_Syntax.pos = uu____10794;
                FStar_Syntax_Syntax.vars = uu____10795;_},uu____10796)::[]))
            when
            is_qlid (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v ->
            let uu____10903 =
              let uu____10906 =
                is_forall
                  (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                 in
              FStar_Pervasives_Native.Some uu____10906  in
            aux uu____10903 (b :: out) t2
        | (FStar_Pervasives_Native.Some b,uu____10914) ->
            let bs = FStar_List.rev out  in
            let uu____10964 = FStar_Syntax_Subst.open_term bs t1  in
            (match uu____10964 with
             | (bs1,t2) ->
                 let uu____10973 = patterns t2  in
                 (match uu____10973 with
                  | (pats,body) ->
                      if b
                      then
                        FStar_Pervasives_Native.Some (QAll (bs1, pats, body))
                      else
                        FStar_Pervasives_Native.Some (QEx (bs1, pats, body))))
        | uu____11021 -> FStar_Pervasives_Native.None  in
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
      let uu____11097 = un_squash t  in
      FStar_Util.bind_opt uu____11097
        (fun t1  ->
           let uu____11113 = head_and_args' t1  in
           match uu____11113 with
           | (hd1,args) ->
               let uu____11152 =
                 let uu____11157 =
                   let uu____11158 = un_uinst hd1  in
                   uu____11158.FStar_Syntax_Syntax.n  in
                 (uu____11157, (FStar_List.length args))  in
               (match uu____11152 with
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
                | uu____11179 -> FStar_Pervasives_Native.None))
       in
    let rec destruct_sq_forall t =
      let uu____11208 = un_squash t  in
      FStar_Util.bind_opt uu____11208
        (fun t1  ->
           let uu____11223 = arrow_one t1  in
           match uu____11223 with
           | FStar_Pervasives_Native.Some (b,c) ->
               let uu____11238 =
                 let uu____11239 = is_tot_or_gtot_comp c  in
                 Prims.op_Negation uu____11239  in
               if uu____11238
               then FStar_Pervasives_Native.None
               else
                 (let q =
                    let uu____11246 = comp_to_comp_typ_nouniv c  in
                    uu____11246.FStar_Syntax_Syntax.result_typ  in
                  let uu____11247 =
                    is_free_in (FStar_Pervasives_Native.fst b) q  in
                  if uu____11247
                  then
                    let uu____11252 = patterns q  in
                    match uu____11252 with
                    | (pats,q1) ->
                        FStar_All.pipe_left maybe_collect
                          (FStar_Pervasives_Native.Some
                             (QAll ([b], pats, q1)))
                  else
                    (let uu____11314 =
                       let uu____11315 =
                         let uu____11320 =
                           let uu____11321 =
                             FStar_Syntax_Syntax.as_arg
                               (FStar_Pervasives_Native.fst b).FStar_Syntax_Syntax.sort
                              in
                           let uu____11332 =
                             let uu____11343 = FStar_Syntax_Syntax.as_arg q
                                in
                             [uu____11343]  in
                           uu____11321 :: uu____11332  in
                         (FStar_Parser_Const.imp_lid, uu____11320)  in
                       BaseConn uu____11315  in
                     FStar_Pervasives_Native.Some uu____11314))
           | uu____11376 -> FStar_Pervasives_Native.None)
    
    and destruct_sq_exists t =
      let uu____11384 = un_squash t  in
      FStar_Util.bind_opt uu____11384
        (fun t1  ->
           let uu____11415 = head_and_args' t1  in
           match uu____11415 with
           | (hd1,args) ->
               let uu____11454 =
                 let uu____11469 =
                   let uu____11470 = un_uinst hd1  in
                   uu____11470.FStar_Syntax_Syntax.n  in
                 (uu____11469, args)  in
               (match uu____11454 with
                | (FStar_Syntax_Syntax.Tm_fvar
                   fv,(a1,uu____11487)::(a2,uu____11489)::[]) when
                    FStar_Syntax_Syntax.fv_eq_lid fv
                      FStar_Parser_Const.dtuple2_lid
                    ->
                    let uu____11540 =
                      let uu____11541 = FStar_Syntax_Subst.compress a2  in
                      uu____11541.FStar_Syntax_Syntax.n  in
                    (match uu____11540 with
                     | FStar_Syntax_Syntax.Tm_abs (b::[],q,uu____11548) ->
                         let uu____11583 = FStar_Syntax_Subst.open_term [b] q
                            in
                         (match uu____11583 with
                          | (bs,q1) ->
                              let b1 =
                                match bs with
                                | b1::[] -> b1
                                | uu____11636 -> failwith "impossible"  in
                              let uu____11643 = patterns q1  in
                              (match uu____11643 with
                               | (pats,q2) ->
                                   FStar_All.pipe_left maybe_collect
                                     (FStar_Pervasives_Native.Some
                                        (QEx ([b1], pats, q2)))))
                     | uu____11704 -> FStar_Pervasives_Native.None)
                | uu____11705 -> FStar_Pervasives_Native.None))
    
    and maybe_collect f1 =
      match f1 with
      | FStar_Pervasives_Native.Some (QAll (bs,pats,phi)) ->
          let uu____11728 = destruct_sq_forall phi  in
          (match uu____11728 with
           | FStar_Pervasives_Native.Some (QAll (bs',pats',psi)) ->
               FStar_All.pipe_left
                 (fun _0_14  -> FStar_Pervasives_Native.Some _0_14)
                 (QAll
                    ((FStar_List.append bs bs'),
                      (FStar_List.append pats pats'), psi))
           | uu____11744 -> f1)
      | FStar_Pervasives_Native.Some (QEx (bs,pats,phi)) ->
          let uu____11750 = destruct_sq_exists phi  in
          (match uu____11750 with
           | FStar_Pervasives_Native.Some (QEx (bs',pats',psi)) ->
               FStar_All.pipe_left
                 (fun _0_15  -> FStar_Pervasives_Native.Some _0_15)
                 (QEx
                    ((FStar_List.append bs bs'),
                      (FStar_List.append pats pats'), psi))
           | uu____11766 -> f1)
      | uu____11769 -> f1
     in
    let phi = unmeta_monadic f  in
    let uu____11773 = destruct_base_conn phi  in
    FStar_Util.catch_opt uu____11773
      (fun uu____11778  ->
         let uu____11779 = destruct_q_conn phi  in
         FStar_Util.catch_opt uu____11779
           (fun uu____11784  ->
              let uu____11785 = destruct_sq_base_conn phi  in
              FStar_Util.catch_opt uu____11785
                (fun uu____11790  ->
                   let uu____11791 = destruct_sq_forall phi  in
                   FStar_Util.catch_opt uu____11791
                     (fun uu____11796  ->
                        let uu____11797 = destruct_sq_exists phi  in
                        FStar_Util.catch_opt uu____11797
                          (fun uu____11801  -> FStar_Pervasives_Native.None)))))
  
let (unthunk_lemma_post :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    let uu____11813 =
      let uu____11814 = FStar_Syntax_Subst.compress t  in
      uu____11814.FStar_Syntax_Syntax.n  in
    match uu____11813 with
    | FStar_Syntax_Syntax.Tm_abs (b::[],e,uu____11821) ->
        let uu____11856 = FStar_Syntax_Subst.open_term [b] e  in
        (match uu____11856 with
         | (bs,e1) ->
             let b1 = FStar_List.hd bs  in
             let uu____11890 = is_free_in (FStar_Pervasives_Native.fst b1) e1
                in
             if uu____11890
             then
               let uu____11895 =
                 let uu____11906 = FStar_Syntax_Syntax.as_arg exp_unit  in
                 [uu____11906]  in
               mk_app t uu____11895
             else e1)
    | uu____11932 ->
        let uu____11933 =
          let uu____11944 = FStar_Syntax_Syntax.as_arg exp_unit  in
          [uu____11944]  in
        mk_app t uu____11933
  
let (action_as_lb :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.action ->
      FStar_Range.range -> FStar_Syntax_Syntax.sigelt)
  =
  fun eff_lid  ->
    fun a  ->
      fun pos  ->
        let lb =
          let uu____11985 =
            let uu____11990 =
              FStar_Syntax_Syntax.lid_as_fv a.FStar_Syntax_Syntax.action_name
                FStar_Syntax_Syntax.delta_equational
                FStar_Pervasives_Native.None
               in
            FStar_Util.Inr uu____11990  in
          let uu____11991 =
            let uu____11992 =
              FStar_Syntax_Syntax.mk_Total a.FStar_Syntax_Syntax.action_typ
               in
            arrow a.FStar_Syntax_Syntax.action_params uu____11992  in
          let uu____11995 =
            abs a.FStar_Syntax_Syntax.action_params
              a.FStar_Syntax_Syntax.action_defn FStar_Pervasives_Native.None
             in
          close_univs_and_mk_letbinding FStar_Pervasives_Native.None
            uu____11985 a.FStar_Syntax_Syntax.action_univs uu____11991
            FStar_Parser_Const.effect_Tot_lid uu____11995 [] pos
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
    let uu____12018 =
      let uu____12025 =
        let uu____12026 =
          let uu____12043 =
            let uu____12054 = FStar_Syntax_Syntax.as_arg t  in [uu____12054]
             in
          (reify_, uu____12043)  in
        FStar_Syntax_Syntax.Tm_app uu____12026  in
      FStar_Syntax_Syntax.mk uu____12025  in
    uu____12018 FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
  
let rec (delta_qualifier :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.delta_depth) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____12100 -> failwith "Impossible"
    | FStar_Syntax_Syntax.Tm_lazy i ->
        let uu____12124 = unfold_lazy i  in delta_qualifier uu____12124
    | FStar_Syntax_Syntax.Tm_fvar fv -> fv.FStar_Syntax_Syntax.fv_delta
    | FStar_Syntax_Syntax.Tm_bvar uu____12126 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_name uu____12127 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_match uu____12128 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_uvar uu____12151 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_unknown  -> FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_type uu____12164 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_quoted uu____12165 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_constant uu____12172 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_arrow uu____12173 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_uinst (t2,uu____12189) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_refine
        ({ FStar_Syntax_Syntax.ppname = uu____12194;
           FStar_Syntax_Syntax.index = uu____12195;
           FStar_Syntax_Syntax.sort = t2;_},uu____12197)
        -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_meta (t2,uu____12205) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____12211,uu____12212) ->
        delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_app (t2,uu____12254) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_abs (uu____12279,t2,uu____12281) ->
        delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_let (uu____12306,t2) -> delta_qualifier t2
  
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
    let uu____12337 = delta_qualifier t  in incr_delta_depth uu____12337
  
let (is_unknown : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____12343 =
      let uu____12344 = FStar_Syntax_Subst.compress t  in
      uu____12344.FStar_Syntax_Syntax.n  in
    match uu____12343 with
    | FStar_Syntax_Syntax.Tm_unknown  -> true
    | uu____12347 -> false
  
let rec (list_elements :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term Prims.list FStar_Pervasives_Native.option)
  =
  fun e  ->
    let uu____12361 =
      let uu____12378 = unmeta e  in head_and_args uu____12378  in
    match uu____12361 with
    | (head1,args) ->
        let uu____12409 =
          let uu____12424 =
            let uu____12425 = un_uinst head1  in
            uu____12425.FStar_Syntax_Syntax.n  in
          (uu____12424, args)  in
        (match uu____12409 with
         | (FStar_Syntax_Syntax.Tm_fvar fv,uu____12443) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.nil_lid ->
             FStar_Pervasives_Native.Some []
         | (FStar_Syntax_Syntax.Tm_fvar
            fv,uu____12467::(hd1,uu____12469)::(tl1,uu____12471)::[]) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.cons_lid ->
             let uu____12538 =
               let uu____12541 =
                 let uu____12544 = list_elements tl1  in
                 FStar_Util.must uu____12544  in
               hd1 :: uu____12541  in
             FStar_Pervasives_Native.Some uu____12538
         | uu____12553 -> FStar_Pervasives_Native.None)
  
let rec apply_last :
  'Auu____12576 .
    ('Auu____12576 -> 'Auu____12576) ->
      'Auu____12576 Prims.list -> 'Auu____12576 Prims.list
  =
  fun f  ->
    fun l  ->
      match l with
      | [] -> failwith "apply_last: got empty list"
      | a::[] -> let uu____12601 = f a  in [uu____12601]
      | x::xs -> let uu____12606 = apply_last f xs  in x :: uu____12606
  
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
          let uu____12652 =
            let uu____12659 =
              let uu____12660 =
                FStar_Syntax_Syntax.lid_as_fv l1
                  FStar_Syntax_Syntax.delta_constant
                  (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
                 in
              FStar_Syntax_Syntax.Tm_fvar uu____12660  in
            FStar_Syntax_Syntax.mk uu____12659  in
          uu____12652 FStar_Pervasives_Native.None rng  in
        let cons1 args pos =
          let uu____12677 =
            let uu____12682 =
              let uu____12683 = ctor FStar_Parser_Const.cons_lid  in
              FStar_Syntax_Syntax.mk_Tm_uinst uu____12683
                [FStar_Syntax_Syntax.U_zero]
               in
            FStar_Syntax_Syntax.mk_Tm_app uu____12682 args  in
          uu____12677 FStar_Pervasives_Native.None pos  in
        let nil args pos =
          let uu____12699 =
            let uu____12704 =
              let uu____12705 = ctor FStar_Parser_Const.nil_lid  in
              FStar_Syntax_Syntax.mk_Tm_uinst uu____12705
                [FStar_Syntax_Syntax.U_zero]
               in
            FStar_Syntax_Syntax.mk_Tm_app uu____12704 args  in
          uu____12699 FStar_Pervasives_Native.None pos  in
        let uu____12708 =
          let uu____12709 =
            let uu____12710 = FStar_Syntax_Syntax.iarg typ  in [uu____12710]
             in
          nil uu____12709 rng  in
        FStar_List.fold_right
          (fun t  ->
             fun a  ->
               let uu____12744 =
                 let uu____12745 = FStar_Syntax_Syntax.iarg typ  in
                 let uu____12754 =
                   let uu____12765 = FStar_Syntax_Syntax.as_arg t  in
                   let uu____12774 =
                     let uu____12785 = FStar_Syntax_Syntax.as_arg a  in
                     [uu____12785]  in
                   uu____12765 :: uu____12774  in
                 uu____12745 :: uu____12754  in
               cons1 uu____12744 t.FStar_Syntax_Syntax.pos) l uu____12708
  
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
        | uu____12889 -> false
  
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
          | uu____12996 -> false
  
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
        | uu____13151 -> false
  
let (debug_term_eq : Prims.bool FStar_ST.ref) = FStar_Util.mk_ref false 
let (check : Prims.string -> Prims.bool -> Prims.bool) =
  fun msg  ->
    fun cond  ->
      if cond
      then true
      else
        ((let uu____13185 = FStar_ST.op_Bang debug_term_eq  in
          if uu____13185
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
        let t11 = let uu____13381 = unmeta_safe t1  in canon_app uu____13381
           in
        let t21 = let uu____13387 = unmeta_safe t2  in canon_app uu____13387
           in
        let uu____13390 =
          let uu____13395 =
            let uu____13396 =
              let uu____13399 = un_uinst t11  in
              FStar_Syntax_Subst.compress uu____13399  in
            uu____13396.FStar_Syntax_Syntax.n  in
          let uu____13400 =
            let uu____13401 =
              let uu____13404 = un_uinst t21  in
              FStar_Syntax_Subst.compress uu____13404  in
            uu____13401.FStar_Syntax_Syntax.n  in
          (uu____13395, uu____13400)  in
        match uu____13390 with
        | (FStar_Syntax_Syntax.Tm_uinst uu____13405,uu____13406) ->
            failwith "term_eq: impossible, should have been removed"
        | (uu____13413,FStar_Syntax_Syntax.Tm_uinst uu____13414) ->
            failwith "term_eq: impossible, should have been removed"
        | (FStar_Syntax_Syntax.Tm_delayed uu____13421,uu____13422) ->
            failwith "term_eq: impossible, should have been removed"
        | (uu____13445,FStar_Syntax_Syntax.Tm_delayed uu____13446) ->
            failwith "term_eq: impossible, should have been removed"
        | (FStar_Syntax_Syntax.Tm_ascribed uu____13469,uu____13470) ->
            failwith "term_eq: impossible, should have been removed"
        | (uu____13497,FStar_Syntax_Syntax.Tm_ascribed uu____13498) ->
            failwith "term_eq: impossible, should have been removed"
        | (FStar_Syntax_Syntax.Tm_bvar x,FStar_Syntax_Syntax.Tm_bvar y) ->
            check "bvar"
              (x.FStar_Syntax_Syntax.index = y.FStar_Syntax_Syntax.index)
        | (FStar_Syntax_Syntax.Tm_name x,FStar_Syntax_Syntax.Tm_name y) ->
            check "name"
              (x.FStar_Syntax_Syntax.index = y.FStar_Syntax_Syntax.index)
        | (FStar_Syntax_Syntax.Tm_fvar x,FStar_Syntax_Syntax.Tm_fvar y) ->
            let uu____13531 = FStar_Syntax_Syntax.fv_eq x y  in
            check "fvar" uu____13531
        | (FStar_Syntax_Syntax.Tm_constant c1,FStar_Syntax_Syntax.Tm_constant
           c2) ->
            let uu____13534 = FStar_Const.eq_const c1 c2  in
            check "const" uu____13534
        | (FStar_Syntax_Syntax.Tm_type
           uu____13535,FStar_Syntax_Syntax.Tm_type uu____13536) -> true
        | (FStar_Syntax_Syntax.Tm_abs (b1,t12,k1),FStar_Syntax_Syntax.Tm_abs
           (b2,t22,k2)) ->
            (let uu____13593 = eqlist (binder_eq_dbg dbg) b1 b2  in
             check "abs binders" uu____13593) &&
              (let uu____13601 = term_eq_dbg dbg t12 t22  in
               check "abs bodies" uu____13601)
        | (FStar_Syntax_Syntax.Tm_arrow (b1,c1),FStar_Syntax_Syntax.Tm_arrow
           (b2,c2)) ->
            (let uu____13648 = eqlist (binder_eq_dbg dbg) b1 b2  in
             check "arrow binders" uu____13648) &&
              (let uu____13656 = comp_eq_dbg dbg c1 c2  in
               check "arrow comp" uu____13656)
        | (FStar_Syntax_Syntax.Tm_refine
           (b1,t12),FStar_Syntax_Syntax.Tm_refine (b2,t22)) ->
            (check "refine bv"
               (b1.FStar_Syntax_Syntax.index = b2.FStar_Syntax_Syntax.index))
              &&
              (let uu____13670 = term_eq_dbg dbg t12 t22  in
               check "refine formula" uu____13670)
        | (FStar_Syntax_Syntax.Tm_app (f1,a1),FStar_Syntax_Syntax.Tm_app
           (f2,a2)) ->
            (let uu____13725 = term_eq_dbg dbg f1 f2  in
             check "app head" uu____13725) &&
              (let uu____13727 = eqlist (arg_eq_dbg dbg) a1 a2  in
               check "app args" uu____13727)
        | (FStar_Syntax_Syntax.Tm_match
           (t12,bs1),FStar_Syntax_Syntax.Tm_match (t22,bs2)) ->
            (let uu____13814 = term_eq_dbg dbg t12 t22  in
             check "match head" uu____13814) &&
              (let uu____13816 = eqlist (branch_eq_dbg dbg) bs1 bs2  in
               check "match branches" uu____13816)
        | (FStar_Syntax_Syntax.Tm_lazy uu____13831,uu____13832) ->
            let uu____13833 =
              let uu____13834 = unlazy t11  in
              term_eq_dbg dbg uu____13834 t21  in
            check "lazy_l" uu____13833
        | (uu____13835,FStar_Syntax_Syntax.Tm_lazy uu____13836) ->
            let uu____13837 =
              let uu____13838 = unlazy t21  in
              term_eq_dbg dbg t11 uu____13838  in
            check "lazy_r" uu____13837
        | (FStar_Syntax_Syntax.Tm_let
           ((b1,lbs1),t12),FStar_Syntax_Syntax.Tm_let ((b2,lbs2),t22)) ->
            ((check "let flag" (b1 = b2)) &&
               (let uu____13874 = eqlist (letbinding_eq_dbg dbg) lbs1 lbs2
                   in
                check "let lbs" uu____13874))
              &&
              (let uu____13876 = term_eq_dbg dbg t12 t22  in
               check "let body" uu____13876)
        | (FStar_Syntax_Syntax.Tm_uvar
           (u1,uu____13878),FStar_Syntax_Syntax.Tm_uvar (u2,uu____13880)) ->
            check "uvar"
              (u1.FStar_Syntax_Syntax.ctx_uvar_head =
                 u2.FStar_Syntax_Syntax.ctx_uvar_head)
        | (FStar_Syntax_Syntax.Tm_quoted
           (qt1,qi1),FStar_Syntax_Syntax.Tm_quoted (qt2,qi2)) ->
            (check "tm_quoted qi" (qi1 = qi2)) &&
              (let uu____13936 = term_eq_dbg dbg qt1 qt2  in
               check "tm_quoted payload" uu____13936)
        | (FStar_Syntax_Syntax.Tm_meta (t12,m1),FStar_Syntax_Syntax.Tm_meta
           (t22,m2)) ->
            (match (m1, m2) with
             | (FStar_Syntax_Syntax.Meta_monadic
                (n1,ty1),FStar_Syntax_Syntax.Meta_monadic (n2,ty2)) ->
                 (let uu____13963 = FStar_Ident.lid_equals n1 n2  in
                  check "meta_monadic lid" uu____13963) &&
                   (let uu____13965 = term_eq_dbg dbg ty1 ty2  in
                    check "meta_monadic type" uu____13965)
             | (FStar_Syntax_Syntax.Meta_monadic_lift
                (s1,t13,ty1),FStar_Syntax_Syntax.Meta_monadic_lift
                (s2,t23,ty2)) ->
                 ((let uu____13982 = FStar_Ident.lid_equals s1 s2  in
                   check "meta_monadic_lift src" uu____13982) &&
                    (let uu____13984 = FStar_Ident.lid_equals t13 t23  in
                     check "meta_monadic_lift tgt" uu____13984))
                   &&
                   (let uu____13986 = term_eq_dbg dbg ty1 ty2  in
                    check "meta_monadic_lift type" uu____13986)
             | uu____13987 -> fail "metas")
        | (FStar_Syntax_Syntax.Tm_unknown ,uu____13992) -> fail "unk"
        | (uu____13993,FStar_Syntax_Syntax.Tm_unknown ) -> fail "unk"
        | (FStar_Syntax_Syntax.Tm_bvar uu____13994,uu____13995) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_name uu____13996,uu____13997) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_fvar uu____13998,uu____13999) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_constant uu____14000,uu____14001) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_type uu____14002,uu____14003) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_abs uu____14004,uu____14005) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_arrow uu____14024,uu____14025) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_refine uu____14040,uu____14041) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_app uu____14048,uu____14049) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_match uu____14066,uu____14067) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_let uu____14090,uu____14091) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_uvar uu____14104,uu____14105) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_meta uu____14118,uu____14119) ->
            fail "bottom"
        | (uu____14126,FStar_Syntax_Syntax.Tm_bvar uu____14127) ->
            fail "bottom"
        | (uu____14128,FStar_Syntax_Syntax.Tm_name uu____14129) ->
            fail "bottom"
        | (uu____14130,FStar_Syntax_Syntax.Tm_fvar uu____14131) ->
            fail "bottom"
        | (uu____14132,FStar_Syntax_Syntax.Tm_constant uu____14133) ->
            fail "bottom"
        | (uu____14134,FStar_Syntax_Syntax.Tm_type uu____14135) ->
            fail "bottom"
        | (uu____14136,FStar_Syntax_Syntax.Tm_abs uu____14137) ->
            fail "bottom"
        | (uu____14156,FStar_Syntax_Syntax.Tm_arrow uu____14157) ->
            fail "bottom"
        | (uu____14172,FStar_Syntax_Syntax.Tm_refine uu____14173) ->
            fail "bottom"
        | (uu____14180,FStar_Syntax_Syntax.Tm_app uu____14181) ->
            fail "bottom"
        | (uu____14198,FStar_Syntax_Syntax.Tm_match uu____14199) ->
            fail "bottom"
        | (uu____14222,FStar_Syntax_Syntax.Tm_let uu____14223) ->
            fail "bottom"
        | (uu____14236,FStar_Syntax_Syntax.Tm_uvar uu____14237) ->
            fail "bottom"
        | (uu____14250,FStar_Syntax_Syntax.Tm_meta uu____14251) ->
            fail "bottom"

and (arg_eq_dbg :
  Prims.bool ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.arg_qualifier
                                                            FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple2 ->
      (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.arg_qualifier
                                                              FStar_Pervasives_Native.option)
        FStar_Pervasives_Native.tuple2 -> Prims.bool)
  =
  fun dbg  ->
    fun a1  ->
      fun a2  ->
        eqprod
          (fun t1  ->
             fun t2  ->
               let uu____14284 = term_eq_dbg dbg t1 t2  in
               check "arg tm" uu____14284)
          (fun q1  -> fun q2  -> check "arg qual" (q1 = q2)) a1 a2

and (binder_eq_dbg :
  Prims.bool ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.arg_qualifier
                              FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple2 ->
      (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.arg_qualifier
                                FStar_Pervasives_Native.option)
        FStar_Pervasives_Native.tuple2 -> Prims.bool)
  =
  fun dbg  ->
    fun b1  ->
      fun b2  ->
        eqprod
          (fun b11  ->
             fun b21  ->
               let uu____14317 =
                 term_eq_dbg dbg b11.FStar_Syntax_Syntax.sort
                   b21.FStar_Syntax_Syntax.sort
                  in
               check "binder sort" uu____14317)
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
        ((let uu____14343 =
            FStar_Ident.lid_equals c11.FStar_Syntax_Syntax.effect_name
              c21.FStar_Syntax_Syntax.effect_name
             in
          check "comp eff" uu____14343) &&
           (let uu____14345 =
              term_eq_dbg dbg c11.FStar_Syntax_Syntax.result_typ
                c21.FStar_Syntax_Syntax.result_typ
               in
            check "comp result typ" uu____14345))
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
    fun uu____14350  ->
      fun uu____14351  ->
        match (uu____14350, uu____14351) with
        | ((p1,w1,t1),(p2,w2,t2)) ->
            ((let uu____14476 = FStar_Syntax_Syntax.eq_pat p1 p2  in
              check "branch pat" uu____14476) &&
               (let uu____14478 = term_eq_dbg dbg t1 t2  in
                check "branch body" uu____14478))
              &&
              (let uu____14480 =
                 match (w1, w2) with
                 | (FStar_Pervasives_Native.Some
                    x,FStar_Pervasives_Native.Some y) -> term_eq_dbg dbg x y
                 | (FStar_Pervasives_Native.None
                    ,FStar_Pervasives_Native.None ) -> true
                 | uu____14519 -> false  in
               check "branch when" uu____14480)

and (letbinding_eq_dbg :
  Prims.bool ->
    FStar_Syntax_Syntax.letbinding ->
      FStar_Syntax_Syntax.letbinding -> Prims.bool)
  =
  fun dbg  ->
    fun lb1  ->
      fun lb2  ->
        ((let uu____14537 =
            eqsum (fun bv1  -> fun bv2  -> true) FStar_Syntax_Syntax.fv_eq
              lb1.FStar_Syntax_Syntax.lbname lb2.FStar_Syntax_Syntax.lbname
             in
          check "lb bv" uu____14537) &&
           (let uu____14543 =
              term_eq_dbg dbg lb1.FStar_Syntax_Syntax.lbtyp
                lb2.FStar_Syntax_Syntax.lbtyp
               in
            check "lb typ" uu____14543))
          &&
          (let uu____14545 =
             term_eq_dbg dbg lb1.FStar_Syntax_Syntax.lbdef
               lb2.FStar_Syntax_Syntax.lbdef
              in
           check "lb def" uu____14545)

let (term_eq :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t1  ->
    fun t2  ->
      let r =
        let uu____14557 = FStar_ST.op_Bang debug_term_eq  in
        term_eq_dbg uu____14557 t1 t2  in
      FStar_ST.op_Colon_Equals debug_term_eq false; r
  
let rec (sizeof : FStar_Syntax_Syntax.term -> Prims.int) =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____14610 ->
        let uu____14633 =
          let uu____14634 = FStar_Syntax_Subst.compress t  in
          sizeof uu____14634  in
        (Prims.parse_int "1") + uu____14633
    | FStar_Syntax_Syntax.Tm_bvar bv ->
        let uu____14636 = sizeof bv.FStar_Syntax_Syntax.sort  in
        (Prims.parse_int "1") + uu____14636
    | FStar_Syntax_Syntax.Tm_name bv ->
        let uu____14638 = sizeof bv.FStar_Syntax_Syntax.sort  in
        (Prims.parse_int "1") + uu____14638
    | FStar_Syntax_Syntax.Tm_uinst (t1,us) ->
        let uu____14645 = sizeof t1  in (FStar_List.length us) + uu____14645
    | FStar_Syntax_Syntax.Tm_abs (bs,t1,uu____14648) ->
        let uu____14673 = sizeof t1  in
        let uu____14674 =
          FStar_List.fold_left
            (fun acc  ->
               fun uu____14687  ->
                 match uu____14687 with
                 | (bv,uu____14695) ->
                     let uu____14700 = sizeof bv.FStar_Syntax_Syntax.sort  in
                     acc + uu____14700) (Prims.parse_int "0") bs
           in
        uu____14673 + uu____14674
    | FStar_Syntax_Syntax.Tm_app (hd1,args) ->
        let uu____14727 = sizeof hd1  in
        let uu____14728 =
          FStar_List.fold_left
            (fun acc  ->
               fun uu____14741  ->
                 match uu____14741 with
                 | (arg,uu____14749) ->
                     let uu____14754 = sizeof arg  in acc + uu____14754)
            (Prims.parse_int "0") args
           in
        uu____14727 + uu____14728
    | uu____14755 -> (Prims.parse_int "1")
  
let (is_fvar : FStar_Ident.lident -> FStar_Syntax_Syntax.term -> Prims.bool)
  =
  fun lid  ->
    fun t  ->
      let uu____14766 =
        let uu____14767 = un_uinst t  in uu____14767.FStar_Syntax_Syntax.n
         in
      match uu____14766 with
      | FStar_Syntax_Syntax.Tm_fvar fv ->
          FStar_Syntax_Syntax.fv_eq_lid fv lid
      | uu____14771 -> false
  
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
        let uu____14812 = FStar_Options.set_options t s  in
        match uu____14812 with
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
          ((let uu____14820 = FStar_Options.restore_cmd_line_options false
               in
            FStar_All.pipe_right uu____14820 (fun a236  -> ()));
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
    | FStar_Syntax_Syntax.Tm_delayed uu____14846 -> failwith "Impossible"
    | FStar_Syntax_Syntax.Tm_name x -> []
    | FStar_Syntax_Syntax.Tm_uvar uu____14872 -> []
    | FStar_Syntax_Syntax.Tm_type u -> []
    | FStar_Syntax_Syntax.Tm_bvar x -> [x]
    | FStar_Syntax_Syntax.Tm_fvar uu____14887 -> []
    | FStar_Syntax_Syntax.Tm_constant uu____14888 -> []
    | FStar_Syntax_Syntax.Tm_lazy uu____14889 -> []
    | FStar_Syntax_Syntax.Tm_unknown  -> []
    | FStar_Syntax_Syntax.Tm_uinst (t1,us) -> unbound_variables t1
    | FStar_Syntax_Syntax.Tm_abs (bs,t1,uu____14898) ->
        let uu____14923 = FStar_Syntax_Subst.open_term bs t1  in
        (match uu____14923 with
         | (bs1,t2) ->
             let uu____14932 =
               FStar_List.collect
                 (fun uu____14944  ->
                    match uu____14944 with
                    | (b,uu____14954) ->
                        unbound_variables b.FStar_Syntax_Syntax.sort) bs1
                in
             let uu____14959 = unbound_variables t2  in
             FStar_List.append uu____14932 uu____14959)
    | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
        let uu____14984 = FStar_Syntax_Subst.open_comp bs c  in
        (match uu____14984 with
         | (bs1,c1) ->
             let uu____14993 =
               FStar_List.collect
                 (fun uu____15005  ->
                    match uu____15005 with
                    | (b,uu____15015) ->
                        unbound_variables b.FStar_Syntax_Syntax.sort) bs1
                in
             let uu____15020 = unbound_variables_comp c1  in
             FStar_List.append uu____14993 uu____15020)
    | FStar_Syntax_Syntax.Tm_refine (b,t1) ->
        let uu____15029 =
          FStar_Syntax_Subst.open_term [(b, FStar_Pervasives_Native.None)] t1
           in
        (match uu____15029 with
         | (bs,t2) ->
             let uu____15052 =
               FStar_List.collect
                 (fun uu____15064  ->
                    match uu____15064 with
                    | (b1,uu____15074) ->
                        unbound_variables b1.FStar_Syntax_Syntax.sort) bs
                in
             let uu____15079 = unbound_variables t2  in
             FStar_List.append uu____15052 uu____15079)
    | FStar_Syntax_Syntax.Tm_app (t1,args) ->
        let uu____15108 =
          FStar_List.collect
            (fun uu____15122  ->
               match uu____15122 with
               | (x,uu____15134) -> unbound_variables x) args
           in
        let uu____15143 = unbound_variables t1  in
        FStar_List.append uu____15108 uu____15143
    | FStar_Syntax_Syntax.Tm_match (t1,pats) ->
        let uu____15184 = unbound_variables t1  in
        let uu____15187 =
          FStar_All.pipe_right pats
            (FStar_List.collect
               (fun br  ->
                  let uu____15202 = FStar_Syntax_Subst.open_branch br  in
                  match uu____15202 with
                  | (p,wopt,t2) ->
                      let uu____15224 = unbound_variables t2  in
                      let uu____15227 =
                        match wopt with
                        | FStar_Pervasives_Native.None  -> []
                        | FStar_Pervasives_Native.Some t3 ->
                            unbound_variables t3
                         in
                      FStar_List.append uu____15224 uu____15227))
           in
        FStar_List.append uu____15184 uu____15187
    | FStar_Syntax_Syntax.Tm_ascribed (t1,asc,uu____15241) ->
        let uu____15282 = unbound_variables t1  in
        let uu____15285 =
          let uu____15288 =
            match FStar_Pervasives_Native.fst asc with
            | FStar_Util.Inl t2 -> unbound_variables t2
            | FStar_Util.Inr c2 -> unbound_variables_comp c2  in
          let uu____15319 =
            match FStar_Pervasives_Native.snd asc with
            | FStar_Pervasives_Native.None  -> []
            | FStar_Pervasives_Native.Some tac -> unbound_variables tac  in
          FStar_List.append uu____15288 uu____15319  in
        FStar_List.append uu____15282 uu____15285
    | FStar_Syntax_Syntax.Tm_let ((false ,lb::[]),t1) ->
        let uu____15357 = unbound_variables lb.FStar_Syntax_Syntax.lbtyp  in
        let uu____15360 =
          let uu____15363 = unbound_variables lb.FStar_Syntax_Syntax.lbdef
             in
          let uu____15366 =
            match lb.FStar_Syntax_Syntax.lbname with
            | FStar_Util.Inr uu____15371 -> unbound_variables t1
            | FStar_Util.Inl bv ->
                let uu____15373 =
                  FStar_Syntax_Subst.open_term
                    [(bv, FStar_Pervasives_Native.None)] t1
                   in
                (match uu____15373 with
                 | (uu____15394,t2) -> unbound_variables t2)
             in
          FStar_List.append uu____15363 uu____15366  in
        FStar_List.append uu____15357 uu____15360
    | FStar_Syntax_Syntax.Tm_let ((uu____15396,lbs),t1) ->
        let uu____15413 = FStar_Syntax_Subst.open_let_rec lbs t1  in
        (match uu____15413 with
         | (lbs1,t2) ->
             let uu____15428 = unbound_variables t2  in
             let uu____15431 =
               FStar_List.collect
                 (fun lb  ->
                    let uu____15438 =
                      unbound_variables lb.FStar_Syntax_Syntax.lbtyp  in
                    let uu____15441 =
                      unbound_variables lb.FStar_Syntax_Syntax.lbdef  in
                    FStar_List.append uu____15438 uu____15441) lbs1
                in
             FStar_List.append uu____15428 uu____15431)
    | FStar_Syntax_Syntax.Tm_quoted (tm1,qi) ->
        (match qi.FStar_Syntax_Syntax.qkind with
         | FStar_Syntax_Syntax.Quote_static  -> []
         | FStar_Syntax_Syntax.Quote_dynamic  -> unbound_variables tm1)
    | FStar_Syntax_Syntax.Tm_meta (t1,m) ->
        let uu____15458 = unbound_variables t1  in
        let uu____15461 =
          match m with
          | FStar_Syntax_Syntax.Meta_pattern args ->
              FStar_List.collect
                (FStar_List.collect
                   (fun uu____15500  ->
                      match uu____15500 with
                      | (a,uu____15512) -> unbound_variables a)) args
          | FStar_Syntax_Syntax.Meta_monadic_lift
              (uu____15521,uu____15522,t') -> unbound_variables t'
          | FStar_Syntax_Syntax.Meta_monadic (uu____15528,t') ->
              unbound_variables t'
          | FStar_Syntax_Syntax.Meta_labeled uu____15534 -> []
          | FStar_Syntax_Syntax.Meta_desugared uu____15541 -> []
          | FStar_Syntax_Syntax.Meta_named uu____15542 -> []  in
        FStar_List.append uu____15458 uu____15461

and (unbound_variables_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.bv Prims.list)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.GTotal (t,uu____15549) -> unbound_variables t
    | FStar_Syntax_Syntax.Total (t,uu____15559) -> unbound_variables t
    | FStar_Syntax_Syntax.Comp ct ->
        let uu____15569 = unbound_variables ct.FStar_Syntax_Syntax.result_typ
           in
        let uu____15572 =
          FStar_List.collect
            (fun uu____15586  ->
               match uu____15586 with
               | (a,uu____15598) -> unbound_variables a)
            ct.FStar_Syntax_Syntax.effect_args
           in
        FStar_List.append uu____15569 uu____15572
