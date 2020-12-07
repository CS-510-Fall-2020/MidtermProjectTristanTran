# MidtermProjectTristanTran
Midterm project Tristan Tran

## About the Analysis
This project takes in several Gutenberg ID's and titles for classic horror novels and performs text mining on them. It outputs word clouds and in the future expansion will include work with sentiment analysis, measuring the count of fear throughout the text. Based on the example through tidy text, text mining tutorial. I'm pretty proud of it, but it's still got a ways to go.
https://www.tidytextmining.com/

## Code Inputs
The code takes in a CSV containing gutenberg ID's. feel free to add any books you would like. They don't have to be horror, but I just particularly like that genre. You can find more titles and ids here
http://www.gutenberg.org/

## Code Out
It will return jpeg word clouds and some plots showing the most commonly used words in each book and a sentiment analysis by chapter.

## To run the analysis
1. Open the R Project.
2. Create a "results/" folder in the top directory.
3. Make changes to the inputs as desired.
4. source("src/HorrorAnalysis.R", chdir = TRUE)
