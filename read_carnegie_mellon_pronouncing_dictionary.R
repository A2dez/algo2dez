
# install.packages('tidyverse')
library(tidyverse)

# For some reason I can't read in the original data'
# data <- read_delim("https://github.com/Alexir/CMUdict/blob/master/cmudict-0.7b", delim = "  ", skip = 126)

# data <- read_delim("http://svn.code.sf.net/p/cmusphinx/code/trunk/cmudict/cmudict-0.7b", delim = "  "
# 
# cp /Users/cexsligo/data_des/csv_files/Carnegie_Mellon_Original_Cleaned.csv  Carnegie_Mellon_Original_Cleaned.csv 

#so here is a version which I edited for another project, getting rid of the top 126 rows
#and separating out the spellings from the pron(unciation)s
cmu <- read_csv('Carnegie_Mellon_Original_Cleaned.csv')



# 0. clean the data -------------------------------------------------------

#this is hilarious. the letters 'NA' form an entry and R read is as NA
x <- which(is.na(cmu$word))
# cmu[x,]

# A tibble: 1 x 3
#   word  phonForm length
#   <chr> <chr>     <int>
# 1 NA    N AA1        NA

cmu[x, 1] = 'na'

#remove  nas in the phone section
cmu <- filter(cmu, is.na(cmu$phonForm)  == F)


#make letters lowercase 
cmu$word <- tolower(cmu$word)

#add a column for number of letters
cmu$length <- str_count(cmu$word) 



  #lets get a list of phones & make a table
phoneset_frequencies <- str_c(cmu$phonForm, collapse = ' ') %>% 
  str_split(' ') %>% table() 

#dfrm it 
phoneset_freqs <- data.frame(phoneset_frequencies)

#sneaky way of separating out vowels and consonants (extract the number)
phoneset_freqs$vorc <- str_extract(phoneset_freqs$., '\\d')


phoneset_freqs <- phoneset_freqs %>% 
  arrange(vorc, Freq) 

#order phones by stress pattern
phoneset_freqs$. <- fct_reorder2(phoneset_freqs$., phoneset_freqs$vorc, phoneset_freqs$Freq)
 
 
phoneset_freqs %>% 
  ggplot( aes (x = ., 
               y = Freq, 
               fill = vorc)) +
  geom_bar(stat = 'identity') +
  coord_flip() +
  facet_wrap(vars(vorc),
             scales = 'free')



