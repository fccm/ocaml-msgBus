OCAML = ocaml
INC_DIR = +msgBus
INC = -I $(INC_DIR)

.PHONY: check
check:
	$(OCAML) $(INC) msgBus.cma msgAttr.cma check.ml

.PHONY: clean
clean:
	$(RM) *.[oa] *.cm[ioxa] *.cmx[as] *.opt *.byte

