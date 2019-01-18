
# IMPORT AND CLEANING


start<-Sys.time()
print("starting import and cleaning")

#open libraries

library(stringr)
library(rvest)
library(XML)
library(tidyr)


# IMPORTING

# importing nietzsche's beyond good and evil from gutenberg library

url <- "https://www.gutenberg.org/files/4363/4363-h/4363-h.htm"

webpage <- read_html(url)

#taking the text from the url 

bge <- webpage %>% html_nodes("p") %>% html_text()  

bge <- iconv(bge, "latin1", "ASCII", sub="")

print("imported")


#CLEANING 

#bge is full text, cutting down to just apophthegms
#known badness here is that i hardcoded the start and end. 
# this should be abstracted to a function that takes url, start and end strings as inputs and cuts down to that
apophthegms <- bge[83:207]

#each sentence begins w/ "\n    " so gonna take that out, take out punctuation and digits and whitespace
apophthegms <- gsub("\n","",apophthegms)

apophthegms <- gsub('[[:punct:] ]+',' ',apophthegms)

apophthegms <- gsub('[[:digit:]]+', '', apophthegms)

apophthegms <- tolower(apophthegms)

apophthegms <- trimws(apophthegms)

#create cleaned text 

cleanedtext <- apophthegms

#create cleaned words and then remove stop words

cleanedwords <- unlist(strsplit(apophthegms,split = " "))

#cleanedwords <- 

# the lemmatization function requires the text to be in a .txt file encoded in UTF-8

Encoding(cleanedtext) <- "UTF-8"

write.table(cleanedtext, file = "cleanedtext.txt",sep = "")


print("cleaned")

#measure time it took 

end <- Sys.time()

end - start
