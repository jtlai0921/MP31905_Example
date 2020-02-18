library(gutenbergr)
library(jiebaR)
library(ggplot2)
library(dplyr)
library(wordcloud)

mixSeg <- worker()
luxun <- gutenberg_download(27166)
luxun.seg <- segment(luxun$text, mixSeg)

luxun_head <- head(luxun.seg)
luxun_head

luxun.freq <- freq(luxun.seg)
colnames(luxun.freq) <- c("word","freq")
freq_df <- arrange(luxun.freq, desc(freq))
head(freq_df)

pos.tagger <- worker("tag")
luxun.pos <- segment(luxun$text, pos.tagger)
tmp_df <- data.frame(luxun.pos, names(luxun.pos))

colnames(tmp_df)<-c("Word","POS")

#Word_POS_Freq <- tmp_df%>%
#  group_by(Word,POS) %>% 
#  summarise(Frequency=n())

tmp_df %>%
  group_by(Word,POS) %>% 
  summarise(Frequency=n()) -> Word_POS_Freq

#str(Word_POS_Freq)

Word_POS_Freq <- arrange(Word_POS_Freq, desc(Word,POS))
head(Word_POS_Freq)

pos_r <- head(subset(Word_POS_Freq,Word_POS_Freq$POS == "r"),200)
pos_r

wordcloud(pos_r$Word,pos_r$Frequency)

#pos_n <- head(subset(Word_POS_Freq,Word_POS_Freq$POS == "n"),10)
#qplot(Word, Frequency, data = pos_n, color=Frequency)

#pos_n_barplot <- ggplot(aes(x = Word, y = Frequency), data = pos_n)+ geom_bar(stat="identity")
#pos_n_barplot

