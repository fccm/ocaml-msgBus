OCAMLC = ocamlc
OCAMLOPT = ocamlopt
OCAMLDOC = ocamldoc
OCAMLFIND = ocamlfind
DOC_ATTR = -html
MKDIR = mkdir -p
RMDIR = rmdir
DOCDIR = doc
EDITOR = vim

.PHONY: all lib opt
all: lib opt
lib: msgBus.cma msgAttr.cma
opt: msgBus.cmxa msgAttr.cmxa

.SECONDARY:

%.cmi: %.mli
	$(OCAMLC) -c $<

%.cmo: %.ml %.cmi
	$(OCAMLC) -c $<

%.cmx: %.ml %.cmi
	$(OCAMLOPT) -c $<

%.cma: %.cmo
	$(OCAMLC) -a -o $@ $<

%.cmxa: %.cmx
	$(OCAMLOPT) -a -o $@ $<

%.cmxs: %.cmxa
	$(OCAMLOPT) -shared -linkall -o $@ $<

.PHONY: findinstall
findinstall:
	$(OCAMLFIND) install msgBus META *.cma *.cmx[as] *.cmi *.mli *.a

.PHONY: edit
edit:
	$(EDITOR) msgBus.ml msgBus.mli msgAttr.ml msgAttr.mli

.PHONY: doc
doc:
	$(MKDIR) $(DOCDIR)
	$(OCAMLDOC) \
	  $(DOC_ATTR) \
	  -d $(DOCDIR) \
	  msgBus.mli \
	  msgAttr.mli

.PHONY: clean
clean:
	$(RM) *.[oa] *.cm[ioxa] *.cmx[as]

.PHONY: cleandoc
cleandoc:
	$(RM) $(DOCDIR)/*
	$(RMDIR) $(DOCDIR)

