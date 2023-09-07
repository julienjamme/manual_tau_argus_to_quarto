library(magrittr)
library(purrr)
library(stringr)

setwd("manual_tau_argus_to_quarto/")

split_chapter_into_section_files <- function(original_file){
  
  dir <- dirname(original_file)
  chapter <- basename(original_file) |> 
    str_remove(".qmd$")
  
  if(str_detect(chapter, "(glossary|references|index)"))
    return(chapter)
  
  sections <- brio::read_file(original_file) |>
    str_split(pattern = "\n## ") |>
    unlist() |>
    as.list()
  names(sections) <- imap(
    sections,
    function(section, number){
      paste0(
        (number-1) %>% {if(. < 10) paste0("0",.) else as.character(.)},
        "-",
        str_extract(section, "^.*\n")  |>
          str_remove("\n") |>
          str_remove(":.*") |>
          str_remove("\\[.*") |>
          str_replace("/", "-") |>
          str_remove("\\^")
      )
    }
  )
  
  if(length(sections) <= 1)
    return(chapter)
  
  # sections[[2]] <- paste0(sections[[1]], "\n\n## ", sections[[2]], collapse = "") 
  
  sections_files <- sections[-1] |>
    imap_chr(
      function(content, section_name){
        section_name <- section_name |> 
          stringr::str_remove_all("[,.!()]") |>
          stringr::str_replace_all(" ", "-")
        
        section_file <- paste0("_", chapter, "-", section_name,".qmd")
        
        num_chap <- chapter |> substr(1,2)
        dir.create(paste0("chapters/", num_chap))
        file <- paste0("chapters/", num_chap, "/", section_file)
        # if(section_name == "01-Introduction")
        #   writeLines(content, con = file, sep = "\n")
        # else
        writeLines(paste0("## ", content), con = file, sep = "\n")
        
        return(section_file)
      }
    )
  
  chapter_qmd <- paste0(
    "# ", str_remove(chapter,"^[0-9]*-"), "\n\n",
    reduce(
      map(
        unname(sections_files),
        function(sf)  {
            num_chap <- chapter |> substr(1,2)
            file <- paste0("chapters/", num_chap, "/", sf)
            paste0("{{< include ", file, " >}}\n\n")
        }
      ),
      paste0,
      collapse = ""
    )
  )
  
  file_chapter <- paste0(dir, "/", chapter, ".qmd")
  writeLines(chapter_qmd, con = file_chapter, sep = "\n")
  
}

if(!dir.exists("chapters")) dir.create("chapters")
files <- list.files(".", ".qmd", full.names = TRUE)

files |> map(split_chapter_into_section_files)


# split_chapter_into_section_files(original_file = files[2])

