scriptencoding utf-8

" https://github.com/baabelfish/nvim-nim/blob/master/syntax/nim.vim

" if exists("b:current_syntax")
"   finish
" endif
" if version < 600
"     syntax
" endif
"
" let b:current_syntax = "nim"

" Keywords
syntax keyword nimKeyword let const var static async await
syntax keyword nimKeyword addr asm atomic bind cast defer discard
syntax keyword nimKeyword do expr stmt end generic mixin iterator
syntax keyword nimKeyword typedesc openarray out ptr ref return using
syntax keyword nimKeyword varargs with without yield nil

syntax keyword nimKeyword echo debugEcho defined
syntax keyword nimKeyword not xor shl shr div mod notin is isnot
syntax keyword nimKeyword and or xor

syntax keyword nimRepeat       for    while   in
syntax keyword nimBoolean      true   false   on      off
syntax keyword nimConditional  if     elif    else    case      continue break
syntax keyword nimDefine       from   as
syntax keyword nimException    try    except  finally raise
syntax keyword nimInclude      import include export
syntax keyword nimLabel        of
syntax keyword nimMacro        macro  template
syntax keyword nimPreCondit    when   block
syntax keyword nimStorage      tuple  enum  interface concept  distinct any
syntax keyword nimStorageClass type
syntax keyword nimTypedef      func   proc    method  converter

syntax keyword nimTodo TODO FIXME


" Operators
" syntax match   nimOperatorAll "[:?<>\|\~\.\^\=\/\+\-%]\+"
" syntax keyword nimOperator    not xor shl shr div mod notin is isnot .
" syntax keyword nimOP11        div mod shl shr
" syntax keyword nimOP10        notin is isnot not
" syntax keyword nimOP9         and
" syntax keyword nimOP8         or xor
" syntax match   nimOP12        "[\@\$\*\=\:\.\&\?\!]"
" syntax match   nimOP7        "[\$\^]"
" syntax match   nimOP6         "[\*\%\\\/]"
" syntax match   nimOP5         "\."
" syntax match   nimOP4         "[=|<|>]"
" syntax match   nimOP3         "\v([!<>])"
" syntax match   nimOP2         "[\:]"
" syntax match   nimOP1         "=>"
" syntax match   nimOP0         "\->"
syntax match   nimOP0         "[=:.,]"
syntax match   nimFunction    /[a-z,A-Z,0-9]\+\ze(/

" Comments
syntax match nimComment "\v#.*$" contains=nimTodo
syntax region nimComment start="#\+\[" end="\]#\+" contains=nimTodo
syntax match nimIdentifier /\w\+/
highlight link nimIdentifier     Identifier

" String
syntax match nimStringLiterals contained /\\n\|\\r\|\\c\|\\l\|\\f\|\\t\|\\v\|\\\\|\\"\|\\\'\|\\a\|\\b\|\\e\|\\x\x\x\|\\[0-9]\+/ containedin=nimString
syntax region nimString start=/\v"/ skip=/\v\\./ end=/\v"/ contains=nimStringLiterals
syntax match nimChar /\'\(\\n\|\\r\|\\c\|\\l\|\\f\|\\t\|\\v\|\\\\|\\"\|\\\'\|\\a\|\\b\|\\e\|.\)\'/

syntax keyword nimBuiltinFunction assert GC_addCycleRoot GC_disable  " echo debugEcho defined
syntax keyword nimBuiltinFunction GC_disableMarkAndSweep GC_enable GC_enableMarkAndSweep GC_fullCollect GC_getStatistics
syntax keyword nimBuiltinFunction GC_ref GC_setStrategy GC_unref abs add addAndFetch addQuitProc
syntax keyword nimBuiltinFunction alloc alloc0 allocCStringArray
syntax keyword nimBuiltinFunction allocShared allocShared0 astToStr atomicDec atomicInc card cas chr clamp close cmp
syntax keyword nimBuiltinFunction compileOption compiles copy copyMem cpuRelax create createShared createSharedU
syntax keyword nimBuiltinFunction createU cstringArrayToSeq dealloc deallocCStringArray deallocShared dec
syntax keyword nimBuiltinFunction declared declaredInScope deepCopy del delete endOfFile definedInScope
syntax keyword nimBuiltinFunction equalMem excl failedAssertImpl find finished flushFile
syntax keyword nimBuiltinFunction freeShared gcInvariant getCurrentException
syntax keyword nimBuiltinFunction getCurrentExceptionMsg getFileHandle getFilePos getFileSize getFrame getFreeMem
syntax keyword nimBuiltinFunction getOccupiedMem getRefcount getStackTrace getTotalMem getTypeInfo gorge high inc
syntax keyword nimBuiltinFunction incl insert instantiationInfo internalNew isNil iterToProc len likely locals low
syntax keyword nimBuiltinFunction max min moveMem new newSeq newString newStringOfCap newWideCString onRaise open
syntax keyword nimBuiltinFunction ord pop pred procCall quit raiseAssert rawEnv rawProc readAll readBuffer readBytes
syntax keyword nimBuiltinFunction readChar readChars readFile readLine realloc reallocShared reopen repr reset resize
syntax keyword nimBuiltinFunction resizeShared safeAdd setControlCHook setCurrentException setFilePos setFrame setLen
syntax keyword nimBuiltinFunction setupForeignThreadGc shallow shallowCopy sizeof slurp stackTraceAvailable staticExec
syntax keyword nimBuiltinFunction staticRead substr succ swap toBiggestFloat toBiggestInt toFloat toInt toU16 toU32
syntax keyword nimBuiltinFunction toU8 unlikely unsafeAddr unsafeNew write writeBuffer writeBytes writeChars writeFile
syntax keyword nimBuiltinFunction writeLine writeLn writeStackTrace xlen ze ze64 zeroMem accumulateResult currentSourcePath
syntax keyword nimBuiltinFunction doAssert excl incl newException onFailedAssert stdmsg


syntax keyword nimBuiltinIterators countdown countup fieldPairs fields items lines mitems mpairs pairs

syntax keyword nimBuiltinType int int8 int16 int32 int64 uint uint8 uint16 uint32 uint64 float float32 float64
syntax keyword nimBuiltinType bool char string cstring pointer Ordinal ptr ref expr stmt typedesc
syntax keyword nimBuiltinType void auto any untyped typed object
syntax keyword nimBuiltinType SomeSignedInt SomeUnsignedInt SomeInteger SomeOrdinal SomeReal SomeNumber SomeFloat
syntax keyword nimBuiltinType range array openArray varargs seq set Slice shared guarded byte
syntax keyword nimBuiltinType Natural Positive RootObj RootRef RootEffect TimeEffect
syntax keyword nimBuiltinType IOEffect ReadIOEffect WriteIOEffect ExecIOEffect
syntax keyword nimBuiltinType Exception SystemError IOError OSError LibraryError ResourceExhaustedError ArithmeticError
syntax keyword nimBuiltinType DivByZeroError OverflowError AccessViolationError AssertionError ValueError KeyError
syntax keyword nimBuiltinType OutOfMemError IndexError FieldError RangeError StackOverflowError ReraiseError
syntax keyword nimBuiltinType ObjectAssignmentError ObjectConversionError FloatingPointError FloatInvalidOpError
syntax keyword nimBuiltinType FloatDivByZeroError FloatOverflowError FloatUnderflowError FloatInexactError
syntax keyword nimBuiltinType DeadThreadError TResult Endianness TaintedString LibHandle ProcAddr ByteAddress
syntax keyword nimBuiltinType BiggestInt BiggestFloat clong culong cschar cshort cint csize clonglong cchar
syntax keyword nimBuiltinType cfloat cdouble clongdouble cuchar cushort cuint culonglong cstringArray
syntax keyword nimBuiltinType PFloat32 PFloat64 PInt64 PInt32 GC_Strategy PFrame TFrame
syntax keyword nimBuiltinType File FileMode FileHandle THINSTANCE AlignType RefCount Utf16Char WideCString NimNode

syntax keyword nimGlobals programResult globalRaiseHook localRaiseHook outOfMemHook stdin stdout stderr errorMessageWriter
syntax keyword nimGlobals nimvm
syntax keyword nimGlobals appType NoFakeVars isMainModule CompileDate CompileTime
syntax keyword nimGlobals cpuEndian hostOS hostCPU QuitSuccess QuitFailure
syntax keyword nimGlobals Inf NegInf NaN NimMajor NimMinor NimPatch NimVersion nativeStackTraceSupported

" Numbers
syntax match nimNumber "\v<[0-9_]+((i|I|u|U)(8|16|32|64))?>"
syntax match nimNumber "\v<0x[0-9,a-f,A-F]+>"
syntax match nimNumber "\v<0[bB][01]+>"
syntax match nimNumber "\v<0[ocC][0-7]+>"
syntax match nimFloat "\v<[0-9_]+(f|d|F|D)>"
syntax match nimFloat "\v<[0-9_]+\.[0-9]+(f|d|F|D)>"
syntax match nimFloat "\v<[0-9_]+((f|F)(32|64|128))>"
syntax match nimFloat "\v<[0-9_]+\.[0-9]+((f|F)(32|64|128))?>"

" Tokens
syntax match nimToken "`"
syntax match nimToken "*"
syntax match nimToken "&"
syntax match nimToken "@"
syntax match nimToken "\$"
" syntax match nimToken "\["
" syntax match nimToken "\]"
" syntax match nimToken "("
" syntax match nimToken ")"
" syntax match nimToken "{"
" syntax match nimToken "}"
" syntax match nimToken ","
" syntax match nimToken ";"
" syntax match nimToken "\[\."
" syntax match nimToken "\.\]"
" syntax match nimToken "(\."
" syntax match nimToken "\.)"
" syntax match nimToken ":"

" Pragmas
syntax case ignore
syntax keyword nimPragmas contained bitsize bycopy byref compile disabling dynlib emit exportc extern header importc incompletestruct containedin=nimPragma
syntax keyword nimPragmas contained link nodecl packed passc passl thread threadvar unchecked union varargs volatile acyclic asmnostackframe containedin=nimPragma
syntax keyword nimPragmas contained assertions boundchecks callconv checks codegendecl compilation compiletime computedgoto deadcodeelim containedin=nimPragma
syntax keyword nimPragmas contained deprecated destructor error experimental fatal final global hint hints immediate importcpp importobjc containedin=nimPragma
syntax keyword nimPragmas contained injectstmt line linearscanend nilchecks noreturn nosideeffect optimization overflowchecks override patterns containedin=nimPragma
syntax keyword nimPragmas contained pop pragma procvar pure push register shallow unroll warning warnings magic discardable inject containedin=nimPragma
syntax keyword nimPragmas contained tags nimcall benign push checks magic rtl inline closure dirty compilerproc inheritable noinit effects requiresinit containedin=nimPragma
syntax region nimPragma start=/{\./ end=/\.}/ contains=nimPragmas,nimString,nimNumber,nimFloat,nimBoolean
syntax case match

" Linking
highlight link nimBoolean          Boolean
highlight link nimBuiltinFunction  Function
"highlight link nimBuiltinIterators Typedef
highlight link nimBuiltinType      Type
highlight link nimComment          Comment
highlight link nimFloat            Float
highlight link nimFunction         Function
highlight link nimIdentifier       Identifier
highlight link nimKeyword          Keyword
highlight link nimNumber           Number
highlight link nimChar             Number
highlight link nimOperatorAll      Operator
highlight link nimString           String
highlight link nimStringLiterals   Character
highlight link nimPragmas          Character
highlight link nimSuffix           SpecialChar
highlight link nimTodo             Todo
highlight link nimToken            Delimiter

highlight link nimConditional  Conditional
highlight link nimConstant     Constant
highlight link nimDefine       Define
highlight link nimException    Exception
highlight link nimGlobals      Constant
highlight link nimInclude      Include
highlight link nimLabel        Label
highlight link nimMacro        Macro
highlight link nimPreCondit    PreCondit
highlight link nimPreProc      PreProc
highlight link nimRepeat       Repeat
highlight link nimStorage      Structure
highlight link nimStorageClass StorageClass
highlight link nimTypedef      Typedef
highlight link nimOperator     Operator

" let g:nvim_nim_highlighter_semantics = []
" if len(g:nvim_nim_highlighter_semantics) > 0
"     hi Semantic0  guifg=#904719 gui=none
"     hi Semantic1  guifg=#44f365 gui=none
"     hi Semantic2  guifg=#503f43 gui=none
"     hi Semantic3  guifg=#c18167 gui=none
"     hi Semantic4  guifg=#688704 gui=none
"     hi Semantic5  guifg=#6b4b77 gui=none
"     hi Semantic6  guifg=#718c07 gui=none
"     hi Semantic7  guifg=#7211cb gui=none
"     hi Semantic8  guifg=#84ec66 gui=none
"     hi Semantic9  guifg=#8f7fc3 gui=none
"     hi Semantic10 guifg=#9dd1db gui=none
"     hi Semantic11 guifg=#b80145 gui=none
"     hi Semantic12 guifg=#c19345 gui=none
"     hi Semantic13 guifg=#ce6723 gui=none
"     hi Semantic14 guifg=#d787c4 gui=none
"     hi Semantic15 guifg=#e20caf gui=none
"     hi Semantic16 guifg=#e59eee gui=none
"     hi Semantic17 guifg=#efd63f gui=none
"     hi Semantic18 guifg=#fcbc89 gui=none
"     hi Semantic19 guifg=#7c78c9 gui=none
" endif
