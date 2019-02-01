


# RECREATION


start<-Sys.time()
print("starting random sentence creation")


returnPOS <- function(POS){
  
  num <- length(subset(dfwords$words,dfwords$POS==POS))
  wordlist <- subset(dfwords$words,dfwords$POS==POS)
  rand <- sample(num,1)
  
  return(wordlist[rand])
  
}



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


