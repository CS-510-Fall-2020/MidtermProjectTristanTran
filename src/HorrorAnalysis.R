packages<-c("textdata","dplyr","gutenbergr","tidytext","wordcloud")
install.packages(setdiff(packages, rownames(installed.packages())))  
library(tidytext)
library(dplyr)
library(gutenbergr)
library(stringr)
library(wordcloud)
library(tidyr)
library(ggplot2)


dir.create("results")
books <- read.table("data/booklist.csv",header=TRUE,sep=",")

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
  filename = paste("results/",title,".jpeg",sep="")
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

#get for each chapter (defined as 80 lines) find the net positive sentiment for each book
horror_sentiment <- tidy_horror %>%
  inner_join(get_sentiments("bing"))%>%
  count(title,index = linenumber%/% 80, sentiment) %>%
  spread(sentiment,n,fill=0)%>%
  mutate(sentiment = positive-negative)

#graph the net positive affinity for each novel.f
ggplot(horror_sentiment, aes(index, sentiment, fill = title)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~title, ncol = 2, scales = "free_x")

ggsave("results/booktrajectory.jpeg")
