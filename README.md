--- 
title: "Curriculum Vitae"
author: "Kenneth I. Dagogo"
date: "09/01/2020"
output: pdf_document
editor_options: 
  chunk_output_type: console
---
  
## Overview of my data science profile
  
  I am a data enthusiast, who loves data and is able to understand the language that data speaks. I have a good technical background  and I am currently going through a Data Science Program at the Stutern SGA 0.7, Data Science track. 
  Please, find attached below, a barchart which gives a brief description of my data science skills.
  

```{r echo=FALSE}
skill <- c("Reading", "Critical Thinking", "Time Management", "Mathematics", " Programming", "System Design", "Report Writing", "Listening", "Teamwork", "Curiosity")
score <- c(9, 9, 10, 10, 7, 5, 8, 9, 10, 9)

data_science_profile <- data.frame(skill, score)

library(ggplot2)

ggplot(data=data_science_profile, aes(x=skill, y=score))  + 
  geom_bar(stat="identity")
```

![Profile](Profile.png)


