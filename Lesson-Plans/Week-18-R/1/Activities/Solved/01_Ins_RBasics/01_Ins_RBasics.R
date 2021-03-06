# R holds many similarities to Python
# Lets look 3 of the 5 at the atomic (holding one value) data types

# Numeric
a <- 3
b <- 3.1415

# Character
c <- "This is a string"
d <- "Yet another string"

# Boolean
e <- TRUE
f <- FALSE
g <- T
h <- F

# The other 2 atomic types are integer and complex (think imaginary numbers)

# The vector is the main workhorse of R
# A vector contains a homogenous set of data elements of the same type
petz <- c("cat","bird","dog","snake","rat","fish","sugar glider","venus fly trap","rock")
junos_pets <- c("robots", "slinkys", "AIs", "jellyfish")

# R is 1 indexed
petnumericvec <- 1:length(petz)

# Numeric vectors can be operated over enmass
petnumericvec2 <- petnumericvec**3

# The c stands for concatinate
# Vectors can be combined using another concatinate function
all_petz <- c(petz, junos_pets)

# Vectors can be looped through
for (x in all_petz){
  print(x)
}

# List are similar to python dictionaries
shop_list <- list(
  "Harris Teeter"=c("eggs", "bacon", "avocado"),
  "Target"=c("detergent", "socks", "filter")
)

# You can inspect the names of a list with the names function
names(shop_list)

# Use brackets to get a signle value sublist
shop_list["Harris Teeter"]

# Or use a vecctor to get a sublist of the items that you want
subshoplist <- shop_list[c(1,2)]

# Use double brackets to get just the values
shop_list[["Harris Teeter"]]

# Or use a dollarsign
# Note the backticks if using this method when there are spaces in the name
# shoplist$`Crowly's Pet Emporium`

# if statements can be applied much like you would do in Python
for (animal in petz){
  if (nchar(animal) > 3){
    next
  }else{
    print(animal)
  }
}

# Functions work much like they do in Python
# petshop <- function(petname){
#   set.seed(sum(utf8ToInt(petname)))
#   # Tells you the best pet for a given petname
#   namevec <- c("cat","bird","dog","snake","rat","fish","sugar glider","venus fly trap","rock")
#   return(paste("If you want to name your pet", petname, "it should be a", sample(namevec,1)))
# }


fahrenheit_to_kelvin <- function(temp_F) {
  temp_K <- ((temp_F - 32) * (5 / 9)) + 273.15
  return(temp_K)
}

# freezing point of water
fahrenheit_to_kelvin(32)

# boiling point of water
fahrenheit_to_kelvin(212)






# BONUS
# Let's build a list of revenues for each of these shops
shop_revenue <- list()
set.seed(4242)
for (eachname in names(shop_list)){
  shop_revenue[[eachname]] <- rnorm(1000,sample(100:10000,1),nchar(eachname)**2)
}

# Now let's get some summary statistics on each of these pet shops
for (eachshop in names(shop_revenue)){
  current_rev <- shop_revenue[[eachshop]]
  avg_rev <- round(mean(current_rev),2)
  sd_rev <- round(sd(current_rev),2)
  summary_rev <- summary(current_rev)
  print(paste(eachshop, 
              " makes an average of $", avg_rev, 
              " +/- $", sd_rev,
              " each month. ",
              "The smallest payment was $", round(summary_rev[["Min."]],2),
              " and the largest payment was $", round(summary_rev[["Max."]],2), sep=""))
}
