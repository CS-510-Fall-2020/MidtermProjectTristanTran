# MidtermProjectTristanTran
Midterm project Tristan Tran

## About the Analysis
This project takes in several Gutenberg ID's and titles for classic horror novels and performs text mining on them. It outputs word clouds and in the future expansion will include work with sentiment analysis, measuring the count of fear throughout the text. Based on the example through tidy text, text mining tutorial. I'm pretty proud of it, but it's still got a ways to go.
https://www.tidytextmining.com/

Sentiment analysis is the use of natural language processing to evaluate the feelings conveyed by words. This is done through using large databases to determine the feelings with which people use words.
For example: typically people will associate puppies with joy and rain with sadness. These sentiments are true in the general sense, but can vary in situations. For instance, clowns are intended to bring joy and had that connotation prior to the introduction of Stephen King's IT to popular culture.

The three lexicons for sentiments provided by tidytext are afinn, bing, and nrc. These are

below is a brief introduction to each lexicon:

### Bing

This is named after the team of Minqing Hu and Bing Liu and their 2004 paper mining and summarizing customer reviews. This lexicon provides a binary value for each word in the dictionary: positive or negative.

### Afinn

This lexicon gives some more granularity to the positive or negative emotions. It rates each word on a scale between -5 (the most negative) and +5 (the most positive)


### NRC
The nrc emotion lexicon is a list of english words and their associations with one of the eight basic emotions: anger, fear, anticipation, trust, surprise, sadness, joy, and disgust. This is useful to find the general tone of sections of a book.

## Code Inputs
The code takes in a CSV containing gutenberg ID's. feel free to add any books you would like. They don't have to be horror, but I just particularly like that genre. You can find more titles and ids here
http://www.gutenberg.org/

## Code Out
It will return jpeg word clouds and some plots showing the most commonly used words in each book and a sentiment analysis by chapter.

### Data Manipulation: Create Tidy Books
The create tidy books function takes in a gutenberg download file and turns it into a tidy text format. Gutenberg books are organized by the (gutenberg_id,text,title) where the text field represents an entire line of text.
Using the tidytext library, we split each group by their unique identifier and create fields for linenumber and chapter. We also unnest each word in the text so that it can be in its own row. Although this makes the novel less readable to humans, it is a much more manageable dataset.

### Visualizing Word Frequency: Word Clouds
The word clouds will create a graphic based on the count of each word and their frequency throughout the novel. This will usually be skewed towards the names of the main characters in novels. If a word is used too frequently so that the scale will cause it to run off the page, it will not be included in the graph and will be displayed as whitespace instead. Check the warnings in the R console for specifics.


### Visualizing The Progression of Poisitive or Negative Sentiment: Trajectory Plot
The get_net_sentiment() function gets the net positive vs negative wordcount for each chunk of 80 lines in a book. The max score is 80 minimum score is -80.

##Goals of the Project
The purpose of this project was to create a relatable visual representation of each book that might reveal trends for individual books or book collections as a whole. We could use this to explore questions such as "What are the prevelant themes in certain works of literature?" "Do most books have happy endings?" "How do I get out of reading this novel for my monthly book club?"

## To run the analysis
1. Open the R Project.
2. Create a "results/" folder in the top directory.
3. Make changes to the inputs as desired.
4. source("src/HorrorAnalysis.R", chdir = FALSE)

## Challenges
- Most classic works of literature are written with different lexicons: Clowns used to be popular entertainment for children's parties and are now a common fear. 
- Omission of anachronistic sentiments such as the use of the word miss as both an honorific vs. a failure.
- Automatic scaling of the word cloud so that most popular words are not omitted
- Ommission of character names from word clouds.