




#-----------------------------Loading Packages---------------
rm(list = ls())


# Load required packages
# check to see if packages are installed. Install them if they are not, then load them into the R session.

# Set dropbox directory
if(Sys.info()[['sysname']]=="Windows") {  
  dropboxroot <- paste0("C:/Users/",Sys.info()[['user']],"/Dropbox/")
} else{
  if(Sys.info()[['sysname']]=="Darwin"){    
    dropboxroot <- paste0("/Users/",Sys.info()[['user']],"/Dropbox/")
  }
}


ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# usage
packages <- c("shiny","stringr","lpSolve","haven","plyr","dplyr","lfe" ,"labelled","readr", "data.table","bit64","reshape2","ggplot2","readxl","scales","R.utils","magrittr","xtable")
ipak(packages)

rep.row<-function(x,n){
  matrix(rep(x,each=n),nrow=n)
}



rt_import <- function(date){
  url <- paste0("http://mis.nyiso.com/public/csv/realtime/", date, "realtime_zone.csv")
  rt <-  read.csv(url,stringsAsFactors = F)
  rt$Time.Stamp <- as.POSIXct(rt$Time.Stamp,format="%m/%d/%Y %H:%M",tz=Sys.timezone())
  return(rt)
}




rt_import_range <- function(start_date, end_date){
  dt <- seq(as.Date(start_date), as.Date(end_date), by="days")
  dtt <- as.character(dt)
  dtt <- str_replace(dtt,"-","")
  dtt <- str_replace(dtt,"-","")
  d <- lapply(dtt,rt_import)
  t <- lapply(dtt, rt_import) %>% bind_rows()
  return(t)
  write.csv(df,"realtime.csv", row.names = FALSE)
}


#start_date<- "2020/06/01"
#end_date <- "2020/06/05"


df <- rt_import_range(start_date = "2020-06-01", end_date = "2020-06-03")


