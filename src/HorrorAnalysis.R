
source("src/sentiment_analysis.R")
dir.create("results")
books <- read.table("data/booklist.csv",header=TRUE,sep=",")

horror_book_id = books["gutenberg_id"]
horror_books <- gutenberg_download(horror_book_id, meta_fields = "title")

tidy_horror <- create_tidy_books(horror_books)

for (row in 1:nrow(books)){
  id <- books[row,1]
  title <- books[row,2]
  print(paste(id,title))
  create_wordcloud(id,title,tidy_horror)
}

horror_sentiment <- get_net_sentiment(tidy_horror,80)

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
