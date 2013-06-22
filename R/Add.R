headerPanelAdd <- function(title, windowTitle=NULL) {
  if (is.null(.GlobalEnv$.shinier)) stop("No skeleton exists; see help(\"shinySkeleton\")")
  ui <- .GlobalEnv$.shinier$ui
  if (!is.null(windowTitle)) title <- paste(deparse(title), ", ", deparse(windowTitle), sep="")
  ui <- gsub("\"Application Title\"", title, ui)
  .GlobalEnv$.shinier$ui <- ui
  invisible(ui)
}

SelectInputAdd <- function(inputId, label, choices, selected = NULL,
                           multiple = FALSE) {

}

# THIS WOULD BE AN ADDITION TO SHINY:
checkboxGroupArrayInput <- function(inputId, label, choices, selected = NULL, ncol = 3) 
{
    choices <- shiny:::choicesWithNames(choices)
    checkboxes <- list(HTML("<table>"))
    thiscol <- 1
    for (i in seq_along(choices)) {
        checkboxes[[length(checkboxes)+1]] <- HTML(ifelse(thiscol==1, "<tr><td>", "<td>"))
        choiceName <- names(choices)[i]
        inputTag <- tags$input(type = "checkbox", name = inputId, 
            id = paste(inputId, i, sep = ""), value = choices[[i]])
        if (choiceName %in% selected) 
            inputTag$attribs$checked <- "checked"
        checkbox <- tags$label(class = "checkbox", inputTag, 
            tags$span(choiceName))
        checkboxes[[length(checkboxes)+1]] <- checkbox
        checkboxes[[length(checkboxes)+1]] <- HTML(ifelse(thiscol==ncol, "</td></tr>", "</td>"))
        thiscol <- ifelse(thiscol==ncol, 1, thiscol+1)
    }
    if (thiscol>1) {
        checkboxes[[length(checkboxes)+1]] <- HTML(rep("<td>&nbsp;</td>", ncol - thiscol + 1))
        checkboxes[[length(checkboxes)+1]] <- HTML("</tr>")
    }
    checkboxes[[length(checkboxes)+1]] <- HTML("</table>")
    tags$div(id = inputId, class = "control-group shiny-input-checkboxgroup", 
        shiny:::controlLabel(inputId, label), checkboxes)
}

checkboxGroupArrayInputAdd <- function(inputId, label, choices, selected = NULL, ncol = 3) {

}

plotOutputAdd <- function(outputId, width = "100%", height = "400px", plotcode=NULL) {

}

# Needs modification, use list of data objects in .shinier
injectData <- function(x, var) {
  assign(var, x)
  .GlobalEnv$.shinierdata <- c(.GlobalEnv$.shinierdata, var)
  save(list=var, file=paste(var, ".Rdata", sep=""))
  
  startline <- grep("library(shiny)", se, fixed=TRUE)
  se <- c(se[1:startline],
          paste("load(", deparse(paste(var,".Rdata",sep="")), ")", sep=""),
          se[-c(1:startline)])
  se
}

# Probably minor editing to get ui and se from the right place, and more
# dummy-proofing.
createApp <- function(appName, overwrite=TRUE) {
  if (file.exists(appName) && !overwrite) stop("App exists") else {
    if (!file.exists(appName)) dir.create(appName)
  }
  writeLines(ui, file.path(appName, "ui.R"))
  writeLines(se, file.path(appName, "server.R"))
  if (!is.null(.GlobalEnv$.shinierdata)) {
    for (i in .GlobalEnv$.shinierdata) {
      file.rename(paste(i, ".Rdata", sep=""), file.path(appName, paste(i, ".Rdata", sep="")))
    }
    .GlobalEnv$.shinierdata <- NULL
  }
}

