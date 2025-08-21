#' Create a vignette in `arsedown::pdf_memo` format
#'
#' Creates a new vignette in `vignettes/` using the `pdf_memo` skeleton.
#'
#' @inheritParams usethis::use_vignette
#' @param what character. Full path to a `.Rmd` skeleton. Defaults to the installed location of the `pdf_memo` skeleton.
#' @param overwrite logical. Overwrite an existing vignette with the same `name`? Default `FALSE` (gives an error).
#' @return invisibly returns the full path to the new file
#' @export
use_memo_vignette <- function(
  name,
  title = name,
  what  = system.file("rmarkdown", "templates", "pdf-memo", "skeleton", "skeleton.Rmd", package = "arsedown"),
  overwrite = FALSE
) {

  dr <- here::here("vignettes", name)

  # fn <- here::here("vignettes", stringr::str_c(name, ".Rmd"))
  vn <- here::here("vignettes", stringr::str_c(name, ".Rmd"))
  fn <- here::here(dr,          stringr::str_c(name, ".Rmd"))

  if(file.exists(fn)) {
    if(overwrite) {
      warning(glue::glue("Overwriting existing {fn}"), immediate. = TRUE)
      file.remove(fn)
    } else {
      stop(glue::glue("{fn} already exists: try another `name` or set `overwrite=TRUE`"))
    }
  }

  # interactivity workaround -- should work across OSes
  xpr <- glue::glue("\"usethis::use_vignette('{name}','{title}')\"")
  exe <- here::here(normalizePath(R.home(component = "bin")), "R")
  system(glue::glue("{exe} --quiet --vanilla -e {xpr}"))

  old <- rmarkdown::yaml_front_matter(vn)

  file.remove(vn)

  if(file.exists(dr)) {} else {dir.create(dr)} # 2024-03-19: not above, b/c we don't know if `here::here("vignettes")` exists

  noo <- rmarkdown::yaml_front_matter(what)

  noo$title    <- old$title
  noo$vignette <- old$vignette
  noo$vignette <- stringr::str_replace_all(noo$vignette, " ", "\n ") # TODO 2024-02-29: try the below?
  # noo$vignette <- stringr::str_replace_all(noo$vignette, " %\\\\", "\n %\\\\")
  noo$vignette <- stringr::str_c(">\n ", noo$vignette)

  noo <- sanitize_yaml_quotes(noo)

  yml <- ymlthis::as_yml(noo)

  ymlthis::use_rmarkdown(yml, fn, what, include_yaml = FALSE, include_body = TRUE)
}

sanitize_yaml_quotes <- function(x) {
  if(is.list(x)) {return(lapply(x, sanitize_yaml_quotes))}

  if(is.character(x)) {stringr::str_replace_all(x, "'", '"')} else {x}
}
