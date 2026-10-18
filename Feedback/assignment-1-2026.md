# Assignment 1 feedback - Xinyi Lyu

**Formative feedback | Rubric 2026.2**

You have both converter scripts, a repository map and an explicit argument-count check. The Q4 explanation also identifies why wrapped sequence lines need to be joined before motif counting. These give you a starting point, but the commands still depend too much on your local setup.

The converters hard-code a results directory under ~/Documents/EECCourseWork. That location will not belong to someone else's checkout, and the tab converter also folds the whole input path into its output path. Use the repository's own results directory and the input basename, then inspect where the converted file actually appears. Check readability and conversion success, send errors to stderr and do not print Done after a failure.

The Unix answers use bare FASTA filenames rather than paths from code/. Q2 did not run successfully there, and Q3-Q4 returned incorrect counts. Once the paths are fixed, correct Q3's inclusion of line endings and Q5's inclusion of header characters. Q1 and Q5 were not executed as single answers because they are spread across several commands. They need to work independently, without remembered shell assignments.

Your .tsv example contains commas rather than tabs, so it cannot demonstrate tab conversion. Replace it with a genuine small tab-delimited table, preferably with an empty field. Add exact commands, tests, bc and any help record to the README, and use a straightforward results ignore rule. The next check should be from a fresh checkout, not from the directory arrangement already on your machine.

---

## Project structure

Relevant tracked layout (simplified; missing required paths are marked):

```text
README.md
.gitignore
code/  unixPrac1.txt, tabtocsv.sh, csvtospace.sh
data/fasta/  3 required files present
data/temperatures/  4 required files present
data/tab-example.tsv [present; comma-delimited contents]
results/  no files tracked; generated on run
sandbox/  no files tracked; optional
Also: READ.md
```

The required root files, assessed code and input filenames are all present. The own .tsv file contains commas, so its name does not yet correspond to its role. There is also READ.md at the root, alongside README.md. No result or sandbox files are tracked.

Keep README.md as the main entry point and clarify whether READ.md has a separate purpose. Replace the own fixture with a genuine tab-delimited table. Prefer ignoring the generated results directory to ignoring CSV files generally: your temperature exception works, but a broad CSV rule could hide required data for later work.

**Assessed snapshot:** `f01020ecbebbbceb33ab93139f998cd7c05b129d`
