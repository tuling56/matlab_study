# makefile for programs and generator

CCOMP = gcc
CFLAGS = -O4

all:  h_prf.exe q_prf.exe m_prf.exe f_prf.exe df.exe ak.exe

h_prf.exe: h_prf_t.c h_prf.c parser_fl.c types_pr.h phase2.c
	$(CCOMP) $(CFLAGS) -o h_prf.exe h_prf_t.c

m_prf.exe: m_prf_t.c m_prf.c parser_fl.c types_pr.h phase2.c
	$(CCOMP) $(CFLAGS) -o m_prf.exe m_prf_t.c

q_prf.exe: q_prf_t.c q_prf.c parser_fl.c types_qpr.h phase2.c
	$(CCOMP) $(CFLAGS) -o q_prf.exe q_prf_t.c

f_prf.exe: f_prf_t.c f_prf.c parser_fl.c types_fpr.h phase2.c
	$(CCOMP) $(CFLAGS) -o f_prf.exe f_prf_t.c

df.exe:    df_t.c    df.c    parser_fl.c types_df.h phase2.c
	$(CCOMP) $(CFLAGS) -o df.exe    df_t.c

ak.exe:    ak.c
	$(CCOMP) $(CFLAGS) -o ak.exe    ak.c

clean:
	rm -f *~ *.exe
