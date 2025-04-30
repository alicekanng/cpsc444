library(ez)
library(ggplot2)
library(geomtextpath)

task1 <- read.csv(file="task1.csv", header=T, sep=",")
task2 <- read.csv(file="task2.csv", header=T, sep=",")
task3 <- read.csv(file="task3.csv", header=T, sep=",")
sus_scores <- read.csv(file="sus_scores.csv", header=T, sep=",")
# 
print(t.test(sus_scores$score[sus_scores$type == "donor"],
             sus_scores$score[sus_scores$type == "non-donor"],
             var.equal=TRUE))
# 
# sus_scores_donor = sus_scores[sus_scores$type == "donor",]
# sus_scores_donor_plot<-ggplot(data=sus_scores_donor, aes(x=factor(pid), y=score)) +
#   geom_bar(stat="identity", fill = "blue") +
#   ylim(0,5) +
#   geom_texthline(aes(yintercept=mean(score), label = mean(score)), colour= 'red') +
#   ggtitle("SUS Scores for Donors") +
#   xlab("Participant ID") +
#   ylab("SUS Score")
# print(sus_scores_donor_plot)
# 
# sus_scores_nondonor = sus_scores[sus_scores$type == "non-donor",]
# sus_scores_nondonor_plot<-ggplot(data=sus_scores_nondonor, aes(x=factor(pid), y=score)) +
#   geom_bar(stat="identity", fill = "#74c365") +
#   ylim(0,5) +
#   geom_texthline(aes(yintercept=mean(score), label = mean(score)), colour= 'red') +
#   ggtitle("SUS Scores for Non-Donors") +
#   xlab("Participant ID") +
#   ylab("SUS Score")
# print(sus_scores_nondonor_plot)

# # ACC
# print(t.test(task3$accuracy[task3$type == " donor"],
#        task3$accuracy[task3$type == " non-donor"],
#        var.equal=TRUE))

# task3_donor = task3[task3$type == " donor",]
# task3_donor_time<-ggplot(data=task3_donor, aes(x=factor(pid), y=accuracy)) +
#   geom_bar(stat="identity", fill = "blue") +
#   ylim(0, 100) +
#   geom_texthline(aes(yintercept=mean(accuracy), label = "100%"), colour= 'red') +
#   ggtitle("Accuracy of Donors in Task 3") +
#   xlab("Participant ID") +
#   ylab("Accuracy (percentage)")
# 
# print(task3_donor_time)

# task3_nondonor = task3[task3$type == " non-donor",]
# task3_nondonor_time<-ggplot(data=task3_nondonor, aes(x=factor(pid), y=accuracy)) +
#   geom_bar(stat="identity", fill = "#74c365") +
#   ylim(0, 100) +
#   scale_x_discrete(breaks=seq(0,8,2), labels=seq(0,8,2)) +
#   geom_texthline(aes(yintercept=mean(accuracy), label = "100%"), colour= 'red') +
#   ggtitle("Accuracy of Non-Donors in Task 3") +
#   xlab("Participant ID") +
#   ylab("Accuracy (percentage")
# 
# print(task3_nondonor_time)

