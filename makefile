COMPILE = gfortran

COMLIB1 =

COMOTT1 = -O0 -Wall -Wextra -g

COMCONV = 

FILES = \
	ChemicalKinetics_ex.o \
	cklib.o \



.SUFFIXES: .f .o

.f.o:
	$(COMPILE) $(COMOTT1) $(COMCONV) -c $<

ChemicalKinetics_exe: $(FILES)
	$(COMPILE) $(COMOTT1) $(COMCONV) $(FILES) -o ChemicalKinetics_exe $(COMLIB1)

ChemicalKinetics_ex.o: ChemicalKinetics_ex.f
cklib.o: cklib.f