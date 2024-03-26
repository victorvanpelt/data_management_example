# Data Management Example
 This repository gives a simple example on how to manage data and structure analyses, so it can easily be shared on github and uses version control. The repository uses a do-file from Stata to illustrate how everything functions. However, it should work with any type of coding and analysis language.


## Repository structure
 It has the following folder:
 - 0_raw: stores the raw data, but does not share it in the repository using a gitignore file  
 - 1_input: stores the input data, typically taken and stored from 0_raw. Also, does not share it in the repository using a gitignore file  
 - 2_ process: stores temporary output/ passing output between code. Also, does not share it in the repository using a gitignore file  
 - 3_output: contains output such as tables and figures  

 There are other folders you can consider adding:
 - #_code: rather than storing code in the main folder, you can store it in this subfolder  
 - #_external: used for storing copies or data and/or code to be shared  
 - #_slides: stores the slides for talks  
 - #_drafts: stores the drafts of papers  
 - #_other: stores other files  

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
