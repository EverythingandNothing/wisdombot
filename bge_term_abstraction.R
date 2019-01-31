

# TERM ABSTRACTION


start<-Sys.time()
print("starting term abstraction")


#open libraries
library(NLP)
library(openNLP)
library(openNLPmodels.en)
library(tm)
library(stringr)
library(gsubfn)
library(plyr)


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
listtext <- list("text" = cleanedtext)

texttagged <- sapply(listtext, function(x){
   sent_token_annotator <- Maxent_Sent_Token_Annotator()
   word_token_annotator <- Maxent_Word_Token_Annotator()
   pos_tag_annotator <- Maxent_POS_Tag_Annotator()
   y1 <- annotate (x,list(sent_token_annotator,word_token_annotator))
   y2 <- annotate(x, pos_tag_annotator, y1)
   # y3 <- annotate (x, Maxent_POS_Tag_Annotator ( probs = TRUE ),y1)
 y2w <- subset(y2, type == "word")
 tags <- sapply(y2w$features , '[[', "POS")
 r1 <- sprintf("%s/%s", x[y2w] , tags)
 r2 <- paste (r1, collapse = " ")
 return (r2)})












