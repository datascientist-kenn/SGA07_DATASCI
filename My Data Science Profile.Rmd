--- 
title: "Curriculum Vitae"
author: "Kenneth I. Dagogo"
date: "09/01/2020"
output: pdf_document
editor_options: 
  chunk_output_type: console
---
  
## Overview of my data science profile
  
  I am a data enthusiast, who loves data and is able to understand the language that data speaks. I have a good technical background and I am currently going through a data science improvement program with STUTERN. I would be happy to help your company interpret the language the data is trying to communicate with you. I look forward to hearing from you soon. 
  Please, find attached below, a barchart which gives a brief description of my data science skills.
  

```{r echo=FALSE}
skill <- c("Reading", "Crit.Think.", "Time Man.", "Maths", " Coding", "Sys.Des.", "Reporting", "Listen", "Team", "Curiosity")
score <- c(9, 9, 10, 10, 7, 5, 8, 9, 10, 9)

data_science_profile <- data.frame(skill, score)

library(ggplot2)

ggplot(data=data_science_profile, aes(x=skill, y=score))  + 
  geom_bar(stat="identity")
```