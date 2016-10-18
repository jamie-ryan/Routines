;+
;==========================================================================================
; PROGRAM:  HSI_SPECTRUM_FITSPASTE
; DESCRIPTION:  This procedure is the driver for spectrum fitspaste classes.  It
;               instantiates hsi_spectrum_fitspaste_specinfo class and calls its member
;               functions to read the two spectral files to be combined, perform sanity
;               checks on the files and then paste them together.
;               NOTE:  The two files must contain at least three extensions - "RATE",
;                      "ENEBAND"/"EBOUNDS", and "HESSI SPECTRAL OBJECT PARAMETES".  The
;                      times in RATE extension must not overlap.  If they do, the program
;                      will issue an error message and stop.  The ENEBAND/EBOUNDS extension
;                      must contain identical boundaries.
;                      For "HESSI SPECTRAL OBJECT PARAMETES", it checks for the existance
;                      and values of the following parameters:
;                         SP_ENERGY_BINNING, SP_DATA_UNIT, SP_ERROR_OUT, DET_INDEX_MASK,
;                         PILEUP_CORRECT, PILEUP_THRESHOLD, PILEUP_TWEAK, COINCIDENCE_FLAG,
;                         OTHER_A2D_INDEX_MASK, SEG_INDEX_MASK, LIVETIME_ENABLE, SUM_FLAG,
;                         SUM_COINCIDENCE, SP_DP_CUTOFF, DECIMATION_CORRECT
;
;
; CALLING SEQUENCE:  hsi_spectrum_fitspaste, firstFile, secondFile, outFile
; INPUT:
;     FIRSTFILE:               Name of the first spectral file
;     SECONDFILE:              Name of the second spectral file
;     OUTFILE:                 Name of the file containing pasted spectra
;
; OUTPUT:
;     File containing two pasted spectra.
;
; WRITTEN BY:  Sandhia Bansal - 02/24/05
; MODIFICATION HISTORY:
; NAME           DATE        DESCRIPTION
;
;==========================================================================================
;-
PRO hsi_spectrum_fitspaste, firstFile, secondFile, outfile

;
; Make sure that the two files exist.
;
if ((f=file_exist(firstFile)) and (s=file_exist(secondFile))) then begin
   ;
   ; Instantiate an object to store program generated messages
   ;
   pMsgList = OBJ_NEW('hsi_spectrum_fitspaste_message_list')
   pMsgList->initialize

   ;
   ; Instantiate a specinfo object for the first file and call its read method.
   ;
   specObj1 = OBJ_NEW('hsi_spectrum_fitspaste_specinfo')
   specObj1->setFilename, firstFile
   status = specObj1->read(pMsgList)
   if (not specObj1->validSpectrum(pMsgList)) then return
   if (status ne 0) then return

   ;
   ; Instantiate a specinfo object for the second file and read it by calling its
   ;     read method.
   ;
   specObj2 = OBJ_NEW('hsi_spectrum_fitspaste_specinfo')
   specObj2->setFilename, secondFile
   status = specObj2->read(pMsgList)

   if (not specObj2->validSpectrum(pMsgList)) then return
   if (status ne 0) then return

   ;
   ; Validate the spectra
   ;
   ;
   ; Perform sanity checks on the two files and if they pass the tests, paste them
   ;    together.  The sanity checks include making sure that the two files have
   ;    all required extensions, don't overlap in time, match in energy boundaries
   ;     and have same values for the selected control parameters.
   ;
   if (specObj1->canbePasted(specObj2, pMsgList)) then begin
      specObj1->combine, specObj2, pMsgList, outfile=outfile

      pMsgList->appendMessage, 'Combined spectrum is written to file: ' + outfile, /noerr
      pMsgList->printInfo
   endif

   ;
   ; Cleanup
   ;
   obj_destroy, specObj1
   obj_destroy, specObj2
   obj_destroy, pMsgList
endif else begin
   if (f eq 0) then $
      print, firstFile + ' cannot be found.'
   if (s eq 0) then $
      print, secondFile + ' cannot be found.'
endelse


END
