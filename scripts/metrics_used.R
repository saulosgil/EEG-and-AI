# libraries
library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(forcats)
library(viridis)
library(stringr)

# path
file_path <- "data/rayyan_extract_infos.xlsx"

metric_labels <- c(
  ACC_METRIC = "Accuracy",
  SE_METRIC  = "Sensitivity",
  SP_METRIC  = "Specificity",
  F1_METRIC  = "F1-score",
  ROC_METRIC = "ROC-AUC"
)

metric_cols <- names(metric_labels)

# reading datasheet
df <- read_excel(file_path, sheet = "r_sheet")

freq_table <- df  |>
  select(all_of(metric_cols)) |>
  mutate(across(everything(), ~ replace_na(as.numeric(.x), 0))) |>
  summarise(across(everything(), sum)) |>
  pivot_longer(
    cols = everything(),
    names_to = "metric_code",
    values_to = "n_studies"
  ) |>
  mutate(metric = metric_labels[metric_code]) |>
  arrange(desc(n_studies))

print(freq_table)

# plot
p <- ggplot(
  freq_table,
  aes(
    x = fct_reorder(metric, n_studies),
    y = n_studies,
    fill = metric
  )
) +
  geom_col() +
  geom_text(aes(label = n_studies), hjust = -0.15, size = 4) +
  coord_flip() +
  scale_fill_viridis_d(option = "viridis", end = 0.9) +
  labs(
    title = "Frequency of Performance Metrics Reported Across Studies",
    x = "Performance metric",
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

