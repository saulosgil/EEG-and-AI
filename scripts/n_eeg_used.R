library(readxl)
library(dplyr)
library(ggplot2)
library(forcats)
library(viridis)

file_path <- "data/rayyan_extract_infos.xlsx"

df <- read_excel(file_path, sheet = "r_sheet")

freq_table <- df |>
  filter(!is.na(n_canais_eeg))  |>
  count(n_canais_eeg, name = "n_studies") |>
  arrange(n_canais_eeg) |>
  mutate(n_canais_eeg = as.factor(n_canais_eeg))

print(freq_table)

p <- ggplot(
  freq_table,
  aes(
    x = fct_inorder(n_canais_eeg),
    y = n_studies,
    fill = n_canais_eeg
  )
) +
  geom_col() +
  geom_text(aes(label = n_studies), vjust = -0.2, size = 4) +
  scale_fill_viridis_d(option = "viridis", end = 0.9) +
  labs(
    title = "Number of EEG Electrodes Used Across Studies",
    x = "Number of EEG electrodes",
    y = "Number of studies"
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "none"
  ) +
  expand_limits(y = max(freq_table$n_studies) + 1)

p
