CLASS zcl_http_serv_compenf_47 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_compenf_47 IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS:
      <data>        TYPE data,
      <results>     TYPE any,
      <structure>   TYPE any,
      <table>       TYPE ANY TABLE,
      <field>       TYPE any,
      <field_value> TYPE data.

    DATA: lv_credt  TYPE datum,
          lv_credt_c TYPE c LENGTH 10,
          lv_bukrs  TYPE bukrs,
          lv_lifnr  TYPE lifnr,
          lv_impor  TYPE zdeimpor,
          lv_vendt  TYPE datum,
          lv_vendt_c TYPE c LENGTH 10,
          lv_refer  TYPE zxblnr1,
          lv_texto  TYPE bktxt,
          lv_idedi  TYPE zdeidedi,
          lv_idedi_c TYPE c LENGTH 10,
          ls_output TYPE zst_compenf_47_out.

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

      ASSIGN COMPONENT 'I_CREDT' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_credt_c = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'I_BUKRS' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_bukrs = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'I_LIFNR' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_lifnr = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'I_IMPOR' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_impor = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'I_VENDT' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_vendt_c = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'I_REFER' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_refer = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'I_TEXTO' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_texto = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'I_IDEDI' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_idedi_c = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
    ENDIF.

    lv_credt = lv_credt_c+6(4) && lv_credt_c+3(2) && lv_credt_c(2).
    lv_vendt = lv_vendt_c+6(4) && lv_vendt_c+3(2) && lv_vendt_c(2).
    lv_idedi = lv_idedi_c+6(4) && lv_idedi_c+3(2) && lv_idedi_c(2).

    CALL FUNCTION 'ZFM_COMPENF_47'
      EXPORTING
        i_credt  = lv_credt
        i_bukrs  = lv_bukrs
        i_lifnr  = lv_lifnr
        i_impor  = lv_impor
        i_vendt  = lv_vendt
        i_refer  = lv_refer
        i_texto  = lv_texto
        i_idedi  = lv_idedi
      IMPORTING
        e_belnr  = ls_output-belnr
        e_credt  = ls_output-credt
        e_vendt  = ls_output-vendt
        e_idedi  = ls_output-idedi
        t_return = ls_output-return.

    "Convertimos el resultado en json
      lv_json = /ui2/cl_json=>serialize(
               data        = ls_output
               pretty_name = /ui2/cl_json=>pretty_mode-low_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
             ).

    response->set_text( lv_json ).

  ENDMETHOD.
ENDCLASS.
