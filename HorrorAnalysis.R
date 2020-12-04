install.packages("textdata")
install.packages("gutenbergr")
install.packages("tidytext")
install.packages("wordcloud")
library(tidytext)
library(dplyr)
library(gutenbergr)
library(stringr)


horror_book_id = c(42324,345,42)
horror_titles = c("Frankenstein","Dracula","Dr. Jekyll and Mr. Hyde ")
horror_books <- gutenberg_download(horror_books, meta_fields = "title")


tidy_horror <- horror_books %>%
  group_by(gutenberg_id) %>%
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, 
                   regex("^chapter [\\divxlc]",
                   ignore_case = TRUE)))) %>%
  ungroup()%>%
  unnest_tokens(word, text)

library(wordcloud)

for (id in horror_book_id){
  filename = paste(id,".jpeg",sep="")
  jpeg(file = filename)
  clound <-  tidy_horror%>%
    filter(gutenberg_id == id) %>%
    anti_join(stop_words) %>%
    count(word)%>%
    with(wordcloud(word, n, max.words = 100,min.freq = 10,scale=c(4,.5)))
  dev.off()
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

