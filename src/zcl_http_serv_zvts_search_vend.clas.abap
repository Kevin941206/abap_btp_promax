CLASS zcl_http_serv_zvts_search_vend DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_zvts_search_vend IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.
    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS: <data>        TYPE data,
                   <field>       TYPE any,
                   <field_value> TYPE data.

    DATA: vtt_vendor TYPE ztt_zvts_vendor,
          lv_vendor  TYPE zst_lfa1-lifnr,
          lv_name    TYPE zst_lfb1-intad.

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
        lv_vendor = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'NAME' OF STRUCTURE <data> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        lv_name = <field_value>.
      ENDIF.
    ENDIF.

    CALL FUNCTION 'ZVTS_SEARCH_VENDOR'
      IMPORTING
        vtt_vendor = vtt_vendor
      CHANGING
        name       = lv_name
        vendor     = lv_vendor.

    "Convertimos el resultado en json
    lv_json = /ui2/cl_json=>serialize(
             data        = vtt_vendor
             pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
             compress    = abap_false                            " Pretty print
           ).

    response->set_text( lv_json ).
  ENDMETHOD.
ENDCLASS.
