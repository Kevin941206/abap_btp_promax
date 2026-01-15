FUNCTION-POOL ZSALES_DOCUMENT.              "MESSAGE-ID ..


TYPES: BEGIN OF ty_cust,
    vbeln TYPE vbeln_va,
    kunnr TYPE kunnr,
    waerk TYPE waerk,
   END OF ty_cust.

TYPES: BEGIN OF ty_vbak,
    vbeln TYPE vbeln_va, " vbak-vbeln,
    erdat TYPE erdat, "vbak-erdat,
    waerk TYPE waerk, "vbak-waerk,
    vkorg TYPE vkorg, "vbak-vkorg,
    vtweg TYPE vtweg, "vbak-vtweg,
    spart TYPE spart, "vbak-spart,
    kunnr TYPE kunnr, "vbak-kunnr,
   END OF ty_vbak.

TYPES: BEGIN OF ty_likp,
    vbeln TYPE vbeln_va, "likp-vbeln,
    erdat TYPE erdat, "likp-erdat,
    bzirk TYPE zbzirk, "likp-bzirk,
    vstel TYPE zvstel, "likp-vstel,
    vkorg TYPE vkorg, "likp-vkorg,
    kunnr TYPE kunnr, "likp-kunnr,
    waerk TYPE waerk, "likp-waerk,
   END OF ty_likp.

TYPES: BEGIN OF ty_vbrk,
    vbeln TYPE vbeln_va, "vbrk-vbeln,
    waerk TYPE waerk, "vbrk-waerk,
    vkorg TYPE vkorg, "vbrk-vkorg,
    bzirk TYPE zbzirk, "vbrk-bzirk,
    erdat TYPE erdat, "vbrk-erdat,
    kunrg TYPE kunrg, "vbrk-kunrg,
   END OF ty_vbrk.

TYPES: BEGIN OF ty_knvv,
    kunnr TYPE kunnr, "knvv-kunnr,
    vkorg TYPE vkorg, "knvv-vkorg,
    vtweg TYPE vtweg, "knvv-vtweg,
    spart TYPE spart, "knvv-spart,
    bzirk TYPE zbzirk, "knvv-bzirk,
   END OF ty_knvv.

TYPES: BEGIN OF ty_vbap,
    vbeln  TYPE vbeln_va, "vbap-vbeln,
    posnr  TYPE posnr, "vbap-posnr,
    matnr  TYPE matnr, "vbap-matnr,
    arktx  TYPE arktx, "vbap-arktx,
    kwmeng TYPE kwmeng, "vbap-kwmeng,
    vrkme  TYPE vrkme, "vbap-vrkme,
    netwr  TYPE p LENGTH 15 DECIMALS 2, "vbap-netwr,
    waerk  TYPE waerk, "vbap-waerk,
    vstel  TYPE zvstel, "vbap-vstel,
    prctr  TYPE prctr, "vbap-prctr,    "LLUNA 28.01.2019
    mwsbp  TYPE p LENGTH 13 DECIMALS 2, "vbap-mwsbp,    "LLUNA 23.03.2020
  END OF ty_vbap.

TYPES: BEGIN OF ty_lips,
    vbeln  TYPE vbeln_va, "lips-vbeln,
    posnr  TYPE posnr, "lips-posnr,
    erdat  TYPE erdat, "lips-erdat,
    matnr  TYPE matnr, "lips-matnr,
    arktx  TYPE arktx, "lips-arktx,
    lfimg  TYPE p LENGTH 13 DECIMALS 3, "lips-lfimg,
    vrkme  TYPE vrkme, "lips-vrkme,
    netwr  TYPE p LENGTH 15 DECIMALS 2, "lips-netwr,
    prctr  TYPE prctr, "lips-prctr,    "LLUNA 28.01.2019
  END OF ty_lips.


TYPES: BEGIN OF ty_vbrp,
    vbeln  TYPE vbeln_va, "vbrp-vbeln,
    posnr  TYPE posnr, "vbrp-posnr,
    erdat  TYPE erdat, "vbrp-erdat,
    matnr  TYPE matnr, "vbrp-matnr,
    arktx  TYPE arktx, "vbrp-arktx,
    fkimg  TYPE fkimg, "vbrp-fkimg,
    vrkme  TYPE vrkme, "vbrp-vrkme,
    netwr  TYPE p LENGTH 15 DECIMALS 2, "vbrp-netwr,
    vstel  TYPE zvstel, "vbrp-vstel,
    prctr  TYPE prctr, "vbrp-prctr,    "LLUNA 28.01.2019
    mwsbp  TYPE p LENGTH 13 DECIMALS 2, "vbrp-mwsbp,    "LLUNA 23.03.2020
  END OF ty_vbrp.

TYPES:BEGIN OF ty_kna1,
  kunnr TYPE kunnr, "kna1-kunnr,
  land1 TYPE land1_gp, "kna1-land1,
  name1 TYPE name1_gp, "kna1-name1,
  name2 TYPE name2_gp, "kna1-name2,
  ort01 TYPE zort01_gp, "kna1-ort01,
  pstlz TYPE pstlz, "kna1-pstlz,
  regio TYPE regio, "kna1-regio,
  stras TYPE stras, "kna1-stras,
  telf1 TYPE telf1, "kna1-telf1,
  ort02 TYPE ort02_gp, "kna1-ort02,
  END OF ty_kna1.

*INI LDGL 25.08.2020  Shipment Info
TYPES: BEGIN OF ty_vttk,
  tknum TYPE c LENGTH 10, "vttk-tknum,
  tdlnr TYPE ztdlnr, "vttk-tdlnr,
  END OF ty_vttk.

TYPES: BEGIN OF ty_lfa1,
  lifnr TYPE lifnr, "lfa1-lifnr,
  name1 TYPE name1_gp, "lfa1-name1,
  END OF ty_lfa1.
*FIN  LDGL 25.08.2020 Shipment info


DATA: t_vbap    TYPE STANDARD TABLE OF zst_vbap, "ty_vbap,
      t_lips    TYPE STANDARD TABLE OF zst_lips, "ty_lips,
      t_vbrp    TYPE STANDARD TABLE OF zst_vbrp. "ty_vbrp.
DATA: t_docflow TYPE STANDARD TABLE OF zst_vbfa.
