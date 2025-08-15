# Default goal is run. So you can just type "make"
.DEFAULT_GOAL := run

# Paths (insert your local paths or environmental variable)
STATA = "C:\Program Files\Stata18\StataSE-64.exe"
RSCRIPT = "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" 

# code variables
DOFILE = 1_code\code.do
RFILE   = 1_code\code.r

# run command runs the stata code
run: do

# Stata code. Run with "make do". Last line removes the log file.
do: $(DOFILE)
	$(STATA) /e /q do $(DOFILE) > NUL 2>&1
	@cmd /c "if exist "*.log"  del /q /f "*.log" 

# R code. Run with "make r"
r:
	$(RSCRIPT) --vanilla --quiet "$(RFILE)" >NUL 2>&1

# housekeeping to remove stuck logfile. Run with "make clean"
clean:
	@cmd /c "if exist "*.log"  del /q /f "*.log"

# Phony targets. Type "make r," "make do," or "make clean"
.PHONY: run do r clean