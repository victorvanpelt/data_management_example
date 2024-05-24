# Makefile

# Stata version
STATA = "C:\Program Files\Stata18\StataSE-64.exe"

# do-file variable
DOFILE = do-file.do

# Define the log file where Stata output will be saved
LOGFILE = do-file.log

# Define the target to execute the .do file
run: $(DOFILE)
	$(STATA) /e /q do $(DOFILE) > NUL 2>&1
	-del $(LOGFILE)

# Clean up log files
clean:
	-del $(LOGFILE)

# Phony targets
.PHONY: run clean