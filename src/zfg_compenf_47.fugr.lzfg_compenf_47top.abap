FUNCTION-POOL ZFG_COMPENF_47.               "MESSAGE-ID ..

  TYPES: BEGIN OF ty_bdcdata.
           INCLUDE STRUCTURE zst_bdcdata.
  TYPES: END OF ty_bdcdata.
  TYPES: BEGIN OF ty_messtab.
           INCLUDE STRUCTURE zst_bdcmsgcoll.
  TYPES: END OF ty_messtab.

* Tabla para Call Transaction
  DATA: i_bdcdata TYPE TABLE OF ty_bdcdata,
        ls_bdcdata LIKE LINE OF i_bdcdata,
        i_messtab TYPE TABLE OF ty_messtab.

* Tablas
  data: i_const type STANDARD TABLE OF ZSTFI_CONST.  "JFMP 18.05.20 Tabla de constantes
* Estructuras
  data: w_opti  type zst_CTU_PARAMS,        "Opciones call transaction
        w_const like line of i_const.   "JFMP 18.05.20

* Variables
  data: v_iva,                 "JFMP 18.05.20 Indicador para saber si en la grabación incluye este valor
        v_ktokk type ktokk,    "JFMP 19.05.20 Gpo. cuentas
        v_datum type char10,   "Fecha DD.MM.AAAA
        v_vendt type char10,   "Fecha vencimiento DD.MM.AAAA
        v_monat type monat,    "Periodo
        v_impor type c LENGTH 11.   "Importe
