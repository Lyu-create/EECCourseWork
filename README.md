# My Git Practice Repository

## Description
This repository contains the cumulative Computing Bootcamp
coursework portfolio for the MRes Ecology, Evolution and
Conservation programme at Imperial College London (2026–2027).

This portfolio has been developed and revised in accordance
with the Computing Bootcamp Assessment Rubric
(see "Resources" section) and the formative feedback
received for Assignments 1–3.

The coursework is based on the MulQuaBio coursebook and
covers Unix, Shell scripting, Python and R.

## Portfolio Structure
This folder contain code, data, result and sandbox where the last two is kept but untracked. There is also a folder for feedback.

## Dependencies
### Software
- Linux (Ubuntu)
- Git
- Bash
- Python 3
- R
### Shell dependencies
- bc
- ImageMagick (for tiff2_png.sh)
### Python dependencies
- IPython (optional, for interactive exercises)
### R packages
- tidyr
- ggplot2

## Getting Started
Clone the repository using HTTPS:
```bash
git clone https://github.com/Lyu-create/EECCourseWork.git
```
Alternatively, use GitHub CLI (if installed):
```bash
gh repo clone Lyu-create/EECCourseWork
```
Navigate to the project root:
```bash
cd EECCourseWork
```
All execution commands in this README should be run from
the project root unless otherwise specified.

## Testing and Reproducibility
The README commands were tested in a fresh clone of the repository by copying and executing them from the project root. Copilot in VS Code was also used to assist with code review and testing.

## Table of contents
Assignment 1
Assigement 2
Assignement 3 
other codes

--------------------------------------------------------------
## Approach to Formative Feedback
Some repeated or overlapping feedback across assignments is addressed only once to avoid duplication.
---------------------------------------------------------------
## Assignment 1 (bash)
1 DNA sequence practical (Unix)
input files: data/fasta/407228326.fasta, data/fasta/407228412.fasta and data/fasta/e_coli.fasta
Run command from project root by copying question by question/line by line to the terminal

2 converters
    limitations: converting one file at a time, change the symbol regardless of the input format

2.1 tabtocsv improved
input path: data/tab-example.tsv
Run command from project root: bash code/tabtocsv.sh data/tab-example.tsv
output path: results/tab-example.tsv.csv

2.2 csvtospace.sh
input path: data/temperatures/1800.csv, data/temperatures/1801.csv, data/temperatures/1802.csv and data/temperatures/1803.csv
run command from project root separately: 
    bash code/csvtospace.sh data/temperatures/1800.csv
    bash code/csvtospace.sh data/temperatures/1801.csv
    bash code/csvtospace.sh data/temperatures/1802.csv
    bash code/csvtospace.sh data/temperatures/1803.csv
output path: results/1800.csv.txt, results/1801.csv.txt, results/1802.csv.txt, results/1803.csv.txt

### Response to formative feedback
| Practical/File | Feedback category | Feedback received | Changes made |
| --- | --- | --- | --- |
| General | Reproducibility | dependen too much on local setup | use relative paths starting from project root 
| gitignore | rule of ignoring | ignoring all csv files may hide required data later | 1. ignored the results directory by .gitignore results/ 2.kept the result directory in display by .gitkeep results/
| README.md | main entry point | clarify whether READ.md has a separate purpose | deleted READ.md because it was a misspelling of README.md
| DNA sequence practical (all questions) | import files | use bare FASTA files | use relative path from data/
| DNA sequence practical general (Q1 and Q5) | independence | command spread across lines | use pipes and +
| DNA sequence practical Q3 | wrong | included line endings | trim new line characteris befor counting with re -d '\n'
 DNA sequence practical Q5 |  wrong | included head characters | exclude head lines with tail -n +2
| converter | test data | .tsv exmaple contains commas | generate a small new tab-delimeted table with an empty field 
| converter | error check | report done even when conversion failed | send errors to the standard error and print error
| converter | extract file | folds the whole input path into its output path | extract base names with basename "$1"


--------------------------------------------------------------
## Assigment 2 (python)
python project: cleaning up silwood tree data
data location:/data/silwood_trees_raw.csv and silwood_trees_metadata.md

input: `record_id` | Survey-record identifier; `location` | Synthetic survey location;`genus` | Tree genus;  `species` | Tree species epithet; `distance_m` | Horizontal distance from observer to tree, in metres; `angle_degrees` | Angle from horizontal to treetop, in degrees

final output: three file in results
1. cleaned data with no spaces at the begining or end of variables (results/silwood_trees_clean.csv)
2. source row, reacord id and rejected reasons (results/silwood_tree_issues.csv)
3. the total number of valid oaks by species (results/oak_species_counts.csv)

run the code by using the command from the project root using: python3 code/clean_silwood_trees.py

testing the code by asserting validate_record, process_records and summarise_oaks by giving normal and error_expected cases.

### limitations: 
In the validate_record function the recognised genus and species are limited, so need updating valid_genus, valid_species, valid_comb maually. Location also have the same restriction. In the summarise_oaks function, only two species are recognised.
It does not handle well large data set but sufficeint for small teaching data set, also due to this purpose, the data may not reflect real fieldwork data.

### pseudocodes
-- for validate_record function:
Create an empty list of rejection reasons.

Clean record_id by removing surrounding whitespace.
Check for missing values, invalid format (ST followed by three digits)
and duplicate IDs.

Clean location, genus and species by removing surrounding whitespace.
Check for missing or invalid values against the metadata,
using case-insensitive comparison.
Standardise valid values.

Check whether individually valid genus and species form a valid combination.

Validate distance and angle:
    Check for missing, non-numeric and non-finite values.
    Check permitted ranges:
        0 < distance <= 100
        0 < angle < 90

Collect rejection reasons from all validation checks.

If any rejection reasons exist:
    Return None and the list of reasons.
Otherwise:
    Return the cleaned record and an empty list.


-- for process_record function:
intialise variables: clean_records and issue list, accepted_ids set as empty
loop through all the rows starting from line 2
call validation_record function for each row
check whether a cleaned_row for the cleaned_records is returned
    if there is a clean row, add it to the clean_record list
    if there is nothing, store the line number, record id and reasons and add the rejection reasons to the issue list
Sort the accepted records in ascending order by record_id.
return to list of accepted record rows and rejected record with the rejection reasons


-- for summarise_oaks function: 
intialise oak count as empty list
set the count of Quercus robur and Quercus petraea as 0
For each row in clean_records
    if the species is Quercus robur
        increase Quercus robur count by one
    or if the species is Quercus petraea
        increase Quercus petraea count by one
For each oak species, if its count is greater than zero, add a row containing the species name and its count to the oak_counts list.
Return the oak_counts list containing the species and their counts.

### Response to formative feedback
| Practical/File | Feedback category | Feedback received | Changes made |
| --- | --- | --- | --- |
| clean silwood tree data | code completeness and functional correctness | difference in the species field of row 2 in oak_species_counts.csv in both test runs |
| clean silwood tree data | code quality and style | use more descriptive names and add short comments (reason for a validation check or data-cleaning step when not obvious)|
| README.md | documentation | make it more useful (add purpose of data cleaner, how to run the script and test for root, the files created)
| README.md | Documentation | test instruction in a newly cloned copy of repository with git clone, enter the folder and run each readme command exactly as written. if something fials, correct the command or add the missing step
| general | version control practice | check for one coherent wotking change (and then write concise meessage for the name of the change and why it is needed when not obvious)
| clean silwood tree data | basic error handling and input validation | turn the diagnosis into a regreesion test (add small, hand-checkable cases that reproduced the behavioru you identify, asserting the relavant species lables, counts and any ordering required by the breif, to make correction repeatbale rather than visual inspection/ rerun both tests and full work flow, recheck all three tables)
| clean silwood tree data | problem-solving appraoch and method implementation | trace one boarderline record |



--------------------------------------------------------------
## Assigmment 3 (R)
1.1 Treeheight calculation
This calculates heights of trees given distance of each tree from its base and angle to its top, using  the trigonometric formula 
- Run command from project root:  Rscript code/TreeHeight.R in linux and source("code/TreeHeight.R") in R terminal
- input path: data/trees.csv
- output path: results/TreeHts.csv

checking:  using the above commands, the output header is 
|Species | Distance.m | Angle.degrees | height_m |
| --- | --- | --- | --- |

and there are 120 rows in the output.

the record checked is:
"Carpinus betulus",39.501561964862,30.2981362491846"
```r
39.501561964862 * tan (30.2981362491846 * pi / 180)
[1] 23.08113
```
Consistent with the value in TreeHts.csv "23.0811254247168"

Rerunning the script replaces the result rather than appending to the original rows.

| Test | command | expected output | result |
| --- | --- | --- | --- |
| Reordered columns |
| Additional columns |
| Missing columns |
| Distance.m is character |
| Distance.m is infinite |
| Distance.m < 0 |
| Distance.m = 0 |
| Distance.m = 100 |
| Distance.m > 100 |
| Angle.degrees is character |
| Angle.degrees is infinite |
| Angle.degrees < 0 |
| Angle.degrees = 0 |
| Angle.degrees = 90 |
| Angle.degrees > 90 |



1.2 generalise tree-height script
- Run command from project root:  bash code/run_get_TreeHeight.sh
- input path: data/trees.csv
- output path: results/trees_treeheights.csv
- filename limitation: Different input paths with the same basename will produce the same output filename in results/

2. pound_hill data visulisation and interpretation
This data is to analyse mean plant species richness and abundance per plot varying among the March, May and October cultivation treatments.
- Run command from project root: Rscript code/pound_hill_analysis.R
- input path: data/pound_hill_data.csv and data/pound_hill_meta_data.csv
- output path: results/pound_hill_plot_richness.csv, results/pound_hill_plot_richness.pdf, results/pound_hill_plot_abundance.pdf

## Response to formative feedback
| Practical/File | Feedback category | Feedback received | Changes made |
| --- | --- | --- | --- |
| results/ | repository organisation and workflow disipline | make output creation reproducible form a newly cloned copu of your repository | create results/ each time a script is ran
| general | code quality and style | keep names descriptive, use comments and avoid repeating calculations
| README | Documention | shold be able to repeat checks | (give exact commands in README.md)
| commit | version-control practice | needs to be easier to follow | (commit each functional revision with short message rather than one large final commit)
| pound hill | problem_solving approach and method implementation | keep interactice viewing outside the required batch run or replace with console freindly inspection |
| pound hill | problem_solving approach and method implementation | filtered out zero counts | (compare quadrat identifier before and after filter, check the adbudance and richness manually)|
| plot generation| problem_solving approach and method implementation | print each plot during execution and close its pdf device before opening the next |
| plot generation| problem_solving approach and method implementation | inspection needed after rerun | (inspect labels, plotted values and biological meanings)
| README | Documnetation | refresh file listing |
| Tree height routes | testing |Rerun one ordinary and one invalid case for each tree-height route. Check stderr, exit behaviour and whether any new result is written; a failed run should not leave a misleading new output | 




---------------------------------------------------------------
## Other Codes
bash scripts (7)
### Bash practice scripts (7)

| Script | Run command and testing instructions | Input | Output | Description and checks |
|---|---|---|---|---|
| `variables.sh` | `bash code/variables.sh` <br><br> `bash code/variables.sh 1 "two words"` | User-entered text, two numbers and optional command-line arguments | Terminal output | Demonstrates variables and command-line arguments. Tested with and without arguments. `$#` reports the actual number of arguments supplied. |
| `MyExampleScript.sh` | `bash code/MyExampleScript.sh` | `$USER` environment variable | Terminal output | `$USER` commonly stores the login name but can be changed or unset. `whoami` reports the effective user. |
| `boilerplate.sh` | `bash code/boilerplate.sh` | None | Terminal output and exit status | Demonstrates the basic structure of a Bash script, including the shebang, comments, script body and exit status. Exit status `0` indicates successful execution. Scientific correctness requires further checks. |
| `CheckLabel.sh` | `bash code/CheckLabel.sh oak` <br><br> `bash code/CheckLabel.sh` <br><br> `bash code/CheckLabel.sh birch` <br><br> `bash code/CheckLabel.sh oak pine` <br><br> Run `echo "$?"` immediately after each command. | Species label and command-line arguments | Terminal output, error messages and exit status | Valid label: `0`. <br> Incorrect argument count: `2`. <br> Unknown label: `1`. |
| `CountLines.sh` | `bash code/CountLines.sh data/tab-example.tsv` <br><br> `cat -A data/tab-example.tsv` <br><br> **Temporary test:** <br> `shell_practice=$(mktemp -d)` <br> `printf 'species\tcount\noak\t12\n' > "$shell_practice/test.txt"` <br> `bash code/CountLines.sh "$shell_practice/test.txt"` | `data/tab-example.tsv` or a temporary text file | Line count displayed in the terminal | Counts newline characters. Confirmed 4 newline characters in `tab-example.tsv` and 2 in the temporary test file. `$` in the output of `cat -A` indicates a line ending. |
| `ConcatenateTwoFiles.sh` | `shell_practice=$(mktemp -d)` <br> `printf 'oak\n' > "$shell_practice/first.txt"` <br> `printf 'pine\n' > "$shell_practice/second.txt"` <br><br> `bash code/ConcatenateTwoFiles.sh "$shell_practice/first.txt" "$shell_practice/second.txt" "$shell_practice/combined.txt"` <br><br> Repeat the final command and inspect the output using `cat "$shell_practice/combined.txt"`. | Two text files and an output path | `combined.txt` in the temporary directory | Combines two files. Rerunning checks whether the output remains reproducible without duplicated contents. The output path must be distinct from both input paths. |
| `tiff2_png.sh` | **Check dependencies:** <br> `command -v magick` <br> `command -v convert` <br><br> **Prepare a temporary directory from the project root:** <br> `project_root="$PWD"` <br> `script_path="$project_root/code/tiff2_png.sh"` <br> `shell_practice=$(mktemp -d)` <br> `mkdir "$shell_practice/images"` <br> `cd "$shell_practice/images"` <br><br> Copy expendable lowercase `.tif` images into this directory. <br><br> **Run conversion:** <br> `bash "$script_path"` <br> `cd "$project_root"` <br><br> **Syntax-only check:** <br> `bash -n code/tiff2_png.sh` | Lowercase `.tif` images in the temporary directory | `.png` images in the same directory | Conversion tested using ImageMagick, which is required for actual image conversion. A syntax check alone cannot verify successful conversion. <br><br> **Limitations:** unmatched file patterns, uppercase extensions, option-like filenames, output collisions and converter failures. Existing PNG files may be overwritten. The script operates in the current directory. |

### Python practice scripts (12)

All commands are run from the project root. For IPython commands, start an interactive session using `ipython`.

| Script | Bash command | IPython command | Input | Output | Description and checks |
|---|---|---|---|---|---|
| `loops.py` | `python3 code/loops.py` | `%run code/loops.py` | Values defined in the script | Terminal output | Demonstrates iteration using `for` and `while` loops. |
| `cfexercises1.py` | `python3 code/cfexercises1.py` | `%run code/cfexercises1.py` | Numerical values | Terminal output | Demonstrates conditional statements, functions, loops and recursive and iterative factorial calculations. |
| `cfexercises2.py` | `python3 code/cfexercises2.py` | `%run code/cfexercises2.py` | Values defined in the script | Terminal output | Demonstrates control flow using loops and conditional statements. |
| `MyExampleScript.py` | `python3 code/MyExampleScript.py` | `%run code/MyExampleScript.py` | Values defined in the script | Terminal output | Demonstrates basic Python script structure and execution. |
| `boilerplate.py` | `python3 code/boilerplate.py` | `%run code/boilerplate.py` | None | Terminal output | Demonstrates the shebang, docstrings, functions and startup guard. |
| `using_name.py` | `python3 code/using_name.py` | `%run code/using_name.py` | None | Terminal output | Demonstrates the use of `__name__` when a script is executed directly or imported. |
| `sysargv.py` | `python3 code/sysargv.py` <br><br> `python3 code/sysargv.py oak "two words"` | `%run code/sysargv.py` <br><br> `%run code/sysargv.py oak "two words"` | Optional command-line arguments | Script name, argument count and argument list | Demonstrates command-line arguments using `sys.argv`. The first element contains the script name. |
| `control_flow.py` | `python3 code/control_flow.py` <br><br> `python3 -m doctest -v code/control_flow.py` | `%run code/control_flow.py` <br><br> `%run -m doctest -v code/control_flow.py` | Numerical values | Terminal output and doctest results | Demonstrates reusable functions and control flow. Doctest compares actual results against expected results in the docstring. |
| `test_control_flow.py` | `python3 code/test_control_flow.py` | `%run code/test_control_flow.py` | Test values and functions imported from `control_flow.py` | Assertion errors if checks fail | Successful assertions produce no output. |
| `observations_practice.py` | `python3 code/observations_practice.py` | `%run code/observations_practice.py` | `data/bootcamp_observations.csv` | Terminal output | Demonstrates CSV loading, count validation and missing-value handling. Site and date must be non-empty text. Empty counts represent missing observations, while zero represents a known observation. |
| `test_observations_practice.py` | `python3 code/test_observations_practice.py` | `%run code/test_observations_practice.py` | Test values and functions imported from `observations_practice.py` | Assertion errors if checks fail | Tests normal, boundary and invalid inputs. `"-1"`, `"many"` and integer `2` must raise `ValueError`. Successful assertions produce no output. |
| `debugme.py` | `python3 code/debugme.py` <br><br> Interactive debugging: `python3 -m pdb code/debugme.py` | `%pdb on` <br> `%run code/debugme.py` | Numerical argument supplied to `buggyfunc()` | Debugger output and error messages | Demonstrates debugging using `pdb`, `%pdb` and `breakpoint()`. Debugger commands include `n` (next line), `Enter` (repeat previous command), `s` (step into a function), `p x` (print variable), `pp locals()` (display local variables), `c` (continue), `l` (list surrounding code), `r` (continue until the function returns) and `q` (quit). Demonstrates specific exception handling using `try` and `except`. |


### R practice scripts (11)

All commands are run from the project root. For interactive R commands, start an R session using `R`.

| Script | Bash command | R console command | Input | Output | Description and checks |
|---|---|---|---|---|---|
| `basic_io.R` | `Rscript code/basic_io.R` | `source("code/basic_io.R")` | `data/trees.csv` | Modified data file | Demonstrates importing, modifying and exporting data, including selecting or removing rows and columns. |
| `boilerplate.R` | `Rscript code/boilerplate.R` | `source("code/boilerplate.R")` | Two function arguments | Argument types displayed in the console | Demonstrates defining a function and identifying the data types of its arguments. |
| `control_flow.R` | `Rscript code/control_flow.R` | `source("code/control_flow.R")` | Values defined within the script | Console output | Demonstrates `if` (conditional execution), `for` (iteration over a sequence) and `while` (iteration while a condition remains true). Individual blocks can also be tested separately in the R console. |
| `r_conditionals.R` | `Rscript code/r_conditionals.R` | `source("code/r_conditionals.R")` <br><br> `print(is.even(6))` <br> `print(is.power2(4))` <br> `print(is.prime(3))` | Numerical values | Console output | Demonstrates conditional functions for identifying even numbers, powers of two and prime numbers. |
| `break.R` | `Rscript code/break.R` | `source("code/break.R")` | Values defined within the script | Console output | Demonstrates using `break` to terminate a loop when a specified condition is met. |
| `next.R` | `Rscript code/next.R` | `source("code/next.R")` | Values defined within the script | Odd numbers displayed in the console | Demonstrates using `next` to skip the current iteration and continue to the following one. |
| `try.R` | `Rscript code/try.R` | `source("code/try.R")` | Randomly generated values | Console output and error messages | Demonstrates error handling using `try()`. The loop continues executing even when an iteration encounters an error. |
| `browse.R` | Start an interactive R session using `R`. | `source("code/browse.R")` | Initial population size, growth rate and number of generations | Debugger output and exponential growth figure | Demonstrates interactive debugging using `browser()`. At the `Browse[1]>` prompt, use `n` (next line), `c` (continue), `Q` (abort), `N` (population vector), `t` (current iteration) and `ls()` (list local variables). At the first breakpoint, `t` was `2` and `N[t]` was approximately `2.718282`. After entering `c`, the loop paused again at `t = 3`. |
| `observations_practice.R` | `Rscript code/observations_practice.R` | `source("code/observations_practice.R")` | `data/bootcamp_observations.csv` <br> `data/bootcamp_observations_invalid.csv` | `results/known_totals.png` and validation error messages | Integrates biological computing, data management and visualisation. The invalid dataset produces the error message "Count values must be non-negative integers". The ordinary dataset generates a figure of known totals. |
| `data_wrang.R` | `Rscript code/data_wrang.R` | `source("code/data_wrang.R")` | See input data specified in the script | Wrangled data | Demonstrates data manipulation and reshaping using base R. |
| `data_wrang_tidy.R` | `Rscript code/data_wrang_tidy.R` | `source("code/data_wrang_tidy.R")` | Wide-format species abundance data | Long-format species abundance data | Demonstrates reshaping data using `tidyr::pivot_longer()`. A test dataset containing 2 rows and 7 columns, including 4 identifying columns and 3 species columns, was used. The expected reshaped dataset contains 6 rows and 6 columns. Requires the `tidyr` package. |


# AI statement
I acknowledge the use of ChatGPT https://chatgpt.com/ for distguishing the concepts ,clarifiying pseudocode, generating test data, checking the grammar errors in my script.
Copilot was used to run scripts according to the readme and help with pushing when there are conflicts between local and github repository.

## Author
- **Name:** Xinyi Lyu
- **Email:** x.lyu26@ic.ac.uk

## Resources
- [MulQuaBio online coursebook](https://mulquabio.github.io/MQB/)
- [MulQuaBio GitHub repository](https://github.com/MulQuaBio/MQB)
- [Computing Bootcamp assessment rubric](https://mulquabio.github.io/MQB/rubrics/Computing_Bootcamp_Rubric.html)

## Acknowledgement
I would like to thank Professor Pawar for writing such a wonderful book that is always updated to teach us to be multiligual in computer programming languages. I would also like to say thank you for his effort to provide formative feedback, which guided the revision and the improvement of this coursework.

