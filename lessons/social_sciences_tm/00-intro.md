---
layout: lesson
root: ../..
title: Introducing text analysis of survey data
---

<div class="objectives" markdown="1">

#### Objectives
*   Explain when a quantitative approach is useful when analysing text
*   Explain how text can be used as quantitative data

</div>

A convenient way to collect information from people is to ask them to type responses to a set of questions. This is especially useful when it's tricky to anticipate the range of responses that is to be collected and when it's not practical or desirable to offer checkboxes or dropdown menus. Collection of free text allows respondents to be unconstrained by the data collection instrument (although the size limit of the text field is a practical constraint). 

Let's say we want to do a survey to understand people's needs about training in data and programming skills. We don't have much prior knowledge about the people taking the survey, so we might use a combination of likert scales ('how often do you program?' with six buttons ranging between 'never' and 'daily' ) and free text responses for questions like 'Briefly list 1-2 specific skills relating to data and software you'd like to acquire'. If 10-20 people take the survey we can easily scan the free text responses and get a sense of what skills people are interested in. But if 100 or more people take the survey, we can't count on a casual glance of the text to get a reliable summary of the responses. 

The challenge that we'll tackle here is how to programmatically quantify the free text responses so we can quickly see what the range of responses are, and rank their frequencies to see what the most popular skills are. 

The next lessons will show:
- how to get survey data like this into R
- how to use the tm package in R to convert the text into numbers, which is what R is especially well suited to working with
- how to manipulate and analyse the data in R to summarise the free text data
- how to visualize the results of the analysis with the ggplot2 package

### What and Why

At the simplest level, the main task in using a programming language to analyse free text data is to convert the words to numbers, upon which we can then perform simple transformations and arithmetic. This would be an extremely tedious task to perform manually, and fortunately there are some quite mature free and open source software packages for R that do it very efficiently. Advantages of using this software include the ability to automate and reproduce the analysis and the transparency of the method that allows others to easily see the choices you've made during the analysis. 

The most important data structure that results from this conversion is the document-term matrix. This is a table of numbers where each column represents a word and each row represents a document. In the case of a survey, we might have one document-term matrix per question, and each row would represent one respondent. Using this data structure, one person's response to a question can be represented as a vector of numbers that express the frequency of various words in their response. Obviously this vector makes little sense if we try to read it as a normal sentence, but it's very useful for working at a large scale and identifying high-frequency words and word associations. One of the key advantages of this structure is storage efficiency. By storing a count of a word in a document we don't need to store all its individual occurrences. And thanks to a format called 'simple triplet matrix' we don't need to store zeros at all. This means that a document-term matrix takes much less memory that the original text it represents, so it's faster to operate on and easier to store and transmit. 

These lessons are designed to be worked through interactively at the R console. At several points we'll be iterating over functions, experimenting with different parameter values. This is a typical process for exploratory data analysis, working interactively and trying several different methods before we get something meaningful.  

<div class="keypoints" markdown="1">

#### Key Points
*   Free text responses is a valuable survey method, but can be challenging to analyse
*   A quantitative approach to analysing free text is advantageous because it can be automated, reproduced and audited. 
*   The document-term matrix is an important data structure for quantitative analysis of free text
*   An exploratory, iterative approach is valuable when encountering new data for the first time

</div>

