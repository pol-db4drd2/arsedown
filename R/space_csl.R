#' Force item spacing in chosen Citation Style Language file
#' @param space    \code{character}. line spacing between entries. Default \code{"2"}.
#' @param cslfile  \code{character}. Location of the CSL file. Default \code{"https://www.zotero.org/styles/american-political-science-association"}.
#' @param destfile \code{character}. Filename to save local copy of csl file to. Default \code{"apsa.csl"}.
#' @param fallback \code{  logical}. Use default if \code{cslfile} not found? Default \code{FALSE} (stops with an error).
#' @return the argument \code{destfile}
#' @export
space_csl <- function(
    space    = "2",
    cslfile  = "https://www.zotero.org/styles/american-political-science-association",
    destfile = 'apsa.csl',
    fallback = FALSE
) {
  ohno <- if(fallback) {warning} else {stop}

  con <- file(cslfile)
  csl <- tryCatch({
    readLines(con)
  }, error = function(e) {
    ohno(paste0("Can't open CSL file ", cslfile))
    readLines(system.file('include', 'apsa.csl', package='arsedown'))
  })
  close(con)

  csl <- stringr::str_replace(csl, "entry-spacing\\s*=\\s*['\"]*\\d+['\"]*", " ")
  csl <- stringr::str_replace(csl, "<bibliography ", paste0("<bibliography entry-spacing = '", space, "' "))

  writeLines(csl, destfile)

  destfile
}
