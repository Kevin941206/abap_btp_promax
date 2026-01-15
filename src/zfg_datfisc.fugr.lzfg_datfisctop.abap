FUNCTION-POOL zfg_datfisc.                  "MESSAGE-ID ..

* INCLUDE LZFG_DATFISCD...                   " Local class definition

* Tablas internas
DATA: i_datfisc TYPE STANDARD TABLE OF ztfi_pidatfisc,
      w_datfisc LIKE LINE OF i_datfisc,
      lv_texto  TYPE ztdline.    "JFMP 08.06.20 Texto a guardar
