all: all
%::
	$(MAKE) -C src $@
clean:
	ocp-build clean
	$(RM) *.old
