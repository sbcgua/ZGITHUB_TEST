*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZGITHUB_FUGR_TM
*   generation date: 02.10.2016 at 17:05:56
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZGITHUB_FUGR_TM    .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
