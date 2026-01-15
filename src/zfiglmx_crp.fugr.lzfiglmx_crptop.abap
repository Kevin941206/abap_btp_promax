FUNCTION-POOL ZFIGLMX_CRP.                  "MESSAGE-ID ..

DATA: ztasd_fact_uuid TYPE ztt_fact_uuid.

TYPES :

*Fi Document header information

  BEGIN OF ty_fi_hd,
    bukrs TYPE zst_bkpf-bukrs,
    belnr TYPE zst_bkpf-belnr,
    gjahr TYPE zst_bkpf-gjahr,
    bktxt TYPE zst_bkpf-bktxt,
  END OF ty_fi_hd,

  BEGIN OF ty_fi_item ,
      bukrs TYPE zst_bseg-bukrs,
      belnr TYPE zst_bseg-belnr,
      gjahr TYPE zst_bseg-gjahr,
      buzei TYPE zst_bseg-buzei,
      buzid TYPE zst_bseg-buzid,
      augbl TYPE zst_bseg-augbl,
      koart TYPE zst_bseg-koart,
      shkzg TYPE zst_bseg-shkzg,
      mwskz TYPE zst_bseg-mwskz,
      dmbtr TYPE zst_bseg-dmbtr,
      wrbtr TYPE zst_bseg-wrbtr,
      sgtxt TYPE zst_bseg-sgtxt,
      xcpdd TYPE zst_bseg-xcpdd,
      hkont TYPE zst_bseg-hkont,
      kunnr TYPE zst_bseg-kunnr,
      lifnr TYPE zst_bseg-lifnr,
      xzahl TYPE zst_bseg-xzahl,
      zlsch TYPE zst_bseg-zlsch,
      rebzg TYPE zst_bseg-rebzg,
      stceg TYPE zst_bseg-stceg,
      vptnr TYPE zst_bseg-vptnr,
  END OF ty_fi_item.

DATA: lt_fi_hd       TYPE TABLE OF ty_fi_hd,
      lt_fi_item     TYPE TABLE OF ty_fi_item,
      lt_fi_hd_tmp   TYPE TABLE OF ty_fi_hd.

DATA: ls_fi_hd   TYPE ty_fi_hd,
      ls_fi_item TYPE ty_fi_item,
      ls_skb1    TYPE ztt_skb1,
      ls_crp_aa  TYPE zst_zfiglmx_crp_aa.

* INCLUDE LZFIGLMX_CRPD...                   " Local class definition
INCLUDE LZFIGLMX_CRPF00.
