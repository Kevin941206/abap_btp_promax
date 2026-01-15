CLASS zcl_http_serv_zget_transp_liq DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_zget_transp_liq IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.
    DATA tdlnr TYPE STANDARD TABLE OF zst_eina_lifnr.
    DATA l_dat TYPE zst_eina_lifnr.
    DATA: lv_tpbez      TYPE text20,
          lv_tknum      TYPE char10,
          lv_fknum      TYPE char10,
          lv_lblni      TYPE char10,
          lv_signi      TYPE text20,
          lv_tipo_flete TYPE c,
          message       TYPE bapi_msg,
          transp        TYPE ztt_zsd_transp.

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
      ASSIGN COMPONENT 'TPBEZ' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_tpbez = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'TKNUM' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_tknum = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'FKNUM' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_fknum = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'LBLNI' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_lblni = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'SIGNI' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_signi = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'TIPO_FLETE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_tipo_flete = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'TDLNR' OF STRUCTURE <data> TO <results>.
      ASSIGN <results>->* TO <table>.

      LOOP AT <table> ASSIGNING <structure>.
        ASSIGN <structure>->* TO <data>.

        ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          l_dat-lifnr = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        APPEND l_dat TO tdlnr.
        CLEAR l_dat.
      ENDLOOP.
    ENDIF.

    CALL FUNCTION 'ZGET_TRANSP_LIQ'
      EXPORTING
        tpbez      = lv_tpbez
        tknum      = lv_tknum
        fknum      = lv_fknum
        lblni      = lv_lblni
        signi      = lv_signi
        tipo_flete = lv_tipo_flete
        tdlnr      = tdlnr
      IMPORTING
        message    = message
        transp     = transp.

    "Convertimos el resultado en json
    DATA(lv_json1) = /ui2/cl_json=>serialize(
            data        = message
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
            compress    = abap_false                            " Pretty print
          ).
    IF transp IS NOT INITIAL.
      DATA(lv_json2) = /ui2/cl_json=>serialize(
               data        = transp
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
             ).

             response->set_text( lv_json1 && lv_json2 ).
    ENDIF.

    response->set_text( lv_json1 ).

  ENDMETHOD.
ENDCLASS.
