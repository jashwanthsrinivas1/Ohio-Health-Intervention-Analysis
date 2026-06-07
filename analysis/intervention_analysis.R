# ============================================================
# OhioHealth Performance Intervention Analysis
# M.S. in Business Analytics | University of Dayton | May 2026
# NOTE: This script uses synthetic data only.
# Real OhioHealth data is confidential and not included.
# ============================================================

library(dplyr)
library(ggplot2)

# ------------------------------------------------------------
# 1. LOAD DATA
# ------------------------------------------------------------
data <- read.csv("data/synthetic_panel_data.csv")

# ------------------------------------------------------------
# 2. DESCRIPTIVE REVIEW
# ------------------------------------------------------------
data %>%
  group_by(intervention) %>%
  summarise(
    mean_pct_change = mean(pct_change, na.rm = TRUE),
    sd_pct_change   = sd(pct_change, na.rm = TRUE),
    n               = n()
  )

ggplot(data, aes(x = factor(intervention), y = pct_change, fill = factor(intervention))) +
  geom_boxplot() +
  labs(
    title = "Performance Change: Intervention vs Non-Intervention Months",
    x     = "Intervention (0 = No, 1 = Yes)",
    y     = "Month-over-Month % Change",
    fill  = "Intervention"
  ) +
  theme_minimal()

# ------------------------------------------------------------
# 3. LAGGED REGRESSION TESTING
# ------------------------------------------------------------
model_n1 <- lm(outcome_n1 ~ intervention, data = data)
summary(model_n1)

model_n2 <- lm(outcome_n2 ~ intervention, data = data)
summary(model_n2)

model_n3 <- lm(outcome_n3 ~ intervention, data = data)
summary(model_n3)

model_n4 <- lm(outcome_n4 ~ intervention, data = data)
summary(model_n4)

# ------------------------------------------------------------
# 4. PATTERN TESTING
# ------------------------------------------------------------
data <- data %>%
  mutate(distance_bin = cut(distance_from_target,
                            breaks = c(0, 0.05, 0.10, 0.15, 0.20, Inf),
                            labels = c("0-5%", "5-10%", "10-15%", "15-20%", "20%+"),
                            include.lowest = TRUE))

data %>%
  filter(intervention == 1) %>%
  group_by(distance_bin) %>%
  summarise(
    avg_outcome_n4 = mean(outcome_n4, na.rm = TRUE),
    n = n()
  )

data %>%
  filter(intervention == 1) %>%
  ggplot(aes(x = distance_bin, y = outcome_n4)) +
  geom_bar(stat = "summary", fun = "mean", fill = "steelblue") +
  labs(
    title = "Intervention Outcomes by Distance from Target (N+4)",
    x     = "Distance from Target at Intervention",
    y     = "Average Outcome (N+4)"
  ) +
  theme_minimal()

# ------------------------------------------------------------
# 5. CONTROL PANEL DECISION LOGIC
# ------------------------------------------------------------
improvement_threshold   <- 0.01
distance_threshold      <- 0.05
max_prior_interventions <- 3

data <- data %>%
  mutate(decision = case_when(
    prior_interventions >= max_prior_interventions & trend == "DOWN" ~ "Escalate",
    distance_from_target >= distance_threshold & trend == "DOWN"     ~ "Intervene",
    TRUE                                                              ~ "Monitor"
  ))

data %>%
  count(decision) %>%
  mutate(pct = round(n / sum(n) * 100, 1))

ggplot(data, aes(x = decision, fill = decision)) +
  geom_bar() +
  scale_fill_manual(values = c("Monitor"   = "green3",
                               "Intervene" = "tomato",
                               "Escalate"  = "orange")) +
  labs(
    title = "Control Panel Decision Distribution",
    x     = "Decision",
    y     = "Count"
  ) +
  theme_minimal()
