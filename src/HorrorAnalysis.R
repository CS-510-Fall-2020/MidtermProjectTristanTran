
source("../src/sentiment_analysis.R")
dir.create("../results")
# load in the books from the csv and clean them up
books <- read.table("../data/booklist.csv",header=TRUE,sep=",")
horror_book_id = books["gutenberg_id"]
horror_books <- gutenberg_download(horror_book_id, meta_fields = "title")

# filter out stop words
all_stop_words <- create_stop_words("../data/ignore.csv")
#create tidy book collection
tidy_horror <- create_tidy_books(horror_books) %>%
  anti_join(all_stop_words,by="word")

#create word clouds for each novel
for (row in 1:nrow(books)){
  id <- books[row,1]
  title <- books[row,2]
  create_wordcloud(id,title,tidy_horror)
}
# get for each chunk (defined as 80 lines) 
# find the net positive sentiment for each book
horror_sentiment <- get_net_sentiment(tidy_horror,80)


#graph the net positive affinity for each novel.f
ggplot(horror_sentiment, aes(index, sentiment, fill = title)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~title, ncol = 2, scales = "free_x")

ggsave("../results/booktrajectory.jpeg")
