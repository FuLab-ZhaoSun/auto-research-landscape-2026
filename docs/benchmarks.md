# 评测基准

## 为什么基准重要

自动科研 agent 很容易生成看起来可信的报告，但真正难点是：

- 是否找到新颖且有意义的假设。
- 是否能写出可运行代码。
- 是否能在真实数据上改进指标。
- 是否能复现实验。
- 是否能控制成本、失败率和幻觉。

因此，评测基准是判断项目价值的关键。

## AstaBench

- 仓库：[allenai/asta-bench](https://github.com/allenai/asta-bench)
- 维护：2026-05-11。
- 特点：2400+ examples，11 benchmarks，覆盖文献检索、代码执行、数据分析和端到端发现。
- 价值：适合做通用 AI research agent 的横向比较。

## AIRS-Bench

- 仓库：[facebookresearch/airs-bench](https://github.com/facebookresearch/airs-bench)
- 维护：2026-05-05。
- 特点：20 个来自前沿 ML 论文的任务，要求 agent 根据 problem、dataset、metric 产出可评分 solution。
- 价值：更聚焦 AI research science agents。

## PostTrainBench

- 仓库：[aisa-group/PostTrainBench](https://github.com/aisa-group/PostTrainBench)
- 维护：2026-05-28。
- 特点：给 agent 10 小时 H100，让它改进一个 base LLM 的后训练表现。
- 价值：很直接地评估 agent 是否能做 AI R&D，而不是只写代码片段。

## ARC-Bench

- 来源：[AutoResearchClaw](https://github.com/aiming-lab/AutoResearchClaw)
- 维护：2026-05-28。
- 特点：55 个开放式自动科研 topic，覆盖 ML、高能物理、量子、生物和统计。
- 价值：偏开放式科研流程评估，仍需更多外部复现。
