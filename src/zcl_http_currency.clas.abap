class ZCL_HTTP_CURRENCY definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HTTP_CURRENCY IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    TYPES: BEGIN OF ty_langu,
             langu TYPE sy-langu,
           END OF ty_langu.

    DATA: ls_langu TYPE ty_langu.
    DATA(lv_json) = request->get_text( ).

    DATA: it_currency TYPE ztt_tcurt.

    CLEAR: ls_langu.
    "Convertimos el json a una estructura interna
    CALL METHOD /ui2/cl_json=>deserialize
      EXPORTING
        json         = lv_json
        pretty_name  = /ui2/cl_json=>pretty_mode-user
        assoc_arrays = abap_true
      CHANGING
        data         = ls_langu.

    IF ls_langu IS NOT INITIAL.

      CALL FUNCTION 'ZVTS_CURRENCY'
        EXPORTING LANGU = ls_langu-langu
        IMPORTING CURRENCY = IT_CURRENCY.

      "Convertimos el resultado en json
      lv_json = /ui2/cl_json=>serialize(
               data        = it_currency
               pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Optional: camelCase keys
               compress    = abap_false                            " Pretty print
               ).

      response->set_text( lv_json ).

   ENDIF.

  endmethod.
ENDCLASS.
