# =======================================================================
# ONE-TIME SETUP for exam2.R  (run once, with internet, BEFORE the exam)
# Open this file in RStudio and press Source (Cmd+Shift+S / Ctrl+Shift+S).
# It does 3 things and prints a checklist at the end:
#   1. installs the packages exam2.R can use
#   2. turns on RStudio settings that catch typing mistakes
#   3. adds "Exam II" entries to RStudio's Addins menu (numbers, ASK)
# Safe to run again. Nothing here changes exam2.R.
# =======================================================================

done <- c()

# ---- 1. packages -------------------------------------------------------
pk <- c("wooldridge", "rstudioapi", "datapasta", "clipr")
need <- pk[!vapply(pk, requireNamespace, TRUE, quietly = TRUE)]
if (length(need)) {
  cat("Installing:", paste(need, collapse = ", "), "\n")
  install.packages(need, type = if (.Platform$pkgType != "source") "binary" else "source")
}
for (p in pk) done <- c(done, sprintf("%-11s %s", p, if (requireNamespace(p, quietly = TRUE)) "installed" else "NOT installed (try again with internet)"))

# ---- 2. RStudio settings (same as Tools > Global Options > Code) ------------
prefs <- list(
  show_diagnostics_r = TRUE,                          # Diagnostics: show problems in R code
  background_diagnostics = TRUE,                      #   ... while you type, not only on save
  warn_if_no_such_variable_in_scope = TRUE,           #   ... yellow mark on a name that was never defined (typos)
  check_arguments_to_r_function_calls = TRUE,         #   ... wrong or missing arguments, e.g. lm(y ~ x, dat = ...)
  check_unexpected_assignment_in_function_call = TRUE,#   ... "=" or "<-" where it doesn't belong
  rainbow_parentheses = TRUE,                         # Display: each ( ) pair gets its own color
  highlight_r_function_calls = TRUE,                  # Display: function names stand out
  highlight_selected_word = TRUE,                     # Display: every copy of the selected word is highlighted
  syntax_color_console = TRUE)                        # Console: colored output
if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
  for (n in names(prefs)) {
    ok <- tryCatch({ rstudioapi::writeRStudioPreference(n, prefs[[n]]); TRUE }, error = function(e) FALSE)
    done <- c(done, sprintf("setting %-45s %s", n, if (ok) "ON" else "could not set (do it by hand: Tools > Global Options > Code)"))
  }
} else done <- c(done, "settings: run this file inside RStudio to turn them on")

# ---- 3. Addins menu entries ----------------------------------------------
pkgdir <- file.path(tempdir(), "exam2tools"); unlink(pkgdir, recursive = TRUE)
dir.create(file.path(pkgdir, "R"), recursive = TRUE); dir.create(file.path(pkgdir, "inst", "rstudio"), recursive = TRUE)
writeLines(c("Package: exam2tools", "Title: Addins for exam2.R", "Version: 1.0", "Description: Opens NUMS() and ASK() from exam2.R.",
             "License: MIT", "Encoding: UTF-8", "Imports: rstudioapi"), file.path(pkgdir, "DESCRIPTION"))
writeLines("export(nums_addin, ask_addin)", file.path(pkgdir, "NAMESPACE"))
writeLines(c(
  "get_fun <- function(name) {",
  "  f <- get0(name, envir = globalenv(), mode = 'function')",
  "  if (is.null(f) && rstudioapi::isAvailable()) {                       # exam2.R open but not run yet: run it",
  "    for (d in rstudioapi::getSourceEditorContext()$path) if (grepl('exam2', basename(d))) {",
  "      message('Running exam2.R first ...'); owd <- setwd(dirname(d)); on.exit(setwd(owd))",
  "      sys.source(d, envir = globalenv()); f <- get0(name, envir = globalenv(), mode = 'function') } }",
  "  if (is.null(f)) stop('Open exam2.R and run it once (Cmd+Shift+Enter / Ctrl+Shift+Enter), then try again.', call. = FALSE)",
  "  f }",
  "nums_addin <- function() get_fun('NUMS')()",
  "ask_addin  <- function() get_fun('ASK')()"), file.path(pkgdir, "R", "addins.R"))
writeLines(c(
  "Name: Exam II: numbers in the question", "Description: Copy the question first. Prints every number in it (NUMS()).", "Binding: nums_addin", "Interactive: false", "",
  "Name: Exam II: which block? (ASK)", "Description: Copy the question first. Runs ASK().", "Binding: ask_addin", "Interactive: false"),
  file.path(pkgdir, "inst", "rstudio", "addins.dcf"))
ok <- tryCatch({ suppressWarnings(install.packages(pkgdir, repos = NULL, type = "source", quiet = TRUE)); requireNamespace("exam2tools", quietly = TRUE) },
               error = function(e) FALSE)
done <- c(done, sprintf("Addins menu entries        %s", if (ok) "added (restart RStudio to see them)" else "could not be added (NUMS() and ASK() still work from the Console)"))

cat("\n==================== SETUP CHECKLIST ====================\n", paste0("  ", done, "\n"),
    "=========================================================\n",
    "Next: restart RStudio (Session > Restart R is not enough: quit and reopen).\n",
    "Then open exam2.R, run it once, and try:  NUMS()   ASK()   Addins > Exam II\n",
    "Optional keyboard shortcut: Tools > Modify Keyboard Shortcuts > search 'Exam II'.\n", sep = "")
