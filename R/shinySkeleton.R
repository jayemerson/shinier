shinySkeleton <- function(name="myshinyapp") {

  if (!is.null(.GlobalEnv$.shinier)) {
    cat("A shinier session exists: flush and overwrite (Y/N)? ")
    ans <- readline()
    if (ans!="Y") stop("See .GlobalEnv$.shinier to examine the object.")
  }

  .GlobalEnv$.shinier <- list(
    name = name,
    ui = readLines(system.file("ui.R", package="shinier")),
    se = readLines(system.file("server.R", package="shinier"))
  )

  cat(name, "has been initialized with the Shiny application skeleton.\n")

}

