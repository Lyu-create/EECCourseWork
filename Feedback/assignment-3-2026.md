# Assignment 3 formative feedback

This feedback is organised using the [Computing Bootcamp rubric](https://mulquabio.github.io/MQB/rubrics/Computing_Bootcamp_Rubric.html). It does not award a mark; use it to decide what to revise and check before final submission.

## Criterion 1: Repository organisation & workflow discipline

- The required source and input files are present. Generated results are not tracked, and `.gitignore` excludes `results/` and `sandbox/`. Your Git history includes descriptive change messages. Your README also provides Assignment 3 commands, input/output paths and a filename limitation.
- Before final submission, **Make output creation reproducible from a newly cloned copy of your repository, where `results/` does not yet exist.** The supplied scripts write into `results/` without visibly creating it. Since that directory is ignored, another user may not have it. Arrange for the output directory to be created when needed, then test each route from the directory containing `code/`, `data/` and the root `README.md`. The successful tree runs do not establish this behaviour in a newly cloned copy of the repository.

## Criterion 2: Code completeness & functional correctness

- Both tree-height routes ran successfully: the fixed route produced `results/TreeHts.csv`, and the generalised route produced `results/trees_treeheights.csv`. Separate comparison with the expected outputs found that each satisfied the stated tree-height required output format and values. This supports those outputs, rather than establishing understanding by itself.

## Criterion 3: Code quality & style

As you revise, keep names descriptive, use comments to explain decisions rather than restating code, and avoid repeating the same calculation in several places.

## Criterion 4: Documentation

Give exact commands in the root `README.md`, together with each script’s input and output files, so that another student could repeat your checks.

## Criterion 5: Version-control practice

Commit each functional revision with a short message that says what changed; this makes your development easier to follow than one large final commit.

## Criterion 8: Basic error-handling & input validation

- Your code shows explicit checks for headers, numeric values, finite values and measurement ranges. The invalid runs halted with relevant distance errors and the expected no-output behaviour.

## Criterion 9: Problem-solving approach & method implementation

- Your README records an independent, direct trigonometric calculation for one tree and reports agreement with the saved height. This usefully connects the original measurements, degree conversion and output.
- Before final submission, **Remove the interactive dependency blocking Pound Hill.** The command stopped at `View(MyWrangledData)` because no graphical display was available. Consequently, neither `results/pound_hill_plot_richness.csv` nor `results/pound_hill_plot_richness.pdf` was generated. Keep interactive viewing outside the required batch run, or replace it with a console-friendly inspection. Then rerun and compare these exact required paths with the filenames actually created; even a spelling difference matters.
- Before final submission, **Check the full Pound Hill route after fixing the blocker.** Your code shows that filtering to positive counts before grouping could omit an entirely zero-count quadrat, affecting plot means if such a quadrat occurs. Compare quadrat identifiers before and after filtering, and check one quadrat’s richness and abundance manually. Also explicitly print each plot during script execution and close its PDF device before opening the next. No newly generated PDF was available for visual review: inspect labels, plotted values and biological meaning after rerunning. Your comments distinguish richness from abundance and avoid a causal claim, but the stated treatment patterns still need checking against regenerated outputs.

## Criterion 10: Learning progression demonstration

Use this feedback as a revision checklist. Make the changes in small, descriptive commits, then add a short README note explaining what you changed and how you checked it. This will make your development from this formative checkpoint visible in the final portfolio.

## Priorities before final submission

- Rerun one ordinary and one invalid case for **each** tree-height route. Check stderr, exit behaviour and whether any new result is written; a failed run should not leave a misleading new output.
- Add the direct command-line usage for `get_TreeHeight.R` to the README, alongside the wrapper example. Refresh the file listing, which still names files shown as deleted in your Git history.
- Commit the focused fixes with descriptive messages, keeping generated outputs untracked.
