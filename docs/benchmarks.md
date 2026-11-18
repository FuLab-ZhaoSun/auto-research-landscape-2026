# 评测基准

本轮窗口新增 NatureBench、Into the Unknown、AISLE、BAISBench 与 RIDAR（科研诚信审计），原有基准的维护日期同步刷新。

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
- 维护：2026-11-10。
- 特点：2400+ examples，11 benchmarks，覆盖文献检索、代码执行、数据分析和端到端发现。
- 价值：适合做通用 AI research agent 的横向比较。

## AIRS-Bench

- 仓库：[facebookresearch/airs-bench](https://github.com/facebookresearch/airs-bench)
- 维护：2026-05-05（本轮窗口外，保留）。
- 特点：20 个来自前沿 ML 论文的任务，要求 agent 根据 problem、dataset、metric 产出可评分 solution。
- 价值：更聚焦 AI research science agents。

## PostTrainBench

- 仓库：[aisa-group/PostTrainBench](https://github.com/aisa-group/PostTrainBench)
- 维护：2026-11-12。
- 特点：给 agent 10 小时 H100，让它改进一个 base LLM 的后训练表现。
- 价值：很直接地评估 agent 是否能做 AI R&D，而不是只写代码片段。

## ARC-Bench

- 来源：[AutoResearchClaw](https://github.com/aiming-lab/AutoResearchClaw)
- 维护：2026-08-19。
- 特点：55 个开放式自动科研 topic，覆盖 ML、高能物理、量子、生物和统计。
- 价值：偏开放式科研流程评估，仍需更多外部复现。

## NatureBench

- 仓库：[FrontisAI/NatureBench](https://github.com/FrontisAI/NatureBench)
- 维护：2026-11-15。
- 特点：从 Nature 系论文蒸馏 90 个跨 6 个学科的科学 ML 任务，要求编码 agent 不只是复现，而是达到原文已发表的 SOTA。
- 价值：把「能不能做出可发表的科研结果」变成可自动评分的任务，并配持续更新的公开 leaderboard。

## Into the Unknown

- 仓库：[prometheus-eval/into-the-unknown](https://github.com/prometheus-eval/into-the-unknown)
- 维护：2026-10-20。
- 特点：与 DOE 国家实验室科学家合作，把尚未发表的后续研究方向作为 15 个开放科研题，要求 agent 写出满足专家预设条件的跟进论文。
- 价值：最贴近真实开放科研与论文写作的评测；首轮结果显示 agent 论文普遍达不到专家标准，且存在捏造论断。

## AISLE（AI Scientists' Last Exam）

- 仓库：[MasterAI-EAM/ai-scientists-last-exam](https://github.com/MasterAI-EAM/ai-scientists-last-exam)
- 维护：2026-11-18。
- 特点：首个面向干湿实验闭环的公开基准，在 Docker 中运行 agent 并给实验记录打分，含湿实验提交与实时 leaderboard。
- 价值：把「能否驱动真实实验」纳入评测，而不只是代码与文本产出。

## BAISBench

- 仓库：[EperLuo/BaisBench](https://github.com/EperLuo/BaisBench)
- 论文：Bioinformatics 2026（DOI 10.1093/bioinformatics/btag227）。
- 维护：2026-03-18（仓库更新早于论文发表，按实标注）。
- 特点：用真实单细胞转录组数据评估 AI scientist 能否得出有意义的生物学发现，而非只做预设分析。
- 价值：补上「真实数据驱动」这一维度，适合作为组学方向 AI scientist 的横向基准。

## RIDAR（科研诚信审计）

- 仓库：[THU-KEG/RIDAR](https://github.com/THU-KEG/RIDAR)
- 维护：2026-10-25。
- 特点：自动检测数据泄漏、指标误用、事后挑选等科研失效模式，并对自主科研 agent 做运行时干预。
- 价值：不是排行榜基准，而是给其他系统和评测做审计的护栏层。

## 使用基准时的注意事项

2026 年 PNAS 的系统性分析（*The more you automate, the less you see*）指出，开源 AI scientist 普遍存在四类问题：

1. 不合适的基准选择；2. 数据泄漏；3. 指标误用；4. 事后挑选（post hoc selection）。

这些问题在最终论文层面往往不可见。因此用基准比较系统时，应同时检查数据隔离、评测脚本版本与选择偏差。
