open Prims
let (codegen_fsharp : unit -> Prims.bool) =
  fun uu____5  ->
    let uu____6 = FStar_Options.codegen ()  in
    uu____6 = (FStar_Pervasives_Native.Some FStar_Options.FSharp)
  
let pruneNones :
  'a . 'a FStar_Pervasives_Native.option Prims.list -> 'a Prims.list =
  fun l  ->
    FStar_List.fold_right
      (fun x  ->
         fun ll  ->
           match x with
           | FStar_Pervasives_Native.Some xs -> xs :: ll
           | FStar_Pervasives_Native.None  -> ll) l []
  
let (mk_range_mle : FStar_Extraction_ML_Syntax.mlexpr) =
  FStar_All.pipe_left
    (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.MLTY_Top)
    (FStar_Extraction_ML_Syntax.MLE_Name (["Prims"], "mk_range"))
  
let (dummy_range_mle : FStar_Extraction_ML_Syntax.mlexpr) =
  FStar_All.pipe_left
    (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.MLTY_Top)
    (FStar_Extraction_ML_Syntax.MLE_Name (["FStar"; "Range"], "dummyRange"))
  
let (mlconst_of_const' :
  FStar_Const.sconst -> FStar_Extraction_ML_Syntax.mlconstant) =
  fun sctt  ->
    match sctt with
    | FStar_Const.Const_effect  -> failwith "Unsupported constant"
    | FStar_Const.Const_range uu____56 -> FStar_Extraction_ML_Syntax.MLC_Unit
    | FStar_Const.Const_unit  -> FStar_Extraction_ML_Syntax.MLC_Unit
    | FStar_Const.Const_char c -> FStar_Extraction_ML_Syntax.MLC_Char c
    | FStar_Const.Const_int (s,i) ->
        FStar_Extraction_ML_Syntax.MLC_Int (s, i)
    | FStar_Const.Const_bool b -> FStar_Extraction_ML_Syntax.MLC_Bool b
    | FStar_Const.Const_float d -> FStar_Extraction_ML_Syntax.MLC_Float d
    | FStar_Const.Const_bytearray (bytes,uu____82) ->
        FStar_Extraction_ML_Syntax.MLC_Bytes bytes
    | FStar_Const.Const_string (s,uu____90) ->
        FStar_Extraction_ML_Syntax.MLC_String s
    | FStar_Const.Const_range_of  ->
        failwith "Unhandled constant: range_of/set_range_of"
    | FStar_Const.Const_set_range_of  ->
        failwith "Unhandled constant: range_of/set_range_of"
    | FStar_Const.Const_reify  ->
        failwith "Unhandled constant: reify/reflect"
    | FStar_Const.Const_reflect uu____91 ->
        failwith "Unhandled constant: reify/reflect"
  
let (mlconst_of_const :
  FStar_Range.range ->
    FStar_Const.sconst -> FStar_Extraction_ML_Syntax.mlconstant)
  =
  fun p  ->
    fun c  ->
      try mlconst_of_const' c
      with
      | uu____108 ->
          let uu____109 =
            let uu____110 = FStar_Range.string_of_range p  in
            let uu____111 = FStar_Syntax_Print.const_to_string c  in
            FStar_Util.format2 "(%s) Failed to translate constant %s "
              uu____110 uu____111
             in
          failwith uu____109
  
let (mlexpr_of_range :
  FStar_Range.range -> FStar_Extraction_ML_Syntax.mlexpr') =
  fun r  ->
    let cint i =
      let uu____123 =
        let uu____124 =
          let uu____125 =
            let uu____136 = FStar_Util.string_of_int i  in
            (uu____136, FStar_Pervasives_Native.None)  in
          FStar_Extraction_ML_Syntax.MLC_Int uu____125  in
        FStar_All.pipe_right uu____124
          (fun _0_17  -> FStar_Extraction_ML_Syntax.MLE_Const _0_17)
         in
      FStar_All.pipe_right uu____123
        (FStar_Extraction_ML_Syntax.with_ty
           FStar_Extraction_ML_Syntax.ml_int_ty)
       in
    let cstr s =
      let uu____153 =
        FStar_All.pipe_right (FStar_Extraction_ML_Syntax.MLC_String s)
          (fun _0_18  -> FStar_Extraction_ML_Syntax.MLE_Const _0_18)
         in
      FStar_All.pipe_right uu____153
        (FStar_Extraction_ML_Syntax.with_ty
           FStar_Extraction_ML_Syntax.ml_string_ty)
       in
    let uu____154 =
      let uu____161 =
        let uu____164 =
          let uu____165 = FStar_Range.file_of_range r  in
          FStar_All.pipe_right uu____165 cstr  in
        let uu____166 =
          let uu____169 =
            let uu____170 =
              let uu____171 = FStar_Range.start_of_range r  in
              FStar_All.pipe_right uu____171 FStar_Range.line_of_pos  in
            FStar_All.pipe_right uu____170 cint  in
          let uu____172 =
            let uu____175 =
              let uu____176 =
                let uu____177 = FStar_Range.start_of_range r  in
                FStar_All.pipe_right uu____177 FStar_Range.col_of_pos  in
              FStar_All.pipe_right uu____176 cint  in
            let uu____178 =
              let uu____181 =
                let uu____182 =
                  let uu____183 = FStar_Range.end_of_range r  in
                  FStar_All.pipe_right uu____183 FStar_Range.line_of_pos  in
                FStar_All.pipe_right uu____182 cint  in
              let uu____184 =
                let uu____187 =
                  let uu____188 =
                    let uu____189 = FStar_Range.end_of_range r  in
                    FStar_All.pipe_right uu____189 FStar_Range.col_of_pos  in
                  FStar_All.pipe_right uu____188 cint  in
                [uu____187]  in
              uu____181 :: uu____184  in
            uu____175 :: uu____178  in
          uu____169 :: uu____172  in
        uu____164 :: uu____166  in
      (mk_range_mle, uu____161)  in
    FStar_Extraction_ML_Syntax.MLE_App uu____154
  
let (mlexpr_of_const :
  FStar_Range.range ->
    FStar_Const.sconst -> FStar_Extraction_ML_Syntax.mlexpr')
  =
  fun p  ->
    fun c  ->
      match c with
      | FStar_Const.Const_range r -> mlexpr_of_range r
      | uu____203 ->
          let uu____204 = mlconst_of_const p c  in
          FStar_Extraction_ML_Syntax.MLE_Const uu____204
  
let rec (subst_aux :
  (FStar_Extraction_ML_Syntax.mlident,FStar_Extraction_ML_Syntax.mlty)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    FStar_Extraction_ML_Syntax.mlty -> FStar_Extraction_ML_Syntax.mlty)
  =
  fun subst1  ->
    fun t  ->
      match t with
      | FStar_Extraction_ML_Syntax.MLTY_Var x ->
          let uu____228 =
            FStar_Util.find_opt
              (fun uu____242  ->
                 match uu____242 with | (y,uu____248) -> y = x) subst1
             in
          (match uu____228 with
           | FStar_Pervasives_Native.Some ts ->
               FStar_Pervasives_Native.snd ts
           | FStar_Pervasives_Native.None  -> t)
      | FStar_Extraction_ML_Syntax.MLTY_Fun (t1,f,t2) ->
          let uu____265 =
            let uu____272 = subst_aux subst1 t1  in
            let uu____273 = subst_aux subst1 t2  in (uu____272, f, uu____273)
             in
          FStar_Extraction_ML_Syntax.MLTY_Fun uu____265
      | FStar_Extraction_ML_Syntax.MLTY_Named (args,path) ->
          let uu____280 =
            let uu____287 = FStar_List.map (subst_aux subst1) args  in
            (uu____287, path)  in
          FStar_Extraction_ML_Syntax.MLTY_Named uu____280
      | FStar_Extraction_ML_Syntax.MLTY_Tuple ts ->
          let uu____295 = FStar_List.map (subst_aux subst1) ts  in
          FStar_Extraction_ML_Syntax.MLTY_Tuple uu____295
      | FStar_Extraction_ML_Syntax.MLTY_Top  -> t
      | FStar_Extraction_ML_Syntax.MLTY_Erased  -> t
  
let (try_subst :
  FStar_Extraction_ML_Syntax.mltyscheme ->
    FStar_Extraction_ML_Syntax.mlty Prims.list ->
      FStar_Extraction_ML_Syntax.mlty FStar_Pervasives_Native.option)
  =
  fun uu____310  ->
    fun args  ->
      match uu____310 with
      | (formals,t) ->
          if (FStar_List.length formals) <> (FStar_List.length args)
          then FStar_Pervasives_Native.None
          else
            (let uu____321 =
               let uu____322 = FStar_List.zip formals args  in
               subst_aux uu____322 t  in
             FStar_Pervasives_Native.Some uu____321)
  
let (subst :
  (FStar_Extraction_ML_Syntax.mlidents,FStar_Extraction_ML_Syntax.mlty)
    FStar_Pervasives_Native.tuple2 ->
    FStar_Extraction_ML_Syntax.mlty Prims.list ->
      FStar_Extraction_ML_Syntax.mlty)
  =
  fun ts  ->
    fun args  ->
      let uu____351 = try_subst ts args  in
      match uu____351 with
      | FStar_Pervasives_Native.None  ->
          failwith
            "Substitution must be fully applied (see GitHub issue #490)"
      | FStar_Pervasives_Native.Some t -> t
  
let (udelta_unfold :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Extraction_ML_Syntax.mlty ->
      FStar_Extraction_ML_Syntax.mlty FStar_Pervasives_Native.option)
  =
  fun g  ->
    fun uu___251_366  ->
      match uu___251_366 with
      | FStar_Extraction_ML_Syntax.MLTY_Named (args,n1) ->
          let uu____375 = FStar_Extraction_ML_UEnv.lookup_ty_const g n1  in
          (match uu____375 with
           | FStar_Pervasives_Native.Some ts ->
               let uu____381 = try_subst ts args  in
               (match uu____381 with
                | FStar_Pervasives_Native.None  ->
                    let uu____386 =
                      let uu____387 =
                        FStar_Extraction_ML_Syntax.string_of_mlpath n1  in
                      let uu____388 =
                        FStar_Util.string_of_int (FStar_List.length args)  in
                      let uu____389 =
                        FStar_Util.string_of_int
                          (FStar_List.length (FStar_Pervasives_Native.fst ts))
                         in
                      FStar_Util.format3
                        "Substitution must be fully applied; got an application of %s with %s args whereas %s were expected (see GitHub issue #490)"
                        uu____387 uu____388 uu____389
                       in
                    failwith uu____386
                | FStar_Pervasives_Native.Some r ->
                    FStar_Pervasives_Native.Some r)
           | uu____393 -> FStar_Pervasives_Native.None)
      | uu____396 -> FStar_Pervasives_Native.None
  
let (eff_leq :
  FStar_Extraction_ML_Syntax.e_tag ->
    FStar_Extraction_ML_Syntax.e_tag -> Prims.bool)
  =
  fun f  ->
    fun f'  ->
      match (f, f') with
      | (FStar_Extraction_ML_Syntax.E_PURE ,uu____407) -> true
      | (FStar_Extraction_ML_Syntax.E_GHOST
         ,FStar_Extraction_ML_Syntax.E_GHOST ) -> true
      | (FStar_Extraction_ML_Syntax.E_IMPURE
         ,FStar_Extraction_ML_Syntax.E_IMPURE ) -> true
      | uu____408 -> false
  
let (eff_to_string : FStar_Extraction_ML_Syntax.e_tag -> Prims.string) =
  fun uu___252_417  ->
    match uu___252_417 with
    | FStar_Extraction_ML_Syntax.E_PURE  -> "Pure"
    | FStar_Extraction_ML_Syntax.E_GHOST  -> "Ghost"
    | FStar_Extraction_ML_Syntax.E_IMPURE  -> "Impure"
  
let (join :
  FStar_Range.range ->
    FStar_Extraction_ML_Syntax.e_tag ->
      FStar_Extraction_ML_Syntax.e_tag -> FStar_Extraction_ML_Syntax.e_tag)
  =
  fun r  ->
    fun f  ->
      fun f'  ->
        match (f, f') with
        | (FStar_Extraction_ML_Syntax.E_IMPURE
           ,FStar_Extraction_ML_Syntax.E_PURE ) ->
            FStar_Extraction_ML_Syntax.E_IMPURE
        | (FStar_Extraction_ML_Syntax.E_PURE
           ,FStar_Extraction_ML_Syntax.E_IMPURE ) ->
            FStar_Extraction_ML_Syntax.E_IMPURE
        | (FStar_Extraction_ML_Syntax.E_IMPURE
           ,FStar_Extraction_ML_Syntax.E_IMPURE ) ->
            FStar_Extraction_ML_Syntax.E_IMPURE
        | (FStar_Extraction_ML_Syntax.E_GHOST
           ,FStar_Extraction_ML_Syntax.E_GHOST ) ->
            FStar_Extraction_ML_Syntax.E_GHOST
        | (FStar_Extraction_ML_Syntax.E_PURE
           ,FStar_Extraction_ML_Syntax.E_GHOST ) ->
            FStar_Extraction_ML_Syntax.E_GHOST
        | (FStar_Extraction_ML_Syntax.E_GHOST
           ,FStar_Extraction_ML_Syntax.E_PURE ) ->
            FStar_Extraction_ML_Syntax.E_GHOST
        | (FStar_Extraction_ML_Syntax.E_PURE
           ,FStar_Extraction_ML_Syntax.E_PURE ) ->
            FStar_Extraction_ML_Syntax.E_PURE
        | uu____433 ->
            let uu____438 =
              let uu____439 = FStar_Range.string_of_range r  in
              let uu____440 = eff_to_string f  in
              let uu____441 = eff_to_string f'  in
              FStar_Util.format3
                "Impossible (%s): Inconsistent effects %s and %s" uu____439
                uu____440 uu____441
               in
            failwith uu____438
  
let (join_l :
  FStar_Range.range ->
    FStar_Extraction_ML_Syntax.e_tag Prims.list ->
      FStar_Extraction_ML_Syntax.e_tag)
  =
  fun r  ->
    fun fs  ->
      FStar_List.fold_left (join r) FStar_Extraction_ML_Syntax.E_PURE fs
  
let (mk_ty_fun :
  (FStar_Extraction_ML_Syntax.mlident,FStar_Extraction_ML_Syntax.mlty)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    FStar_Extraction_ML_Syntax.mlty -> FStar_Extraction_ML_Syntax.mlty)
  =
  FStar_List.fold_right
    (fun uu____478  ->
       fun t  ->
         match uu____478 with
         | (uu____484,t0) ->
             FStar_Extraction_ML_Syntax.MLTY_Fun
               (t0, FStar_Extraction_ML_Syntax.E_PURE, t))
  
type unfold_t =
  FStar_Extraction_ML_Syntax.mlty ->
    FStar_Extraction_ML_Syntax.mlty FStar_Pervasives_Native.option
let rec (type_leq_c :
  unfold_t ->
    FStar_Extraction_ML_Syntax.mlexpr FStar_Pervasives_Native.option ->
      FStar_Extraction_ML_Syntax.mlty ->
        FStar_Extraction_ML_Syntax.mlty ->
          (Prims.bool,FStar_Extraction_ML_Syntax.mlexpr
                        FStar_Pervasives_Native.option)
            FStar_Pervasives_Native.tuple2)
  =
  fun unfold_ty  ->
    fun e  ->
      fun t  ->
        fun t'  ->
          match (t, t') with
          | (FStar_Extraction_ML_Syntax.MLTY_Var
             x,FStar_Extraction_ML_Syntax.MLTY_Var y) ->
              if x = y
              then (true, e)
              else (false, FStar_Pervasives_Native.None)
          | (FStar_Extraction_ML_Syntax.MLTY_Fun
             (t1,f,t2),FStar_Extraction_ML_Syntax.MLTY_Fun (t1',f',t2')) ->
              let mk_fun xs body =
                match xs with
                | [] -> body
                | uu____593 ->
                    let e1 =
                      match body.FStar_Extraction_ML_Syntax.expr with
                      | FStar_Extraction_ML_Syntax.MLE_Fun (ys,body1) ->
                          FStar_Extraction_ML_Syntax.MLE_Fun
                            ((FStar_List.append xs ys), body1)
                      | uu____625 ->
                          FStar_Extraction_ML_Syntax.MLE_Fun (xs, body)
                       in
                    let uu____632 =
                      mk_ty_fun xs body.FStar_Extraction_ML_Syntax.mlty  in
                    FStar_Extraction_ML_Syntax.with_ty uu____632 e1
                 in
              (match e with
               | FStar_Pervasives_Native.Some
                   {
                     FStar_Extraction_ML_Syntax.expr =
                       FStar_Extraction_ML_Syntax.MLE_Fun (x::xs,body);
                     FStar_Extraction_ML_Syntax.mlty = uu____642;
                     FStar_Extraction_ML_Syntax.loc = uu____643;_}
                   ->
                   let uu____664 =
                     (type_leq unfold_ty t1' t1) && (eff_leq f f')  in
                   if uu____664
                   then
                     (if
                        (f = FStar_Extraction_ML_Syntax.E_PURE) &&
                          (f' = FStar_Extraction_ML_Syntax.E_GHOST)
                      then
                        let uu____680 = type_leq unfold_ty t2 t2'  in
                        (if uu____680
                         then
                           let body1 =
                             let uu____691 =
                               type_leq unfold_ty t2
                                 FStar_Extraction_ML_Syntax.ml_unit_ty
                                in
                             if uu____691
                             then FStar_Extraction_ML_Syntax.ml_unit
                             else
                               FStar_All.pipe_left
                                 (FStar_Extraction_ML_Syntax.with_ty t2')
                                 (FStar_Extraction_ML_Syntax.MLE_Coerce
                                    (FStar_Extraction_ML_Syntax.ml_unit,
                                      FStar_Extraction_ML_Syntax.ml_unit_ty,
                                      t2'))
                              in
                           let uu____696 =
                             let uu____699 =
                               let uu____700 =
                                 let uu____705 =
                                   mk_ty_fun [x]
                                     body1.FStar_Extraction_ML_Syntax.mlty
                                    in
                                 FStar_Extraction_ML_Syntax.with_ty uu____705
                                  in
                               FStar_All.pipe_left uu____700
                                 (FStar_Extraction_ML_Syntax.MLE_Fun
                                    ([x], body1))
                                in
                             FStar_Pervasives_Native.Some uu____699  in
                           (true, uu____696)
                         else (false, FStar_Pervasives_Native.None))
                      else
                        (let uu____734 =
                           let uu____741 =
                             let uu____744 = mk_fun xs body  in
                             FStar_All.pipe_left
                               (fun _0_19  ->
                                  FStar_Pervasives_Native.Some _0_19)
                               uu____744
                              in
                           type_leq_c unfold_ty uu____741 t2 t2'  in
                         match uu____734 with
                         | (ok,body1) ->
                             let res =
                               match body1 with
                               | FStar_Pervasives_Native.Some body2 ->
                                   let uu____768 = mk_fun [x] body2  in
                                   FStar_Pervasives_Native.Some uu____768
                               | uu____777 -> FStar_Pervasives_Native.None
                                in
                             (ok, res)))
                   else (false, FStar_Pervasives_Native.None)
               | uu____785 ->
                   let uu____788 =
                     ((type_leq unfold_ty t1' t1) && (eff_leq f f')) &&
                       (type_leq unfold_ty t2 t2')
                      in
                   if uu____788
                   then (true, e)
                   else (false, FStar_Pervasives_Native.None))
          | (FStar_Extraction_ML_Syntax.MLTY_Named
             (args,path),FStar_Extraction_ML_Syntax.MLTY_Named (args',path'))
              ->
              if path = path'
              then
                let uu____824 =
                  FStar_List.forall2 (type_leq unfold_ty) args args'  in
                (if uu____824
                 then (true, e)
                 else (false, FStar_Pervasives_Native.None))
              else
                (let uu____840 = unfold_ty t  in
                 match uu____840 with
                 | FStar_Pervasives_Native.Some t1 ->
                     type_leq_c unfold_ty e t1 t'
                 | FStar_Pervasives_Native.None  ->
                     let uu____854 = unfold_ty t'  in
                     (match uu____854 with
                      | FStar_Pervasives_Native.None  ->
                          (false, FStar_Pervasives_Native.None)
                      | FStar_Pervasives_Native.Some t'1 ->
                          type_leq_c unfold_ty e t t'1))
          | (FStar_Extraction_ML_Syntax.MLTY_Tuple
             ts,FStar_Extraction_ML_Syntax.MLTY_Tuple ts') ->
              let uu____876 = FStar_List.forall2 (type_leq unfold_ty) ts ts'
                 in
              if uu____876
              then (true, e)
              else (false, FStar_Pervasives_Native.None)
          | (FStar_Extraction_ML_Syntax.MLTY_Top
             ,FStar_Extraction_ML_Syntax.MLTY_Top ) -> (true, e)
          | (FStar_Extraction_ML_Syntax.MLTY_Named uu____893,uu____894) ->
              let uu____901 = unfold_ty t  in
              (match uu____901 with
               | FStar_Pervasives_Native.Some t1 ->
                   type_leq_c unfold_ty e t1 t'
               | uu____915 -> (false, FStar_Pervasives_Native.None))
          | (uu____920,FStar_Extraction_ML_Syntax.MLTY_Named uu____921) ->
              let uu____928 = unfold_ty t'  in
              (match uu____928 with
               | FStar_Pervasives_Native.Some t'1 ->
                   type_leq_c unfold_ty e t t'1
               | uu____942 -> (false, FStar_Pervasives_Native.None))
          | (FStar_Extraction_ML_Syntax.MLTY_Erased
             ,FStar_Extraction_ML_Syntax.MLTY_Erased ) -> (true, e)
          | uu____949 -> (false, FStar_Pervasives_Native.None)

and (type_leq :
  unfold_t ->
    FStar_Extraction_ML_Syntax.mlty ->
      FStar_Extraction_ML_Syntax.mlty -> Prims.bool)
  =
  fun g  ->
    fun t1  ->
      fun t2  ->
        let uu____961 = type_leq_c g FStar_Pervasives_Native.None t1 t2  in
        FStar_All.pipe_right uu____961 FStar_Pervasives_Native.fst

let is_type_abstraction :
  'a 'b 'c .
    (('a,'b) FStar_Util.either,'c) FStar_Pervasives_Native.tuple2 Prims.list
      -> Prims.bool
  =
  fun uu___253_1004  ->
    match uu___253_1004 with
    | (FStar_Util.Inl uu____1015,uu____1016)::uu____1017 -> true
    | uu____1040 -> false
  
let (is_xtuple :
  (Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2 ->
    Prims.int FStar_Pervasives_Native.option)
  =
  fun uu____1063  ->
    match uu____1063 with
    | (ns,n1) ->
        let uu____1078 =
          let uu____1079 =
            FStar_Util.concat_l "." (FStar_List.append ns [n1])  in
          FStar_Parser_Const.is_tuple_datacon_string uu____1079  in
        if uu____1078
        then
          let uu____1082 =
            let uu____1083 = FStar_Util.char_at n1 (Prims.parse_int "7")  in
            FStar_Util.int_of_char uu____1083  in
          FStar_Pervasives_Native.Some uu____1082
        else FStar_Pervasives_Native.None
  
let (resugar_exp :
  FStar_Extraction_ML_Syntax.mlexpr -> FStar_Extraction_ML_Syntax.mlexpr) =
  fun e  ->
    match e.FStar_Extraction_ML_Syntax.expr with
    | FStar_Extraction_ML_Syntax.MLE_CTor (mlp,args) ->
        let uu____1097 = is_xtuple mlp  in
        (match uu____1097 with
         | FStar_Pervasives_Native.Some n1 ->
             FStar_All.pipe_left
               (FStar_Extraction_ML_Syntax.with_ty
                  e.FStar_Extraction_ML_Syntax.mlty)
               (FStar_Extraction_ML_Syntax.MLE_Tuple args)
         | uu____1101 -> e)
    | uu____1104 -> e
  
let (record_field_path :
  FStar_Ident.lident Prims.list -> Prims.string Prims.list) =
  fun uu___254_1113  ->
    match uu___254_1113 with
    | f::uu____1119 ->
        let uu____1122 = FStar_Util.prefix f.FStar_Ident.ns  in
        (match uu____1122 with
         | (ns,uu____1132) ->
             FStar_All.pipe_right ns
               (FStar_List.map (fun id1  -> id1.FStar_Ident.idText)))
    | uu____1143 -> failwith "impos"
  
let record_fields :
  'a .
    FStar_Ident.lident Prims.list ->
      'a Prims.list ->
        (Prims.string,'a) FStar_Pervasives_Native.tuple2 Prims.list
  =
  fun fs  ->
    fun vs  ->
      FStar_List.map2
        (fun f  -> fun e  -> (((f.FStar_Ident.ident).FStar_Ident.idText), e))
        fs vs
  
let (is_xtuple_ty :
  (Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2 ->
    Prims.int FStar_Pervasives_Native.option)
  =
  fun uu____1199  ->
    match uu____1199 with
    | (ns,n1) ->
        let uu____1214 =
          let uu____1215 =
            FStar_Util.concat_l "." (FStar_List.append ns [n1])  in
          FStar_Parser_Const.is_tuple_constructor_string uu____1215  in
        if uu____1214
        then
          let uu____1218 =
            let uu____1219 = FStar_Util.char_at n1 (Prims.parse_int "5")  in
            FStar_Util.int_of_char uu____1219  in
          FStar_Pervasives_Native.Some uu____1218
        else FStar_Pervasives_Native.None
  
let (resugar_mlty :
  FStar_Extraction_ML_Syntax.mlty -> FStar_Extraction_ML_Syntax.mlty) =
  fun t  ->
    match t with
    | FStar_Extraction_ML_Syntax.MLTY_Named (args,mlp) ->
        let uu____1233 = is_xtuple_ty mlp  in
        (match uu____1233 with
         | FStar_Pervasives_Native.Some n1 ->
             FStar_Extraction_ML_Syntax.MLTY_Tuple args
         | uu____1237 -> t)
    | uu____1240 -> t
  
let (flatten_ns : Prims.string Prims.list -> Prims.string) =
  fun ns  ->
    let uu____1250 = codegen_fsharp ()  in
    if uu____1250
    then FStar_String.concat "." ns
    else FStar_String.concat "_" ns
  
let (flatten_mlpath :
  (Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2 ->
    Prims.string)
  =
  fun uu____1262  ->
    match uu____1262 with
    | (ns,n1) ->
        let uu____1275 = codegen_fsharp ()  in
        if uu____1275
        then FStar_String.concat "." (FStar_List.append ns [n1])
        else FStar_String.concat "_" (FStar_List.append ns [n1])
  
let (mlpath_of_lid :
  FStar_Ident.lident ->
    (Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2)
  =
  fun l  ->
    let uu____1288 =
      FStar_All.pipe_right l.FStar_Ident.ns
        (FStar_List.map (fun i  -> i.FStar_Ident.idText))
       in
    (uu____1288, ((l.FStar_Ident.ident).FStar_Ident.idText))
  
let rec (erasableType :
  unfold_t -> FStar_Extraction_ML_Syntax.mlty -> Prims.bool) =
  fun unfold_ty  ->
    fun t  ->
      let uu____1314 = FStar_Extraction_ML_UEnv.erasableTypeNoDelta t  in
      if uu____1314
      then true
      else
        (let uu____1316 = unfold_ty t  in
         match uu____1316 with
         | FStar_Pervasives_Native.Some t1 -> erasableType unfold_ty t1
         | FStar_Pervasives_Native.None  -> false)
  
let rec (eraseTypeDeep :
  unfold_t ->
    FStar_Extraction_ML_Syntax.mlty -> FStar_Extraction_ML_Syntax.mlty)
  =
  fun unfold_ty  ->
    fun t  ->
      match t with
      | FStar_Extraction_ML_Syntax.MLTY_Fun (tyd,etag,tycd) ->
          if etag = FStar_Extraction_ML_Syntax.E_PURE
          then
            let uu____1342 =
              let uu____1349 = eraseTypeDeep unfold_ty tyd  in
              let uu____1353 = eraseTypeDeep unfold_ty tycd  in
              (uu____1349, etag, uu____1353)  in
            FStar_Extraction_ML_Syntax.MLTY_Fun uu____1342
          else t
      | FStar_Extraction_ML_Syntax.MLTY_Named (lty,mlp) ->
          let uu____1364 = erasableType unfold_ty t  in
          if uu____1364
          then FStar_Extraction_ML_UEnv.erasedContent
          else
            (let uu____1369 =
               let uu____1376 = FStar_List.map (eraseTypeDeep unfold_ty) lty
                  in
               (uu____1376, mlp)  in
             FStar_Extraction_ML_Syntax.MLTY_Named uu____1369)
      | FStar_Extraction_ML_Syntax.MLTY_Tuple lty ->
          let uu____1387 = FStar_List.map (eraseTypeDeep unfold_ty) lty  in
          FStar_Extraction_ML_Syntax.MLTY_Tuple uu____1387
      | uu____1393 -> t
  
let (prims_op_equality : FStar_Extraction_ML_Syntax.mlexpr) =
  FStar_All.pipe_left
    (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.MLTY_Top)
    (FStar_Extraction_ML_Syntax.MLE_Name (["Prims"], "op_Equality"))
  
let (prims_op_amp_amp : FStar_Extraction_ML_Syntax.mlexpr) =
  let uu____1396 =
    let uu____1401 =
      mk_ty_fun
        [("x", FStar_Extraction_ML_Syntax.ml_bool_ty);
        ("y", FStar_Extraction_ML_Syntax.ml_bool_ty)]
        FStar_Extraction_ML_Syntax.ml_bool_ty
       in
    FStar_Extraction_ML_Syntax.with_ty uu____1401  in
  FStar_All.pipe_left uu____1396
    (FStar_Extraction_ML_Syntax.MLE_Name (["Prims"], "op_AmpAmp"))
  
let (conjoin :
  FStar_Extraction_ML_Syntax.mlexpr ->
    FStar_Extraction_ML_Syntax.mlexpr -> FStar_Extraction_ML_Syntax.mlexpr)
  =
  fun e1  ->
    fun e2  ->
      FStar_All.pipe_left
        (FStar_Extraction_ML_Syntax.with_ty
           FStar_Extraction_ML_Syntax.ml_bool_ty)
        (FStar_Extraction_ML_Syntax.MLE_App (prims_op_amp_amp, [e1; e2]))
  
let (conjoin_opt :
  FStar_Extraction_ML_Syntax.mlexpr FStar_Pervasives_Native.option ->
    FStar_Extraction_ML_Syntax.mlexpr FStar_Pervasives_Native.option ->
      FStar_Extraction_ML_Syntax.mlexpr FStar_Pervasives_Native.option)
  =
  fun e1  ->
    fun e2  ->
      match (e1, e2) with
      | (FStar_Pervasives_Native.None ,FStar_Pervasives_Native.None ) ->
          FStar_Pervasives_Native.None
      | (FStar_Pervasives_Native.Some x,FStar_Pervasives_Native.None ) ->
          FStar_Pervasives_Native.Some x
      | (FStar_Pervasives_Native.None ,FStar_Pervasives_Native.Some x) ->
          FStar_Pervasives_Native.Some x
      | (FStar_Pervasives_Native.Some x,FStar_Pervasives_Native.Some y) ->
          let uu____1474 = conjoin x y  in
          FStar_Pervasives_Native.Some uu____1474
  
let (mlloc_of_range :
  FStar_Range.range ->
    (Prims.int,Prims.string) FStar_Pervasives_Native.tuple2)
  =
  fun r  ->
    let pos = FStar_Range.start_of_range r  in
    let line = FStar_Range.line_of_pos pos  in
    let uu____1486 = FStar_Range.file_of_range r  in (line, uu____1486)
  
let rec (doms_and_cod :
  FStar_Extraction_ML_Syntax.mlty ->
    (FStar_Extraction_ML_Syntax.mlty Prims.list,FStar_Extraction_ML_Syntax.mlty)
      FStar_Pervasives_Native.tuple2)
  =
  fun t  ->
    match t with
    | FStar_Extraction_ML_Syntax.MLTY_Fun (a,uu____1505,b) ->
        let uu____1507 = doms_and_cod b  in
        (match uu____1507 with | (ds,c) -> ((a :: ds), c))
    | uu____1528 -> ([], t)
  
let (argTypes :
  FStar_Extraction_ML_Syntax.mlty ->
    FStar_Extraction_ML_Syntax.mlty Prims.list)
  =
  fun t  ->
    let uu____1540 = doms_and_cod t  in
    FStar_Pervasives_Native.fst uu____1540
  
let rec (uncurry_mlty_fun :
  FStar_Extraction_ML_Syntax.mlty ->
    (FStar_Extraction_ML_Syntax.mlty Prims.list,FStar_Extraction_ML_Syntax.mlty)
      FStar_Pervasives_Native.tuple2)
  =
  fun t  ->
    match t with
    | FStar_Extraction_ML_Syntax.MLTY_Fun (a,uu____1567,b) ->
        let uu____1569 = uncurry_mlty_fun b  in
        (match uu____1569 with | (args,res) -> ((a :: args), res))
    | uu____1590 -> ([], t)
  
exception NoTacticEmbedding of Prims.string 
let (uu___is_NoTacticEmbedding : Prims.exn -> Prims.bool) =
  fun projectee  ->
    match projectee with
    | NoTacticEmbedding uu____1602 -> true
    | uu____1603 -> false
  
let (__proj__NoTacticEmbedding__item__uu___ : Prims.exn -> Prims.string) =
  fun projectee  ->
    match projectee with | NoTacticEmbedding uu____1610 -> uu____1610
  
let (not_implemented_warning :
  FStar_Range.range -> Prims.string -> Prims.string -> unit) =
  fun r  ->
    fun t  ->
      fun msg  ->
        let uu____1626 =
          let uu____1631 =
            FStar_Util.format2
              "Plugin %s will not run natively because %s.\n" t msg
             in
          (FStar_Errors.Warning_CallNotImplementedAsWarning, uu____1631)  in
        FStar_Errors.log_issue r uu____1626
  
type emb_loc =
  | S 
  | R 
let (uu___is_S : emb_loc -> Prims.bool) =
  fun projectee  -> match projectee with | S  -> true | uu____1637 -> false 
let (uu___is_R : emb_loc -> Prims.bool) =
  fun projectee  -> match projectee with | R  -> true | uu____1643 -> false 
let (interpret_plugin_as_term_fun :
  FStar_TypeChecker_Env.env ->
    FStar_Ident.lident ->
      FStar_Syntax_Syntax.typ ->
        FStar_Extraction_ML_Syntax.mlexpr' ->
          (FStar_Extraction_ML_Syntax.mlexpr,Prims.int,Prims.bool)
            FStar_Pervasives_Native.tuple3 FStar_Pervasives_Native.option)
  =
  fun tcenv  ->
    fun fv  ->
      fun t  ->
        fun ml_fv  ->
          let t1 =
            FStar_TypeChecker_Normalize.normalize
              [FStar_TypeChecker_Normalize.EraseUniverses;
              FStar_TypeChecker_Normalize.AllowUnboundUniverses;
              FStar_TypeChecker_Normalize.UnfoldUntil
                FStar_Syntax_Syntax.delta_constant] tcenv t
             in
          let w =
            FStar_Extraction_ML_Syntax.with_ty
              FStar_Extraction_ML_Syntax.MLTY_Top
             in
          let lid_to_name l =
            let uu____1684 =
              let uu____1685 = FStar_Extraction_ML_Syntax.mlpath_of_lident l
                 in
              FStar_Extraction_ML_Syntax.MLE_Name uu____1685  in
            FStar_All.pipe_left
              (FStar_Extraction_ML_Syntax.with_ty
                 FStar_Extraction_ML_Syntax.MLTY_Top) uu____1684
             in
          let lid_to_top_name l =
            let uu____1692 =
              let uu____1693 = FStar_Extraction_ML_Syntax.mlpath_of_lident l
                 in
              FStar_Extraction_ML_Syntax.MLE_Name uu____1693  in
            FStar_All.pipe_left
              (FStar_Extraction_ML_Syntax.with_ty
                 FStar_Extraction_ML_Syntax.MLTY_Top) uu____1692
             in
          let str_to_name s =
            let uu____1700 = FStar_Ident.lid_of_str s  in
            lid_to_name uu____1700  in
          let str_to_top_name s =
            let uu____1707 = FStar_Ident.lid_of_str s  in
            lid_to_top_name uu____1707  in
          let fstar_syn_emb_prefix s =
            str_to_name (Prims.strcat "FStar_Syntax_Embeddings." s)  in
          let fstar_refl_emb_prefix s =
            str_to_name (Prims.strcat "FStar_Reflection_Embeddings." s)  in
          let mk_basic_embedding l s =
            let emb_prefix =
              match l with
              | S  -> fstar_syn_emb_prefix
              | R  -> fstar_refl_emb_prefix  in
            emb_prefix (Prims.strcat "e_" s)  in
          let mk_arrow_embedding arity =
            let uu____1745 =
              let uu____1746 = FStar_Util.string_of_int arity  in
              Prims.strcat "embed_arrow_" uu____1746  in
            fstar_syn_emb_prefix uu____1745  in
          let mk_any_embedding s =
            let uu____1753 =
              let uu____1754 =
                let uu____1761 = fstar_syn_emb_prefix "mk_any_emb"  in
                let uu____1762 =
                  let uu____1765 = str_to_name s  in [uu____1765]  in
                (uu____1761, uu____1762)  in
              FStar_Extraction_ML_Syntax.MLE_App uu____1754  in
            FStar_All.pipe_left w uu____1753  in
          let mk_lam nm e =
            FStar_All.pipe_left w
              (FStar_Extraction_ML_Syntax.MLE_Fun
                 ([(nm, FStar_Extraction_ML_Syntax.MLTY_Top)], e))
             in
          let known_type_constructors =
            let uu____1804 =
              let uu____1815 =
                let uu____1826 =
                  let uu____1837 =
                    let uu____1848 =
                      let uu____1857 =
                        FStar_Reflection_Data.fstar_refl_types_lid "term"  in
                      (uu____1857, (Prims.parse_int "0"), "term", R)  in
                    let uu____1858 =
                      let uu____1869 =
                        let uu____1878 =
                          FStar_Reflection_Data.fstar_refl_types_lid "fv"  in
                        (uu____1878, (Prims.parse_int "0"), "fv", R)  in
                      let uu____1879 =
                        let uu____1890 =
                          let uu____1899 =
                            FStar_Reflection_Data.fstar_refl_types_lid
                              "binder"
                             in
                          (uu____1899, (Prims.parse_int "0"), "binder", R)
                           in
                        let uu____1900 =
                          let uu____1911 =
                            let uu____1920 =
                              FStar_Reflection_Data.fstar_refl_syntax_lid
                                "binders"
                               in
                            (uu____1920, (Prims.parse_int "0"), "binders", R)
                             in
                          let uu____1921 =
                            let uu____1932 =
                              let uu____1943 =
                                let uu____1954 =
                                  let uu____1965 =
                                    let uu____1974 =
                                      FStar_Parser_Const.mk_tuple_lid
                                        (Prims.parse_int "2")
                                        FStar_Range.dummyRange
                                       in
                                    (uu____1974, (Prims.parse_int "2"),
                                      "tuple2", S)
                                     in
                                  let uu____1975 =
                                    let uu____1986 =
                                      let uu____1995 =
                                        FStar_Reflection_Data.fstar_refl_data_lid
                                          "exp"
                                         in
                                      (uu____1995, (Prims.parse_int "0"),
                                        "exp", R)
                                       in
                                    [uu____1986]  in
                                  uu____1965 :: uu____1975  in
                                (FStar_Parser_Const.option_lid,
                                  (Prims.parse_int "1"), "option", S) ::
                                  uu____1954
                                 in
                              (FStar_Parser_Const.list_lid,
                                (Prims.parse_int "1"), "list", S) ::
                                uu____1943
                               in
                            (FStar_Parser_Const.norm_step_lid,
                              (Prims.parse_int "0"), "norm_step", S) ::
                              uu____1932
                             in
                          uu____1911 :: uu____1921  in
                        uu____1890 :: uu____1900  in
                      uu____1869 :: uu____1879  in
                    uu____1848 :: uu____1858  in
                  (FStar_Parser_Const.string_lid, (Prims.parse_int "0"),
                    "string", S) :: uu____1837
                   in
                (FStar_Parser_Const.unit_lid, (Prims.parse_int "0"), "unit",
                  S) :: uu____1826
                 in
              (FStar_Parser_Const.bool_lid, (Prims.parse_int "0"), "bool", S)
                :: uu____1815
               in
            (FStar_Parser_Const.int_lid, (Prims.parse_int "0"), "int", S) ::
              uu____1804
             in
          let is_known_type_constructor fv1 n1 =
            FStar_Util.for_some
              (fun uu____2132  ->
                 match uu____2132 with
                 | (x,args,uu____2143,uu____2144) ->
                     (FStar_Syntax_Syntax.fv_eq_lid fv1 x) && (n1 = args))
              known_type_constructors
             in
          let find_env_entry bv uu____2159 =
            match uu____2159 with
            | (bv',uu____2165) -> FStar_Syntax_Syntax.bv_eq bv bv'  in
          let rec mk_embedding env t2 =
            let uu____2189 =
              let uu____2190 = FStar_Syntax_Subst.compress t2  in
              uu____2190.FStar_Syntax_Syntax.n  in
            match uu____2189 with
            | FStar_Syntax_Syntax.Tm_name bv when
                FStar_Util.for_some (find_env_entry bv) env ->
                let uu____2198 =
                  let uu____2199 =
                    let uu____2204 =
                      FStar_Util.find_opt (find_env_entry bv) env  in
                    FStar_Util.must uu____2204  in
                  FStar_Pervasives_Native.snd uu____2199  in
                FStar_All.pipe_left mk_any_embedding uu____2198
            | FStar_Syntax_Syntax.Tm_refine (x,uu____2220) ->
                mk_embedding env x.FStar_Syntax_Syntax.sort
            | FStar_Syntax_Syntax.Tm_ascribed (t3,uu____2226,uu____2227) ->
                mk_embedding env t3
            | uu____2268 ->
                let t3 = FStar_TypeChecker_Normalize.unfold_whnf tcenv t2  in
                let uu____2270 = FStar_Syntax_Util.head_and_args t3  in
                (match uu____2270 with
                 | (head1,args) ->
                     let n_args = FStar_List.length args  in
                     let uu____2314 =
                       let uu____2315 = FStar_Syntax_Util.un_uinst head1  in
                       uu____2315.FStar_Syntax_Syntax.n  in
                     (match uu____2314 with
                      | FStar_Syntax_Syntax.Tm_refine (b,uu____2319) ->
                          mk_embedding env b.FStar_Syntax_Syntax.sort
                      | FStar_Syntax_Syntax.Tm_fvar fv1 when
                          is_known_type_constructor fv1 n_args ->
                          let arg_embeddings =
                            FStar_List.map
                              (fun uu____2339  ->
                                 match uu____2339 with
                                 | (t4,uu____2345) -> mk_embedding env t4)
                              args
                             in
                          let nm =
                            (((fv1.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v).FStar_Ident.ident).FStar_Ident.idText
                             in
                          let uu____2347 =
                            let uu____2356 =
                              FStar_Util.find_opt
                                (fun uu____2380  ->
                                   match uu____2380 with
                                   | (x,uu____2390,uu____2391,uu____2392) ->
                                       FStar_Syntax_Syntax.fv_eq_lid fv1 x)
                                known_type_constructors
                               in
                            FStar_All.pipe_right uu____2356 FStar_Util.must
                             in
                          (match uu____2347 with
                           | (uu____2419,t_arity,trepr_head,loc_embedding) ->
                               let head2 =
                                 mk_basic_embedding loc_embedding nm  in
                               (match t_arity with
                                | _0_20 when _0_20 = (Prims.parse_int "0") ->
                                    head2
                                | n1 ->
                                    FStar_All.pipe_left w
                                      (FStar_Extraction_ML_Syntax.MLE_App
                                         (head2, arg_embeddings))))
                      | uu____2427 ->
                          let uu____2428 =
                            let uu____2429 =
                              let uu____2430 =
                                FStar_Syntax_Print.term_to_string t3  in
                              Prims.strcat "Embedding not defined for type "
                                uu____2430
                               in
                            NoTacticEmbedding uu____2429  in
                          FStar_Exn.raise uu____2428))
             in
          let abstract_tvars tvar_names body =
            match tvar_names with
            | [] -> body
            | uu____2446 ->
                let args_tail =
                  FStar_Extraction_ML_Syntax.MLP_Var "args_tail"  in
                let mk_cons hd_pat tail_pat =
                  FStar_Extraction_ML_Syntax.MLP_CTor
                    ((["Prims"], "Cons"), [hd_pat; tail_pat])
                   in
                let fst_pat v1 =
                  FStar_Extraction_ML_Syntax.MLP_Tuple
                    [FStar_Extraction_ML_Syntax.MLP_Var v1;
                    FStar_Extraction_ML_Syntax.MLP_Wild]
                   in
                let pattern =
                  FStar_List.fold_right
                    (fun hd_var  -> mk_cons (fst_pat hd_var)) tvar_names
                    args_tail
                   in
                let branch1 =
                  let uu____2483 =
                    let uu____2484 =
                      let uu____2485 =
                        let uu____2492 =
                          let uu____2495 = str_to_name "args_tail"  in
                          [uu____2495]  in
                        (body, uu____2492)  in
                      FStar_Extraction_ML_Syntax.MLE_App uu____2485  in
                    FStar_All.pipe_left w uu____2484  in
                  (pattern, FStar_Pervasives_Native.None, uu____2483)  in
                let default_branch =
                  let uu____2509 =
                    let uu____2510 =
                      let uu____2511 =
                        let uu____2518 = str_to_name "failwith"  in
                        let uu____2519 =
                          let uu____2522 =
                            let uu____2523 =
                              mlexpr_of_const FStar_Range.dummyRange
                                (FStar_Const.Const_string
                                   ("arity mismatch", FStar_Range.dummyRange))
                               in
                            FStar_All.pipe_left w uu____2523  in
                          [uu____2522]  in
                        (uu____2518, uu____2519)  in
                      FStar_Extraction_ML_Syntax.MLE_App uu____2511  in
                    FStar_All.pipe_left w uu____2510  in
                  (FStar_Extraction_ML_Syntax.MLP_Wild,
                    FStar_Pervasives_Native.None, uu____2509)
                   in
                let body1 =
                  let uu____2529 =
                    let uu____2530 =
                      let uu____2545 = str_to_name "args"  in
                      (uu____2545, [branch1; default_branch])  in
                    FStar_Extraction_ML_Syntax.MLE_Match uu____2530  in
                  FStar_All.pipe_left w uu____2529  in
                mk_lam "args" body1
             in
          let uu____2580 = FStar_Syntax_Util.arrow_formals_comp t1  in
          match uu____2580 with
          | (bs,c) ->
              let result_typ = FStar_Syntax_Util.comp_result c  in
              let arity = FStar_List.length bs  in
              let uu____2621 =
                let uu____2638 =
                  FStar_Util.prefix_until
                    (fun uu____2672  ->
                       match uu____2672 with
                       | (b,uu____2678) ->
                           let uu____2679 =
                             let uu____2680 =
                               FStar_Syntax_Subst.compress
                                 b.FStar_Syntax_Syntax.sort
                                in
                             uu____2680.FStar_Syntax_Syntax.n  in
                           (match uu____2679 with
                            | FStar_Syntax_Syntax.Tm_type uu____2683 -> false
                            | uu____2684 -> true)) bs
                   in
                match uu____2638 with
                | FStar_Pervasives_Native.None  -> (bs, [])
                | FStar_Pervasives_Native.Some (tvars,x,rest) ->
                    (tvars, (x :: rest))
                 in
              (match uu____2621 with
               | (type_vars,bs1) ->
                   let non_tvar_arity = FStar_List.length bs1  in
                   let tvar_names =
                     FStar_List.mapi
                       (fun i  ->
                          fun tv  ->
                            let uu____2867 = FStar_Util.string_of_int i  in
                            Prims.strcat "tv_" uu____2867) type_vars
                      in
                   let tvar_context =
                     FStar_List.map2
                       (fun b  ->
                          fun nm  -> ((FStar_Pervasives_Native.fst b), nm))
                       type_vars tvar_names
                      in
                   let rec aux accum_embeddings env bs2 =
                     match bs2 with
                     | [] ->
                         let arg_unembeddings =
                           FStar_List.rev accum_embeddings  in
                         let res_embedding = mk_embedding env result_typ  in
                         let uu____2959 = FStar_Syntax_Util.is_pure_comp c
                            in
                         if uu____2959
                         then
                           let embed_fun_N =
                             mk_arrow_embedding non_tvar_arity  in
                           let args =
                             let uu____2978 =
                               let uu____2981 =
                                 let uu____2984 = lid_to_top_name fv  in
                                 [uu____2984]  in
                               res_embedding :: uu____2981  in
                             FStar_List.append arg_unembeddings uu____2978
                              in
                           let fun_embedding =
                             FStar_All.pipe_left w
                               (FStar_Extraction_ML_Syntax.MLE_App
                                  (embed_fun_N, args))
                              in
                           let tabs = abstract_tvars tvar_names fun_embedding
                              in
                           let uu____2989 =
                             let uu____2996 = mk_lam "_psc" tabs  in
                             (uu____2996, arity, true)  in
                           FStar_Pervasives_Native.Some uu____2989
                         else
                           (let uu____3008 =
                              let uu____3009 =
                                FStar_TypeChecker_Env.norm_eff_name tcenv
                                  (FStar_Syntax_Util.comp_effect_name c)
                                 in
                              FStar_Ident.lid_equals uu____3009
                                FStar_Parser_Const.effect_TAC_lid
                               in
                            if uu____3008
                            then
                              let h =
                                let uu____3019 =
                                  let uu____3020 =
                                    FStar_Util.string_of_int non_tvar_arity
                                     in
                                  Prims.strcat
                                    "FStar_Tactics_Interpreter.mk_tactic_interpretation_"
                                    uu____3020
                                   in
                                str_to_top_name uu____3019  in
                              let tac_fun =
                                let uu____3028 =
                                  let uu____3029 =
                                    let uu____3036 =
                                      let uu____3037 =
                                        let uu____3038 =
                                          FStar_Util.string_of_int
                                            non_tvar_arity
                                           in
                                        Prims.strcat
                                          "FStar_Tactics_Native.from_tactic_"
                                          uu____3038
                                         in
                                      str_to_top_name uu____3037  in
                                    let uu____3045 =
                                      let uu____3048 = lid_to_top_name fv  in
                                      [uu____3048]  in
                                    (uu____3036, uu____3045)  in
                                  FStar_Extraction_ML_Syntax.MLE_App
                                    uu____3029
                                   in
                                FStar_All.pipe_left w uu____3028  in
                              let tac_lid_app =
                                let uu____3052 =
                                  let uu____3053 =
                                    let uu____3060 =
                                      str_to_top_name
                                        "FStar_Ident.lid_of_str"
                                       in
                                    (uu____3060, [w ml_fv])  in
                                  FStar_Extraction_ML_Syntax.MLE_App
                                    uu____3053
                                   in
                                FStar_All.pipe_left w uu____3052  in
                              let psc = str_to_name "psc"  in
                              let all_args = str_to_name "args"  in
                              let args =
                                let uu____3068 =
                                  let uu____3071 =
                                    FStar_All.pipe_left w
                                      (FStar_Extraction_ML_Syntax.MLE_Const
                                         (FStar_Extraction_ML_Syntax.MLC_Bool
                                            true))
                                     in
                                  [uu____3071; tac_fun]  in
                                FStar_List.append uu____3068
                                  (FStar_List.append arg_unembeddings
                                     [res_embedding; tac_lid_app; psc])
                                 in
                              let tabs =
                                match tvar_names with
                                | [] ->
                                    let uu____3073 =
                                      FStar_All.pipe_left w
                                        (FStar_Extraction_ML_Syntax.MLE_App
                                           (h,
                                             (FStar_List.append args
                                                [all_args])))
                                       in
                                    mk_lam "args" uu____3073
                                | uu____3076 ->
                                    let uu____3079 =
                                      FStar_All.pipe_left w
                                        (FStar_Extraction_ML_Syntax.MLE_App
                                           (h, args))
                                       in
                                    abstract_tvars tvar_names uu____3079
                                 in
                              let uu____3082 =
                                let uu____3089 = mk_lam "psc" tabs  in
                                (uu____3089, (arity + (Prims.parse_int "1")),
                                  false)
                                 in
                              FStar_Pervasives_Native.Some uu____3082
                            else
                              (let uu____3103 =
                                 let uu____3104 =
                                   let uu____3105 =
                                     FStar_Syntax_Print.term_to_string t1  in
                                   Prims.strcat
                                     "Plugins not defined for type "
                                     uu____3105
                                    in
                                 NoTacticEmbedding uu____3104  in
                               FStar_Exn.raise uu____3103))
                     | (b,uu____3115)::bs3 ->
                         let uu____3127 =
                           let uu____3130 =
                             mk_embedding env b.FStar_Syntax_Syntax.sort  in
                           uu____3130 :: accum_embeddings  in
                         aux uu____3127 env bs3
                      in
                   (try aux [] tvar_context bs1
                    with
                    | NoTacticEmbedding msg ->
                        ((let uu____3163 = FStar_Ident.string_of_lid fv  in
                          not_implemented_warning t1.FStar_Syntax_Syntax.pos
                            uu____3163 msg);
                         FStar_Pervasives_Native.None)))
  