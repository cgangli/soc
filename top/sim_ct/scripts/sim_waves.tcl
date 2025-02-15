
fsdbDumpfile "$WAVES.fsdb"
fsdbDumpvars 0 "tb" "+mda"
fsdbDumpMDA
run
quit


#scope tb
#dump -file $WAVES
#dump -add tb -depth 0
#fsdbDumpvars 0 "tb" "+mda"
#fsdbDumpMDA
#run
#quit
