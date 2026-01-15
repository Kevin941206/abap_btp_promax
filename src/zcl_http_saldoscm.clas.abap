class ZCL_HTTP_SALDOSCM definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HTTP_SALDOSCM IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

"------------------------------------------------------------
" Declaración de referencias dinámicas y field-symbols
"------------------------------------------------------------
DATA lr_data TYPE REF TO data.

FIELD-SYMBOLS:
  <data>        TYPE data,   " Estructura raíz deserializada del JSON
  <data2>       TYPE data,   " Estructura para cada registro de ACCOUNT
  <field>       TYPE any,    " Componente dinámico
  <field_value> TYPE data,   " Valor dinámico del componente
  <table>       TYPE any,    " Para mapear tablas del JSON
  <line>        TYPE any.    " Para mapear cada registro de una tabla JSON

"------------------------------------------------------------
" Declaración de variables finales donde guardaremos los datos
"------------------------------------------------------------
DATA:
  bukrs      TYPE bukrs,
  year       TYPE gjahr,
  period     TYPE zrpmax,
  account    TYPE ztthfis_racct,   " Tabla interna final
  ls_account TYPE zhfis_racct,     " Línea de la tabla ACCOUNT
  saldos     TYPE ztt_saldoscm.    " Resultado de la función

"------------------------------------------------------------
" Obtener el JSON recibido en el request
"------------------------------------------------------------
DATA(lv_json) = request->get_text( ).

"------------------------------------------------------------
" Deserializar JSON a estructura dinámica ABAP
"------------------------------------------------------------
CALL METHOD /ui2/cl_json=>deserialize
  EXPORTING
    json         = lv_json
    pretty_name  = /ui2/cl_json=>pretty_mode-user   " Mantiene nombres tal cual vienen
    assoc_arrays = abap_true                        " Maneja arrays como tablas
  CHANGING
    data         = lr_data.

"------------------------------------------------------------
" Validar que la conversión creó una estructura
"------------------------------------------------------------
IF lr_data IS BOUND.

  ASSIGN lr_data->* TO <data>.  " Estructura raíz del JSON

  "============================================================
  " BUKRS
  "============================================================
  ASSIGN COMPONENT 'BUKRS' OF STRUCTURE <data> TO <field>.
  IF <field> IS ASSIGNED.
    lr_data = <field>.
    ASSIGN lr_data->* TO <field_value>.
    bukrs = <field_value>.
  ENDIF.
  UNASSIGN: <field>, <field_value>.

  "============================================================
  " YEAR
  "============================================================
  ASSIGN COMPONENT 'YEAR' OF STRUCTURE <data> TO <field>.
  IF <field> IS ASSIGNED.
    lr_data = <field>.
    ASSIGN lr_data->* TO <field_value>.
    year = <field_value>.
  ENDIF.
  UNASSIGN: <field>, <field_value>.

  "============================================================
  " PERIOD
  "============================================================
  ASSIGN COMPONENT 'PERIOD' OF STRUCTURE <data> TO <field>.
  IF <field> IS ASSIGNED.
    lr_data = <field>.
    ASSIGN lr_data->* TO <field_value>.
    period = <field_value>.
  ENDIF.
  UNASSIGN: <field>, <field_value>.

  "============================================================
  " ACCOUNT (TABLA DEL JSON)
  "============================================================
  ASSIGN COMPONENT 'ACCOUNT' OF STRUCTURE <data> TO <field>.
  IF <field> IS ASSIGNED.

    lr_data = <field>.
    ASSIGN lr_data->* TO <table>.   " Se asigna la tabla completa del JSON

    "------------------------------------------------------------
    " Recorrer cada registro dentro de ACCOUNT
    "------------------------------------------------------------
    LOOP AT <table> ASSIGNING <line>.
      ASSIGN <line>->* TO <data2>.  " Estructura interna de cada línea del JSON

      "------------------------------------------------------------
      " RACCT (Campo dentro de ACCOUNT)
      "------------------------------------------------------------
      ASSIGN COMPONENT 'RACCT' OF STRUCTURE <data2> TO <field>.
      IF <field> IS ASSIGNED.
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        ls_account-racct = <field_value>.
      ENDIF.
      UNASSIGN: <field>, <field_value>.

      " Agregar línea a la tabla interna final
      APPEND ls_account TO account.

    ENDLOOP.

  ENDIF.

  UNASSIGN: <field>, <line>, <table>.

ENDIF.

"------------------------------------------------------------
" Llamada a la función Z para calcular saldos contables
"------------------------------------------------------------
CALL FUNCTION 'ZHFIS_SALDOSCM'
  EXPORTING
    i_company_code = bukrs
    i_year         = year
    i_period       = period
    i_account      = account
  IMPORTING
    e_saldoscm     = saldos.

"------------------------------------------------------------
" Convertir el resultado en JSON para la respuesta REST
"------------------------------------------------------------
lv_json = /ui2/cl_json=>serialize(
            data        = saldos
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case
            compress    = abap_false
          ).

"------------------------------------------------------------
" Enviar la respuesta final al cliente
"------------------------------------------------------------
response->set_text( lv_json ).

  endmethod.
ENDCLASS.
