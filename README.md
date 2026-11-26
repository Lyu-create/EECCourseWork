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
# Assignment 1 (bash)
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

## Response to formative feedback
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
# Assigment 2 (python)
python project: cleaning up silwood tree data
data location:/data/silwood_trees_raw.csv and silwood_trees_metadata.md

input: `record_id` | Survey-record identifier; `location` | Synthetic survey location;`genus` | Tree genus;  `species` | Tree species epithet; `distance_m` | Horizontal distance from observer to tree, in metres; `angle_degrees` | Angle from horizontal to treetop, in degrees

final output: three file in results
1. cleaned data with no spaces at the begining or end of variables (results/silwood_trees_clean.csv)
2. source row, reacord id and rejected reasons (results/silwood_tree_issues.csv)
3. the total number of valid oaks by species (results/oak_species_counts.csv)

run the code by using the command from the project root using: python3 code/clean_silwood_trees.py

testing the code by asserting validate_record, process_records and summarise_oaks by giving normal and error_expected cases.

## limitations:
In the validate_record function the recognised genus and species are limited, so need updating valid_genus, valid_species, valid_comb maually. Location also have the same restriction. In the summarise_oaks function, only two species are recognised.
It does not handle well large data set but sufficeint for small teaching data set, also due to this purpose, the data may not reflect real fieldwork data.

## pseudocodes
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

## Response to formative feedback
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
# Assigmment 3 (R)
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
# other codes
bash scripts (7)
----------------Shell scripting------------
- variables.sh; bash code/variables.sh or with arguments
    enter string and two number as the output required
    sentense can be printed even without parameter, need "$#" to count the number of arguments

- MyExampleScript.sh; bash code/MyExampleScript.sh
    print login name that can be changes or unset. 
    However whoami always show the effective user.

- boilerplate.sh; bash code/boilerplate.sh
    minal bash script: shebang(first line) telling computer to use Bash to readh the script;
    comment notes using "#"
    code is the scripts body, exit 0 means success but maybe not scientifically correct. Errors are captured with non-zeor values
    good practice to name the file with the extension of its language

- CheckLabel.sh
    echo "$?" prints the exit status
    run with bash code/CheckLabel.sh
    argument is oak/pine -> oak/pine, 0
    not equal to one argument -> Usage: code/CheckLabel.sh oak|pine, 2
    one argument that is not oak -> Unknown label: <>, 1

- CountLines.sh: count the number of lines using new line characters
    bash code/CountLines.sh data/tab-example.tsv -> 4
    use cat -A data/tab-example to inspect the number of new line characters "$"
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
    run the second time to check it does not duplicate the whole result

- tiff2_png.sh
    ImageMagick can be used to coenvert tiff to png is installed separately (not required here). Check with command -v magick and command -v convert, if absence, there will not be an output path.
    free tiff can be downloaded from the website
        if cannot find tiff image, use bash -n code/tiff2_png.sh to inspect syntax error but does not guarantee conversion success
    test in temporary directory: 
        project_root=$PWD
        script_path=$project_root/code/tiff2_png.sh
        mkdir "$shell_practice/images"
        cd "$shell_practice/images"
        pwd
    with tiff image, check the files that will be produced with (replace the temp path with your own, make sure you are in the temporary directory)
        for filename in *.tif
        do
            printf 'convert <%s> <%s>\n' "$filename" "$(basename "$filename" .tif).png" 
        done
        if cannot find the file, the output would be "convert <*.tif> <*.png>"
    run the script with: bash $script_path
    remember to return back to project root by cd $project_root
    limitations: no matches, uppercase extensions, option-like filenames, output collisions, converter failure, adding optional directory argument. existing png may be overwritten.

python scripts (12)
- loops.py
- cfexercises1.py
- cfexercises2.py
- MyExampleScript.py:
    run with python3 code/MyExampleScript.py
- boilerplate.py:
    run with python3 code/boilerplate.py
- using_name.py:
- sysargv.py
- control_flow.py
    run in bash terminal with python3 code/control_flow.py
    %run code/control_flow.py in ipython terminal
- test_control_flow.py
    run with python3 code/test_control_flow.py, no output means passed assertions checks.
- observations_practice.py
    run with python3 code/observations_practice.py or %run code/test_observations_practice.py
    data: data/bootcamp_observations.csv
       site: Non-empty text identifying a site.
       date: Non-empty text identifying the sampling date. Supplied dates use YYYY-MM-DD; calendar validation is outside this exercise.
       count: Empty text "" means missing; otherwise text that int can convert to a non-negative integer. Zero is a known observation. 
- test_observations_practice.py
    run with python3 code/test_observations_practice.py,
    no output means passed assertions checks.
- debugme.py
    debug with %pdb, run code/debugme.py
        n: continue execution until the next line
        ENTER: repeat the previous command
        s: “step” into next function or procedure (i.e., continue the debugging inside the function, as opposed to simply execute it till it returns)
        p x: print variable x
        pp locals(): pretty print all variables and objects in current workspace scope
        c: continue until next break-point
        l: print the code surrounding the current position (you can specify how many)
        R: continue until the end of the function
        q: quit
    use breakpoint()
    try - except, can catch specific error types


R scripts (11)
----------------section: biological computing in R------------
- basic_io.R: import file and create a new file with added or omitted columns or rows
    data: data/trees.csv
    run from the coursework project root with Rscript code/basic_io.R

- boilerplate.R: making a function that shows the types of the inputed two arguments separately
    in the R console: source("code/boilerplate.R")

- control_flow.R
    run each block seperately by sending or pasting into the R console
    if: run some block of code only when condition is true
    for: repeat task over some range of input values
    while: perform operation till some condition met
    test the whole by running in R console source("code/control_flow.R") or Rscript code/control_flow.R on linux

- r_conditionals.R: functions with conditionals, checking for even number, whether a number is a power of 2 and prime numbers.
    run in R console with source("code/r_conditionals.R"), check with print(is.even(6)), print(is.power2(4)) and print(is.prime(3)).
    or Rscript code/r_conditionals.R on linux which gives the output directly

- break.R: control flow with break, breaking at a certain iteration
    run in R console with source("code/break.R")

- next.R: control flow with next, checking and printing the odds numbers throughout iteration
    run in R console with source("code/next.R")

- try.R: catch error using try() in generated random number, carry on the iteration even when error occurs
    run in R console with source("code/try.R")

- browse.R: debuging using browse() in a generated population, showing the values on each iteration.
    run in R console with source("code/browse.R")
    in this mode: Browse[1]>
        n: execute the next line.
        c: exit browser and continue execution
        Q: exit browser and abort, return to top-level.
        use N or t to see the list of values
        ls() to insepct all variables in the function
    At first breakpoint, t was 2, N[t] was  2.718282. after entering c, it is confirmed that the loop paused again at t = 3.
  
  limtiation: need to know where about the bug is

- observations_practice.R
using both "biological computing in R" and "data management and data visualisation" sections
data: data/bootcamp_observations_invalid.csv, giving an error mesage of "Count values must be non-negative integers".
create a figure in results/known_totals.png when using data/bootcamp_observations.csv.

----------------section: data management and data visualisation------------
- data_wrang

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
This should give 2 rows, 7 columns (4 identifying columns and 3 species columns)

```{r}
MyWrangledData_test <- TempData_test |>
  tidyr::pivot_longer(
    cols = -c(Cultivation, Block, Plot, Quadrat),
    names_to = "Species",
    values_to = "Count"
)
print(MyWrangledData_test)
```
This should give 6 rows and 6 columns


# AI statement
I acknowledge the use of ChatGPT https://chatgpt.com/ for distguishing the concepts ,clarifiying pseudocode, generating test data, checking the grammar errors in my script.

## Author
- **Name:** Xinyi Lyu
- **Email:** x.lyu26@ic.ac.uk

## Resources
- [MulQuaBio online coursebook](https://mulquabio.github.io/MQB/)
- [MulQuaBio GitHub repository](https://github.com/MulQuaBio/MQB)
- [Computing Bootcamp assessment rubric](https://mulquabio.github.io/MQB/rubrics/Computing_Bootcamp_Rubric.html)

## Acknowledgement
I would like to thank Professor Pawar for writing such a wonderful book that is always updated to teach us to be multiligual in computer programming languages. I would also like to say thank you for his effort to provide formative feedback, which guided the revision and the improvement of this coursework.
