packages<-c("textdata","dplyr","gutenbergr","tidytext","wordcloud","readr","tibble")
install.packages(setdiff(packages, rownames(installed.packages())))  
library(tidytext)
library(dplyr)
library(gutenbergr)
library(stringr)
library(wordcloud)
library(tidyr)
library(ggplot2)
library(readr)
library(tibble)

create_stop_words <- function(stop_words_csv){
  my_stop_words <- read_csv(stop_words_csv)
  my_stop_words <- my_stop_words %>% add_column(lexicon = "horror_novels")
  all_stop_words <- stop_words %>%
    bind_rows(my_stop_words)
  return(all_stop_words)
}

create_tidy_books <- function(gutenberg_collection){
  result <- gutenberg_collection %>%
    group_by(gutenberg_id) %>%
    mutate(linenumber = row_number(),
           chapter = cumsum(str_detect(text, 
                                       regex("^chapter [\\divxlc]",
                                             ignore_case = TRUE)))) %>%
    ungroup()%>%
    unnest_tokens(word, text)
  return(result)
}

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

get_net_sentiment <- function(book_collection,chunklength){
  result <- tidy_horror %>%
    inner_join(get_sentiments("bing")) %>%
    count(title,index = linenumber %/% chunklength, sentiment) %>%
    spread(sentiment,n,fill=0) %>%
    mutate(sentiment = positive-negative)
  return(result)
}
