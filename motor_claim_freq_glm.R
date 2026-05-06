# EXPOSURE ADJUSTED MOTOR INSURANCE CLAIM FREQUENCY MODEL
# USING POISSON GLM IN R 

# Objective - Estimate expected motor insurance claim frequency accurately to support 
#             fair pricing and manage portfolio risk.
#             This project develops a frequency model using policyholder, vehicle, and other risk factors.

# DATASET USED - French Motor Third-Party Liability Portfolio Dataset
#                678,013 policy records
#                Variables include claim counts, exposure, driver age,
#                vehicle characteristics, region, and density.

#-----------------------------------------------------------------------------------------------------
# 1. LOADING DATASET
#-----------------------------------------------------------------------------------------------------

motor <- read.csv("C:/Users/Yashasvi/Downloads/freMTPL2freq.csv")
head(motor)


#------------------------------------------------------------------------------------------------------
# 2. EXPLORATORY DATA ANALYSIS
#------------------------------------------------------------------------------------------------------

summary(motor)
hist(motor$ClaimNb,main = "Distribution of Claim Counts",
     xlab = "Number of Claims")
table(motor$ClaimNb)
mean(motor$ClaimNb)

# Key insights:

# Claim frequency is low and concentrated at zero
# Very few policies have claims and the rare extreme cases is with maximum 16 claims 
# this concludes that claims are rare events and claim counts are right skewed.
# it shows that most customers never claim
# so the claim behaviour of this dataset concludes that claims are rare and infrequent which supports the use of a poisson process
# Exposure varies across policies, requiring offset treatment.

#-----------------------------------------------------------------------------------------------------
# 3. TRAIN/TEST
#-----------------------------------------------------------------------------------------------------
set.seed(123)
s1 <- sample(seq_len(nrow(motor)), size = 0.6*nrow(motor))
train <- motor[s1,]
test <- motor[-s1,]

#-----------------------------------------------------------------------------------------------------
# 4. FREQUENCY MODEL
#-----------------------------------------------------------------------------------------------------

model1 <- glm(ClaimNb ~ DrivAge + VehAge + VehPower+ BonusMalus + Density, family = poisson(link = "log"), offset = log(Exposure), data = train)
summary(model1)
exp(coef(model1))

# There is a multiplicative effect on expected claim frequency

#---------------------------------------------------------------------------------------------------------
# 5. PREDICTION AND VALIDATION
#---------------------------------------------------------------------------------------------------------

train$pred <- predict(model1, type = "response")
test$pred <- predict(model1, newdata = test, type = "response")

#--------------------------------------------------------------------------------------------------------
# 6. VISUALISATIONS 
#--------------------------------------------------------------------------------------------------------

age_avg <- aggregate(pred ~ DrivAge, data = train, mean)

plot(age_avg$DrivAge, age_avg$pred,
     type = "l", lwd = 2,
     main = "Average Predicted Claim Frequency by Driver's Age",
     xlab = "Driver Age",
     ylab = "Average Predicted Frequency")

train$dens_bin <- cut(train$Density, breaks = 10)
dens_avg <- aggregate(pred ~ dens_bin, train, mean)

barplot(dens_avg$pred,
        main = "Average Predicted Claim Frequency by Density Group",
        xlab = "Density Group",
        ylab = "Average Predicted Frequency")


boxplot(pred ~ VehPower, data = train,
        main = "Predicted Frequency by Vehicle Power",
        xlab = "Vehicle Power",
        ylab = "Predicted Frequency")

#---------------------------------------------------------------------------------------------------------
# 7. PRICING 
#---------------------------------------------------------------------------------------------------------

# assuming the average claim cost is 25000 rupees
avg_claim <- 25000
train$pure_premium <- train$pred*avg_claim

# adding 30% loading

train$finalPrem <- train$pure_premium*1.3
summary(train$finalPrem)

#----------------------------------------------------------------------------------------------------------
# 8. DISPERSION TEST
#----------------------------------------------------------------------------------------------------------

deviance(model1)/df.residual(model1)
# this indicates that variance < mean, i.e underdispersion,
# meaning the poisson model may be overestimating the variability and so alternative count models could be consdered

