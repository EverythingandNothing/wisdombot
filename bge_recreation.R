


# RECREATION


start<-Sys.time()
print("starting random sentence creation")


#helper function used in next function. 
# input is a POS, function returns a word that matches that POS

returnPOS <- function(POS){
  
  num <- length(subset(dfwords$words,dfwords$POS==POS))
  wordlist <- subset(dfwords$words,dfwords$POS==POS)
  rand <- sample(num,1)
  
  return(wordlist[rand])
  
}


# function selects a sentence strucutre and fills it in w/ random words 

generateRandSentence <- function(){
  
  sentenceindex <- sample(1:length(listtext$text),1)
  sentencestructure <- listtext$POS[[sentenceindex]]
  randsentence <- c()
  
  for(i in 1:length(sentencestructure)){
    randsentence <- c(randsentence,returnPOS(sentencestructure[i]))
  }
  return(randsentence)
}






print("done.")

end <- Sys.time()

end - start


