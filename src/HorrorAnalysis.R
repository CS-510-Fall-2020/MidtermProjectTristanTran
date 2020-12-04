install.packages("textdata")
install.packages("gutenbergr")
install.packages("tidytext")
install.packages("wordcloud")
library(tidytext)
library(dplyr)
library(gutenbergr)
library(stringr)
library(wordcloud)

books <- read.table("../data/booklist.csv",header=TRUE,sep=",")
horror_book_id = books["gutenberg_id"]
horror_books <- gutenberg_download(horror_book_id, meta_fields = "title")

tidy_horror <- horror_books %>%
  group_by(gutenberg_id) %>%
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, 
                   regex("^chapter [\\divxlc]",
                   ignore_case = TRUE)))) %>%
  ungroup()%>%
  unnest_tokens(word, text)

create_wordcloud <- function(id,title,tidy_books){
  filename = paste("../results/",title,".jpeg",sep="")
  jpeg(file = filename)
  tidy_books%>%
    filter(gutenberg_id == id) %>%
    anti_join(stop_words) %>%
    count(word)%>%
    with(wordcloud(word, n, max.words = 100,min.freq = 10,scale=c(4,.5)))
  dev.off()
}




for (row in 1:nrow(books)){
  id <- books[row,1]
  title <-books[row,2]
  print(paste(id,title))
  create_wordcloud(id,title,tidy_horror)
}

nrc_fear <- get_sentiments("nrc")%>%
  filter(sentiment == "fear")

#does the code for one book
tidy_horror%>%
  filter(gutenberg_id == 42) %>%
  inner_join(nrc_fear)%>%
  count(word,sort=TRUE)

#create a for each loop\
for (id in horror_book_id){
  tidy_horror%>%
    filter(gutenberg_id == 42) %>%
    inner_join(nrc_fear)%>%
    count(word,sort=TRUE)
}

