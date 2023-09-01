Suggestion: work on vscode 

Step by step:

- Install pandoc 
- Export the odt file into a md file with pandoc
These two steps can be done by running the bash_init.sh file.

- While exporting to md, some of the pictures are exported in the svm format. 
I choose to export them into png files manually.

- Then it's time to export the markdown file into a quarto (qmd) file. During the process, we split the md file into several files - one by chapter. To do that we run the R code "from_md_toquarto_book.R"
