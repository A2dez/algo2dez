
install.packages('tidyverse')
library(tidyverse)
data <- read_delim("https://github.com/Alexir/CMUdict/blob/master/cmudict-0.7b", delim = "  ", skip = 126)
data

data <- read_delim("http://svn.code.sf.net/p/cmusphinx/code/trunk/cmudict/cmudict-0.7b", delim = "  ")
data
View(data)


# move to the project directory
cd Projects/website

# initiate the upstream tracking of the project on the GitHub repo
git remote add origin https://github.com/hansenjohnson/website.git

# pull all files from the GitHub repo (typically just readme, license, gitignore)
git pull origin master

# set up GitHub repo to track changes on local machine
git push -u origin master

git remote add origin https://github.com/A2dez/algo2dez
git status


