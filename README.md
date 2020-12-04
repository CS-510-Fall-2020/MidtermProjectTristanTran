# MidtermProjectTristanTran
Midterm project Tristan Tran

## About the Analysis
This project takes in several Gutenberg ID's and titles for classic horror novels and performs text mining on them. It outputs word clouds and in the future expansion will include work with sentiment analysis, measuring the count of fear throughout the text.

## Code Inputs
The code takes in a CSV containing gutenberg ID's.

## Code Out
It will return jpeg word clouds and some plots showing the most commonly used words in each book and a sentiment analysis by chapter.

## To run the analysis
1. Open the R Project.
2. Create a "results/" folder in the top directory.
3. Make changes to the inputs as desired.
4. source("src/HorrorAnalysis.R", chdir = TRUE)
