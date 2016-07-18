#set up initial variables, gets number of rows
loop_start <-1 #Which row to start on
loop_count <-1 #Not using anymore
loop_stop <-as.integer(nrow(mydata))
#The function get_meta_content uses the variable xpath
xpath <- as.character("//meta[@property='og:title']")
#Set the column for the new data
new_column <- 11
#Here comes the loop
#for each row the url will get pulled an the resulting meta contetn will be added to column 11
for (i in loop_start:loop_stop){
  
result_content <- as.character(get_meta_content(as.character(mydata[[loop_start,2]])))
mydata[[loop_start,new_column]] <- result_content
loop_start <- loop_start +1
Sys.sleep(1) #Delay to prevent the server getting angry for requests
}

#Don't Tell Mom the Babysitter is Dead
cat("The Dishes are done man. I stopped on row:", loop_start) 
#Eventually I need to add an Try Catch function to move through errors like 403 and 503
#For now if the loop dies it just spits the number it was working on


