CLASS zcl_http_serv_crp_journal_deta DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_crp_journal_deta IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.
    DATA l_dat TYPE zst_eina_lifnr.
    DATA: lv_company    TYPE bukrs,
          lv_doc_number TYPE belnr_d,
          lv_year       TYPE gjahr,
          lv_tipo       TYPE koart.
    DATA: t_journal_doc_rel     TYPE ztt_zcrp_journal_doc_rel,
          t_journal_doc_rel_imp TYPE ztt_zcrp_journal_doc_rel_imp,
          e_journal_detail      TYPE zst_zcrp_journal_detail.

    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS:
      <data>        TYPE data,
      <results>     TYPE any,
      <structure>   TYPE any,
      <table>       TYPE ANY TABLE,
      <field>       TYPE any,
      <field_value> TYPE data.

    "Obtenemos el json
    DATA(lv_json) = request->get_text( ).

    "Convertimos el json a una tabla interna
    CALL METHOD /ui2/cl_json=>deserialize
      EXPORTING
        json         = lv_json
        pretty_name  = /ui2/cl_json=>pretty_mode-user
        assoc_arrays = abap_true
      CHANGING
        data         = lr_data.

    IF lr_data IS BOUND.
      ASSIGN lr_data->* TO <data>.
      ASSIGN COMPONENT 'COMPANY' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_company = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'DOC_NUMBER' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_doc_number = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'YEAR' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_year = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'TIPO' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_tipo = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
    ENDIF.

    CALL FUNCTION 'ZFIGLMX_CRP_JOURNAL_DETAIL'
      EXPORTING
        i_company             = lv_company
        i_doc_number          = lv_doc_number
        i_year                = lv_year
        i_tipo                = lv_tipo
      IMPORTING
        t_journal_doc_rel     = t_journal_doc_rel
        t_journal_doc_rel_imp = t_journal_doc_rel_imp
        e_journal_detail      = e_journal_detail.

    "Convertimos el resultado en json
    DATA(lv_json1) = /ui2/cl_json=>serialize(
            data        = t_journal_doc_rel
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).

    DATA(lv_json2) = /ui2/cl_json=>serialize(
      data        = t_journal_doc_rel_imp
      pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
      compress    = abap_false                            " Pretty print
    ).

    DATA(lv_json3) = /ui2/cl_json=>serialize(
      data        = e_journal_detail
      pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
      compress    = abap_false                            " Pretty print
    ).

     response->set_text( lv_json1 && lv_json2 && lv_json3 ).

  ENDMETHOD.
ENDCLASS.
