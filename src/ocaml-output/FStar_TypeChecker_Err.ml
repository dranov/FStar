open Prims
let info_at_pos env file row col =
  let uu____34 = FStar_TypeChecker_Common.info_at_pos file row col in
  match uu____34 with
  | None  -> None
  | Some info ->
      (match info.FStar_TypeChecker_Common.identifier with
       | FStar_Util.Inl bv ->
           let uu____55 =
             let uu____61 =
               let uu____64 = FStar_Syntax_Print.nm_to_string bv in
               FStar_Util.Inl uu____64 in
             let uu____65 = FStar_Syntax_Syntax.range_of_bv bv in
             (uu____61, (info.FStar_TypeChecker_Common.identifier_ty),
               uu____65) in
           Some uu____55
       | FStar_Util.Inr fv ->
           let uu____74 =
             let uu____80 =
               let uu____83 = FStar_Syntax_Syntax.lid_of_fv fv in
               FStar_Util.Inr uu____83 in
             let uu____84 = FStar_Syntax_Syntax.range_of_fv fv in
             (uu____80, (info.FStar_TypeChecker_Common.identifier_ty),
               uu____84) in
           Some uu____74)
let add_errors:
  FStar_TypeChecker_Env.env ->
    (Prims.string* FStar_Range.range) Prims.list -> Prims.unit
  =
  fun env  ->
    fun errs  ->
      let errs1 =
        FStar_All.pipe_right errs
          (FStar_List.map
             (fun uu____120  ->
                match uu____120 with
                | (msg,r) ->
                    if r = FStar_Range.dummyRange
                    then
                      let uu____129 = FStar_TypeChecker_Env.get_range env in
                      (msg, uu____129)
                    else
                      (let r' =
                         let uu___212_132 = r in
                         {
                           FStar_Range.def_range = (r.FStar_Range.use_range);
                           FStar_Range.use_range =
                             (uu___212_132.FStar_Range.use_range)
                         } in
                       let uu____133 =
                         let uu____134 = FStar_Range.file_of_range r' in
                         let uu____135 =
                           let uu____136 =
                             FStar_TypeChecker_Env.get_range env in
                           FStar_Range.file_of_range uu____136 in
                         uu____134 <> uu____135 in
                       if uu____133
                       then
                         let uu____139 =
                           let uu____140 =
                             let uu____141 =
                               let uu____142 =
                                 FStar_Range.string_of_use_range r in
                               Prims.strcat uu____142 ")" in
                             Prims.strcat "(Also see: " uu____141 in
                           Prims.strcat msg uu____140 in
                         let uu____143 = FStar_TypeChecker_Env.get_range env in
                         (uu____139, uu____143)
                       else (msg, r)))) in
      FStar_Errors.add_errors errs1
let err_msg_type_strings:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term -> (Prims.string* Prims.string)
  =
  fun env  ->
    fun t1  ->
      fun t2  ->
        let s1 = FStar_TypeChecker_Normalize.term_to_string env t1 in
        let s2 = FStar_TypeChecker_Normalize.term_to_string env t2 in
        if s1 = s2
        then
          FStar_Options.with_saved_options
            (fun uu____167  ->
               (let uu____169 =
                  FStar_Options.set_options FStar_Options.Set
                    "--print_full_names --print_universes" in
                ());
               (let uu____170 =
                  FStar_TypeChecker_Normalize.term_to_string env t1 in
                let uu____171 =
                  FStar_TypeChecker_Normalize.term_to_string env t2 in
                (uu____170, uu____171)))
        else (s1, s2)
let exhaustiveness_check: Prims.string = "Patterns are incomplete"
let subtyping_failed:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.typ ->
      FStar_Syntax_Syntax.typ -> Prims.unit -> Prims.string
  =
  fun env  ->
    fun t1  ->
      fun t2  ->
        fun x  ->
          let uu____189 = err_msg_type_strings env t1 t2 in
          match uu____189 with
          | (s1,s2) ->
              FStar_Util.format2
                "Subtyping check failed; expected type %s; got type %s" s2 s1
let ill_kinded_type: Prims.string = "Ill-kinded type"
let totality_check: Prims.string = "This term may not terminate"
let unexpected_signature_for_monad:
  FStar_TypeChecker_Env.env ->
    FStar_Ident.lident -> FStar_Syntax_Syntax.term -> Prims.string
  =
  fun env  ->
    fun m  ->
      fun k  ->
        let uu____206 = FStar_TypeChecker_Normalize.term_to_string env k in
        FStar_Util.format2
          "Unexpected signature for monad \"%s\". Expected a signature of the form (a:Type => WP a => Effect); got %s"
          m.FStar_Ident.str uu____206
let expected_a_term_of_type_t_got_a_function:
  FStar_TypeChecker_Env.env ->
    Prims.string ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.string
  =
  fun env  ->
    fun msg  ->
      fun t  ->
        fun e  ->
          let uu____223 = FStar_TypeChecker_Normalize.term_to_string env t in
          let uu____224 = FStar_Syntax_Print.term_to_string e in
          FStar_Util.format3
            "Expected a term of type \"%s\"; got a function \"%s\" (%s)"
            uu____223 uu____224 msg
let unexpected_implicit_argument: Prims.string =
  "Unexpected instantiation of an implicit argument to a function that only expects explicit arguments"
let expected_expression_of_type:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.string
  =
  fun env  ->
    fun t1  ->
      fun e  ->
        fun t2  ->
          let uu____241 = err_msg_type_strings env t1 t2 in
          match uu____241 with
          | (s1,s2) ->
              let uu____246 = FStar_Syntax_Print.term_to_string e in
              FStar_Util.format3
                "Expected expression of type \"%s\"; got expression \"%s\" of type \"%s\""
                s1 uu____246 s2
let expected_function_with_parameter_of_type:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term -> Prims.string -> Prims.string
  =
  fun env  ->
    fun t1  ->
      fun t2  ->
        let uu____261 = err_msg_type_strings env t1 t2 in
        match uu____261 with
        | (s1,s2) ->
            FStar_Util.format3
              "Expected a function with a parameter of type \"%s\"; this function has a parameter of type \"%s\""
              s1 s2
let expected_pattern_of_type:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.string
  =
  fun env  ->
    fun t1  ->
      fun e  ->
        fun t2  ->
          let uu____284 = err_msg_type_strings env t1 t2 in
          match uu____284 with
          | (s1,s2) ->
              let uu____289 = FStar_Syntax_Print.term_to_string e in
              FStar_Util.format3
                "Expected pattern of type \"%s\"; got pattern \"%s\" of type \"%s\""
                s1 uu____289 s2
let basic_type_error:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term option ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.string
  =
  fun env  ->
    fun eopt  ->
      fun t1  ->
        fun t2  ->
          let uu____308 = err_msg_type_strings env t1 t2 in
          match uu____308 with
          | (s1,s2) ->
              (match eopt with
               | None  ->
                   FStar_Util.format2 "Expected type \"%s\"; got type \"%s\""
                     s1 s2
               | Some e ->
                   let uu____314 = FStar_Syntax_Print.term_to_string e in
                   FStar_Util.format3
                     "Expected type \"%s\"; but \"%s\" has type \"%s\"" s1
                     uu____314 s2)
let occurs_check: Prims.string =
  "Possibly infinite typ (occurs check failed)"
let unification_well_formedness: Prims.string =
  "Term or type of an unexpected sort"
let incompatible_kinds:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.string
  =
  fun env  ->
    fun k1  ->
      fun k2  ->
        let uu____327 = FStar_TypeChecker_Normalize.term_to_string env k1 in
        let uu____328 = FStar_TypeChecker_Normalize.term_to_string env k2 in
        FStar_Util.format2 "Kinds \"%s\" and \"%s\" are incompatible"
          uu____327 uu____328
let constructor_builds_the_wrong_type:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.string
  =
  fun env  ->
    fun d  ->
      fun t  ->
        fun t'  ->
          let uu____345 = FStar_Syntax_Print.term_to_string d in
          let uu____346 = FStar_TypeChecker_Normalize.term_to_string env t in
          let uu____347 = FStar_TypeChecker_Normalize.term_to_string env t' in
          FStar_Util.format3
            "Constructor \"%s\" builds a value of type \"%s\"; expected \"%s\""
            uu____345 uu____346 uu____347
let constructor_fails_the_positivity_check env d l =
  let uu____369 = FStar_Syntax_Print.term_to_string d in
  let uu____370 = FStar_Syntax_Print.lid_to_string l in
  FStar_Util.format2
    "Constructor \"%s\" fails the strict positivity check; the constructed type \"%s\" occurs to the left of a pure function type"
    uu____369 uu____370
let inline_type_annotation_and_val_decl: FStar_Ident.lid -> Prims.string =
  fun l  ->
    let uu____375 = FStar_Syntax_Print.lid_to_string l in
    FStar_Util.format1
      "\"%s\" has a val declaration as well as an inlined type annotation; remove one"
      uu____375
let inferred_type_causes_variable_to_escape:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.bv -> Prims.string
  =
  fun env  ->
    fun t  ->
      fun x  ->
        let uu____388 = FStar_TypeChecker_Normalize.term_to_string env t in
        let uu____389 = FStar_Syntax_Print.bv_to_string x in
        FStar_Util.format2
          "Inferred type \"%s\" causes variable \"%s\" to escape its scope"
          uu____388 uu____389
let expected_function_typ:
  FStar_TypeChecker_Env.env -> FStar_Syntax_Syntax.term -> Prims.string =
  fun env  ->
    fun t  ->
      let uu____398 = FStar_TypeChecker_Normalize.term_to_string env t in
      FStar_Util.format1
        "Expected a function; got an expression of type \"%s\"" uu____398
let expected_poly_typ:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.string
  =
  fun env  ->
    fun f  ->
      fun t  ->
        fun targ  ->
          let uu____415 = FStar_Syntax_Print.term_to_string f in
          let uu____416 = FStar_TypeChecker_Normalize.term_to_string env t in
          let uu____417 = FStar_TypeChecker_Normalize.term_to_string env targ in
          FStar_Util.format3
            "Expected a polymorphic function; got an expression \"%s\" of type \"%s\" applied to a type \"%s\""
            uu____415 uu____416 uu____417
let nonlinear_pattern_variable: FStar_Syntax_Syntax.bv -> Prims.string =
  fun x  ->
    let m = FStar_Syntax_Print.bv_to_string x in
    FStar_Util.format1 "The pattern variable \"%s\" was used more than once"
      m
let disjunctive_pattern_vars:
  FStar_Syntax_Syntax.bv Prims.list ->
    FStar_Syntax_Syntax.bv Prims.list -> Prims.string
  =
  fun v1  ->
    fun v2  ->
      let vars v3 =
        let uu____441 =
          FStar_All.pipe_right v3
            (FStar_List.map FStar_Syntax_Print.bv_to_string) in
        FStar_All.pipe_right uu____441 (FStar_String.concat ", ") in
      let uu____446 = vars v1 in
      let uu____447 = vars v2 in
      FStar_Util.format2
        "Every alternative of an 'or' pattern must bind the same variables; here one branch binds (\"%s\") and another (\"%s\")"
        uu____446 uu____447
let name_and_result c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Total (t,uu____466) -> ("Tot", t)
  | FStar_Syntax_Syntax.GTotal (t,uu____476) -> ("GTot", t)
  | FStar_Syntax_Syntax.Comp ct ->
      let uu____486 =
        FStar_Syntax_Print.lid_to_string ct.FStar_Syntax_Syntax.effect_name in
      (uu____486, (ct.FStar_Syntax_Syntax.result_typ))
let computed_computation_type_does_not_match_annotation env e c c' =
  let uu____530 = name_and_result c in
  match uu____530 with
  | (f1,r1) ->
      let uu____541 = name_and_result c' in
      (match uu____541 with
       | (f2,r2) ->
           let uu____552 = err_msg_type_strings env r1 r2 in
           (match uu____552 with
            | (s1,s2) ->
                FStar_Util.format4
                  "Computed type \"%s\" and effect \"%s\" is not compatible with the annotated type \"%s\" effect \"%s\""
                  s1 f1 s2 f2))
let unexpected_non_trivial_precondition_on_term:
  FStar_TypeChecker_Env.env -> FStar_Syntax_Syntax.term -> Prims.string =
  fun env  ->
    fun f  ->
      let uu____565 = FStar_TypeChecker_Normalize.term_to_string env f in
      FStar_Util.format1
        "Term has an unexpected non-trivial pre-condition: %s" uu____565
let expected_pure_expression e c =
  let uu____585 = FStar_Syntax_Print.term_to_string e in
  let uu____586 =
    let uu____587 = name_and_result c in
    FStar_All.pipe_left FStar_Pervasives.fst uu____587 in
  FStar_Util.format2
    "Expected a pure expression; got an expression \"%s\" with effect \"%s\""
    uu____585 uu____586
let expected_ghost_expression e c =
  let uu____617 = FStar_Syntax_Print.term_to_string e in
  let uu____618 =
    let uu____619 = name_and_result c in
    FStar_All.pipe_left FStar_Pervasives.fst uu____619 in
  FStar_Util.format2
    "Expected a ghost expression; got an expression \"%s\" with effect \"%s\""
    uu____617 uu____618
let expected_effect_1_got_effect_2:
  FStar_Ident.lident -> FStar_Ident.lident -> Prims.string =
  fun c1  ->
    fun c2  ->
      let uu____638 = FStar_Syntax_Print.lid_to_string c1 in
      let uu____639 = FStar_Syntax_Print.lid_to_string c2 in
      FStar_Util.format2
        "Expected a computation with effect %s; but it has effect %s"
        uu____638 uu____639
let failed_to_prove_specification_of:
  FStar_Syntax_Syntax.lbname -> Prims.string Prims.list -> Prims.string =
  fun l  ->
    fun lbls  ->
      let uu____650 = FStar_Syntax_Print.lbname_to_string l in
      let uu____651 = FStar_All.pipe_right lbls (FStar_String.concat ", ") in
      FStar_Util.format2
        "Failed to prove specification of %s; assertions at [%s] may fail"
        uu____650 uu____651
let failed_to_prove_specification: Prims.string Prims.list -> Prims.string =
  fun lbls  ->
    match lbls with
    | [] ->
        "An unknown assertion in the term at this location was not provable"
    | uu____659 ->
        let uu____661 =
          FStar_All.pipe_right lbls (FStar_String.concat "\n\t") in
        FStar_Util.format1 "The following problems were found:\n\t%s"
          uu____661
let top_level_effect: Prims.string =
  "Top-level let-bindings must be total; this term may have effects"
let cardinality_constraint_violated l a =
  let uu____682 = FStar_Syntax_Print.lid_to_string l in
  let uu____683 = FStar_Syntax_Print.bv_to_string a.FStar_Syntax_Syntax.v in
  FStar_Util.format2
    "Constructor %s violates the cardinality of Type at parameter '%s'; type arguments are not allowed"
    uu____682 uu____683