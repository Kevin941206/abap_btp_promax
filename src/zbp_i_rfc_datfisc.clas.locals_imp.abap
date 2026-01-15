CLASS lhc_Z_I_RFC_DATFISC DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR z_i_rfc_datfisc RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR z_i_rfc_datfisc RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR z_i_rfc_datfisc RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE z_i_rfc_datfisc.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE z_i_rfc_datfisc.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE z_i_rfc_datfisc.

    METHODS read FOR READ
      IMPORTING keys FOR READ z_i_rfc_datfisc RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK z_i_rfc_datfisc.

    METHODS execute_rfc FOR MODIFY
      IMPORTING keys FOR ACTION z_i_rfc_datfisc~execute_rfc RESULT result.

    METHODS:
      call_rfc_function
        IMPORTING
          iv_input_param  TYPE string
        EXPORTING
          ev_output_param TYPE string.
*          ev_return_code  TYPE char1
*          ev_message      TYPE string.

ENDCLASS.

CLASS lhc_Z_I_RFC_DATFISC IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD execute_rfc.
    " Leer datos de entrada
    READ ENTITIES OF z_i_rfc_datfisc IN LOCAL MODE
      ENTITY z_i_rfc_datfisc
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_entities).

    LOOP AT lt_entities INTO DATA(ls_entity).
      " Llamar al RFC
      call_rfc_function(
        EXPORTING
          iv_input_param  = ls_entity-inputparam
        IMPORTING
          ev_output_param = DATA(lv_output)
*          ev_return_code  = DATA(lv_return_code)
*          ev_message      = DATA(lv_message)
      ).

      " Preparar resultado
*      APPEND VALUE #(
**        client      = ls_entity-client
**        %key        = ls_entity-%key
**        output_param = lv_output
**        return_code  = lv_return_code
**        message      = lv_message
**        processed_at = utclong_current( )
*      ) TO result.
     APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fs_result>).
     <fs_result>-InputParam = 'test'.
   ENDLOOP.
  ENDMETHOD.

  METHOD call_rfc_function.
    DATA t_datfisc TYPE STANDARD TABLE OF zstfi_datfisc.
    DATA e_messa TYPE zdemessa.



    " Aquí llamas a tu RFC real
    CALL FUNCTION 'ZFM_DATFISC'
      EXPORTING
        t_datfisc = t_datfisc
      IMPORTING
        e_messa   = e_messa.

    ev_output_param = 'test'.

*    IF sy-subrc <> 0.
*      ev_return_code = 'E'.
*      ev_message = |Error calling RFC: { sy-subrc }|.
*    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_Z_I_RFC_DATFISC DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_Z_I_RFC_DATFISC IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
