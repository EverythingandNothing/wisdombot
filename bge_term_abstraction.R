

# TERM ABSTRACTION


start<-Sys.time()
print("starting term abstraction")


#open libraries and import csv of POS descriptions
print("opening libraries and importing POS Descriptions")

library(NLP)
library(openNLP)
library(openNLPmodels.en)
library(tm)
library(stringr)
library(gsubfn)
library(plyr)
library(dplyr)

POSdescriptions <- read.csv("POSDescription.csv", stringsAsFactors = FALSE)


# ATTEMPT USING TREETAG; failed because it couldn't find a file called englishlexicon.txt
# i looked for this file and asked on stack overflow but couldn't figure it out so tried other methods
#
#library(koRpus)
# 
# #is this redundant? 
#library(koRpus.lang.en)
# 
# # taking the cleaned text and doing lemmatization
#set.kRp.env(lang="en")
# 
#lemmatizedtext <- tagged.results <- treetag(file = "cleanedtext.txt", treetagger="manual", format="obj",
#                                            TT.tknz=FALSE , lang="en",
#                                            TT.options=list(path="/Applications/TreeTagger", preset="en"))
# 

#ATTEMPT USING NLP/openNLP from http://martinschweinberger.de/docs/articles/PosTagR.pdf 
# formats the cleaned text as a list: $text is the raw text, $POS is the POS
print("tagging parts of speech")

listtext <- list("text" = cleanedtext)

sent_token_annotator <- Maxent_Sent_Token_Annotator ()
word_token_annotator <- Maxent_Word_Token_Annotator ()
pos_tag_annotator <- Maxent_POS_Tag_Annotator ()

#function takes a character vector as an input and outputs a list of the POS
tagPOS <- function(x){
  
  y1 <- annotate (x,list(sent_token_annotator,word_token_annotator))
  y2 <- annotate(x, pos_tag_annotator, y1)
  y2w <- subset(y2, type == "word") 
  tags <- list(sapply(y2w$features , '[[', "POS"))
  return(tags)
}

#applies the tag function to the text 
for (i in 1:length(listtext$text)){
  listtext$POS[i] <- tagPOS(listtext$text[[i]])
}


#creating a vector that holds all the words, remove blanks, join w POS and POS description

words <- c()

for(i in 1:length(listtext$text)){
  
  words <- c(words,unlist(strsplit(listtext$text[[i]],split=" ")))
  
}

words <- words[words != ""]

POS <- unlist(listtext$POS)

dfwords <- data.frame("words" = words, "POS" = POS, stringsAsFactors = FALSE) 
dfwords <- left_join(dfwords, POSdescriptions, by = "POS")




#measure time it took 

print("done.")

end <- Sys.time()

end - start











