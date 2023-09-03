Suggestion: work on vscode 

Step by step:

- create a quarto book (on vscode: palette => Quarto: create a project => book)

- Install pandoc 
- Export the odt file into a md file with pandoc
These two steps can be done by running the bash_init.sh file.

- While exporting to md, some of the pictures are exported in the svm format. 
I choose to export them into png files manually.

- Then it's time to export the markdown file into a quarto (qmd) file. During the process, we split the md file into several files - one by chapter. To do that we run the R code "from_md_toquarto_book.R"

- Split the chapters into sections with "split_chapters.R"

- update the _quarto.yml, mentionning the list of chapters

- create github pages with the command line: `quarto publish gh-pages`

- render the quarto book with `quarto render`