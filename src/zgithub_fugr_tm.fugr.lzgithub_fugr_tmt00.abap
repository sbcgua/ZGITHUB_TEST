*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZGITHUB_TABL....................................*
DATA:  BEGIN OF STATUS_ZGITHUB_TABL                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZGITHUB_TABL                  .
CONTROLS: TCTRL_ZGITHUB_TABL
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZGITHUB_TABL                  .
TABLES: ZGITHUB_TABL                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
