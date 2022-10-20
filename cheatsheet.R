# Sarah Grobe
# Created September 2022
# Last Updated October 2022




# Examples available in advanceSales.R  (Jobs/Ticket Office Internship/Advance Sales/advanceSales.R)



# load in packages
require(dplyr)
require(ggplot2)
require(writexl)
require(scales)
require(reticulate)
require(readxl)




## Creating a function
functionName <- function(param1, param2) {
  # do things to the parameters here.....
  
  
  
  # if applicable:
  return(argument)      # functions can only return one argument, so if you need to return multiple objects,
                        # put them together in a list and return the list!
}

## Calling a function:

# if no return object:
functionName(p1, p2)

# if you want the return object:
output <- functionName(p1, p2)






#### Reading in Data ############################################################################

# set working directory to the location of the file:
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# read in data of various formats
d <- read_excel("file.xlsx")    # also works for xls files
d <- read.csv("file.csv")       # also works on .txt files if they have comma delimiters!
d <- read.delim("file.txt")


# if there isn't a header in the file (just raw data, no variable names)
d <- read.csv("file.csv", header = FALSE)   # works for any of the above methods

# if separated by something other than commas (e.g., a colon)
d <- read.delim("file.csv", sep = ":", header = FALSE)
d <- read.delim("file.csv", sep = ":")


# Note that when reading in files, the "sep" argument separates variables for each observation, while 
# newlines separate observations

















#### Writing data to files #######################################################################

# to a csv:
write.csv(dataframe, "filename.csv")

# to Excel file:
write_xlsx(dataframe,"filename.xlsx")

















#### Indexing a dataframe #######################################################################

# General dataframe metadata commands (to help with indexing)

nrow(d)     # the number of rows in the dataframe
ncol(d)     # the number of columns (variables) in the dataframe
names(d)    # all column/variable names for the dataframe


# change variable names in a dataframe
names(d) <- c("Variable1", "Variable2", "Variable3")

# adding an index column
data <- tibble::rowid_to_column(data, "index")





# For a dataframe d:

variable <- d[column]   # variable is a dataframe of nrow(d) rows and one column
                        # note that "column" can be either an index or the name of the column in quotes

# Note: sometimes this one behaves weirdly, but ideally behaves like this:
variable <- d[,column]  # variable is a vector of length nrow(d) holding the values of the column
                        # note that "column" can be either an index or the name of the column in quotes

variable <- d[,column1:column2]   # variable is a dataframe of nrow(d) rows and all columns between 
                                  # column1 and column2 (inclusive)

variable <- d[row,]               # variable is a dataframe of 1 row and ncol(d) columns

variable <- d[row1:row2,]         # variable is a dataframe of all rows between row1 and row2 (inclusive) and
                                  # ncol(d) columns




# Loop through all rows in a dataframe for a specific column:

for (i in seq(1:nrow(d))) {
  d[i,]         # extract the row
  d[i,column]   # extract value in that row in a certain column
  
  ### other actions ###
  
}


# General notes: R uses 1-based indexing (as opposed to 0-based) and both indices are inclusive!















#### dplyr main function examples ################################################################

d <- d %>% mutate(boolean = v1 > 2)     # creates new variable called boolean based on v1

d <- d %>% select(v1, v2)               # dataframe only has the columns v1 and v2
d <- d %>% select(-v2)                  # removes v2 from the dataframe

d %>% arrange(-v2)                      # sorts dataframe by v2 in descending order, prints to console
d <- d %>% arrange(-v2)                 # sorts dataframe by v2 in descending order, saves the dataframe
d <- d %>% arrange(v2)                  # sorts dataframe by v2 in ascending order, saves the dataframe

d %>% group_by(category) %>% count      # prints each group (unique value in "categorical") and the number
                                        # in each group; note that group_by must be used with another function
                                        # like it is here; it does nothing on its own!
 
t <- d %>% group_by(category) %>% count # saves a dataframe with results of the group_by and count

d %>% filter(category == value)         # prints only those rows in d which meet the condition category == value
t <- d %>% filter(category == value)    # same as above, but saves to a  dataframe (with ncol(d) columns)


t <- d %>% distinct(VariableName)       # similar to group_by; t is a dataframe of one column holding all unique
                                        # values of the variable VariableName in the dataframe d

t <- d %>% distinct(VariableName, .keep_all = TRUE)    # same as above, but retains other columns (variables) in 
                                                       # the d dataframe when creating the t dataframe















#### Data manipulation ############################################################################

# To calculate percents of a categorical variable:

d2 <- d %>% group_by(category) %>% count()             # obtain counts for variable of interest
pct_category <- c(d2$n / sum(d2$n))                    # calculate percents, save to vector
plottingData <- data.frame(d2$category, pct_category)  # create dataframe of categories & percents





# Create a categorical variable based on a numeric variable

# vector of the category names
binNames <- c("Day of Tip-Off", "1-11 Days\nBefore", "12-29 Days\nBefore", "30+ Days\nBefore")

# fill with NAs (a sort of failsafe)
bin <- c()
for (i in seq(1, nrow(d))) {
  bin <- append(bin, NA)
}

# add this column to the dataframe
d <- cbind(d, bin)

# enter in values based on the variable dayDiffs
d$bin[d$dayDiffs < 1] <- binNames[1]
d$bin[d$dayDiffs >= 1 & d$dayDiffs <= 11] <- binNames[2]
d$bin[d$dayDiffs >= 12 & d$dayDiffs <= 29] <- binNames[3]
d$bin[d$dayDiffs >= 30] <- binNames[4]

# set as a factor to order the categories
d <- within(d, bin <- factor(bin, levels = factor(binNames[c(1, 2, 3, 4)])))





# Loop through all rows in a dataframe:

for (i in seq(1:nrow(d))) {
  d[i,]         # extract the row
  d[i,column]   # extract value in that row in a certain column
  
  ### other actions ###
  
}


# Create empty dataframe
df <- data.frame(matrix(ncol = 3, nrow = 0))   # this example has three columns
colnames(df) <- c("col1", "col2", "col3")




## Global variables: use two caret symbols to declare global scope

# This allows us to create a variable inside a function and be able to access it without 
# needing to return it

# example:

myFunction <- function(parameter) {
  ## some code here ##
  
  globalValue <<- something
  
  ## more code ##
}

# after running myFunction above, we would be able to call and access the variable globalValue
# outside the scope of the function!
# Note that if we declare the variable as globalValue <- something, it would be deleted after the
# run of myFunction is complete, since it's only accessible within that scope



## Obtaining date and time
Sys.time()   # gives the current date and time in YYYY-MM-DD HH:MM:SS format
Sys.date()   # gives just the current date (without the time)












#### ggplot graphing #############################################################################

# General format:
ggplot(data = dataframe, mapping = aes(x = xvariable, y = yvariable, color = "colorName", fill = "colorName")) +
  geom_GRAPHTYPE() + 
  ggtitle("title") + 
  xlab("xlabel") + 
  ylab("ylabel")



# My aesthetic preferences: change the theme, enlarge the text, and center the title:
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), axis.text=element_text(size=11))



# Some common graph types:
  geom_bar()        # barplot with just an x variable; R will make the counts by itself
  
  geom_col()        # barplot with x for categories and y for bar values
  
  geom_point()      # scatterplot
  
  geom_histogram()  # a histogram!
  
  
  
# To graph percents:

d2 <- d %>% group_by(category) %>% count()             # obtain counts for variable of interest
pct_category <- c(d2$n / sum(d2$n))                    # calculate percents, save to vector
plottingData <- data.frame(d2$category, pct_category)  # create dataframe of categories & percents

# Finally, use geom_col to plot the percents for each category:
ggplot(data = plottingData, mapping = aes(x = category, y = pct_category, fill = "color", 
                                                label=percent(pct_sold))) + 
  geom_col(position = 'dodge', show.legend = FALSE) +
  ggtitle("Title") +
  ylab("y label") +
  xlab("x label") +
  scale_y_continuous(labels=percent) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), axis.text=element_text(size=11)) +
  scale_fill_manual(values = "color")



# Same plot as above, but with percentage labels over each bar:
ggplot(data = plottingData, mapping = aes(x = category, y = pct_category, fill = "color", 
                                          label=percent(pct_sold))) + 
  geom_col(position = 'dodge', show.legend = FALSE) +
  ggtitle("Title") +
  ylab("y label") +
  xlab("x label") +
  geom_text(position = position_dodge(width = .9),    # move to center of bars
            vjust = -0.5,                             # nudge above top of bar
            size = 4) + 
  scale_y_continuous(labels=percent) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), axis.text=element_text(size=11)) +
  scale_fill_manual(values = "color")










# Barplot with count labels over each bar:
ggplot(data = dataframe, mapping = aes(x = xvariable, fill = "color")) + 
  geom_bar(show.legend = FALSE) +
  ggtitle("title") +
  ylab("y label") +
  xlab("x label") +
  geom_text(aes(label = ..count..), stat = "count", vjust = -0.5, colour = "black") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), axis.text=element_text(size=11)) +
  scale_fill_manual(values = "color")







# Barplot with multiple bars (these examples have two):

# Counts with labels
ggplot(data = dataframe, mapping = aes(x = xvariable, y = group_by_counts, position = category, 
                                       fill = category, label = group_by_counts)) + 
  geom_bar(position="dodge", stat="identity") + 
  scale_fill_manual(values = c("color1","color2")) + 
  labs(fill="Better Name of Category Variable") +
  ggtitle("title") +
  xlab("x label") +
  ylab("y label") +
  geom_text(position = position_dodge(width = 0.9), vjust = -0.5) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), axis.text=element_text(size=11))

# Counts without labels
ggplot(data = dataframe, mapping = aes(x = xvariable, y = group_by_counts, position = category, 
                                       fill = category, label = group_by_counts)) + 
  geom_bar(position="dodge", stat="identity") + 
  scale_fill_manual(values = c("color1","color2")) + 
  labs(fill="Better Name of Category Variable") +
  ggtitle("title") +
  xlab("x label") +
  ylab("y label") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), axis.text=element_text(size=11))








# Percentages with labels (this uses a slightly different style; that's fine, it doesn't actually matter)
dataframe  %>% 
  ggplot(aes(x = xvariable, y = pct_group_by_counts, fill = category, 
             label = scales::percent(pct_group_by_counts))) + 
  geom_col(position = 'dodge') + 
  geom_text(position = position_dodge(width = .9),    # move to center of bars
            vjust = -0.5,                             # nudge above top of bar
            size = 4) + 
  scale_fill_manual(values = c("color1","color2")) + 
  scale_y_continuous(labels = scales::percent) +
  ggtitle("title") +
  xlab("xlabel") +
  ylab("ylabel") +
  labs(fill="Better Name of Category Variable") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), axis.text=element_text(size=11))


# percentages without labels
dataframe  %>% 
  ggplot(aes(x = xvariable, y = pct_group_by_counts, fill = category)) + 
  geom_col(position = 'dodge') + 
  scale_fill_manual(values = c("color1","color2")) + 
  scale_y_continuous(labels = scales::percent) +
  ggtitle("title") +
  xlab("xlabel") +
  ylab("ylabel") +
  labs(fill="Better Name of Category Variable") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), axis.text=element_text(size=11))


# Proportion of category for each value of category2 (the x variable); assumes 2 categories
ggplot(data = dataframe, mapping = aes(x = xvariable, fill = category)) + 
  geom_bar(position = 'fill') +
  scale_fill_manual(values = c("color1","color2")) + 
  labs(fill="Better Name of Category Variable") +
  ggtitle("title") +
  xlab("xlabel") +
  ylab("ylabel") +
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5), axis.text=element_text(size=11))
















