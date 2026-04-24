#' Install ADS8192 CLI launchers
#'
#' Installs the package CLI launcher(s) onto the user's PATH using Rapp.
#'
#'@return Invisible NULL
#' @export
install_ads8192_cli <- function() {
  Rapp::install_pkg_cli_apps("ADS8192")
  invisible(NULL)
}
