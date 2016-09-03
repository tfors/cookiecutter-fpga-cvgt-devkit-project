TOP = {{cookiecutter.project_name}}
QSYS_SYSTEM = system
FAMILY = "Cyclone V"
DEVICE = 5CGTFD9E5F35C7
EPICS_MODULE = epics_eth

.PHONY: all program console generate compile clean

all:
	$(MAKE) generate
	$(MAKE) compile
	$(MAKE) $(QSYS_SYSTEM).h

program: output_files/$(TOP).sof
	$(QUARTUS_ROOTDIR)/bin/quartus_pgm \
		--mode=jtag --operation=p\;$^

console:
	$(QUARTUS_ROOTDIR)/sopc_builder/bin/system-console \
		--project_dir=. \
		--cli \
		--jdi=output_files/$(TOP).jdi \
		--rc_script=master.tcl

generate:
	$(QUARTUS_ROOTDIR)/sopc_builder/bin/qsys-generate \
		$(QSYS_SYSTEM).qsys \
		--synthesis=VERILOG \
		--output-directory=./$(QSYS_SYSTEM) \
		--family=$(FAMILY) \
		--part=$(DEVICE)

$(QSYS_SYSTEM).h: $(QSYS_SYSTEM).sopcinfo
	$(QUARTUS_ROOTDIR)/sopc_builder/bin/sopc-create-header-files $^ \
		--single $@ --module $(EPICS_MODULE)

compile:
	$(QUARTUS_ROOTDIR)/bin/quartus_sh \
		--flow compile \
		$(TOP)

clean:
	find . -name "*.bak" -exec rm {} \;
	find . -name "*~" -exec rm {} \;
	rm -rf \
		db \
		incremental_db \
		$(QSYS_SYSTEM) \
		reconfig_mif \
		output_files \
	rm -f \
		c5_pin_model_dump.txt \
		PLLJ_PLLSPE_INFO.txt \
		$(QSYS_SYSTEM).sopcinfo
