#set up initial variables, gets number of rows
loop_start <-1 #Which row to start on
loop_count <-1 #Not using anymore
loop_stop <-as.integer(nrow(mydata))
#The function get_meta_content uses the variable xpath
xpath <- as.character("//meta[@property='og:title']")
#Set the column for the new data
new_column <- 11
#Here comes the loop
#for each row the url will get pulled an the resulting meta contetn will be added to "new_column"
for (i in loop_start:loop_stop){

tryCatch(
  {
    # 'tryCatch()' will return the last evaluated expression 
    # in case the "try" part was completed successfully
    
    result_content <- as.character(get_meta_content(as.character(mydata[[loop_start,2]])))
    mydata[[loop_start,new_column]] <- iconv(result_content) #iconv fixes some text encoding issues
    message(paste( "Completed Row: ", loop_start)) 
    # The return value of `readLines()` is the actual value 
    # that will be returned in case there is no condition 
    # (e.g. warning or error). 
    # You don't need to state the return value via `return()` as code 
    # in the "try" part is not wrapped insided a function (unlike that
    # for the condition handlers for warnings and error below)
  },
  error=function(cond) {
    message(paste("Problem with URL:", as.character(mydata[[loop_start,2]])))
    message(paste("Error in row:", loop_start))
    # Choose a return value in case of error
    mydata[[loop_start,new_column]] <- as.character("Error")
  },
  warning=function(cond) {
    message(paste("URL caused a warning:", as.character(mydata[[loop_start,2]])))
    message("Here's the original warning message:")
    message(cond)
    # Choose a return value in case of warning
    mydata[[loop_start,new_column]] <- as.character("Warning")
  },
  finally={
    # NOTE:
    # Here goes everything that should be executed at the end,
    # regardless of success or error.
    # If you want more than one expression to be executed, then you 
    # need to wrap them in curly brackets ({...}); otherwise you could
    # just have written 'finally=<expression>' 
    loop_start <- loop_start +1
    Sys.sleep(0.1) #Delay to prevent the server getting angry at too requests
  }
)}

#Don't Tell Mom the Babysitter is Dead
message(paste("The Dishes are done man. I finished on row: ", loop_start))

