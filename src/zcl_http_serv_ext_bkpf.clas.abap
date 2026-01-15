class ZCL_HTTP_SERV_EXT_BKPF definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HTTP_SERV_EXT_BKPF IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
  DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <field_value> TYPE data.
    DATA: lv_bukrs TYPE bukrs,
          lv_blart TYPE blart,
          lv_fech_ini TYPE datum,
          lv_fech_fin TYPE datum,
          lv_usnam    TYPE usnam,
          lt_result TYPE zfi_tt_allx_bkpf.

    DATA(lv_json) = request->get_text( ).

    "Convertimos el json
    CALL METHOD /ui2/cl_json=>deserialize
      EXPORTING
        json         = lv_json
        pretty_name  = /ui2/cl_json=>pretty_mode-user
        assoc_arrays = abap_true
      CHANGING
        data         = lr_data.
    IF lr_data IS BOUND.
      ASSIGN lr_data->* TO <data>.
      ASSIGN COMPONENT 'BUKRS' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_bukrs = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
      ASSIGN COMPONENT 'BLART' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_blart = <field_value>.
      ENDIF.
      ASSIGN COMPONENT 'FECH_INI' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_fech_ini = <field_value>.
      ENDIF.
      ASSIGN COMPONENT 'FECH_FIN' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_fech_fin = <field_value>.
      ENDIF.
      ASSIGN COMPONENT 'USNAM' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_usnam = <field_value>.
      ENDIF.
    ENDIF.

   CALL FUNCTION 'ZALL_EXTRACTOR_BKPF'
     EXPORTING
      bukrs = lv_bukrs
      blart = lv_blart
      fech_ini = lv_fech_ini
      fech_fin = lv_fech_fin
      usnam = lv_usnam
     IMPORTING
      tab_result = lt_result.

    "Convertimos el resultado en json
    lv_json = /ui2/cl_json=>serialize(
             data        = lt_result
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).

    response->set_text( lv_json ).
  endmethod.
ENDCLASS.
