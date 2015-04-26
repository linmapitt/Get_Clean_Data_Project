#run_analysis.R

#load test set
test_data<-read.table("./test/X_test.txt", header=TRUE)
test_sub_data<-read.table("./test/subject_test.txt", header=TRUE)
test_act_data<-read.table("./test/y_test.txt", header=TRUE)

#load train set
train_data<-read.table("./train/X_train.txt", header=TRUE)
train_sub_data<-read.table("./train/subject_train.txt", header=TRUE)
train_act_data<-read.table("./train/y_train.txt", header=TRUE)
act_label_data<-read.table("./activity_labels.txt")

#load features file as column names
col_n<-read.table("./features.txt")
col_name<-col_n[,2]
colnames(test_data)<-col_name
colnames(train_data)<-col_name
colnames(test_sub_data)<-"Subject"
colnames(train_sub_data)<-"Subject"
colnames(test_act_data)<-"ActLab"
colnames(train_act_data)<-"ActLab"
colnames(act_label_data)<-c("ActLab","Activity")

#merge test data and train data
new_data<-rbind(test_data, train_data)
new_sub_data<-rbind(test_sub_data, train_sub_data)
new_act_data<-rbind(test_act_data, train_act_data)

#only pick mean measure from new_data (33 columns)
mean_data<-new_data[ , grepl( "mean\\(" , names( new_data ) ) ]

#only pick std measure from new_data (33 columns)
std_data<-new_data[ , grepl( "std\\(" , names( new_data ) ) ]

#combine them into final data set
tmp1<-cbind(new_sub_data, new_act_data)
tmp2<-cbind(tmp1, mean_data)
final_data<-cbind(tmp2, std_data)

#replace activity label with activity
merge_data_tmp<-merge(act_label_data, final_data, by="ActLab")
merge_act_data<-merge_data_tmp[,-1]

#use descriptive variable names
#remove -
new_cname<-gsub("-", "", names(merge_act_data))
colnames(merge_act_data)<-new_cname
#remove ()
new_cname<-gsub("\\(\\)", "", names(merge_act_data))
colnames(merge_act_data)<-new_cname
#change BodyBody to Body
new_cname<-gsub("BodyBody", "Body", names(merge_act_data))
colnames(merge_act_data)<-new_cname

#Group by subject and Activity
measures<-group_by(merge_act_data, Subject, Activity )
#get means
new_data_set<-summarize(measures, meanoftBodyAccmeanX=mean(tBodyAccmeanX),meanoftBodyAccmeanY=mean(tBodyAccmeanY), meanoftBodyAccmeanZ=mean(tBodyAccmeanZ),
                    meanoftBodyAccstdX=mean(tBodyAccstdX), meanoftBodyAccstdY=mean(tBodyAccstdY), meanoftBodyAccstdZ=mean(tBodyAccstdZ))

