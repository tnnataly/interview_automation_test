# Welcome to the farmdrop technical test for automation testers

Please spend no more than two hours on the following task. You are not expected to finish all of it - this is as much to understand how you approach things as it is to see if you can build working tests.

## Background
Farmdrop sometimes uses a staging site at [https://staging-web.farmdrop.com](https://staging-web.farmdrop.com) to run integration tests.  The database is reset periodically and the payments system is connected to a sandbox, so you can experiment freely.

## Task
Please build a suite of tests for the sign up form which will run against this staging site.

1. Write out a series of scenarios as a Cucumber feature file(s). Try to think from regression prospective and come up with as many scenarios as you feel are appropriate in order to make sure this form is fully tested.
2. Begin to automate your scenarios and continue until your allocated time runs out. Use Cucumber/Ruby and any other gems/frameworks you feel are appropriate.

## Notes
* Code reuse is important to us, so we are interested in seeing what approaches you take to keep your code and tests modular.
* Can you show an approach to handle multiple browsers(headless,chrome should do) as well.
* Your submission should include instructions on how to run it.

## Submission
Please fork this repository and commit code to it. Send us the link to your repo in an email.

Good Luck!!!
