#' wrapper for \code{bookdown::\link[bookdown]{pdf_book}} with Gordon Arsenoff's defaults
#' @param smolhead \code{logical}. Smaller-sized headings?   Default \code{TRUE} (\code{FALSE} gives regular LaTeX headings).
#' @inheritParams bookdown::pdf_book
#' @return whatever \code{pdf_book} does
#' @export
pdf_memo <- function(
  # include options
  smolhead = TRUE,
  ...
) {
  # 2022-10-25: options other than includes have been moved to the template. Exclusively use the template
  bookdown::pdf_book(
    includes = list(
      in_header = c(
        if(TRUE)     {system.file("include", "packages.tex", package = "arsedown")},
        if(TRUE)     {system.file("include", "commands.tex", package = "arsedown")},
        if(smolhead) {system.file("include", "smolhead.tex", package = "arsedown")}
      )
    ),
    ...
  )
}

# helper monkeys ----
