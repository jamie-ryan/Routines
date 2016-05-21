pro bash2idl, inputargs
;pro test, other_args
;  compile_opt strictarr

;  args = command_line_args(count=nargs)

;  help, nargs
;  if (nargs gt 0L) then print, args

;  help, other_args
;  if (n_elements(other_args) gt 0L) then print, other_args
;end

;Call it from the command line in either of the following two ways:

;Desktop$ idl -e "test" -args $MODE
;IDL Version 8.2, Mac OS X (darwin x86_64 m64). (c) 2012, Exelis Visual Information Solutions, Inc.
;Installation number: 216855.
;Licensed for use by: Tech-X Corporation

;% Compiled module: TEST.
;NARGS           LONG      =            1
;test
;OTHER_ARGS      UNDEFINED = <Undefined>
;Desktop$ idl -e "test, '$MODE'"
;IDL Version 8.2, Mac OS X (darwin x86_64 m64). (c) 2012, Exelis Visual Information Solutions, Inc.
;Installation number: 216855.
;Licensed for use by: Tech-X Corporation

;% Compiled module: TEST.
;NARGS           LONG      =            0
;OTHER_ARGS      STRING    = 'test'
;test
print, 'It seems to have worked! '+inputargs+'!!!'
end
