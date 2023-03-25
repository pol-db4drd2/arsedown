#' inject_call <- function(f, g, pat, ...) {
#'   f_func <- f
#'   f_body <- body(f_func)
#'   f_char <- as.character(f_body)
#'   f_what <- which(stringr::str_detect(f_char, pat))
#'
#'   g_args <- rlang::list2(...)
#'   g_call <- as.call(c(list(str2lang(g)), g_args)) # ugly string parsing
#'
#'   # itt casuistry
#'   if(f_body[[f_what]][[1]] == as.name("<-")) {
#'     f_body[[f_what]][[3]] <- g_call
#'   } else {
#'     f_body[[f_what]] <- g_call
#'   }
#'
#'   body(f_func) <- f_body
#'
#'   f_func
#' }
#'
#' use_any_template <- function(template, save_as = template, the_data = list(), ignore = FALSE, open = FALSE) {
#'   use_template <- inject_call(
#'     usethis::use_template,
#'     "arsedown::render_any_template",
#'     "render_template",
#'     template = template,
#'     the_data = the_data
#'   )
#'
#'   use_template(template, save_as, the_data, ignore = ignore, open = open)
#' }
#'
#' #' replace values of yaml nodes with function args in an rmakrdown template
#' #' @param template  `character`. Full path to tomplate file. **BREAKS** compatibility with `usethis:::render_template`.
#' #' @param the_data named `list`. Args to fill in the YAML header in the template. Default `list()`.
#' #' @return a `list` with one element which is a character vector of lines to output.
#' #' @export
#' render_any_template <- function(template, the_data = list()) {
#'   if(!rlang::is_named2(the_data)) {stop("The argument `the_data` to `use_any_template` must be a named list.")}
#'
#'   # read and substitute the yaml front matter ----
#'   the_yaml <- rmarkdown::yaml_front_matter(template)
#'
#'   the_yaml[names(the_data)] <- the_data # you asked for it, you got it
#'
#'   the_yaml <- yaml::as.yaml(the_yaml)
#'   the_yaml <- paste0("---\n", the_yaml, "---\n")
#'   the_yaml <- stringr::str_replace_all(the_yaml, "''", '"')
#'
#'   # can't immediately find a function for reading everything besides the yaml front matter ----
#'   the_text <- readLines(template)
#'   the_text <- paste0(the_text, collapse = "\n")
#'   the_text <- stringr::str_split(the_text, "\n---\n")
#'   the_text <- dplyr::first(the_text)
#'   the_text <- dplyr::last(the_text)
#'
#'   the_temp <- paste0(the_yaml, the_text)
#'   the_temp <- stringr::str_split(the_temp, "\n")
#'
#'   the_temp
#' }
