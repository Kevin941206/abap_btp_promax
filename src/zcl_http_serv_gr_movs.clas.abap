class ZCL_HTTP_SERV_GR_MOVS definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HTTP_SERV_GR_MOVS IMPLEMENTATION.


  METHOD IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <field_value> TYPE data.

    DATA: vendor    TYPE elifn,
          company   TYPE bukrs,
          po_number TYPE ebeln,
          grs_sdate TYPE ebeln,
          grs_edate TYPE ebeln,
          language  TYPE sy-langu,
          message   TYPE zchar255,
          grs_movs  TYPE ztt_grs_movs.

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
      ASSIGN COMPONENT 'VENDOR' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        vendor = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.
      ASSIGN COMPONENT 'COMPANY' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        company = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'PO_NUMBER' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        po_number = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'GRS_SDATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        grs_sdate = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'GRS_EDATE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        grs_edate  = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'LANGUAGE' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        language = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

    ENDIF.

    IF vendor IS NOT INITIAL.

      CLEAR: grs_movs.

      CALL FUNCTION 'ZVTS_GR_MOVS'
        EXPORTING vendor    = vendor
                  company   = company
                  po_number = po_number
                  grs_sdate = grs_sdate
                  grs_edate = grs_edate
                  language  = language
        IMPORTING message   = message
                  grs_movs  = grs_movs.

      "Convertimos el resultado en json
      lv_json = /ui2/cl_json=>serialize(
               data        = grs_movs " ztt_grs_detail
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
               ).

      response->set_text( lv_json ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
