#' Create a document in `arsedown::pdf_memo` format
#'
#' Creates a new R Markdown document in the current project directory using the `pdf_memo` skeleton.
#'
#' @inheritParams use_memo_vignette
#' @param whence `character`. A file path. Default `[here::here]()`.
#' @return invisibly returns the full path to the new file
#' @export
use_memo <- function(
  name,
  title  = name,
  what   = system.file("rmarkdown", "templates", "pdf-memo", "skeleton", "skeleton.Rmd", package = "arsedown"),
  whence = here::here(),
  overwrite = FALSE
) {
  dr <- here::here(whence, stringr::str_c(name))

  if(file.exists(dr)) {} else {dir.create(dr)}

  fn <- here::here(dr, stringr::str_c(name, ".Rmd"))

  if(file.exists(fn)) {
    if(overwrite) {
      warning(glue::glue("Overwriting existing {fn}"), immediate. = TRUE)
      file.remove(fn)
    } else {
      stop(glue::glue("{fn} already exists: try another `name` or set `overwrite=TRUE`"))
    }
  }

  noo <- rmarkdown::yaml_front_matter(what)

  noo$title <- title

  noo <- sanitize_yaml_quotes(noo)

  yml <- ymlthis::as_yml(noo)

  ymlthis::use_rmarkdown(yml, fn, what, include_yaml = FALSE, include_body = TRUE)
}
