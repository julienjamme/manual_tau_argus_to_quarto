library(magrittr)
if(! dir.exists("chapters")) dir.create("chapters")
brio::read_file("TauManualV4.1_Rev.md") |>
  # One qmd file at each h1 level
  stringr::str_split(pattern = "\n# []") |>
  # wmf files to png files (in the md) => run ths bash file to convert all wmf
  stringr::str_replace_all(pattern = ".wmf[)]", replacement = ".png)") |>
  unlist() |>
  purrr::iwalk(
    function(f, i){
      if(i == 1){
        chap <- "index"
        f <- substring(f,3)
      }else{
        chap <- stringr::str_extract(f, "^.*\n") |> 
          stringr::str_remove("\n") |>
          stringr::str_replace_all("( |, )", "_")
      }
      file <- paste0(chap,".qmd")
      # file.edit(file.path(file))
      writeLines(paste0("# ", f), con = file, sep = "\n")
    }
  )