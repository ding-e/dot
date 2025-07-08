scriptencoding utf-8

"https://github.com/fatih/vim-go/blob/master/syntax/go.vim

"if exists("b:current_syntax")
"  finish
"endif
"syn sync minlines=500
"let b:current_syntax = "go"

" vim: sw=2 ts=2 et

syn keyword goKeyword                  package import var const defer go goto return break continue fallthrough
syn keyword goKeyword                  if else switch select case default for range
syn keyword goKeyword                  chan map bool string error any comparable
syn keyword goKeyword                  int int8 int16 int32 int64 rune
syn keyword goKeyword                  byte uint uint8 uint16 uint32 uint64 uintptr
syn keyword goKeyword                  float32 float64 complex64 complex128
syn keyword goKeyword                  append cap clear close complex copy delete imag len
syn keyword goKeyword                  make max min new panic print println real recover
syn keyword goKeyword                  true false nil iota contained TODO FIXME XXX BUG
syn keyword goKeyword                  struct interface type
hi link goKeyword                      Keyword

syn match goDecimalInt                 "\<-\=\%(0\|\%(\d\|\d_\d\)\+\)\>"
syn match goHexadecimalInt             "\<-\=0[xX]_\?\%(\x\|\x_\x\)\+\>"
syn match goOctalInt                   "\<-\=0[oO]\?_\?\%(\o\|\o_\o\)\+\>"
syn match goBinaryInt                  "\<-\=0[bB]_\?\%([01]\|[01]_[01]\)\+\>"
hi link goDecimalInt                   Integer
hi link goHexadecimalInt               Integer
hi link goOctalInt                     Integer
hi link goBinaryInt                    Integer
hi link Integer                        Number

syn match goFloat                      "\<-\=\%(0\|\%(\d\|\d_\d\)\+\)\.\%(\%(\%(\d\|\d_\d\)\+\)\=\%([Ee][-+]\=\%(\d\|\d_\d\)\+\)\=\>\)\="
syn match goFloat                      "\s\zs-\=\.\%(\d\|\d_\d\)\+\%(\%([Ee][-+]\=\%(\d\|\d_\d\)\+\)\>\)\="
syn match goFloat                      "\<-\=\%(0\|\%(\d\|\d_\d\)\+\)[Ee][-+]\=\%(\d\|\d_\d\)\+\>"
syn match goHexadecimalFloat           "\<-\=0[xX]\%(_\x\|\x\)\+\.\%(\%(\x\|\x_\x\)\+\)\=\%([Pp][-+]\=\%(\d\|\d_\d\)\+\)\=\>"
syn match goHexadecimalFloat           "\<-\=0[xX]\.\%(\x\|\x_\x\)\+\%([Pp][-+]\=\%(\d\|\d_\d\)\+\)\=\>"
syn match goHexadecimalFloat           "\<-\=0[xX]\%(_\x\|\x\)\+[Pp][-+]\=\%(\d\|\d_\d\)\+\>"
hi link goFloat                        Float
hi link goHexadecimalFloat             Float

syn match goImaginaryDecimal           "\<-\=\%(0\|\%(\d\|\d_\d\)\+\)i\>"
syn match goImaginaryHexadecimal       "\<-\=0[xX]_\?\%(\x\|\x_\x\)\+i\>"
syn match goImaginaryOctal             "\<-\=0[oO]\?_\?\%(\o\|\o_\o\)\+i\>"
syn match goImaginaryBinary            "\<-\=0[bB]_\?\%([01]\|[01]_[01]\)\+i\>"
syn match goImaginaryFloat             "\<-\=\%(0\|\%(\d\|\d_\d\)\+\)\.\%(\%(\%(\d\|\d_\d\)\+\)\=\%([Ee][-+]\=\%(\d\|\d_\d\)\+\)\=\)\=i\>"
syn match goImaginaryFloat             "\s\zs-\=\.\%(\d\|\d_\d\)\+\%([Ee][-+]\=\%(\d\|\d_\d\)\+\)\=i\>"
syn match goImaginaryFloat             "\<-\=\%(0\|\%(\d\|\d_\d\)\+\)[Ee][-+]\=\%(\d\|\d_\d\)\+i\>"
syn match goImaginaryHexadecimalFloat  "\<-\=0[xX]\%(_\x\|\x\)\+\.\%(\%(\x\|\x_\x\)\+\)\=\%([Pp][-+]\=\%(\d\|\d_\d\)\+\)\=i\>"
syn match goImaginaryHexadecimalFloat  "\<-\=0[xX]\.\%(\x\|\x_\x\)\+\%([Pp][-+]\=\%(\d\|\d_\d\)\+\)\=i\>"
syn match goImaginaryHexadecimalFloat  "\<-\=0[xX]\%(_\x\|\x\)\+[Pp][-+]\=\%(\d\|\d_\d\)\+i\>"
hi link goImaginaryDecimal             Number
hi link goImaginaryHexadecimal         Number
hi link goImaginaryOctal               Number
hi link goImaginaryBinary              Number
hi link goImaginaryFloat               Float
hi link goImaginaryHexadecimalFloat    Float

syn match goVarArgs                    /\.\.\./
hi link goVarArgs                      goOperator
hi link goOperator                     Operator

"                                      -> type constraint opening bracket
"                                      |-> start non-counting group
"                                      ||  -> any word character
"                                      ||  |  -> at least one, as many as possible
"                                      ||  |  |    -> start non-counting group
"                                      ||  |  |    |   -> match ~
"                                      ||  |  |    |   | -> at most once
"                                      ||  |  |    |   | |     -> allow a slice type
"                                      ||  |  |    |   | |     |      -> any word character
"                                      ||  |  |    |   | |     |      | -> start a non-counting group
"                                      ||  |  |    |   | |     |      | | -> that matches word characters and |
"                                      ||  |  |    |   | |     |      | | |     -> close the non-counting group
"                                      ||  |  |    |   | |     |      | | |     | -> close the non-counting group
"                                      ||  |  |    |   | |     |      | | |     | |-> any number of matches
"                                      ||  |  |    |   | |     |      | | |     | || -> start a non-counting group
"                                      ||  |  |    |   | |     |      | | |     | || | -> a comma and whitespace
"                                      ||  |  |    |   | |     |      | | |     | || | |      -> at most once
"                                      ||  |  |    |   | |     |      | | |     | || | |      | -> close the non-counting group
"                                      ||  |  |    |   | |     |      | | |     | || | |      | | -> at least one of those non-counting groups, as many as possible
"                                      ||  |  |    |   | | --------   | | |     | || | |      | | | -> type constraint closing bracket
"                                      ||  |  |    |   | ||        |  | | |     | || | |      | | | |
syn match goTypeParams                 /\[\%(\w\+\s\+\%(\~\?\%(\[]\)\?\w\%(\w\||\)\)*\%(,\s*\)\?\)\+\]/ nextgroup=goSimpleParams,goDeclType contained
hi link goDeclType                     Keyword

