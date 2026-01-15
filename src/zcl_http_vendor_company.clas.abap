class ZCL_HTTP_VENDOR_COMPANY definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HTTP_VENDOR_COMPANY IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


"------------------------------------------------------------
" Declaración de variables y field-symbols dinámicos
"------------------------------------------------------------
DATA lr_data TYPE REF TO data.

FIELD-SYMBOLS:
  <data>        TYPE data,   " Estructura completa del JSON
  <field>       TYPE any,    " Campo genérico para acceder dinámicamente
  <field_value> TYPE data.   " Valor del campo dinámico

" Variables donde guardaremos los valores obtenidos del JSON
DATA:
  tax       TYPE ztt_ztax,
  lv_langu  TYPE sy-langu,
  lv_lifnr  TYPE lifnr,
  company   TYPE ztt_lfb1.

" Obtención del JSON del request
DATA(lv_json) = request->get_text( ).

"------------------------------------------------------------
" Deserialización del JSON a una estructura dinámica
"------------------------------------------------------------
CALL METHOD /ui2/cl_json=>deserialize
  EXPORTING
    json         = lv_json
    pretty_name  = /ui2/cl_json=>pretty_mode-user  " Mantiene nombres del JSON
    assoc_arrays = abap_true                      " Arrays como tablas
  CHANGING
    data         = lr_data.

"------------------------------------------------------------
" Extraer el campo LIFNR del JSON (dinámicamente)
"------------------------------------------------------------
IF lr_data IS BOUND.
  ASSIGN lr_data->* TO <data>.

  " Buscar el componente 'LIFNR' dentro de la estructura deserializada
  ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <data> TO <field>.

  IF <field> IS ASSIGNED.
    " Recuperar el valor interno del campo encontrado
    lr_data = <field>.
    ASSIGN lr_data->* TO <field_value>.
    lv_lifnr = <field_value>.
  ENDIF.

  UNASSIGN: <field>, <field_value>.
ENDIF.

"------------------------------------------------------------
" Llamar a función Z para obtener la compañía del proveedor
"------------------------------------------------------------
CALL FUNCTION 'ZVTS_VENDOR_COMPANY'
  EXPORTING
    vendor  = lv_lifnr
  IMPORTING
    company = company.

"------------------------------------------------------------
" Convertir el resultado en JSON (respuesta)
"------------------------------------------------------------
lv_json = /ui2/cl_json=>serialize(
            data        = company
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Claves en camelCase
            compress    = abap_false                            " Formato legible
          ).

" Enviar el JSON como respuesta del servicio
response->set_text( lv_json ).

  endmethod.
ENDCLASS.
