# Assignment 2 formative feedback

This feedback is organised by the relevant computing bootcamp criteria. Use it to decide what is already working, what you need to investigate, and what to revise before the cumulative submission.

The full criteria are in the [Computing Bootcamp assessment rubric](https://github.com/MulQuaBio/MQB/blob/main/content/rubrics/Computing_Bootcamp_Rubric.md).

## 1. Repository organisation and workflow discipline

- Your root README, `.gitignore`, cleaning script, test script and supplied data files are in the expected locations. The supplied CSV and metadata are unchanged, giving you a reproducible starting point.

## 2. Code completeness and functional correctness

- The supplied raw CSV and metadata are unchanged. The cleaning workflow completed and generated all three outputs. Separately, output checks found that the clean-records and issues tables satisfied their required output format and contents in both test runs.
- **Trace the oak-summary discrepancy.** Although execution completed, the output check found a difference in the `species` field of row 2 in `oak_species_counts.csv` in both test runs. This is a specific output issue, not a failure to run. Trace accepted oak records from `clean_records` into `summarise_oaks()` and then into the writer. Check how species labels become summary keys and how output rows are ordered; this will help distinguish a grouping or labelling issue from an ordering issue without changing already-matching outputs unnecessarily.

## 3. Code quality and style

- Your `main()` function gives the program a clear overall structure by connecting loading, processing, summarising and writing. Keep these stages distinct as you revise; use descriptive names and add short comments where the reason for a validation check or data-cleaning step is not obvious.

## 4. Documentation

- Your root README is in place. Make it useful to someone opening the repository for the first time: explain what the cleaner does, how to run the script and tests from the repository root, and which three files it creates. Test the instructions in a newly cloned copy of your repository (a separate folder created with `git clone`): enter that folder and run each README command exactly as written. If something fails, correct the command or add the missing step.

## 5. Version-control practice

- Since the previous formative feedback was added, the saved history contains 12 non-merge commits. Messages such as `using assertions to test codes under different conditions`, `add boundary value test for distance_m`, and `Delete test_silwood_trees.py in the wrong place` make both additions and corrections visible.
- Keep this pattern for the final revisions. Before each commit, use `git diff --staged` to check that it contains one coherent, working change, then write a concise message that names that change and, where it is not obvious, why it was needed.

## 8. Basic error handling and input validation

- Your separate test file is present and ran successfully. Your code contains assertion-style checks covering record validation, accepted/rejected partitioning and the oak summary. These exercise several stages of the workflow, although successful execution does not show that every important case is covered.
- **Turn the diagnosis into a regression test.** The existing tests cover the summary, but they have not prevented this discrepancy. Add a small, hand-checkable case that reproduces the behaviour you identify, asserting the relevant species labels, counts and any ordering required by the brief. This makes the correction repeatable rather than dependent on visual inspection.
- Make the smallest justified correction, add the regression test and rerun both your tests and the full workflow. Recheck all three tables.

## 9. Problem-solving approach and method implementation

- Your code shows a connected workflow: `main()` calls `load_records()` to read the supplied CSV, passes rows to `process_records()`, which calls `validate_record()`, and receives `(clean_records, issues)`. The cleaned collection then reaches `summarise_oaks()`, followed by three `write_csv()` calls. The flow from input to outputs is easy to follow.
- Trace one borderline record through validation and the accepted/rejected branch, then trace accepted oak records through the summary and written output.
- After correcting the logic, keep the smallest example that exposed each problem as an assertion-based regression test in `code/test_silwood_trees.py`. Check the relevant function return value and the affected output table, then briefly explain the corrected data flow in your root README.
