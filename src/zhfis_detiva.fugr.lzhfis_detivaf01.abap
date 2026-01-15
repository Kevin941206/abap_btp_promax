*----------------------------------------------------------------------*
*      -->P_0956   text
*      -->P_LS_BKPF_FI  text
*      <--P_LV_TDLINE  text
*----------------------------------------------------------------------*
FORM read_text  USING    p_tdid   TYPE char4
                         p_bkpf   TYPE ty_bkpf_fi
                CHANGING p_tdline TYPE ztdline.

  DATA : tdobject TYPE zst_thead-tdobject  VALUE 'BELEG',
         tdname   TYPE zst_thead-tdname.

  DATA: lt_stxh  TYPE TABLE OF zst_stxh,
        ls_stxh  TYPE zst_stxh,
        lv_spras TYPE zst_stxh-tdspras.

  DATA:  ls_sign      TYPE zst_zzfiglmx_je_sign.

  DATA : lt_txtl TYPE TABLE OF zst_tline,
         ls_txtl TYPE zst_tline.

  CLEAR ls_stxh.
  ls_stxh-tdid = p_tdid.
  CONCATENATE p_bkpf-bukrs p_bkpf-belnr p_bkpf-gjahr INTO ls_stxh-tdname RESPECTING BLANKS.
  ls_stxh-tdobject = 'BELEG'.

*  SELECT SINGLE tdspras FROM stxh INTO ls_stxh-tdspras
*                                 WHERE tdobject = ls_stxh-tdobject
*                                   AND tdname   = ls_stxh-tdname
*                                   AND tdid     = ls_stxh-tdid.

zcl_qry_zhfis_detiva=>zhfis_stxh( EXPORTING i_operacion = 'READ' ls_stxh = ls_stxh IMPORTING lv_tdpras = lv_spras ).
ls_stxh-tdspras = lv_spras.

  IF ls_stxh IS NOT INITIAL.
    CLEAR lt_txtl.
*    CALL FUNCTION 'READ_TEXT'
*      EXPORTING
*        id                      = ls_stxh-tdid
*        language                = ls_stxh-tdspras
*        name                    = ls_stxh-tdname
*        object                  = ls_stxh-tdobject
*      TABLES
*        lines                   = lt_txtl
*      EXCEPTIONS
*        id                      = 1
*        language                = 2
*        name                    = 3
*        not_found               = 4
*        object                  = 5
*        reference_check         = 6
*        wrong_access_to_archive = 7
*        OTHERS                  = 8.
    IF sy-subrc <> 0. ENDIF.

    READ TABLE lt_txtl INTO ls_txtl INDEX 1.
    IF sy-subrc = 0.
      p_tdline = ls_txtl-tdline.
    ENDIF.
  ENDIF.

ENDFORM.                    " READ_TEXT
