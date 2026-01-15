CLASS zcl_http_serv_vendor DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_vendor IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA lr_data TYPE REF TO data.
    FIELD-SYMBOLS:
      <data>        TYPE data,
      <results>     TYPE any,
      <structure>   TYPE any,
      <table>       TYPE ANY TABLE,
      <field>       TYPE any,
      <field_value> TYPE data.

    DATA: lt_load_vendor TYPE ztt_load_vendor,
          ls_load_vendor TYPE zload_vendor,
          lv_vendor      TYPE lifnr,
          lv_message     TYPE char256.

    "Obtenemos el json
    DATA(lv_json) = request->get_text( ).

    "Convertimos el json a una tabla interna
    CALL METHOD /ui2/cl_json=>deserialize
      EXPORTING
        json         = lv_json
        pretty_name  = /ui2/cl_json=>pretty_mode-user
        assoc_arrays = abap_true
      CHANGING
        data         = lt_load_vendor.

    IF lt_load_vendor IS NOT INITIAL.
      CALL FUNCTION 'ZVTS_VENDOR'
        EXPORTING
          load_vendor = lt_load_vendor
        IMPORTING
          vendor      = lv_vendor
          message     = lv_message.

      "Convertimos el resultado en json
      lv_json = /ui2/cl_json=>serialize(
               data        = lv_vendor
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
             ).
      DATA(lv_json2) = /ui2/cl_json=>serialize(
               data        = lv_message
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
             ).

      response->set_text( lv_json && lv_json2 ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
