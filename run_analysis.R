features <- read.csv("features.txt",sep=" ",header=FALSE)

# Select features with mean() or std() function
indexes <- grep('mean|std',features[, 2])

# Replace '-' character with '.' fBodyAcc-std()-X => fBodyAcc.std().X
features[, 2] <- gsub('-','.',features[, 2])

# Remove '()'   fBodyAcc.std().X=>fBodyAcc.std.X
features[, 2] <- gsub('\\(\\)','',features[, 2])

# Lower case and insert '.' fBodyAcc.std.X=> f.body.std..x
features[,2] <-gsub("([A-Z])",".\\L\\1", features[, 2],perl = TRUE)

# Remove extra '.' f.body.std..x => f.body.std.x
features[, 2] <- gsub('\\.\\.','.',features[, 2])

# Training set
options(digits=10)
# Measurements
x_train <- read.table("train/X_train.txt",colClasses="numeric",col.names = features[, 2])
# Filter data
x_train <- x_train[, indexes]

# Test set
x_test <- read.table("test/X_test.txt",colClasses="numeric",col.names=features[, 2])
x_test <- x_test[, indexes]

# Join x_train and x_test
x_data <- rbind(x_train,x_test)

# Read subject data
x_subject_train <- read.csv("train/subject_train.txt",sep=" ",header=FALSE)
x_subject_test  <- read.csv("test/subject_test.txt",sep=" ",header=FALSE)
x_subject <- rbind(x_subject_train,x_subject_test)

# Insert new 'subject' column
x <- cbind(subject = x_subject[, 1],x_data)

# Labels

# read activity_label codes
labels <- read.csv("activity_labels.txt",sep=" ",col.names=c("activity.id","activity.label"),header = FALSE)
# naming conventions
labels[, 2] <- gsub("([A-Z])","\\L\\1",labels[,2],perl = TRUE)
labels[, 2] <- gsub('_','.',labels[,2],perl = TRUE)

# read 
y_train <- read.csv("train/y_train.txt",header = FALSE,col.names=c("activity.id"))
y_test  <- read.csv("test/y_test.txt",header = FALSE,col.names=c("activity.id"))
y_data  <- rbind(y_train,y_test)

# Insert new 'activity.id' column
x <- cbind(activity.id=y_data[, 1],x)

# Descriptive names for activity labels
y_data[,1]<-labels[y_data[,1],2]


cleaned_data <-  cbind(activity.label=y_data[, 1],x)
melted <- melt(cleaned_data,id=c ("subject","activity.label"))
melted$value <- as.numeric(melted$value)
tiny_data<-dcast(melted,subject+activity.label~variable,fun.aggregate=mean)


