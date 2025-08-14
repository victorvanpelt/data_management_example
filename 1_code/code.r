# Clear everything
rm(list = ls()); invisible(gc())

# Use CRAN mirror (needed when running via Rscript / make)
options(repos = c(CRAN = "https://cloud.r-project.org"))

# If we're at the project root, step into 1_code; otherwise, do nothing.
if (dir.exists(file.path(getwd(), "1_code"))) {
  setwd(file.path(getwd(), "1_code"))
}
# Now go up one level so we're guaranteed to be at the project root
setwd("..")
ROOT <- getwd()

# Packages
need <- c("readr","haven","dplyr","sandwich","lmtest","modelsummary")
to_install <- setdiff(need, rownames(installed.packages()))
if (length(to_install)) install.packages(to_install)  # repos taken from options()
invisible(lapply(need, require, character.only = TRUE))

# Paths
path_csv   <- file.path(ROOT, "0_data",   "gen_ai_earnings.csv")
path_proc  <- file.path(ROOT, "2_process", "gen_ai_earnings.rds")
path_edit  <- file.path(ROOT, "2_process", "edit_gen_ai_earnings.rds")
path_table <- file.path(ROOT, "3_output", "Table 1r.rtf")

dir.create(file.path(ROOT, "2_process"), showWarnings = FALSE, recursive = TRUE)
dir.create(file.path(ROOT, "3_output"),  showWarnings = FALSE, recursive = TRUE)

# Import raw CSV -> save as .dta
df <- readr::read_csv(path_csv, show_col_types = FALSE)
saveRDS(df, path_proc)

# Clear + reload the .dta
rm(df); invisible(gc())
df <- readRDS(path_proc)

# Transform
df$earnings_scaled <- df$earnings / 10
df <- df[df$earnings_scaled >= 0, , drop = FALSE]

# Save edited .dta
saveRDS(df, path_edit)

# Clear + reload edited .dta
rm(df); invisible(gc())
df <- readRDS(path_edit)

# Regression with robust SE
mod <- lm(earnings_scaled ~ gen_ai, data = df)
vc  <- sandwich::vcovHC(mod, type = "HC1")  # heteroskedasticity-robust (Stata's ,r)

# Export table 
df_m <- length(coef(mod)) - 1L  # model df (number of regressors)

gof_map <- tibble::tribble(
  ~raw,         ~clean, ~fmt,
  "r.squared",  "R2",      3,
  "statistic",  "F",       3,
  "p.value",    "p",       3,
  "nobs",       "N",       0
)

# Add df_m as a custom row at the end
add_rows_tbl <- tibble::tibble(term = "df_m", `Model 1` = df_m)

modelsummary::modelsummary(
  list("Model 1" = mod),
  vcov      = list(vc),
  estimate  = "{estimate}",
  statistic = "({std.error})",
  stars     = c("*" = .10, "**" = .05, "***" = .01),
  gof_map   = gof_map,
  add_rows  = add_rows_tbl,
  fmt       = 3,
  title     = "TABLE 1 - REGRESSIONS OF SCALED EARNINGS ON GENERATIVE AI",
  notes     = "p-levels are two-tailed, * p < 0.10, ** p < 0.05, *** p < 0.01; robust SE in parentheses.",
  output    = path_table
)

# Exit
q(save = "no")
