#' insert vignette front matter into template and use new file
#' @param input     `character`. Name of template file.
#' @param output    `character`. Name of new      file.
#' @param the_title `character`. Title of the new vignette.
#' @return whatever `ymlthis::use_rmarkdown` does
#' @export
insert_front_matter <- function(input, output, the_title) {
  the_yaml <- rmarkdown::yaml_front_matter(input)
  the_yaml <- ymlthis::as_yml(the_yaml)
  the_yaml <- ymlthis::yml_vignette(the_yaml, the_title)

  ymlthis::use_rmarkdown(the_yaml, output, input, include_yaml = FALSE, include_body = TRUE)
}

