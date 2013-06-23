shinySkeleton <- function(name = "myshinyapp") {

  if (!is.null(.GlobalEnv$.shinier)) {
    cat("A shinier session exists: flush and overwrite (Y/N)? ")
    ans <- readline()
    if (ans!="Y") {
      stop("See .GlobalEnv$.shinier to examine the existing object.")
    }
  }
  if (file.exists(name)) {
    warning(paste("A Shiny application by that name exists in this directory;",
                  "proceed with caution and be careful with createApp().",
                  sep="\n"))
  }

  .GlobalEnv$.shinier <- list(
    name = name,
    ui = readLines(system.file("ui.R", package="shinier")),
    se = readLines(system.file("server.R", package="shinier")),
    data = list()
  )

  invisible(.GlobalEnv$.shinier)
}

