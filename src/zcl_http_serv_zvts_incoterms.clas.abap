CLASS zcl_http_serv_zvts_incoterms DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_serv_zvts_incoterms IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    TYPES: BEGIN OF ty_langu,
             langu TYPE sy-langu,
           END OF ty_langu.


    DATA: langu    TYPE sy-langu,
          lr_data  TYPE REF TO data,
          inco     TYPE ztt_tinct,
          st_langu TYPE ty_langu,
          prueba   TYPE char20.
    FIELD-SYMBOLS:
      <data>    TYPE data,
      <results> TYPE any.

    "Obtenemos el json
    DATA(lv_json) = request->get_text( ).

    "Convertimos el json a una tabla interna
    CALL METHOD /ui2/cl_json=>deserialize
      EXPORTING
        json         = lv_json
        pretty_name  = /ui2/cl_json=>pretty_mode-user
        assoc_arrays = abap_true
      CHANGING
        data         = st_langu.

*    IF lr_data IS BOUND.
*      ASSIGN lr_data->* TO <data>.
*      ASSIGN COMPONENT 'LANGU' OF STRUCTURE <data> TO <results>.
*    ENDIF.

    IF st_langu-langu IS NOT INITIAL.
      CALL FUNCTION 'ZVTS_INCOTERMS'
        EXPORTING
          langu = st_langu-langu
        IMPORTING
          inco  = inco.

      "Convertimos el resultado en json
      lv_json = /ui2/cl_json=>serialize(
               data        = inco
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
             ).

      response->set_text( lv_json ).

    ENDIF.

    ENDMETHOD.
ENDCLASS.
