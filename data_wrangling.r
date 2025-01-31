#' ---
#' title: "1.4 — Data Wrangling"
#' author: "Your Name Here!"
#' date: "September 6, 2022"
#' format: html
#' editor: visual
#' ---
#' 
#' # Required Packages
#' 
#' First, install the following two packages with the command `install.packages("tidyverse")` and `install.packages("gapminder")` in the console below.[^1] Alternatively, you will probably already get a yellow banner at the top of this file indicating you need to install the packages, and can install them by clicking `Install`. Don't install any package in an R chunk in this document, since it needs to be installed into R Studio.
#' 
#' [^1]: Note that you can install multiple packages at the same time by combining the package names into a vector, like so: `install.packages(c("tidyverse", "gapminder")).`
#' 
#' Then, load the package by running (clicking the green play button) the chunk below:
#' 
## ---- load-packages-------------------
library("tidyverse") # my friend and yours
library("gapminder") # for dataset

gapminder <- gapminder # explicitly save data as a dataframe

#' 
#' # Warm Up to `dplyr` with `gapminder` Again
#' 
#' ## Question 1
#' 
#' Let's look at the data again by running the following chunk. `glimpse()` is a suped-up tidyverse version of `str()`. You can also start to see how to use the pipe operator `%>%`.
#' 
## ----q1-------------------------------
gapminder %>% 
  glimpse()

#' 
#' ## Question 2
#' 
#' Now `select()` only the variables `year`, `lifeExp`, and `country`.
#' 
## ----q2-------------------------------
# type your code below in this chunk


#' 
#' ## Question 3
#' 
#' Now `select()` all variables *except* `pop`.
#' 
## ----q3-------------------------------
# type your code below in this chunk


#' 
#' ## Question 4
#' 
#' `rename()` the variable `continent` to `cont`.
#' 
## ----q4-------------------------------
# type your code below in this chunk


#' 
#' ## Question 5
#' 
#' `arrange()` the data by `year`.
#' 
## ----q5-------------------------------
# type your code below in this chunk


#' 
#' ## Question 6
#' 
#' Now `arrange()` by year, but in descending order.
#' 
## ----q6-------------------------------
# type your code below in this chunk


#' 
#' ## Question 7
#' 
#' Now `arrange()` by `year`, then by `lifeExp`
#' 
## ----q7-------------------------------
# type your code below in this chunk


#' 
#' ## Question 8
#' 
#' Let's try subsetting some rows. `filter()` observations with `pop` greater than 1 billion (9 zeros).
#' 
## ----q8-------------------------------
# type your code below in this chunk


#' 
#' ## Question 9
#' 
#' Redo the same command from question 8, but of that subset of data, only look at India.
#' 
## ----q9-------------------------------
# # type your code below in this chunk


#' 
#' ## Question 10
#' 
#' Let's pipe a bunch of commands together. `select()` your data to look only at `year`, `gdpPercap`, and `country` in the year `1997`, for countries that have a `gdpPercap` greater than 20,000, and `arrange()` them alphabetically.
#' 
## ----q10------------------------------
# type your code below in this chunk


#' 
#' ## Question 11
#' 
#' Make a new variable with `mutate()` called `GDP`, which is equal to `gdpPercap * pop`.
#' 
## ----q11------------------------------
# type your code below in this chunk


#' 
#' ## Question 12
#' 
#' Make a new variable that is `pop` in millions.
#' 
## ----q12------------------------------
# type your code below in this chunk


#' 
#' ## Question 13
#' 
#' Use the `summarize()` command to get the overall average GDP per capita in the data.
#' 
## ----q13------------------------------
# type your code below in this chunk


#' 
#' ## Question 14
#' 
#' Use `summarize()` to get the number of observations, the mean, median, minimum, maximum, and standard deviation of GDP per capita.
#' 
#' ## Question 15
#' 
#' The code below gets the average GDP per capita by continent. Run it to see the results.
#' 
## ----q15-example----------------------
gapminder %>%
  group_by(continent) %>%
  summarize(avg_gdppc = mean(gdpPercap))

#' 
#' Now, modify it to show the average GDP per capita by year (i.e. over time).
#' 
## ----q15------------------------------
# type your code below in this chunk


#' 
#' ## Question 16
#' 
#' Get the average GDP per capita by year and by continent with `group_by()` and `summarize()`. Then save this as an object. Next, make a line graph with `ggplot()` (automatically loaded with `tidyverse`!) using this object as the source for your `data` layer. Be sure to map `color = continent` in the `aes` layer! This should plot GDP per capita over time by continent.
#' 
## ----q16------------------------------
# type your code below in this chunk


#' 
#' ## Question 17
#' 
#' Copy your code from question 16 and redo this all in one step: rather than saving your subsetted data as an object, pipe it directly into ggplot's data layer!
#' 
## ----q17------------------------------
# type your code below in this chunk


#' 
#' # An Example Data: Majors
#' 
#' Now let's step it up to work with some data "in the wild" to answer some research questions. This will have you combine your `dplyr` skills and add some new things such as importing with `readr`.
#' 
#' Let's look at fivethirtyeight's article [" The Economic Guide To Picking A College Major "](https://fivethirtyeight.com/features/the-economic-guide-to-picking-a-college-major/). fivethirtyeight is great about making the data behind their articles public, we can [download all of their data here](https://data.fivethirtyeight.com/). Search for `college majors` and click download (the blue arrow button).[^2] We will look at the `recent-grads.csv` file.
#' 
#' [^2]: This will download a `.zip` file that contains many spreadsheets. Unzip it with a program that unzips files (such as WinZip, 7-zip, the Unarchiver, etc).
#' 
#' The description in the `readme` file for the data is as follows:
#' 
#' | Header                 | Description                                                                |
#' |---------------------|---------------------------------------------------|
#' | `Rank`                 | Rank by median earnings                                                    |
#' | `Major_code`           | Major code, FO1DP in ACS PUMS                                              |
#' | `Major`                | Major description                                                          |
#' | `Major_category`       | Category of major from Carnevale et al                                     |
#' | `Total`                | Total number of people with major                                          |
#' | `Sample_size`          | Sample size (unweighted) of full-time, year-round ONLY (used for earnings) |
#' | `Men`                  | Male graduates                                                             |
#' | `Women`                | Female graduates                                                           |
#' | `ShareWomen`           | Women as share of total                                                    |
#' | `Employed`             | Number employed (ESR == 1 or 2)                                            |
#' | `Full_time`            | Employed 35 hours or more                                                  |
#' | `Part_time`            | Employed less than 35 hours                                                |
#' | `Full_time_year_round` | Employed at least 50 weeks (WKW == 1) and at least 35 hours (WKHP \>= 35)  |
#' | `Unemployed`           | Number unemployed (ESR == 3)                                               |
#' | `Unemployment_rate`    | Unemployed / (Unemployed + Employed)                                       |
#' | `Median`               | Median earnings of full-time, year-round workers                           |
#' | `P25th`                | 25th percentile of earnigns                                                |
#' | `P75th`                | 75th percentile of earnings                                                |
#' | `College_jobs`         | Number with job requiring a college degree                                 |
#' | `Non_college_jobs`     | Number with job not requiring a college degree                             |
#' | `Low_wage_jobs`        | Number in low-wage service jobs                                            |
#' 
#' ## Question 18
#' 
#' Import the data with `read_csv()` and assign it to an object (a `tibble`) called `majors` (or whatever you want to call it).
#' 
#' One way to avoid problems is to move this to the same file as R's working directory, which again you can determine with `getwd()`. If you are doing this in R Studio Cloud, use the **Upload** button to add the file to the working directory (once you've downloaded it from the internet!). If you are doing this on your computer, move the downloaded file on your computer to wherever your R Project folder for this project is.
#' 
## ----q18------------------------------
# type your code below in this chunk


#' 
#' Once it's loaded, get a look at the data with glimpse:
#' 
## ----glimpse-majors-------------------
majors %>% # or whatever you named your tibble with the data
  glimpse()

#' 
#' ## Question 19
#' 
#' What are all the unique values of `Major`? How many are there?
#' 
## ----q19------------------------------
# type your code below in this chunk


#' 
#' ## Question 20
#' 
#' Which major has the lowest unemployment rate?
#' 
## ----q20------------------------------
# type your code below in this chunk


#' 
#' ## Question 21
#' 
#' What are the top three majors that have the highest percentage of women?
#' 
## ----q21------------------------------
# type your code below in this chunk


#' 
#' ## Question 22
#' 
#' Make a boxplot of `Median` wage by `Major_Category`.
#' 
## ----q22------------------------------
# type your code below in this chunk


#' 
#' ## Question 23
#' 
#' Is there a systematic difference between STEM majors and non-STEM majors? First, define
#' 
## ----stem-----------------------------
stem_categories <- c("Biology & Life Science",
                     "Computers & Mathematics",
                     "Engineering",
                     "Physical Sciences")

#' 
#' Next, make a variable `stem`, for whether or not a `Major_category` is `"stem"` or `"not stem"`.
#' 
## ----stem-variable--------------------
# type your code below in this chunk


#' 
#' Finally, `summarize()` `Median` for stem and not stem groups.
#' 
## ----grouped-stem-summary-------------
# type your code below in this chunk


