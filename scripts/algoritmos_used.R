# libraries
library(readxl)
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(forcats)
library(viridis)

# path: use the summary spreadsheet created from the table
file_path <- "data/ml_studies_summary.xlsx"

# read table
df <- read_excel(file_path, sheet = "Study summary")

# count algorithms from the "Algorithms used" column
freq_table <- df |>
  select(`First author`, Year, `Algorithms used`) |>
  separate_rows(`Algorithms used`, sep = ";") |>
  mutate(`Algorithms used` = str_squish(`Algorithms used`)) |>

  # remove deep learning approaches and empty cells
  filter(
    !is.na(`Algorithms used`),
    `Algorithms used` != "",
    !str_detect(`Algorithms used`, regex("Multilayer perceptron|Long short-term memory|Convolutional neural network|Gated recurrent unit", ignore_case = TRUE))
  ) |>

  # harmonize names to match the plot categories
  mutate(
    algorithm = case_when(
      str_detect(`Algorithms used`, regex("^Support vector machine$|^Linear SVM$|^RBF SVM$", ignore_case = TRUE)) ~ "SVM",
      str_detect(`Algorithms used`, regex("^Random forest$", ignore_case = TRUE)) ~ "Random Forest",
      str_detect(`Algorithms used`, regex("^k-Nearest neighbors$|^Enhanced k-nearest neighbors$", ignore_case = TRUE)) ~ "k-Nearest Neighbors",
      str_detect(`Algorithms used`, regex("^Logistic regression$", ignore_case = TRUE)) ~ "Logistic Regression",
      str_detect(`Algorithms used`, regex("^Naive Bayes$", ignore_case = TRUE)) ~ "Naive Bayes",
      str_detect(`Algorithms used`, regex("^Gradient boosting$", ignore_case = TRUE)) ~ "Gradient Boosting",
      str_detect(`Algorithms used`, regex("^Linear discriminant analysis$", ignore_case = TRUE)) ~ "Linear Discriminant Analysis",
      str_detect(`Algorithms used`, regex("^Quadratic discriminant analysis$", ignore_case = TRUE)) ~ "Quadratic Discriminant Analysis",
      str_detect(`Algorithms used`, regex("^Decision tree$", ignore_case = TRUE)) ~ "Decision Tree",
      str_detect(`Algorithms used`, regex("^XGBoost$", ignore_case = TRUE)) ~ "XGBoost",
      str_detect(`Algorithms used`, regex("^RUSBoost$", ignore_case = TRUE)) ~ "RUSBoost",
      str_detect(`Algorithms used`, regex("^GentleBoost$", ignore_case = TRUE)) ~ "GentleBoost",
      TRUE ~ NA_character_
    )
  ) |>
  filter(!is.na(algorithm)) |>

  # count unique studies per algorithm
  distinct(`First author`, Year, algorithm) |>
  count(algorithm, name = "n_studies") |>
  arrange(desc(n_studies))

print(freq_table)

p <- ggplot(
  freq_table,
  aes(
    x = fct_reorder(algorithm, n_studies),
    y = n_studies,
    fill = algorithm
  )
) +
  geom_col() +
  geom_text(aes(label = n_studies), hjust = -0.15, size = 4) +
  coord_flip() +
  scale_fill_viridis_d(option = "viridis", end = 0.9) +
  labs(
    title = "Most Frequently Used Machine Learning Algorithms",
    x = "Algorithm",
    y = "Number of studies"
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(face = "bold"),
    axis.text.y = element_text(size = 10),
    legend.position = "none"
  ) +
  expand_limits(y = max(freq_table$n_studies) + 1)

p
