#' wrapper for `bookdown::\link[bookdown]{pdf_book}` with Gordon Arsenoff's defaults
#' @param smolhead \code{logical}. Smaller-sized headings? Default `TRUE`.
#' @param smolcaps \code{logical}. Small-caps internal references? Default `TRUE`.
#' @inheritParams bookdown::pdf_book
#' @return whatever \code{pdf_book} does
#' @export
pdf_memo <- function(
  # include options
  smolhead = TRUE,
  smolcaps = TRUE,
  ...
) {
  template <- rlang::list2(...)$template
  template <- c(template, if(smolcaps) {capslink()} else {"default"})[[1]]

  # 2022-10-25: options other than includes have been moved to the template. Exclusively use the template
  tryCatch({
    bookdown::pdf_book(
      includes = list(
        in_header = c(
          if(TRUE)     {system.file("include", "packages.tex", package = "arsedown")},
          if(TRUE)     {system.file("include", "commands_1_layout.tex", package = "arsedown")},
          if(TRUE)     {system.file("include", "commands_2_column.tex", package = "arsedown")},
          if(TRUE)     {system.file("include", "commands_3_table.tex",  package = "arsedown")},
          if(TRUE)     {system.file("include", "commands_4_toc.tex",    package = "arsedown")},
          if(smolhead) {system.file("include", "smolhead.tex", package = "arsedown")}
        )
      ),
      template = template,
      ...
    )
  })
}

# helper monkeys ----
# find and patch the default template with smolcaps.tex
# it doesn't work to just put smolcaps.tex in `includes$in_header` b/c the default template sets link styles after that
capslink <- function() {
  tmpath <- tempfile()

  # lol rmarkdown doesn't rely on the system pandoc come on now
  pandoc <- rmarkdown::find_pandoc()$dir
  handle <- pipe(glue::glue("{pandoc}/pandoc -D latex"))
  pandle <- readLines(handle)
  close(handle)

  # now mung the template

  where  <- utils::head(which(stringr::str_detect(pandle, "if\\(title\\)")), 1)
  pandle <- list(pandle[1:(where)], pandle[(where+1):length(pandle)])
  pandle <- c(
    pandle[[1]],
    readLines(system.file("include", "smolcaps.tex", package = "arsedown")),
    pandle[[2]]
  )

  writeLines(pandle, glue::glue("{tmpath}.latex"))

  tmpath
}
