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
- Assignment 1
- Assignment 2
- Assignment 3 
- other codes

--------------------------------------------------------------
## Approach to Formative Feedback

Some repeated or overlapping feedback across assignments is addressed only once to avoid duplication.
---------------------------------------------------------------
## Assignment 1 (bash)
### Assignment 1 – Unix and Shell Scripting

All commands should be run from the project root.

| Script | Run command and testing instructions | Input | Output | Description and checks |
|---|---|---|---|---|
| `unixPrac1.txt` | Copy and execute each command from `code/unixPrac1.txt` individually in the Bash terminal. | `data/fasta/407228326.fasta` <br> `data/fasta/407228412.fasta` <br> `data/fasta/e_coli.fasta` | Terminal output | Demonstrates Unix command-line processing of DNA sequence data. Check each result against the corresponding practical question. |
| `tabtocsv.sh` | `bash code/tabtocsv.sh data/tab-example.tsv` | `data/tab-example.tsv` | `results/tab-example.tsv.csv` | Converts tab-separated text to comma-separated text. Inspect the generated file to confirm that tabs have been replaced with commas. |
| `csvtospace.sh` | `bash code/csvtospace.sh data/temperatures/1800.csv` <br><br> `bash code/csvtospace.sh data/temperatures/1801.csv` <br><br> `bash code/csvtospace.sh data/temperatures/1802.csv` <br><br> `bash code/csvtospace.sh data/temperatures/1803.csv` | `data/temperatures/1800.csv` <br> `data/temperatures/1801.csv` <br> `data/temperatures/1802.csv` <br> `data/temperatures/1803.csv` | `results/1800.csv.txt` <br> `results/1801.csv.txt` <br> `results/1802.csv.txt` <br> `results/1803.csv.txt` | Converts commas to spaces. Inspect each generated file to confirm the conversion. |

**Converter limitations:** Both converters process one file at a time and replace delimiter characters regardless of the input file format. They do not interpret quoted fields or validate the underlying data structure.


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
## Assignment 2 – Python: Cleaning Silwood Tree Data

This practical demonstrates data validation, cleaning, error reporting and summarising tree survey records using Python.

### Scripts, inputs and outputs

All commands are run from the project root.

| Script | Run command | Input | Output | Description and checks |
|---|---|---|---|---|
| `clean_silwood_trees.py` | `python3 code/clean_silwood_trees.py` | `data/silwood_trees_raw.csv` <br> `data/silwood_trees_metadata.md` (validation reference) | `results/silwood_trees_clean.csv` — cleaned and validated records. <br><br> `results/silwood_tree_issues.csv` — rejected records, source row numbers, record IDs and rejection reasons. <br><br> `results/oak_species_counts.csv` — total number of valid oak records by species. | Validates records, removes surrounding whitespace, standardises valid values, records rejection reasons and summarises accepted oak records. |
| `test_silwood_trees.py` | `python3 code/test_silwood_trees.py` | Test records and functions imported from `clean_silwood_trees.py` | Test results and assertion errors if checks fail | Tests `validate_record()`, `process_records()` and `summarise_oaks()` using valid and invalid cases. |

### Input data structure

| Column | Description |
|---|---|
| `record_id` | Survey-record identifier |
| `location` | Synthetic survey location |
| `genus` | Tree genus |
| `species` | Tree species epithet |
| `distance_m` | Horizontal distance from the observer to the tree, in metres |
| `angle_degrees` | Angle from the horizontal to the treetop, in degrees |

### Pseudocode

| Function | Algorithm | Return value |
|---|---|---|
| `validate_record()` | 1. Initialise an empty list of rejection reasons. <br> 2. Remove surrounding whitespace from the record ID and check for missing, invalid or duplicate IDs. Valid IDs consist of `ST` followed by three digits. <br> 3. Clean location, genus and species, checking them against metadata using case-insensitive comparison. <br> 4. Standardise valid values and check genus–species combinations. <br> 5. Check distance and angle for missing, non-numeric, non-finite and out-of-range values (`0 < distance <= 100` and `0 < angle < 90`). <br> 6. Collect rejection reasons from all validation checks. | Valid record: cleaned dictionary and an empty list. <br><br> Invalid record: `None` and a list of rejection reasons. |
| `process_records()` | 1. Initialise empty lists for cleaned records and issues, and an empty set for accepted IDs. <br> 2. Iterate through the input rows, starting at CSV line 2. <br> 3. Call `validate_record()` for each row. <br> 4. Add accepted records to the cleaned-record list. <br> 5. For rejected records, store the source row number, record ID and rejection reasons. <br> 6. Sort accepted records in ascending order by record ID. | List of accepted records and list of rejected-record issues. |
| `summarise_oaks()` | 1. Initialise an empty list for oak counts. <br> 2. Initialise counts for *Quercus robur* and *Quercus petraea* to zero. <br> 3. Iterate through accepted records and increase the corresponding species count. <br> 4. Add each oak species with a count greater than zero to the summary list. | List containing oak species and their counts. |

### Limitations

| Area | Limitation |
|---|---|
| Taxonomic validation | Recognised genera, species and genus–species combinations are restricted to predefined values. These require manual updates when processing additional taxa. |
| Location validation | Only predefined survey locations are recognised. |
| Oak summary | Only *Quercus robur* and *Quercus petraea* are included. |
| Scalability | Designed for a small teaching dataset. Performance on large datasets has not been evaluated. |
| Data representativeness | The synthetic teaching dataset may only partially represent the complexity of real fieldwork data. |


### Response to formative feedback
| Practical/File | Feedback category | Feedback received | Changes made |ve feedback
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
## Assignment 3 – R: Tree Height Calculation and Pound Hill Analysis

### Scripts, inputs and outputs

All commands are run from the project root.

| Script | Bash command | R console command | Input | Output | Description and checks |
|---|---|---|---|---|---|
| `TreeHeight.R` | `Rscript code/TreeHeight.R` | `source("code/TreeHeight.R")` | `data/trees.csv` | `results/TreeHts.csv` | Calculates tree heights from horizontal distances and angles using trigonometry. Output dimensions and an individual height calculation were checked. |
| `get_TreeHeight.R` and `run_get_TreeHeight.sh` | `bash code/run_get_TreeHeight.sh` | Run through the Bash wrapper | `data/trees.csv` | `results/trees_treeheights.csv` | Generalises the tree-height calculation. Different input paths with the same basename may produce the same output filename in `results/`. |
| `pound_hill_analysis.R` | `Rscript code/pound_hill_analysis.R` | `source("code/pound_hill_analysis.R")` | `data/pound_hill_data.csv` <br> `data/pound_hill_meta_data.csv` | `results/pound_hill_plot_richness.csv` <br> `results/pound_hill_plot_richness.pdf` <br> `results/pound_hill_plot_abundance.pdf` | Analyses how mean plant species richness and abundance per plot vary among the March, May and October cultivation treatments. |

### TreeHeight.R – Testing evidence

| Check | Method | Observed result |
|---|---|---|
| Output creation | Run `Rscript code/TreeHeight.R` from the project root. | `results/TreeHts.csv` was created. |
| Column names | Inspect the output header. | `Species`, `Distance.m`, `Angle.degrees`, `height_m`. |
| Number of records | Inspect the number of data rows. | 120 rows. |
| Numerical accuracy | Manually calculate the height of the selected *Carpinus betulus* record using `39.501561964862 * tan(30.2981362491846 * pi / 180)`. | Manual calculation: `23.08113` m. CSV value: `23.0811254247168` m. The values agree to the displayed precision. |
| Reproducibility | Rerun the script and inspect the output. | The existing output is replaced, with no additional rows appended. |

### Tree-height validation tests

| Test case | Command or test method | Expected output | Observed result |
|---|---|---|---|
| Reordered columns | | | |
| Additional columns | | | |
| Missing columns | | | |
| `Distance.m` is character | | | |
| `Distance.m` is infinite | | | |
| `Distance.m < 0` | | | |
| `Distance.m = 0` | | | |
| `Distance.m = 100` | | | |
| `Distance.m > 100` | | | |
| `Angle.degrees` is character | | | |
| `Angle.degrees` is infinite | | | |
| `Angle.degrees < 0` | | | |
| `Angle.degrees = 0` | | | |
| `Angle.degrees = 90` | | | |
| `Angle.degrees > 90` | | | |

### Response to formative feedback

| Practical / File | Feedback category | Feedback received | Changes made and verification |
|---|---|---|---|
| General | Repository organisation and workflow discipline | Make output creation reproducible from a newly cloned repository. | Scripts create `results/` when needed. |
| General | Code quality and style | Keep variable names descriptive, use comments and avoid repeating calculations. | |
| `README.md` | Documentation | Provide sufficient information for readers to repeat the checks. | Provide exact execution and testing commands in `README.md`. |
| Git commits | Version-control practice | Make the development history easier to follow. | Commit individual functional revisions with concise commit messages. |
| `pound_hill_analysis.R` | Problem-solving approach and method implementation | Keep interactive viewing outside the required batch execution | replace it with console-friendly inspection|
| `pound_hill_analysis.R` | Problem-solving approach and method implementation | Zero counts were filtered out. | Although the number of quadrats do not differ between filtering out zero before and after grouping, the filter is applied aftering grouping so a quadrat will not be deleted if it has a zero count. Grouping is performed directly on MyWrangledData |
| Plot generation | Problem-solving approach and method implementation | Print each plot during execution and close its PDF device before opening the next. | close the richness plot before creating the abundance plot and use the print command|
| Plot generation | Testing and verification | Inspect generated plots after rerunning the script. | Inspect axis labels, plotted values and biological meaning. |
| `README.md` | Documentation | Refresh the repository file listing. | |
| Tree-height scripts | Testing and verification | Rerun one ordinary and one invalid case for each tree-height route. Check stderr, exit behaviour and whether any new result is written. A failed run should not leave a misleading new output. | |



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
| `observations_practice.R` | `Rscript code/observations_practice.R <input_file>` <br><br> Requires an input file path as a command-line argument. | `source("code/observations_practice.R")` | `data/bootcamp_observations.csv` <br><br> `data/bootcamp_observations_boundary.csv` <br><br> `data/bootcamp_observations_invalid.csv` | `results/known_totals.png` <br> Console summaries and validation errors | **Ordinary:** A (2, 1), B (0, 0). <br> **Boundary:** C (NA, 2), D (0, 0). <br> **Invalid:** Expected error "Count values must be non-negative integers". |
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

