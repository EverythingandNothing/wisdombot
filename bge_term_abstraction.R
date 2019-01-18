

# TERM ABSTRACTION


start<-Sys.time()
print("starting term abstraction")


#open libraries
library(textstem)

# ATTEMPT TO USE TREETAG FAILED, USING OTHER METHODS UNTIL THEN
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




leammatizedtext <- lemmatize_words(cleanedtext)

