# Control Panel Framework — Decision Guide

## Purpose

The control panel translates statistical findings into a practical decision-support tool for operational leaders. Rather than treating every below-target decline as equally urgent, it evaluates multiple signals before recommending action.

## Four Input Signals

| Signal | What It Measures |
|---|---|
| Trend direction | Is performance moving up or down? |
| Distance from target | How far below target is the metric? |
| Historical variability | Is this movement unusual given past behavior? |
| Prior intervention history | Has this metric been intervened on before without recovery? |

## Three Decision Categories

| Decision | Meaning | When It Applies |
|---|---|---|
| **Monitor** | Performance movement appears within expected variation | Trend is flat or improving, distance from target is small |
| **Intervene** | Decline is large enough to justify formal corrective action | Below target, declining, distance exceeds threshold |
| **Escalate** | Persistent concern despite prior interventions | Multiple prior interventions with no sustained recovery |

## Adjustable Thresholds

| Threshold | Default | What It Controls |
|---|---|---|
| Improvement threshold | 1.00% | Minimum improvement to consider performance good |
| Distance threshold | 2.00% | How far from target triggers concern |
| Max prior interventions | 5 | Number of attempts before escalation |
| Z threshold | 0.00 | Sensitivity to unusual changes |

## Key Insight from Analysis

Interventions performed better when metrics were already close to target (distance less than 10%). When performance had moved materially off target, intervention outcomes were weaker. This suggests the control panel's distance threshold is one of its most important inputs.

## Important Note

The control panel is a decision-support layer, not a replacement for leadership judgment. It provides a consistent, data-driven starting point for determining when formal action is most likely to add value.
