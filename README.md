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
This folder contains code, data, results, and a sandbox. The results and sandbox folders are kept locally but are not tracked by Git. There is also a folder for feedback.

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
The README commands were tested in a fresh clone of the repository by copying and running them from the project root. Copilot in VS Code was also used to assist with code review and testing.

## Table of contents
- Assignment 1
- Assignment 2
- Assignment 3
- Other code

--------------------------------------------------------------
## Approach to Formative Feedback
Some repeated or overlapping feedback across assignments is addressed only once to avoid duplication.
---------------------------------------------------------------
# Assignment 1 (bash)
1. DNA sequence practical (Unix)
Input files: `data/fasta/407228326.fasta`, `data/fasta/407228412.fasta`, and `data/fasta/e_coli.fasta`.
Run the commands from the project root, copying them into the terminal question by question or line by line.

2. Converters
    Limitations: converts one file at a time and replaces the specified symbol regardless of the input format.

2.1 Improved tab-to-CSV converter
Input: `data/tab-example.tsv`
Run from the project root with `bash code/tabtocsv.sh data/tab-example.tsv`.
Output: `results/tab-example.tsv.csv`

2.2 `csvtospace.sh`
Inputs: `data/temperatures/1800.csv`, `data/temperatures/1801.csv`, `data/temperatures/1802.csv`, and `data/temperatures/1803.csv`.
Run each command separately from the project root:
    bash code/csvtospace.sh data/temperatures/1800.csv
    bash code/csvtospace.sh data/temperatures/1801.csv
    bash code/csvtospace.sh data/temperatures/1802.csv
    bash code/csvtospace.sh data/temperatures/1803.csv
Outputs: `results/1800.csv.txt`, `results/1801.csv.txt`, `results/1802.csv.txt`, and `results/1803.csv.txt`.

## Response to formative feedback
| Practical/File | Feedback category | Feedback received | Changes made |
| --- | --- | --- | --- |
| General | Reproducibility | Too dependent on the local setup | Use relative paths starting from the project root. |
| .gitignore | Ignore rules | Ignoring all CSV files may hide required data later | Ignore the results directory with `results/` and keep it visible in the repository with `results/.gitkeep`. |
| README.md | Main entry point | Clarify whether `READ.md` has a separate purpose | Delete `READ.md`, which was a misspelling of `README.md`. |
| DNA sequence practical (all questions) | Input files | Use bare FASTA files | Use relative paths from `data/`. |
| DNA sequence practical (Q1 and Q5) | Independence | Commands were spread across lines | Use pipes and `+` to combine commands. |
| DNA sequence practical Q3 | Incorrect count | Included line endings | Remove newline characters before counting with `tr -d '\n'`. |
| DNA sequence practical Q5 | Incorrect output | Included header characters | Exclude header lines with `tail -n +2`. |
| Converter | Test data | The `.tsv` example contained commas | Generate a small, tab-delimited table with an empty field. |
| Converter | Error handling | Reported completion even when conversion failed | Send errors to standard error and print an error message. |
| Converter | Output filename | Included the full input path in the output path | Extract the basename with `basename "$1"`. |

# Assignment 3 (R)
1.1 Tree height calculation
This script calculates tree heights from the distance to each tree and the angle to its top, using the trigonometric formula.
- Run from the project root with `Rscript code/TreeHeight.R` on Linux, or use `source("code/TreeHeight.R")` in an R terminal.
- Input: `data/trees.csv`
- Output: `results/TreeHts.csv`

Check: using the command above, the output header should be:
|Species | Distance.m | Angle.degrees | height_m |
| --- | --- | --- | --- |

The output should contain 120 data rows.

The checked record is:
"Carpinus betulus",39.501561964862,30.2981362491846"
```r
39.501561964862 * tan (30.2981362491846 * pi / 180)
[1] 23.08113
```
This is consistent with the value `23.0811254247168` in `TreeHts.csv`.

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



1.2 Generalise the tree-height script
- Run from the project root with `bash code/run_get_TreeHeight.sh`.
- Input: `data/trees.csv`
- Output: `results/trees_treeheights.csv`
- Filename limitation: different input paths with the same basename will produce the same output filename in `results/`.

2. Pound Hill data visualisation and interpretation
These data are used to analyse mean plant species richness and abundance per plot across the March, May, and October cultivation treatments.
- Run from the project root with `Rscript code/pound_hill_analysis.R`.
- Inputs: `data/pound_hill_data.csv` and `data/pound_hill_meta_data.csv`
- Outputs: `results/pound_hill_plot_richness.csv`, `results/pound_hill_plot_richness.pdf`, and `results/pound_hill_plot_abundance.pdf`

## Response to formative feedback
| Practical/File | Feedback category | Feedback received | Changes made |
| --- | --- | --- | --- |
| results/ | Repository organisation and workflow discipline | Make output creation reproducible from a newly cloned copy of the repository | Create `results/` whenever a script is run. |
| General | Code quality and style | Keep names descriptive, add comments, and avoid repeating calculations. |
| README | Documentation | Readers should be able to repeat checks | Provide exact commands in `README.md`. |
| Commit | Version control practice | Make the history easier to follow | Commit each functional revision with a short message rather than making one large final commit. |
| Pound Hill | Problem-solving approach and method implementation | Keep interactive viewing outside the required batch run, or replace it with console-friendly inspection. |
| Pound Hill | Problem-solving approach and method implementation | Zero counts were filtered out | Compare quadrat identifiers before and after filtering, and check abundance and richness manually. |
| Plot generation | Problem-solving approach and method implementation | Print each plot during execution and close its PDF device before opening the next one. |
| Plot generation | Problem-solving approach and method implementation | Inspect the results after rerunning | Check labels, plotted values, and their biological meaning. |
| README | Documentation | Refresh the file listing | Update the file listing. |
| Tree-height routes | Testing | Rerun one ordinary and one invalid case for each tree-height route. Check standard error, exit behaviour, and whether a new result is written; a failed run should not leave a misleading output. |


--------------------------------------------------------------
# Assignment 2 (Python)
Python project: cleaning the Silwood tree data.
Data files: `data/silwood_trees_raw.csv` and `data/silwood_trees_metadata.md`.

Input fields: `record_id` (survey-record identifier), `location` (synthetic survey location), `genus` (tree genus), `species` (species epithet), `distance_m` (horizontal distance from the observer to the tree, in metres), and `angle_degrees` (angle from horizontal to treetop, in degrees).

Final outputs: three files in `results/`:
1. Cleaned data with no leading or trailing whitespace in values (`results/silwood_trees_clean.csv`).
2. Source row, record ID, and rejection reasons (`results/silwood_tree_issues.csv`).
3. The number of valid oak records per species (`results/oak_species_counts.csv`).

Run the script from the project root with `python3 code/clean_silwood_trees.py`.

Test the code by calling `validate_record`, `process_records`, and `summarise_oaks` with normal and expected-error cases.

limitations: 
In `validate_record`, the recognised genera, species, and combinations are limited, so `valid_genus`, `valid_species`, and `valid_comb` must be updated manually. Locations have the same restriction. In `summarise_oaks`, only two species are recognised.

The script is not designed for large datasets, but is sufficient for this small teaching dataset. The data may not reflect real fieldwork.

pseudocode:
-- For the `validate_record` function:
Create an empty list of rejection reasons.

Clean `record_id` by removing surrounding whitespace.
Check for missing values, an invalid format (ST followed by three digits),
and duplicate IDs.

Clean location, genus, and species by removing surrounding whitespace.
Check for missing or invalid values against the metadata,
using case-insensitive comparison.
Standardise valid values.

Check whether a valid genus and valid species form a valid combination.

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


-- For the `process_records` function:
Initialise `clean_records` and the issue list as empty, and initialise `accepted_ids` as an empty set.
Loop through all rows, starting from line 2.
Call `validate_record` for each row.
Check whether a cleaned row is returned:
    if so, add it to clean_records
    otherwise, store the line number, record ID, and reasons in the issue list
Sort the accepted records in ascending order by `record_id`.
Return the accepted records and rejected records with their rejection reasons.


-- For the `summarise_oaks` function:
Initialise the counts of Quercus robur and Quercus petraea to zero.
For each row in `clean_records`:
    if the species is Quercus robur, increase its count by one
    if the species is Quercus petraea, increase its count by one
For each oak species with a count greater than zero, add a row with the species name and count to `oak_counts`.
Return `oak_counts`.

## Response to formative feedback
| Practical/File | Feedback category | Feedback received | Changes made |
| --- | --- | --- | --- |
| Silwood tree data cleaning | Code completeness and functional correctness | The species value in row 2 of `oak_species_counts.csv` differed between the two test runs. |
| Silwood tree data cleaning | Code quality and style | Use descriptive names and add brief comments to explain non-obvious validation or data-cleaning steps. |
| README.md | Documentation | Make it more useful by adding the data cleaner's purpose, instructions for running and testing it from the project root, and a list of generated files. |
| README.md | Documentation | Test the instructions in a fresh clone: clone the repository, enter the project folder, and run each README command exactly as written. If a command fails, correct it or add the missing step. |
| General | Version control practice | Make one coherent working change at a time, then write a concise commit message that explains the change and why it is needed when that is not obvious. |
| Silwood tree data cleaning | Error handling and input validation | Turn the diagnosis into a regression test. Add small, hand-checkable cases that reproduce the behaviour, asserting the relevant species labels, counts, and ordering required by the brief. Rerun both the tests and the full workflow, then recheck all three tables. |
| Silwood tree data cleaning | Problem-solving approach and method implementation | Trace one borderline record. |



--------------------------------------------------------------





---------------------------------------------------------------
# Other code
bash scripts (7)
----------------Shell scripting------------
- variables.sh; bash code/variables.sh or with arguments
    Enter a string and two numbers as required by the script.
    A sentence can be printed without parameters; use "$#" to count the number of arguments.

- MyExampleScript.sh; bash code/MyExampleScript.sh
    Prints the login name, which can be changed or unset.
    However, whoami always shows the effective user.

- boilerplate.sh; bash code/boilerplate.sh
    Minimal Bash script: the shebang (first line) tells the computer to use Bash to read the script.
    Comments begin with "#".
    The code is the script's body. Exit status 0 indicates success, though not necessarily scientific correctness. Errors should use non-zero exit statuses.
    It is good practice to name the file with the extension of its language.

- CheckLabel.sh
    echo "$?" prints the exit status
    run with bash code/CheckLabel.sh
    argument is oak/pine -> oak/pine, 0
    not equal to one argument -> Usage: code/CheckLabel.sh oak|pine, 2
    one argument that is not oak -> Unknown label: <>, 1

- CountLines.sh: count the number of lines using newline characters
    bash code/CountLines.sh data/tab-example.tsv -> 4
    Use cat -A data/tab-example.tsv to inspect newline characters, shown as "$".
    or test in temporary directory:
        shell_practice=$(mktemp -d)
        printf 'species\tcount\noak\t12\n' > "$shell_practice/test.txt"
        printf 'Practice data: %s\n' "$shell_practice"
        bash code/CountLines.sh $shell_practice/test.txt -> 2

- ConcatenateTwoFiles.sh
    test in temporary directory: 
        printf 'oak\n' > "$shell_practice/first.txt"
        printf 'pine\n' > "$shell_practice/second.txt"
        bash code/ConcatenateTwoFiles.sh "$shell_practice/first.txt" "$shell_practice/second.txt" "$shell_practice/combined.txt"
    Run the script a second time to check that it does not duplicate the result.

- tiff2_png.sh
    ImageMagick can be used to convert TIFF files to PNG files. It is installed separately and is not required here. Check with command -v magick and command -v convert; if neither is available, no output file will be created.
    A free TIFF image can be downloaded from a suitable website.
        If no TIFF image is available, use bash -n code/tiff2_png.sh to check for syntax errors. This does not guarantee that conversion will succeed.
    test in temporary directory: 
        project_root=$PWD
        script_path=$project_root/code/tiff2_png.sh
        mkdir "$shell_practice/images"
        cd "$shell_practice/images"
        pwd
    With a TIFF image, check the files that will be produced using the following loop. Replace the temporary path with your own, and make sure you are in the temporary directory.
        for filename in *.tif
        do
            printf 'convert <%s> <%s>\n' "$filename" "$(basename "$filename" .tif).png" 
        done
        If no matching file is found, the output will be "convert <*.tif> <*.png>".
    Run the script with: bash $script_path
    Return to the project root with cd $project_root.
    Limitations: no matches, uppercase extensions, option-like filenames, output collisions, converter failures, and no optional directory argument. Existing PNG files may be overwritten.

python scripts (12)
- loops.py
- cfexercises1.py
- cfexercises2.py
- MyExampleScript.py:
    Run with python3 code/MyExampleScript.py.
- boilerplate.py:
    Run with python3 code/boilerplate.py.
- using_name.py:
- sysargv.py
- control_flow.py
    Run in a Bash terminal with python3 code/control_flow.py.
    In an IPython terminal, use %run code/control_flow.py.
- test_control_flow.py
    Run with python3 code/test_control_flow.py. No output means all assertions passed.
- observations_practice.py
    Run with python3 code/observations_practice.py.
    Input: data/bootcamp_observations.csv
       site: non-empty text identifying a site.
       date: non-empty text identifying the sampling date. Supplied dates use YYYY-MM-DD; calendar validation is outside the scope of this exercise.
       count: an empty string ("") means missing; otherwise, the value must be text that int() can convert to a non-negative integer. Zero is a known observation.
- test_observations_practice.py
    Run with python3 code/test_observations_practice.py.
- debugme.py
    Debug with %pdb and run code/debugme.py.
        n: continue execution until the next line.
        ENTER: repeat the previous command
        s: “step” into next function or procedure (i.e., continue the debugging inside the function, as opposed to simply execute it till it returns)
        p x: print variable x
        pp locals(): pretty print all variables and objects in current workspace scope
        c: continue until next break-point
        l: print the code surrounding the current position (you can specify how many)
        R: continue until the end of the function
        q: quit
    Use breakpoint().
    try-except blocks can catch specific error types.


R scripts (15)
----------------section: biological computing in R------------
- basic_io.R: import a file and create a new file with added or omitted columns or rows.
    Input: data/trees.csv
    Run from the project root with Rscript code/basic_io.R.

- boilerplate.R: create a function that shows the types of two input arguments separately
    In the R console, run source("code/boilerplate.R").

- control_flow.R
    Run each block separately by sending or pasting it into the R console.
    if: run a block of code only when a condition is true
    for: repeat a task over a range of input values
    while: repeat an operation until a condition is met
    Test the whole script in the R console with source("code/control_flow.R"), or on Linux with Rscript code/control_flow.R.

- r_conditionals.R: functions with conditionals, checking for even number, whether a number is a power of 2 and prime numbers.
    Run in the R console with source("code/r_conditionals.R"), then check with print(is.even(6)), print(is.power2(4)), and print(is.prime(3)).
    Alternatively, run Rscript code/r_conditionals.R on Linux to print the output directly.

- break.R: demonstrate control flow with break by exiting a loop at a specified iteration.
    In the R console, run source("code/break.R").

- next.R: demonstrate control flow with next by printing odd numbers during iteration.
    In the R console, run source("code/next.R").

- try.R: catch errors using try() in a generated random-number example and continue iterating when an error occurs
    In the R console, run source("code/try.R").

- browse.R: debug using browser() in a generated population and show the values at each iteration.
    In the R console, run source("code/browse.R").
    At the browser prompt (Browse[1]>):
        n: execute the next line.
        c: exit the browser and continue execution.
        Q: exit the browser and return to the top level.
        Use N or t to see the list of values.
        Use ls() to inspect all variables in the function.
    At the first breakpoint, t was 2 and N[t] was 2.718282. After entering c, the loop paused again at t = 3.
  
  Limitation: you need to know approximately where the bug is.

- observations_practice.R
This script is used in both the "Biological Computing in R" and "Data Management and Data Visualisation" sections.
Input: data/bootcamp_observations_invalid.csv should produce the error "Count values must be non-negative integers".
Using data/bootcamp_observations.csv creates the figure results/known_totals.png.

----------------Section: data management and data visualisation------------
- data_wrang.R and data_wrang_tidy.R demonstrate reshaping the Pound Hill data from wide to long format.

- data_wrang_tidy.R
    Use tidyr::pivot_longer(), tested with:

```{r} 
TempData_test <- data.frame(
    Cultivation = c("March", "May"),
    Block = c("A", "B"),
    Plot = c(1, 2),
    Quadrat = c("Q1", "Q2"),
    Grass = c(10, 8),
    Clover = c(5, 7),
    Daisy = c(3, 2)
)
print(TempData_test)
```
This should produce 2 rows and 7 columns (4 identifying columns and 3 species columns).

```{r}
MyWrangledData_test <- TempData_test |>
  tidyr::pivot_longer(
    cols = -c(Cultivation, Block, Plot, Quadrat),
    names_to = "Species",
    values_to = "Count"
)
print(MyWrangledData_test)
```
This should produce 6 rows and 6 columns.


# AI statement
I acknowledge using ChatGPT (https://chatgpt.com/) to distinguish concepts, clarify pseudocode, generate test data, and check the grammar in my scripts.

## Author
- **Name:** Xinyi Lyu
- **Email:** x.lyu26@ic.ac.uk

## Resources
- [MulQuaBio online coursebook](https://mulquabio.github.io/MQB/)
- [MulQuaBio GitHub repository](https://github.com/MulQuaBio/MQB)
- [Computing Bootcamp assessment rubric](https://mulquabio.github.io/MQB/rubrics/Computing_Bootcamp_Rubric.html)

## Acknowledgement
I would like to thank Professor Pawar for writing such a wonderful, regularly updated book that teaches us to use multiple programming languages. I would also like to thank him for providing formative feedback, which guided the revision and improvement of this coursework.
