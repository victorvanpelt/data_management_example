# Default goal is run. So you can just type "make"
.DEFAULT_GOAL := run

# Stata version
STATA = "C:\Program Files\Stata18\StataSE-64.exe"

# do-file variable
DOFILE = 1_code\do-file.do
LOGFILE = do-file.log

# Define the target to execute the .do file
run: $(DOFILE)
	$(STATA) /e /q do $(DOFILE) > NUL 2>&1
	@IF EXIST "$(LOGFILE)" DEL /Q "$(LOGFILE)" >NUL 2>&1

clean:
	@IF EXIST "$(LOGFILE)" DEL /Q "$(LOGFILE)" >NUL 2>&1

# Phony targets
.PHONY: run clean