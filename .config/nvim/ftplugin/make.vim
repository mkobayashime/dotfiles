command! -nargs=0 -range=% PhonyTargets ,<line1>,<line2>s@^\(?!\.PHONY\)\(\S\+\)\(:.*\)$@.PHONY: \1\r\3\2@g
