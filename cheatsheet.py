# Sarah Grobe
# Created December 2022
# Last Updated December 2022




### Imports ##################################################################

# Some common imports (and ones that would be needed for this script)
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import json
import datetime





### Files ####################################################################

## Reading

# CSV
file_data = pd.read_csv('sample_file.csv')

# Excel (using pandas)
file_data = pd.read_excel('sample_file.xlsx')

# JSON - recommend using the following function
def json_loader(filename):
    '''
    Parameters
    ----------
    filename : a json file to be loaded into a list of dictionaries (jsons)

    Returns
    -------
    data: a list of dictionaries contianing information from the json

    '''
    data = []      # list to hold file data
    f = open(filename, 'r')
    data = json.loads(f.read())
    return data

json_file_data = json_loader(filename = "data/sample_file.json")


## Writing

# CSV
my_dataframe.to_csv('sample_file.csv', index = False)

# Excel (using pandas)
my_dataframe.to_excel('sample_file.xlsx', index = False)

# JSON
with open('data/sample_file.json', 'w') as outfile:
    json.dump(my_dictionary, outfile)
outfile.close()






### Functions ################################################################

## Declaring
def function_name(param1, param2):
    ### do things to the parameters here ###
    result = param1 + param2
    
    # if returning:
    return result

# Note that Python functions can return more than one object, including objects 
# of different types! (e.g., return a list, integer, and string all at once)


## Calling

# if something is getting returned:
return_result = function_name(param1, param2)

# if nothing getting returned:
function_name(param1, param2)

# can also have no parameters:
function_name()
return_result = function_name()






### Lists ####################################################################

## Basic list functions


## Sorting





### Dictionaries #############################################################

## Basic dict functions







### Numpy Matrices ###########################################################

## Building a matrix


## Matrix math





### Pandas DataFrames ########################################################

## Building


## Sorting


## Indexing





### Datetimes ################################################################







### Graphing (using matplotlib.pyplot) #######################################

## Line graph


## Bar plot (standard)


## Grouped bar plot


## Histogram


## Scatterplot


## Grid cells













