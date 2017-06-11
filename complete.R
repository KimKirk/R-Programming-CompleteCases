##created by Kimberley Kirk 06-04-2017

##reports number of completely observed cases for each variable across various air pollution monitors
complete <- function(directory, id = 1:332) {
    ##set working directory to where the "specdata" folder is
    setwd(file.path("C:", "Users", "Michael", "Desktop", "Inbox", "Career Change", "Data Science", "R Programming", directory))

    ##find all csv files in current working directory
    csv_files_list_all = list.files(pattern="*.csv")

    ##apply read.csv function across list of all found csv files
    all_data_data_frame <- do.call(rbind, lapply(csv_files_list_all, function(x) read.csv(x, colClasses= c("Date", "numeric", "numeric", "integer"), comment.char="" )))
    
    ##find rows for a specific monitor ID
    all_data_subset_IDs <- all_data_data_frame[all_data_data_frame$ID %in% id, ]
    
    ##find rows where no NA
    subset_IDs_no_NA <- all_data_subset_IDs[complete.cases(all_data_subset_IDs), ]

    ##find length of each ID and order by ID, set new names for columns
    ordered <- setNames(aggregate(subset_IDs_no_NA[,3],by=list(subset_IDs_no_NA$ID),FUN=length), c("id","nobs"))

    return (ordered)
    
}