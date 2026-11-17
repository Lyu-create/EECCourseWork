My Git practice repository

This repository is to hand in homework for bootscamp module in Imperial College London MRes Ecology, Evolution and Conservation. The course books is MulQuaBio

Current EECCourseWork project structure:
Feedback

    assignment-1-2026.md
    assignment-2-2026.md

code

    TreeHeight.R
    Vectorize1.R
    apply1.R
    apply2.R
    basic_io.R
    boilerplate.R
    break.R
    browse.R
    clean_silwood_trees.py
    control_flow.R
    csvtospace.sh
    get_TreeHeight.R
    next.R
    oaks.py
    pound_hill_analysis.R
    preallocate.R
    r_conditionals.R
    run_get_TreeHeight.sh
    sample.R
    tabtocsv.sh
    test_silwood_trees.py
    try.R
    unixPrac1.txt

data

    fasta
        407228326.fasta
        407228412.fasta
        e_coli.fasta
    temperatures
        1800.csv
        1801.csv
        1802.csv
        1803.csv
    pound_hill_data.csv
    pound_hill_meta_data.csv
    silwood_trees_metadata.md
    silwood_trees_raw.csv
    tab-example.tsv
    trees.csv

results
sandbox
.gitignore
README.md

## Clone or download the EECCourseWork repository and run all commands from the project root unless otherwise specified.
--------------------------------------------------------------
Assigmment 3 (R)
1.1 Treeheight calculation
This calculates heights of trees given distance of each tree from its base and angle to its top, using  the trigonometric formula 
- Run command from project root:  Rscript code/TreeHeight.R in linux and source("code/TreeHeight.R") in terminal
- input path: data/trees.csv
- output path: results/TreeHts.csv
- checked record: "Carpinus betulus",39.501561964862,30.2981362491846"
```r
39.501561964862 * tan (30.2981362491846 * pi / 180)
[1] 23.08113
```
Consistent with the value in TreeHts.csv "23.0811254247168"

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

--------------------------------------------------------------
Assigment 2 (python)
python project: cleaning up silwood tree data
data location:/data/silwood_trees_raw.csv and silwood_trees_metadata.md

input: `record_id` | Survey-record identifier; `location` | Synthetic survey location;`genus` | Tree genus;  `species` | Tree species epithet; `distance_m` | Horizontal distance from observer to tree, in metres; `angle_degrees` | Angle from horizontal to treetop, in degrees

final output: three file in results
1. cleaned data with no spaces at the begining or end of variables (results/silwood_trees_clean.csv)
2. source row, reacord id and rejected reasons (results/silwood_tree_issues.csv)
3. the total number of valid oaks by species (results/oak_species_counts.csv)

run the code by using the command from the project root using: python3 code/clean_silwood_trees.py

testing the code by asserting validate_record, process_records and summarise_oaks by giving normal and error_expected cases.

limitations: 
In the validate_record function the recognised genus and species are limited, so need updating valid_genus, valid_species, valid_comb maually. Location also have the same restriction. In the summarise_oaks function, only two species are recognised.
It does not handle well large data set but sufficeint for small teaching data set, also due to this purpose, the data may not reflect real fieldwork data.

pseudocodes
-- for validate_record function:
create a empty list for rejection reasons

clean record id by moving surrounding whitespace, assign it to clean_record_id
checking record_id
    if missing record_id, add "missing record_id" to reasons
    if record_id does not start with ST or end with three digits (five characters in total), add "invalid record_id" to reasons
    if record_id is in accpted_ids, add "duplicate record_id" to reasons

clean location by moving surrounding whitespace, assign it to clean_location
define a set with valid_locations shown in the metadata
define valid_locations_fold being case insensitive of valid_location using a loop
check location
    if missing location, add "missing location" to reasons
    if location not in valid_locations, add "invalid location" to reasons
save the caseinsensitive location into clean_location

clean genus by moving surrounding whitespace, assign it to clean_genus
define a set with valid_genus shown in the metadata
define valid_genus_fold being case insensitive of valid_genus using a loop
check genus
    if missing genus, add "missing genus" to reasons
    if genus not in valid_genus, add "invalid genus" to reasons
save the caseinsensitive genus into clean_genus

clean species by moving surrounding whitespace, assign it to clean_species
define a set with valid_species shown in the metadata
define valid_species_fold being case insensitive of valid_species using a loop
check species
    if missing species, add "missing species" to reasons
    if species not in valid_species, add "invalid species" to reasons
save the caseinsensitive species into clean_species

check for genus and species combination
    if the genus and species are all in valid_genus and valid_species but the combination is not a valid combination, add "invalid genus/species combination" to reasons

check distance
    if missing distance, add "missing distance_m" to reasons
    if the distance is inf or nan or cannot be converted into a number, add "invalid distance_m" to reasons
    if the distance can be converted into a number and is greater than 100 or no greater than 0, add "distance_m out of range"

check angle
    if missing angle, add "missing angle_degree" to reasons
    if the angle is inf or nan or cannot be converted into a number, add "invalid angle_degree" to reasons
    if the angle can be converted into a number and is no greater than 0 or no smaller than 90, add "angle_degree out of range" 

each block checks a different validation rule so the function collects all reasons from each and then generate the output

output:tuple[dict[str, str] | None, list[str]]
invalid records are rows that failed at least one test above, returning to None and a list of reasons
valid records are rows that passed all tests, returning to cleaned dictionary of column names, values and an empty list of reasons

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

--------------------------------------------------------------
Assignment 1 (bash)
1 DNA sequence practical
input files: data/fasta/407228326.fasta, data/fasta/407228412.fasta and data/fasta/e_coli.fasta
Run command from project root by copying question by question/line by line to the terminal

2 converters
    limitations: converting one file at a time, change the symbol regardless of the input format

2.1 tabtocsv improved (tab-example.tsv can be substituted by other tsv files)
input path: data/tab-example.tsv
Run command from project root: bash code/tabtocsv.sh data/tab-example.tsv
output path: results/tab-example.tsv.csv

2.2 csvtospace (1800-1803.csv can be substituted by other csv files)
input path: data/temperatures/1800.csv, data/temperatures/1801.csv, data/temperatures/1802.csv and data/temperatures/1803.csv
run command from project root: bash code/csvtospace.sh data/temperatures/1800-1803.csv
output path: results/1800-1803.csv.txt


---------------------------------------------------------------
## other codes
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
    run with code/CheckLabel.sh
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


R scripts (11)
----------------section: biological computing in R------------
- basic_io.R 
- boilerplate.R
- control_flow.R

- r_conditionals.R: functions with conditionals, checking for even number, whether a number is a power of 2 and prime numbers.
    run in R conole with source("code/r_conditionals.R")

- break.R: control flow with break, breaking at a certain iteration
    run in R conole with source("code/break.R")

- next.R: control flow with next, checking and printing the odds numbers throughout iteration
    run in R conole with source("code/next.R")

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
  
  limtiation: need to know where about the bug is

- observations_practice.R
tested with data/bootcamp_observations_invalid.csv, giving an error mesage of "Count values must be non-negative integers".
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


AI statement
I acknowledge the use of ChatGPT https://chatgpt.com/ for distguishing the concepts ,clarifiying pseudocode, generating test data, checking the grammar errors in my script.

Author: Xinyi Lyu
email: xl6226@ic.ac.uk
