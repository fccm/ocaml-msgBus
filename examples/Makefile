OCAML = ocaml
INC_DIR = +msgBus
INC = -I $(INC_DIR)
MODULES = msgBus.cma msgAttr.cma
EXAMPLE = example1.ml

.PHONY: run
run:
	$(OCAML) $(INC) $(MODULES) $(EXAMPLE)
