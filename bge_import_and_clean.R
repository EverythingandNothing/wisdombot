
# IMPORT AND CLEANING
#known improvement is that i need to suppress all the code and just show the logs


start<-Sys.time()
print("starting import and cleaning")

#open libraries

library(stringr)
library(rvest)
library(XML)
library(tidyr)
library(tm)


# IMPORTING

# importing nietzsche's beyond good and evil from gutenberg library

url <- "https://www.gutenberg.org/files/4363/4363-h/4363-h.htm"

webpage <- read_html(url)

#taking the text from the url 

bge <- webpage %>% html_nodes("p") %>% html_text()  

bge <- iconv(bge, "latin1", "ASCII", sub=" ")

print("import finished.")


#CLEANING 

#bge is full text, cutting down to just apophthegms
#known badness here is that i hardcoded the start and end. 
# this should be abstracted to a function that takes url, start and end strings as inputs and cuts down to that

apophthegms <- bge[83:207]

#each sentence begins w/ "\n    " so gonna take that out, take out punctuation and digits and whitespace
apophthegms <- gsub("\n"," ",apophthegms)

apophthegms <- gsub('[[:punct:] ]+',' ',apophthegms)

apophthegms <- gsub('[[:digit:]]+', ' ', apophthegms)

apophthegms <- tolower(apophthegms)

apophthegms <- trimws(apophthegms, which = c("right"))

#create cleaned text 

cleanedtext <- apophthegms

#create cleaned words and then remove stop words

stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
stopwords_regex = paste0('\\b', stopwords_regex, '\\b')

cleanedwords <- unlist(strsplit(apophthegms,split = " "))
cleanedwords <- str_replace_all(cleanedwords,stopwords_regex,'') 

wordcountbefore <- length(cleanedwords)

cleanedwords <- cleanedwords[cleanedwords != '']

wordcountafter <- length(cleanedwords)
pctremoved <- round(((wordcountbefore-wordcountafter)/wordcountbefore)*100,1)

cat(wordcountbefore-wordcountafter," words (",pctremoved,"%) were removed. ",wordcountafter," words remain.")

# the lemmatization function requires the text to be in a .txt file encoded in UTF-8

textfile <- "cleanedtext.txt"
wordfile <- "cleanedwords.txt"

Encoding(cleanedtext) <- "UTF-8"
Encoding(cleanedwords) <- "UTF-8"

write.table(cleanedtext, file = textfile,sep = "")
write.table(cleanedwords, file = wordfile,sep = "")



print("text and words have been cleaned and saved as .txt")

#measure time it took 

end <- Sys.time()

end - start
