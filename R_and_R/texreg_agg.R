

# Modify for error.
# Neither texreg nor broom supports models of class "".

texreg_agg <- function (l, file = NULL, single.row = FALSE, stars = c(0.001,
                                                                      0.01, 0.05), custom.header = NULL, custom.model.names = NULL,
                        custom.coef.names = NULL, custom.coef.map = NULL, custom.gof.names = NULL,
                        custom.gof.rows = NULL, custom.note = NULL, digits = 2, leading.zero = TRUE,
                        symbol = "\\cdot", override.coef = 0, override.se = 0,
                        override.pvalues = 0, override.ci.low = 0, override.ci.up = 0,
                        omit.coef = NULL, reorder.coef = NULL, reorder.gof = NULL,
                        ci.force = FALSE, ci.force.level = 0.95, ci.test = 0, groups = NULL,
                        custom.columns = NULL, custom.col.pos = NULL, bold = 0, center = TRUE,
                        caption = "Statistical models", caption.above = FALSE,
                        label = "table:coefficients", booktabs = FALSE, dcolumn = FALSE,
                        siunitx = FALSE, lyx = FALSE, sideways = FALSE, longtable = FALSE,
                        threeparttable = FALSE, use.packages = TRUE, table = TRUE,
                        tabular = TRUE, no.margin = FALSE, fontsize = NULL, scalebox = NULL,
                        float.pos = "", ...)
{
  if (isTRUE(dcolumn) && isTRUE(siunitx)) {
    dcolumn <- FALSE
    msg <- paste("The dcolumn and siunitx packages cannot be used at",
                 "the same time. Switching off 'dcolumn'.")
    warning(msg)
  }
  if (isTRUE(dcolumn) && bold > 0) {
    dcolumn <- FALSE
    msg <- paste("The dcolumn package and the 'bold' argument cannot be used at",
                 "the same time. Switching off 'dcolumn'.")
    if (length(stars) > 1 || (length(stars) > 0 && (stars ==
                                                    TRUE || stars != 0))) {
      warning(paste(msg, "You should also consider setting stars = 0."))
    }
    else {
      warning(msg)
    }
  }
  if (isTRUE(siunitx) && bold > 0) {
    siunitx <- FALSE
    msg <- paste("The siunitx package and the 'bold' argument cannot be used at",
                 "the same time. Switching off 'siunitx'.")
    if (length(stars) > 1 || (length(stars) > 0 && (stars ==
                                                    TRUE || stars != 0))) {
      warning(paste(msg, "You should also consider setting stars = 0."))
    }
    else {
      warning(msg)
    }
  }
  if (isTRUE(siunitx) && isTRUE(threeparttable)) {
    siunitx <- FALSE
    msg <- paste("The siunitx package and the threeparttable package cannot be",
                 "used together. Switching off 'siunitx'. Consider using\n                 'dcolumn = TRUE' instead for decimal point alignment.")
    warning(msg)
  }
  if (isTRUE(longtable) && isTRUE(sideways)) {
    sideways <- FALSE
    msg <- paste("The longtable package and sideways environment cannot be",
                 "used at the same time. You may want to use the pdflscape package.",
                 "Switching off 'sideways'.")
    warning(msg)
  }
  if (isTRUE(longtable) && !is.null(scalebox)) {
    scalebox <- NULL
    warning(paste("'longtable' and 'scalebox' are not compatible. Setting scalebox = NULL."))
  }
  if (isTRUE(table) && !isTRUE(tabular)) {
    table <- FALSE
    warning("Setting 'table = FALSE' because 'tabular = FALSE'.")
  }
  output.matrix <- matrixreg(l, single.row = single.row, stars = stars,
                             custom.model.names = custom.model.names, custom.coef.names = custom.coef.names,
                             custom.coef.map = custom.coef.map, custom.gof.names = custom.gof.names,
                             custom.gof.rows = custom.gof.rows, digits = digits, leading.zero = leading.zero,
                             star.symbol = "*", symbol = symbol, override.coef = override.coef,
                             override.se = override.se, override.pvalues = override.pvalues,
                             override.ci.low = override.ci.low, override.ci.up = override.ci.up,
                             omit.coef = omit.coef, reorder.coef = reorder.coef, reorder.gof = reorder.gof,
                             ci.force = ci.force, ci.force.level = ci.force.level,
                             ci.test = ci.test, groups = groups, custom.columns = custom.columns,
                             custom.col.pos = custom.col.pos, dcolumn = dcolumn, siunitx = siunitx,
                             bold = bold, output.type = "latex", include.attributes = TRUE,
                             trim = TRUE, ...)
  gof.names <- attr(output.matrix, "gof.names")
  coef.names <- attr(output.matrix, "coef.names")
  mod.names <- attr(output.matrix, "mod.names")
  ci <- attr(output.matrix, "ci")
  ci.test <- attr(output.matrix, "ci.test")
  lab.length <- max(nchar(c(coef.names, gof.names)))
  coltypes <- customcolumnnames(mod.names, custom.columns,
                                custom.col.pos, types = TRUE)
  mod.names <- customcolumnnames(mod.names, custom.columns,
                                 custom.col.pos, types = FALSE)
  coldef <- ""
  if (isTRUE(no.margin)) {
    margin.arg <- "@{}"
  }
  else {
    margin.arg <- ""
  }
  coefcount <- 0
  for (i in 1:length(mod.names)) {
    if (coltypes[i] == "coef") {
      coefcount <- coefcount + 1
    }
    if (isTRUE(single.row) && coltypes[i] == "coef" &&
        !isTRUE(siunitx)) {
      if (isTRUE(ci[coefcount])) {
        separator <- "]"
      }
      else {
        separator <- ")"
      }
    }
    else {
      separator <- "."
    }
    if (coltypes[i] %in% c("coef", "customcol")) {
      alignmentletter <- "c"
    }
    else if (coltypes[i] == "coefnames") {
      alignmentletter <- "l"
    }
    if (isTRUE(dcolumn)) {
      if (coltypes[i] != "coef") {
        coldef <- paste0(coldef, alignmentletter, margin.arg,
                         " ")
      }
      else {
        dl <- compute.width(output.matrix[, i], left = TRUE,
                            single.row = single.row, bracket = separator)
        dr <- compute.width(output.matrix[, i], left = FALSE,
                            single.row = single.row, bracket = separator)
        coldef <- paste0(coldef, "D{", separator,
                         "}{", separator, "}{", dl, separator,
                         dr, "}", margin.arg, " ")
      }
    }
    else if (isTRUE(siunitx)) {
      if (coltypes[i] != "coef") {
        coldef <- paste0(coldef, alignmentletter, margin.arg,
                         " ")
      }
      else {
        dl <- compute.width(output.matrix[, i], left = TRUE,
                            single.row = single.row, bracket = separator)
        dr <- compute.width(output.matrix[, i], left = FALSE,
                            single.row = single.row, bracket = separator)
        coldef <- paste0(coldef, "S[table-format=",
                         dl, separator, dr, "]", margin.arg, " ")
      }
    }
    else {
      coldef <- paste0(coldef, alignmentletter, margin.arg,
                       " ")
    }
  }
  coldef <- trimws(coldef)
  string <- "\n"
  linesep <- ifelse(isTRUE(lyx), "\n\n", "\n")
  if (isTRUE(use.packages)) {
    if (!is.null(scalebox)) {
      string <- paste0(string, "\\usepackage{graphicx}",
                       linesep)
    }
    if (isTRUE(sideways) & isTRUE(table)) {
      string <- paste0(string, "\\usepackage{rotating}",
                       linesep)
    }
    if (isTRUE(booktabs)) {
      string <- paste0(string, "\\usepackage{booktabs}",
                       linesep)
    }
    if (isTRUE(dcolumn)) {
      string <- paste0(string, "\\usepackage{dcolumn}",
                       linesep)
    }
    if (isTRUE(siunitx)) {
      string <- paste0(string, "\\usepackage{siunitx}",
                       linesep)
    }
    if (isTRUE(longtable)) {
      string <- paste0(string, "\\usepackage{longtable}",
                       linesep)
    }
    if (isTRUE(threeparttable)) {
      if (isTRUE(longtable)) {
        string <- paste0(string, "\\usepackage{threeparttablex}",
                         linesep)
      }
      else {
        string <- paste0(string, "\\usepackage{threeparttable}",
                         linesep)
      }
    }
    if (!is.null(scalebox) || isTRUE(dcolumn) || isTRUE(siunitx) ||
        isTRUE(booktabs) || isTRUE(sideways) || isTRUE(longtable) ||
        isTRUE(threeparttable)) {
      string <- paste0(string, linesep)
    }
  }
  snote <- get_stars_note(stars = stars, star.symbol = "*",
                          symbol = symbol, ci = ci, ci.test = ci.test, output = "latex")
  if (is.null(fontsize)) {
    notesize <- "scriptsize"
  }
  else if (fontsize == "tiny" || fontsize == "scriptsize" ||
           fontsize == "footnotesize" || fontsize == "small") {
    notesize <- "tiny"
  }
  else if (fontsize == "normalsize") {
    notesize <- "scriptsize"
  }
  else if (fontsize == "large") {
    notesize <- "footnotesize"
  }
  else if (fontsize == "Large") {
    notesize <- "small"
  }
  else if (fontsize == "LARGE") {
    notesize <- "normalsize"
  }
  else if (fontsize == "huge") {
    notesize <- "large"
  }
  else if (fontsize == "Huge") {
    notesize <- "Large"
  }
  if (is.null(custom.note)) {
    if (snote == "") {
      note <- ""
    }
    else if (!isTRUE(threeparttable)) {
      note <- paste0("\\multicolumn{", length(mod.names),
                     "}{l}{\\", notesize, "{", snote,
                     "}}")
    }
    else {
      note <- paste0("\\", notesize, "{\\item ",
                     snote, "}")
    }
  }
  else if (custom.note == "") {
    note <- ""
  }
  else {
    if (!isTRUE(threeparttable)) {
      note <- paste0("\\multicolumn{", length(mod.names),
                     "}{l}{\\", notesize, "{", custom.note,
                     "}}")
    }
    else {
      note <- paste0("\\", notesize, "{", custom.note,
                     "}")
    }
    note <- gsub("%stars", snote, note, perl = TRUE)
  }
  if (note != "") {
    if (isTRUE(longtable) && !isTRUE(threeparttable)) {
      note <- paste0(note, "\\\\", linesep)
    }
    else {
      note <- paste0(note, linesep)
    }
  }
  if (isTRUE(longtable)) {
    if (isTRUE(center)) {
      string <- paste0(string, "\\begin{center}\n")
    }
    if (!is.null(fontsize)) {
      string <- paste0(string, "\\begin{", fontsize,
                       "}", linesep)
    }
    if (isTRUE(threeparttable)) {
      string <- paste0(string, "\\begin{ThreePartTable}",
                       linesep, "\\begin{TableNotes}[flushleft]",
                       linesep, note, "\\end{TableNotes}", linesep)
    }
    if (float.pos == "") {
      string <- paste0(string, "\\begin{longtable}{",
                       coldef, "}", linesep)
    }
    else {
      string <- paste0(string, "\\begin{longtable}[",
                       float.pos, "]{", coldef, "}", linesep)
    }
  }
  else {
    if (isTRUE(table)) {
      if (isTRUE(sideways)) {
        t <- "sideways"
      }
      else {
        t <- ""
      }
      if (float.pos == "") {
        string <- paste0(string, "\\begin{", t,
                         "table}", linesep)
      }
      else {
        string <- paste0(string, "\\begin{", t,
                         "table}[", float.pos, "]", linesep)
      }
      if (isTRUE(caption.above)) {
        string <- paste0(string, "\\caption{",
                         caption, "}", linesep)
      }
      if (isTRUE(center)) {
        string <- paste0(string, "\\begin{center}",
                         linesep)
      }
      if (!is.null(fontsize)) {
        string <- paste0(string, "\\begin{", fontsize,
                         "}", linesep)
      }
      if (!is.null(scalebox)) {
        string <- paste0(string, "\\scalebox{",
                         scalebox, "}{", linesep)
      }
    }
    if (isTRUE(siunitx)) {
      string <- paste0(string, "\\sisetup{parse-numbers=false, table-text-alignment=right}",
                       linesep)
    }
    if (isTRUE(threeparttable)) {
      string <- paste0(string, "\\begin{threeparttable}",
                       linesep)
    }
    if (isTRUE(tabular)) {
      string <- paste0(string, "\\begin{tabular}{",
                       coldef, "}", linesep)
    }
  }
  tablehead <- ""
  if (isTRUE(booktabs)) {
    tablehead <- paste0(tablehead, "\\toprule", linesep)
  }
  else {
    tablehead <- paste0(tablehead, "\\hline", linesep)
  }
  if (!is.null(custom.header) && length(custom.header) > 0 &&
      !any(is.na(custom.header))) {
    if (!"list" %in% class(custom.header) || length(custom.header) >=
        length(mod.names) || is.null(names(custom.header)) ||
        !all(sapply(custom.header, is.numeric))) {
      stop("'custom.header' must be a named list of numeric vectors.")
    }
    ch <- unlist(custom.header)
    for (i in 1:length(ch)) {
      if (is.na(ch[i])) {
        stop("NA values are not permitted in 'custom.header'. Try leaving out the model indices that should not be included in the custom header.")
      }
      if (ch[i]%%1 != 0) {
        stop("The model column indices in 'custom.header' must be provided as integer values.")
      }
      if (ch[i] < 1 || ch[i] >= length(mod.names)) {
        stop("The model column indices in 'custom.header' must be between 1 and the number of models.")
      }
      if (i > 1 && ch[i] <= ch[i - 1]) {
        stop("The model column indices in 'custom.header' must be strictly increasing.")
      }
    }
    ch <- ""
    rules <- ""
    counter <- 0
    for (i in 1:length(custom.header)) {
      if (length(custom.header[[i]]) != custom.header[[i]][length(custom.header[[i]])] -
          custom.header[[i]][1] + 1) {
        stop("Each item in 'custom.header' must have strictly consecutive column indices, without gaps.")
      }
      numCoefCol <- 0
      numCustomCol <- 0
      for (j in 1:length(coltypes)) {
        if (coltypes[j] == "coef") {
          numCoefCol <- numCoefCol + 1
        }
        else if (coltypes[j] == "customcol") {
          numCustomCol <- numCustomCol + 1
        }
        if (numCoefCol == custom.header[[i]][1]) {
          (break)()
        }
      }
      startIndex <- numCoefCol + numCustomCol
      numCoefCol <- 0
      numCustomCol <- 0
      for (j in 1:length(coltypes)) {
        if (coltypes[j] == "coef") {
          numCoefCol <- numCoefCol + 1
        }
        else if (coltypes[j] == "customcol") {
          numCustomCol <- numCustomCol + 1
        }
        if (numCoefCol == custom.header[[i]][length(custom.header[[i]])]) {
          (break)()
        }
      }
      stopIndex <- numCoefCol + numCustomCol
      if (i > 1) {
        emptycells <- custom.header[[i]][1] - custom.header[[i -
                                                               1]][length(custom.header[[i - 1]])] - 1
        if (emptycells > 0) {
          for (j in 1:emptycells) {
            ch <- paste0(ch, " &")
            counter <- counter + 1
          }
        }
      }
      if (startIndex > counter + 1) {
        difference <- startIndex - (counter + 1)
        for (j in 1:difference) {
          ch <- paste0(ch, " &")
          counter <- counter + 1
        }
      }
      ch <- paste0(ch, " & \\multicolumn{", stopIndex -
                     startIndex + 1, "}{c}{", names(custom.header)[i],
                   "}")
      counter <- counter + stopIndex - startIndex + 1
      if (isTRUE(booktabs)) {
        rules <- paste0(rules, ifelse(i > 1, " ",
                                      ""), "\\cmidrule(lr){", startIndex +
                          1, "-", stopIndex + 1, "}")
      }
      else {
        rules <- paste0(rules, ifelse(i > 1, " ",
                                      ""), "\\cline{", startIndex + 1,
                        "-", stopIndex + 1, "}")
      }
    }
    tablehead <- paste0(tablehead, ch, " \\\\", linesep,
                        rules, linesep)
  }
  tablehead <- paste0(tablehead, mod.names[1])
  if (isTRUE(dcolumn)) {
    for (i in 2:length(mod.names)) {
      if (coltypes[i] != "coef") {
        tablehead <- paste0(tablehead, " & ", mod.names[i])
      }
      else {
        tablehead <- paste0(tablehead, " & \\multicolumn{1}{c}{",
                            mod.names[i], "}")
      }
    }
  }
  else if (isTRUE(siunitx)) {
    for (i in 2:length(mod.names)) {
      if (coltypes[i] != "coef") {
        tablehead <- paste0(tablehead, " & ", mod.names[i])
      }
      else {
        tablehead <- paste0(tablehead, " & {",
                            mod.names[i], "}")
      }
    }
  }
  else {
    for (i in 2:length(mod.names)) {
      tablehead <- paste0(tablehead, " & ", mod.names[i])
    }
  }
  if (isTRUE(booktabs)) {
    tablehead <- paste0(tablehead, " \\\\", linesep,
                        "\\midrule", linesep)
  }
  else {
    tablehead <- paste0(tablehead, " \\\\", linesep,
                        "\\hline", linesep)
  }
  if (isFALSE(longtable)) {
    string <- paste0(string, tablehead)
  }
  if (isTRUE(booktabs)) {
    bottomline <- paste0("\\bottomrule", linesep)
  }
  else {
    bottomline <- paste0("\\hline", linesep)
  }
  if (isTRUE(longtable)) {
    if (isTRUE(caption.above)) {
      string <- paste0(string, "\\caption{", caption,
                       "}", linesep, "\\label{", label,
                       "}\\\\", linesep, tablehead, "\\endfirsthead",
                       linesep, tablehead, "\\endhead", linesep,
                       bottomline, "\\endfoot", linesep, bottomline,
                       ifelse(isTRUE(threeparttable), "\\insertTableNotes\\\\\n",
                              note), "\\endlastfoot", linesep)
    }
    else {
      string <- paste0(string, tablehead, "\\endfirsthead",
                       linesep, tablehead, "\\endhead", linesep,
                       bottomline, "\\endfoot", linesep, bottomline,
                       ifelse(isTRUE(threeparttable), "\\insertTableNotes\\\\\n",
                              note), "\\caption{", caption, "}",
                       linesep, "\\label{", label, "}",
                       linesep, "\\endlastfoot \\\\", linesep)
    }
  }
  max.lengths <- numeric(length(output.matrix[1, ]))
  for (i in 1:length(output.matrix[1, ])) {
    max.length <- 0
    for (j in 1:length(output.matrix[, 1])) {
      if (nchar(output.matrix[j, i]) > max.length) {
        max.length <- nchar(output.matrix[j, i])
      }
    }
    max.lengths[i] <- max.length
  }
  for (i in 1:length(output.matrix[, 1])) {
    for (j in 1:length(output.matrix[1, ])) {
      nzero <- max.lengths[j] - nchar(output.matrix[i,
                                                    j])
      zeros <- rep(" ", nzero)
      zeros <- paste(zeros, collapse = "")
      output.matrix[i, j] <- paste0(output.matrix[i, j],
                                    zeros)
    }
  }
  for (i in 1:(length(output.matrix[, 1]) - length(gof.names))) {
    for (j in 1:length(output.matrix[1, ])) {
      string <- paste0(string, output.matrix[i, j])
      if (j == length(output.matrix[1, ])) {
        string <- paste0(string, " \\\\", linesep)
      }
      else {
        string <- paste0(string, " & ")
      }
    }
  }
  if (length(gof.names) > 0) {
    if (isTRUE(booktabs)) {
      string <- paste0(string, "\\midrule", linesep)
    }
    else {
      string <- paste0(string, "\\hline", linesep)
    }
    for (i in (length(output.matrix[, 1]) - (length(gof.names) -
                                             1)):(length(output.matrix[, 1]))) {
      for (j in 1:length(output.matrix[1, ])) {
        string <- paste0(string, output.matrix[i, j])
        if (j == length(output.matrix[1, ])) {
          string <- paste0(string, " \\\\", linesep)
        }
        else {
          string <- paste0(string, " & ")
        }
      }
    }
  }
  if (isFALSE(longtable)) {
    string <- paste0(string, bottomline)
    if (isTRUE(threeparttable)) {
      string <- paste0(string, ifelse(isTRUE(tabular),
                                      "\\end{tabular}", ""), ifelse(isTRUE(tabular),
                                                                    linesep, ""), "\\begin{tablenotes}[flushleft]",
                       linesep, note, "\\end{tablenotes}", linesep,
                       "\\end{threeparttable}", linesep)
    }
    else {
      if (isTRUE(tabular)) {
        string <- paste0(string, note, "\\end{tabular}",
                         linesep)
      }
      else {
        string <- paste0(string, note)
      }
    }
  }
  if (isTRUE(longtable)) {
    string <- paste0(string, "\\end{longtable}", linesep)
    if (isTRUE(threeparttable)) {
      string <- paste0(string, "\\end{ThreePartTable}",
                       linesep)
    }
    if (!is.null(fontsize)) {
      string <- paste0(string, "\\end{", fontsize,
                       "}", linesep)
    }
    if (isTRUE(center)) {
      string <- paste0(string, "\\end{center}", linesep)
    }
  }
  else if (isTRUE(table)) {
    if (!is.null(fontsize)) {
      string <- paste0(string, "\\end{", fontsize,
                       "}", linesep)
    }
    if (!is.null(scalebox)) {
      string <- paste0(string, "}", linesep)
    }
    if (isFALSE(caption.above)) {
      string <- paste0(string, "\\caption{", caption,
                       "}", linesep)
    }
    string <- paste0(string, "\\label{", label, "}",
                     linesep)
    if (isTRUE(center)) {
      string <- paste0(string, "\\end{center}", linesep)
    }
    if (isTRUE(sideways)) {
      t <- "sideways"
    }
    else {
      t <- ""
    }
    string <- paste0(string, "\\end{", t, "table}",
                     linesep)
  }
  if (is.null(file) || is.na(file)) {
    class(string) <- c("character", "texregTable")
    return(string)
  }
  else if (!is.character(file)) {
    stop("The 'file' argument must be a character string.")
  }
  else {
    sink(file)
    cat(string)
    sink()
    message(paste0("The table was written to the file '",
                   file, "'.\n"))
  }
}