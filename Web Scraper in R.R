#set up initial variables, gets number of rows
loop_start <-1 #Which row to start on
loop_count <-1 #Not using anymore
loop_stop <-as.integer(nrow(mydata))
#The function get_meta_content uses the variable xpath
xpath <- as.character("//meta[@property='article:published_time']")
#Set the column for the new data
new_column <- 12
#Here comes the loop
#for each row the url will get pulled an the resulting meta contetn will be added to column 11
for (i in loop_start:loop_stop){
  
result_content <- as.character(get_meta_content(as.character(mydata[[loop_start,2]])))
mydata[[loop_start,new_column]] <- result_content
loop_start <- loop_start +1
loop_count <- loop_count +1
Sys.sleep(1)
}

#Don't Tell Mom the Babysitter is Dead
cat("The Dishes are done man. I finished up to row:", loop_start) 
#Eventually I need to add an if else error to skip 403 etc


