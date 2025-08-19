# Data Management Example
 This repository gives a simple example on how to manage data and structure analyses, so it can easily be shared on github and uses version control. The repository uses Stata, R, and Quarto to illustrate how everything functions. However, it should work with any type of coding and analysis language.

## Repository structure
 It has the following folders:
 - 0_data: stores the raw data, but does not share it in the repository.
 - 1_code: stores the code files which are shared in the repository.  
 - 2_ process: stores temporary output/ passing output between code. Also, does not share it in the repository using a gitignore file  
 - 3_output: contains output such as tables and figures  

 There are other folders you can consider adding:
 - #_external: used for storing copies or data and/or code to be shared  
 - #_slides: stores the slides for talks  
 - #_docs: stores the drafts of papers  

## Key principles
Here are some key principles:

### Reproducibility
- Others should be able to run the code to produce the output, anywhere and anytime, regardless of their location of PC.
- All file calls within a directory use relative paths (i.e., "..\1_input\data.csv") and not direct paths (i.e., "C:\user\[name]\Documents\data_management_example\1_input\data.csv")  
- The code is deterministic. If randomization is required, specify a seed. 

### Readability
- Others can read the code and understand how it works  
- Use a clear structure in your code from top to bottom  
- Use comments to explain what an excerpt of code is doing  
- Delete or comment out code that does not help generate output  
