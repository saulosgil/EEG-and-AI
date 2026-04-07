# 🧠⚡ EEG-and-AI

📊 Repository with **R scripts** and curated datasets for a review-oriented analysis of how **electroencephalography (EEG)** and **artificial intelligence (AI)/machine learning** have been used across published studies.

This repository organizes data extraction files and reproducible scripts to summarize the literature, including:

- 🤖 the **most frequently used machine learning algorithms**;
- 📏 the **performance metrics** most often reported;
- 🎛️ the **number of EEG electrodes/channels** used across studies;
- 🌍 the **geographic distribution** of included studies.  

The repository currently contains two main folders, `data/` and `scripts/`, and is written entirely in **R**.

---

## 📖 About the project

This project was developed to support the synthesis and visualization of evidence from studies combining **EEG-based data** with **AI/machine learning methods**. The repository includes structured spreadsheets and analysis scripts that generate summary figures for the reviewed literature.

---

## 🎯 Main goals

This repository can be used to:

- 🧾 summarize the machine learning algorithms reported across included EEG studies;
- 📈 quantify which performance metrics are most frequently presented;
- 🎚️ describe the distribution of EEG channel/electrode counts across studies;
- 🗺️ visualize the countries represented in the included literature.

These aims are reflected directly in the scripts `algoritmos_used.R`, `metrics_used.R`, `n_eeg_used.R`, and `mapa_paises_artigos_incluidos.R`.

---

## 🗂️ Repository structure

```text
EEG-and-AI/
├── data/
│   ├── ml_studies_summary.xlsx
│   ├── raw_dataExtracted.zip
│   └── rayyan_extract_infos.xlsx
├── scripts/
│   ├── algoritmos_used.R
│   ├── mapa_paises_artigos_incluidos.R
│   ├── metrics_used.R
│   └── n_eeg_used.R
├── EEG and AI.Rproj
└── .gitignore
└── EstudoDirigido_ML_depression_detection
```

---

## 📁 Data files

### `ml_studies_summary.xlsx`
Used by `algoritmos_used.R` to read the **"Study summary"** sheet and count the frequency of machine learning algorithms listed in the **"Algorithms used"** column.

### `rayyan_extract_infos.xlsx`
Used by both `metrics_used.R` and `n_eeg_used.R`. In the scripts, this spreadsheet is read from the **"r_sheet"** worksheet.

### `raw_dataExtracted.zip`
Compressed raw extracted material stored in the repository data folder.

---

## 🧪 Scripts overview

### 🤖 `scripts/algoritmos_used.R`
This script:

- reads `data/ml_studies_summary.xlsx`;
- separates multiple algorithms listed in the same cell;
- standardizes algorithm names;
- excludes selected deep learning approaches such as multilayer perceptron, long short-term memory, convolutional neural network, and gated recurrent unit;
- counts the number of studies per algorithm;
- generates a horizontal bar chart titled **"Most Frequently Used Machine Learning Algorithms"**.

The script harmonizes categories such as:

- SVM
- Random Forest
- k-Nearest Neighbors
- Logistic Regression
- Naive Bayes
- Gradient Boosting
- Linear Discriminant Analysis
- Quadratic Discriminant Analysis
- Decision Tree
- XGBoost
- RUSBoost
- GentleBoost

### 📈 `scripts/metrics_used.R`
This script:

- reads `data/rayyan_extract_infos.xlsx`;
- sums study-level indicators for reported metrics;
- maps coded fields to metric labels;
- creates a plot titled **"Frequency of Performance Metrics Reported Across Studies"**.

The metric labels explicitly defined in the script are:

- Accuracy
- Sensitivity
- Specificity
- F1-score
- ROC-AUC

### 🎛️ `scripts/n_eeg_used.R`
This script:

- reads `data/rayyan_extract_infos.xlsx`;
- counts how many studies used each EEG channel/electrode count from the `n_canais_eeg` field;
- creates a bar chart titled **"Number of EEG Electrodes Used Across Studies"**.

### 🌍 `scripts/mapa_paises_artigos_incluidos.R`
This script:

- builds a country-level count table;
- uses `rnaturalearth`, `sf`, `ggplot2`, and `ggrepel`;
- relabels **England** as **United Kingdom** and **United States** as **United States of America** for mapping compatibility;
- generates a world map titled **"Geographic distribution of studies included in the analysis"**.

The countries explicitly listed in the script data object are the Netherlands, United States, Switzerland, England/United Kingdom, and Ireland.

---

## 💻 Requirements

The project is based in **R** and includes an RStudio project file named `EEG and AI.Rproj`.

The scripts use packages such as:

- `readxl`
- `dplyr`
- `tidyr`
- `stringr`
- `ggplot2`
- `forcats`
- `viridis`
- `rnaturalearth`
- `sf`
- `ggrepel`

You can install the main dependencies in R with:

```r
install.packages(c(
  "readxl",
  "dplyr",
  "tidyr",
  "stringr",
  "ggplot2",
  "forcats",
  "viridis",
  "rnaturalearth",
  "sf",
  "ggrepel"
))
```

---

## ▶️ How to use

### 1. Clone the repository

```bash
git clone https://github.com/saulosgil/EEG-and-AI.git
```

### 2. Open the project in RStudio

Open:

```r
EEG and AI.Rproj
```

### 3. Run the scripts

You can run the scripts individually depending on the output you want to generate:

```r
source("scripts/algoritmos_used.R")
source("scripts/metrics_used.R")
source("scripts/n_eeg_used.R")
source("scripts/mapa_paises_artigos_incluidos.R")
```

The scripts expect the spreadsheets to remain in the `data/` directory using the relative paths defined inside the code.

---

## 🔁 Reproducibility

To keep the workflow reproducible:

- ✅ preserve the current folder structure;
- ✅ keep the input spreadsheets inside `data/`;
- ✅ run the scripts from the project root;
- ✅ use R/RStudio with the listed packages installed.

Because the repository is designed as a descriptive evidence-mapping workflow, the outputs depend directly on the maintained extraction spreadsheets.

---

## 📝 Suggested citation

If you use this repository, consider citing the corresponding review/manuscript and linking this GitHub repository as the analysis source.

```bibtex
@misc{gil_eeg_ai_repo,
  author = {Gil, Saulo},
  title = {EEG-and-AI},
  year = {2026},
  howpublished = {GitHub repository},
  note = {Repository for literature synthesis and visualization of EEG and AI studies}
}
```

---


---

## 🌟 Final note

This repository is a compact and useful base for organizing, summarizing, and visualizing the literature on **EEG and AI**. Its current structure is especially suited to review projects that need transparent descriptive summaries of algorithms, metrics, EEG acquisition characteristics, and geographic distribution of included studies.

#

## 👨‍💻 Author

**Saulo Gil**  
GitHub: [@saulosgil](https://github.com/saulosgil)
