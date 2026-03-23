library(dplyr)
library(ggplot2)
library(rnaturalearth)
library(sf)
library(ggrepel)

# 1. Dataset
data <- data.frame(
  location = c(
    "Netherlands","United States","Netherlands","Netherlands",
    "Switzerland","United States","England","Netherlands",
    "Ireland","Netherlands","England","Switzerland",
    "Switzerland","United States","England","Switzerland",
    "United States","United States","United States","United States"
  )
)

# 2. Corrigir nomes para rnaturalearth
data <- data %>%
  mutate(location = case_when(
    location == "England" ~ "United Kingdom",
    location == "United States" ~ "United States of America",
    TRUE ~ location
  ))

# 3. Contagem de ocorrências
country_counts <- data %>%
  count(location) %>%
  rename(count = n)

# 4. Mapa mundial
world <- ne_countries(scale = "medium", returnclass = "sf")

# 5. Preparar para join
world_df <- world %>% st_drop_geometry() %>% select(name, iso_a3)

# 6. Juntar frequência
world_df <- world_df %>%
  left_join(country_counts, by = c("name" = "location"))

# 7. Substituir NAs por 0
world_df$count <- as.numeric(ifelse(is.na(world_df$count), 0, world_df$count))

# 8. Reanexar geometria
world_freq <- world %>%
  left_join(world_df %>% select(iso_a3, count), by = "iso_a3")

# 9. Subset de países com ocorrências
focus_countries <- world_freq %>% filter(count > 0)

# 10. Calcular centróides
coords <- st_coordinates(st_centroid(focus_countries))
focus_countries <- focus_countries %>%
  mutate(lon = coords[,1], lat = coords[,2])

# 11. Criar coluna de fill: cinza claro para count=0
world_freq <- world_freq %>%
  mutate(fill_color = ifelse(count == 0, NA, count))

# 12. Plot em estilo artigo científico
ggplot() +
  geom_sf(data = world_freq, aes(fill = fill_color), color = "gray80", size = 0.2) +
  ggrepel::geom_text_repel(
    data = focus_countries,
    aes(x = lon,
        y = lat,
        label = name),
    size = 3,
    fontface = "bold",
    segment.color = "gray60"
  ) +
  scale_fill_viridis_c(
    option = "viridis",
    na.value = "lightgray",
    name = "Occurrences"
  ) +
  theme_bw(base_size = 12) +
  theme(
    panel.background = element_rect(fill = "white",
                                    color = NA),
    panel.grid = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    legend.position = "bottom",
    legend.key.width = unit(2, "cm")
  ) +
  labs(
    title = "Geographic distribution of studies included in the analysis",
  )
