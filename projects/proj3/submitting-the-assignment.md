# Submitting the Assignment

## Files

You may **not** modify the signature of any methods or classes that we provide to you, but you're free to add helper methods.

You should make sure that all code you modify belongs to files with `TODO(proj3)` comments in them \(e.g. don't add helper methods to DataBox\). A full list of files that you may modify follows:

* `src/main/java/edu/berkeley/cs186/database/query/join/BNLJOperator.java`
* `src/main/java/edu/berkeley/cs186/database/query/join/SortOperator.java`
* `src/main/java/edu/berkeley/cs186/database/query/join/SortMergeOperator.java`
* `src/main/java/edu/berkeley/cs186/database/query/join/GHJOperator.java`
* `src/main/java/edu/berkeley/cs186/database/query/QueryPlan.java` \(Part 2 only\)

Make sure that your code does _not_ use any static \(non-final\) variables - this may cause odd behavior when running with maven vs. in your IDE \(tests run through the IDE often run with a new instance of Java for each test, so the static variables get reset, but multiple tests per Java instance may be run when using maven, where static variables _do not_ get reset\).

## Gradescope

Once all of your files are prepared in your repo you can submit to Gradescope through GitHub the same way you did for [Project 0](../proj0/submitting.md#pushing-changes-to-github-classroom).

## Submitting via upload <a id="submitting-via-upload"></a>

If your GitHub account has access to many repos, the Gradescope UI might time out while trying to load which repos you have available. If this is the case for you, you can submit your code directly using via upload. You can zip up your source code with `zip -r submission.zip src/` and submit that directly to the autograder.

## Partners

If you haven't yet already be sure to fill out [this form](https://docs.google.com/forms/d/e/1FAIpQLSdnDiXgyjRRFvm2mQ0G4M1o2xjGMDLpjXlOjbDzfAxPGibvZg/viewform?usp=sf_link) so we know who you're working with. Every student is responsible for submitting to gradescope individually -- if you submit but your partner doesn't then your partner will not got credit. If you worked off of a shared repo both members of the group are free to submit that repo. Slip days will be deducted individually. For example: You submit on time, but your partner submits a day late. Your partner will have to use a slip day or will receive a late penalty on the project \(but you will not\).

## Grade breakdown

This project is worth 8% of your overall grade.

* **30% of your score will come from your submission for Part 1**. We will only be running public Part 1 tests on your Part 1 submission.
* **70% of your score will come from your final submission**. We will be running the hidden Part 1 tests, the public Part 2 tests, and the hidden Part 2 tests on your Part 2 submission.
* 60% of your overall score will be made up of the tests released in this project \(the tests that we provided in `database.query.*`\).
* 40% of your overall score will be made up of hidden, unreleased tests that we will run on your submission after the deadline.
* The combined public and hidden tests from Part 1 are worth 50%
* The combined public and hidden tests from Part 2 are worth 50%.
