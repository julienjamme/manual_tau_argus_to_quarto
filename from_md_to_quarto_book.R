library(magrittr)
setwd("manual_tau_argus_to_quarto/")
if(! dir.exists("chapters")) dir.create("chapters")
brio::read_file("TauManualV4.1_Rev.md") |>
  # Remove all the anchors
  stringr::str_remove_all(pattern = "\\[\\]\\{#anchor-[0-9]*\\}") |>
  stringr::str_remove_all(pattern = "\\[[0-9]*\\]\\{#anchor\\}") |>
  stringr::str_remove_all(pattern = "\\(#anchor-[0-9]*\\)") |>
  # stringr::str_remove_all(pattern = "\\{#anchor-[0-9]*\\}\\[\\]") |>
  # stringr::str_remove_all("\\[\\]") |>
  # fix information on dimension of the pictures
  stringr::str_remove_all("\n> ") |>
  stringr::str_replace_all('width="', "width=") |>
  stringr::str_replace_all('cm"height="', "cm height=") |>
  stringr::str_replace_all('cm"', "cm") |>
  # One qmd file at each h1 level
  stringr::str_split(pattern = "\n# ") |>
  unlist() |>
  purrr::iwalk(
    function(f, i){
      j <- i - 1
      if(i == 1){
        chap <- "index"
        f <- substring(f,3)
      }else{
        chap <- stringr::str_extract(f, "^.*\n") |>
#          stringr::str_remove_all(pattern = "\\{#anchor-[0-9]*\\}") |>
#          stringr::str_remove_all(pattern = "\\{#anchor-[0-9]*\\}\\[\\]") |>
          stringr::str_remove_all("\\[\\]") |>
          stringr::str_remove("\n") |>
          stringr::str_replace_all("( |, )", "_")
      }
      num <- ifelse(j<10, paste0("0",j), j)
      file <- ifelse(i == 1, paste0(chap,".qmd"), paste0(num, "_", chap,".qmd"))
      # file.edit(file.path(file))
      writeLines(paste0("# ", f), con = file, sep = "\n")
    }
  )