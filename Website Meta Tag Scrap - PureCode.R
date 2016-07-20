loop_start <-1 #Start scraping on this row
loop_stop <-as.integer(nrow(mydata))
xpath <- as.character("//meta[@property='og:title']")
new_column <- 11 #Set the column for the new data
for (i in loop_start:loop_stop){
  tryCatch(
    {
      result_content <- as.character(get_meta_content(as.character(mydata[[loop_start,2]])))
      mydata[[loop_start,new_column]] <- iconv(result_content)
      message(paste( "Completed Row: ", loop_start)) 
    },
    error=function(cond) {
      message(paste("Problem with URL:", as.character(mydata[[loop_start,2]])))
      message(paste("Error in row:", loop_start))
      mydata[[loop_start,new_column]] <- as.character("Error")
    },
    warning=function(cond) {
      message(paste("URL caused a warning:", as.character(mydata[[loop_start,2]])))
      message("Here's the original warning message:")
      message(cond)
      mydata[[loop_start,new_column]] <- as.character("Warning")
    },
    finally={
      loop_start <- loop_start +1
      Sys.sleep(1) #Delay to prevent the server getting angry at too requests
    }
  )}
cat("The Dishes are done man. I finished on row:", loop_start) 