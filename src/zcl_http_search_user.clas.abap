class ZCL_HTTP_SEARCH_USER definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HTTP_SEARCH_USER IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


"------------------------------------------------------------
" Declaración de estructuras dinámicas y field-symbols
"------------------------------------------------------------
DATA lr_data TYPE REF TO data.

FIELD-SYMBOLS:
  <data>        TYPE data,   " Contendrá la estructura completa del JSON deserializado
  <field>       TYPE any,    " Para acceder dinámicamente a los campos del JSON
  <field_value> TYPE data.   " Valor del campo dinámico

"------------------------------------------------------------
" Variables donde se guardarán los datos extraídos del JSON
"------------------------------------------------------------
DATA:
  user    TYPE uname,
  name1   TYPE char30,
  name2   TYPE char30,
  email   TYPE zemail,
  message TYPE char100.

"------------------------------------------------------------
" Obtener el JSON enviado desde la petición REST
"------------------------------------------------------------
DATA(lv_json) = request->get_text( ).

"------------------------------------------------------------
" Deserializar el JSON → estructura dinámica ABAP
"------------------------------------------------------------
CALL METHOD /ui2/cl_json=>deserialize
  EXPORTING
    json         = lv_json
    pretty_name  = /ui2/cl_json=>pretty_mode-user   " Mantiene nombres tal como vienen en el JSON
    assoc_arrays = abap_true                        " Maneja arreglos como tablas
  CHANGING
    data         = lr_data.

"------------------------------------------------------------
" Extraer dinámicamente el campo USER del JSON
"------------------------------------------------------------
IF lr_data IS BOUND.

  " Asigna la estructura raíz del JSON al field-symbol <data>
  ASSIGN lr_data->* TO <data>.

  " Busca el componente 'USER' dentro del JSON
  ASSIGN COMPONENT 'USER' OF STRUCTURE <data> TO <field>.

  IF <field> IS ASSIGNED.
    " Obtiene el valor almacenado en USER
    lr_data = <field>.
    ASSIGN lr_data->* TO <field_value>.
    user = <field_value>.
  ENDIF.

  UNASSIGN: <field>, <field_value>.
ENDIF.

"------------------------------------------------------------
" Llamada a la función Z para obtener los datos del usuario
"------------------------------------------------------------
CALL FUNCTION 'ZVTS_SEARCH_USER'
  EXPORTING
    user    = user
  IMPORTING
    name1   = name1
    name2   = name2
    email   = email
    message = message.

"------------------------------------------------------------
" Convertir cada resultado a JSON por separado
" * Nota: tu lógica hace concatenación de 4 JSON independientes
"------------------------------------------------------------
DATA(lv_json_name1) = /ui2/cl_json=>serialize(
                        data        = name1
                        pretty_name = /ui2/cl_json=>pretty_mode-camel_case
                        compress    = abap_false
                      ).

DATA(lv_json_name2) = /ui2/cl_json=>serialize(
                        data        = name2
                        pretty_name = /ui2/cl_json=>pretty_mode-camel_case
                        compress    = abap_false
                      ).

DATA(lv_json_email) = /ui2/cl_json=>serialize(
                        data        = email
                        pretty_name = /ui2/cl_json=>pretty_mode-camel_case
                        compress    = abap_false
                      ).

DATA(lv_json_message) = /ui2/cl_json=>serialize(
                          data        = message
                          pretty_name = /ui2/cl_json=>pretty_mode-camel_case
                          compress    = abap_false
                        ).

"------------------------------------------------------------
" Enviar la concatenación de todos los JSONs como respuesta
"------------------------------------------------------------
response->set_text(
  lv_json_name1 &&
  lv_json_name2 &&
  lv_json_email &&
  lv_json_message
).
  endmethod.
ENDCLASS.
