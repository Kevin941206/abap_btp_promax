*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZFIGLMX_CRP_AA..................................*
*TYPES  BEGIN OF status_zfiglmx_crp_aa                .   "state vector
*         INCLUDE STRUCTURE zst_vimstatus.
*DATA:  END OF status_zfiglmx_crp_aa                .
*CONTROLS: TCTRL_ZFIGLMX_CRP_AA
*            TYPE TABLEVIEW USING SCREEN '0002'.
*.........table declarations:.................................*
*DATA: zfiglmx_crp_aa TYPE ztt_zfiglmx_crp_aa.              .

* general table data declarations..............
*INCLUDE lsvimtdt                                .
