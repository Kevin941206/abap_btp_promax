class ZCL_HTTP_SERV_CARGA_DIR definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HTTP_SERV_CARGA_DIR IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    DATA lr_data  TYPE REF TO data.
    DATA lr_data2 TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <results>     TYPE any,
                   <structure>   TYPE any,
                   <table>       TYPE ANY TABLE,
                   <field_value> TYPE data.

    DATA: FECHA TYPE BLDAT,
          SOCIEDAD TYPE BUKRS,
          TIPODOC TYPE BLART,
          MONTO TYPE WRBTR,
          CUENTA TYPE LIFNR,
          REFERENCIA TYPE ZCHAR16,
          UID TYPE ZCHAR50,
          ID_BOVEDA TYPE ZCHAR25,
          VIA TYPE ZCHAR01,
          PLANTA TYPE DZUONR,
          RFC TYPE STCD1,
          DOCUMENT TYPE EBELN,
          BASE_RET TYPE WRBTR,
          IMP_RET TYPE WRBTR,
          CARGOS TYPE ZTT_CARGA_DIR,
          DOCTO TYPE BELNR_D,
          EJER_FIS TYPE GJAHR,
          MESSAGE TYPE CHAR100.

    DATA: IT_CARGOS TYPE ZTT_CARGA_DIR,
          WA_CARGOS LIKE LINE OF IT_CARGOS.

    DATA(lv_json) = request->get_text( ).
    DATA(lv_json2) = request->get_text( ).
    DATA(lv_json3) = request->get_text( ).

    CALL METHOD /ui2/cl_json=>deserialize
      EXPORTING
        json         = lv_json
        pretty_name  = /ui2/cl_json=>pretty_mode-user
        assoc_arrays = abap_true
      CHANGING
        data         = lr_data.

    IF lr_data IS BOUND.
      ASSIGN lr_data->* TO <data>.
      ASSIGN COMPONENT 'FECHA' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        fecha = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'SOCIEDAD' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        sociedad = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'TIPODOC' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        tipodoc = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'MONTO' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        monto = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'CUENTA' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        cuenta = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'REFERENCIA' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        referencia = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'UID' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        uid = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'ID_BOVEDA' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        id_boveda = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'VIA' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        via = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'PLANTA' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        planta = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'RFC' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        rfc = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'DOCUMENT' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        document = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'BASE_RET' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        base_ret = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'IMP_RET' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        imp_ret = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.


******************************************************************************************

*      ASSIGN lr_data->* TO <data>.
      ASSIGN COMPONENT 'CARGOS' OF STRUCTURE <data> TO <results>.

      ASSIGN <results>->* TO <table>.

      LOOP AT <table> ASSIGNING <structure>.
        ASSIGN <structure>->* TO <data>.

        ASSIGN COMPONENT 'MOV' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          wa_cargos-mov = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'CUENTA' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          wa_cargos-cuenta = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'IMPORTE' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          wa_cargos-importe = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'MONEDA' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          wa_cargos-moneda = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'IVA' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          wa_cargos-iva = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'CENCO' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          wa_cargos-cenco = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        ASSIGN COMPONENT 'TEXTO' OF STRUCTURE <data> TO <field>.
        IF <field> IS ASSIGNED.
          lr_data = <field>.
          ASSIGN lr_data->* TO <field_value>.
          wa_cargos-texto = <field_value>.
        ENDIF.
        UNASSIGN: <field>, <field_value>.

        APPEND wa_cargos TO cargos.
        CLEAR wa_cargos.
      ENDLOOP.

    ENDIF.

*    IF lr_data IS BOUND.
*      ASSIGN lr_data->* TO <data>.
*      ASSIGN COMPONENT 'CARGOS' OF STRUCTURE <data> TO <results>.
*      ASSIGN <results>->* TO <table>.
*
*      LOOP AT <table> ASSIGNING <structure>.
*        ASSIGN <structure>->* TO <data>.
*
*        ASSIGN COMPONENT 'MOV' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_cargos-mov = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'CUENTA' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_cargos-cuenta = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'IMPORTE' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_cargos-importe = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'MONEDA' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_cargos-moneda = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'IVA' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_cargos-iva = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'CENCO' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_cargos-cenco = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        ASSIGN COMPONENT 'TEXTO' OF STRUCTURE <data> TO <field>.
*        IF <field> IS ASSIGNED.
*          lr_data = <field>.
*          ASSIGN lr_data->* TO <field_value>.
*          wa_cargos-texto = <field_value>.
*        ENDIF.
*        UNASSIGN: <field>, <field_value>.
*
*        APPEND wa_cargos TO cargos.
*        CLEAR wa_cargos.
*      ENDLOOP.
*    ENDIF.





*    IF fecha IS NOT INITIAL AND sociedad IS NOT INITIAL AND tipodoc IS NOT INITIAL AND monto IS NOT INITIAL.

*      CLEAR: cargos.
*document = '0000030691'.

      CALL FUNCTION 'ZCARGA_DIR'
       EXPORTING FECHA      = fecha
                 SOCIEDAD   = sociedad
                 TIPODOC    = tipodoc
                 MONTO      = monto
                 CUENTA     = cuenta
                 REFERENCIA = referencia
                 UID        = uid
                 ID_BOVEDA  = id_boveda
                 VIA        = via
                 PLANTA     = planta
                 RFC        = rfc
                 DOCUMENT   = document
                 BASE_RET   = base_ret
                 IMP_RET    = imp_ret
                 CARGOS     = cargos
       IMPORTING DOCTO      = docto
                 EJER_FIS   = ejer_fis
                 MESSAGE    = message
                 CARGOS     = cargos.

      "Convertimos el resultado en json
      lv_json = /ui2/cl_json=>serialize(
               data        = docto " ztt_grs_detail
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
               ).

      lv_json2 = /ui2/cl_json=>serialize(
               data        = ejer_fis " ztt_grs_detail
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
               ).

      lv_json3 = /ui2/cl_json=>serialize(
               data        = message " ztt_grs_detail
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
               ).

      response->set_text( lv_json && lv_json2 && lv_json3 ).

*    ENDIF.

  ENDMETHOD.
ENDCLASS.
