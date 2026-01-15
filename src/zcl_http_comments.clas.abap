CLASS zcl_http_comments DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_comments IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    "------------------------------------------------------------
    " Declaración de estructuras dinámicas y field-symbols
    "------------------------------------------------------------
    DATA lr_data TYPE REF TO data.

    FIELD-SYMBOLS:
      <data>        TYPE data,   " Estructura completa del JSON deserializado
      <field>       TYPE any,    " Campo dinámico para acceder a componentes
      <field_value> TYPE data.   " Valor del componente dinámico

    "------------------------------------------------------------
    " Variables donde se guardarán los datos extraídos del JSON
    "------------------------------------------------------------
    DATA:
      ebeln       TYPE ebeln,
      langu       TYPE langu,
      comentarios TYPE char255,
      message     TYPE char255.

    "------------------------------------------------------------
    " Obtener JSON enviado en el request del servicio
    "------------------------------------------------------------
    DATA(lv_json) = request->get_text( ).

    "------------------------------------------------------------
    " Deserializar JSON → estructura dinámica ABAP
    "------------------------------------------------------------
    CALL METHOD /ui2/cl_json=>deserialize
      EXPORTING
        json         = lv_json
        pretty_name  = /ui2/cl_json=>pretty_mode-user  " Mantiene los nombres tal como vienen en el JSON
        assoc_arrays = abap_true                       " Maneja arreglos como tablas
      CHANGING
        data         = lr_data.

    "------------------------------------------------------------
    " Extraer dinámicamente el campo EBELN del JSON
    "------------------------------------------------------------
    IF lr_data IS BOUND.

      " Asigna la estructura raíz del JSON al field-symbol <data>
      ASSIGN lr_data->* TO <data>.

      " Busca el componente 'EBELN' dentro de la estructura JSON
      ASSIGN COMPONENT 'EBELN' OF STRUCTURE <data> TO <field>.

      IF <field> IS ASSIGNED.
        " Obtiene el valor real almacenado en el componente EBELN
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        ebeln = <field_value>.  " Se copia el valor a la variable final
      ENDIF.

      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'COMENTARIOS' OF STRUCTURE <data> TO <field>.

      IF <field> IS ASSIGNED.
        " Obtiene el valor real almacenado en el componente EBELN
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        comentarios = <field_value>.  " Se copia el valor a la variable final
      ENDIF.

      UNASSIGN: <field>, <field_value>.

      ASSIGN COMPONENT 'LANGU' OF STRUCTURE <data> TO <field>.

      IF <field> IS ASSIGNED.
        " Obtiene el valor real almacenado en el componente EBELN
        lr_data = <field>.
        ASSIGN lr_data->* TO <field_value>.
        langu = <field_value>.  " Se copia el valor a la variable final
      ENDIF.

      UNASSIGN: <field>, <field_value>.
    ENDIF.

    "------------------------------------------------------------
    " Llamada a la función Z que procesa los comentarios de la orden
    "------------------------------------------------------------
    CALL FUNCTION 'ZVTS_COMMENTS'
      EXPORTING
        ebeln       = ebeln           " Número de orden (extraído del JSON)
        comentarios = comentarios     " Comentarios recibidos
        langu       = langu           " Idioma
      IMPORTING
        message     = message.        " Respuesta del módulo funcional

    "------------------------------------------------------------
    " Convertir la respuesta a JSON para el servicio REST
    "------------------------------------------------------------
    lv_json = /ui2/cl_json=>serialize(
                data        = message
                pretty_name = /ui2/cl_json=>pretty_mode-camel_case  " Llaves en camelCase
                compress    = abap_false                            " Formato legible (no comprimido)
              ).

    "------------------------------------------------------------
    " Enviar la respuesta al cliente
    "------------------------------------------------------------
    response->set_text( lv_json ).


  ENDMETHOD.
ENDCLASS.
