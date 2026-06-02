# 顶刊与顶会系统

## Google AI Co-Scientist

- 链接：[Nature article](https://www.nature.com/articles/s41586-026-10644-y)
- 类型：科学假设生成、批判、演化、排序的多智能体系统。
- 开源状态：未见 Google 官方完整代码开源。
- 相关复刻：[Kaimen-Inc/Co-Scientist](https://github.com/Kaimen-Inc/Co-Scientist)
- 最近维护：非官方复刻在 2026-05-31 有更新。
- 判断：半年内最重要的 AI scientist 系统之一。重点不是写论文，而是形成可实验验证的研究假设。

## Robin

- 仓库：[Future-House/robin](https://github.com/Future-House/robin)
- 论文：[Nature article](https://www.nature.com/articles/s41586-026-10652-y)
- 最近维护：2026-04-21。
- 类型：端到端生物发现系统。
- 能力：从疾病输入开始，生成假设、提出实验模型、分析数据、迭代候选结论。
- 限制：运行完整数据分析依赖 Edison 平台。

## ERA

- 仓库：[google-research/era](https://github.com/google-research/era)
- 论文：[Nature article](https://www.nature.com/articles/s41586-026-10658-6)
- 最近维护：2026-05-27。
- 类型：Empirical Research Assistant。
- 能力：帮助科学家写专家级实证研究软件，覆盖公共卫生、气候、水文、经济、组合学等任务。
- 判断：不是论文写作工具，而是科研代码生产力工具。

## The AI Scientist

- 仓库：[SakanaAI/AI-Scientist](https://github.com/SakanaAI/AI-Scientist)
- 论文：[Nature article](https://www.nature.com/articles/s41586-026-10265-5)
- 最近维护：2025-12-19。
- 类型：自动 AI 研究闭环。
- 能力：idea 生成、实验代码、图表、论文、自动 review。
- 风险：会执行 LLM 生成代码，必须容器化和限制网络。

## CellVoyager

- 仓库：[zou-group/CellVoyager](https://github.com/zou-group/CellVoyager)
- 论文：[Nature Methods article](https://www.nature.com/articles/s41592-026-03029-6)
- 最近维护：2026-03-28。
- 类型：计算生物学 agent。
- 能力：自动分析生物数据，特别是单细胞和相关数据分析。

## Virtual Lab

- 仓库：[zou-group/virtual-lab](https://github.com/zou-group/virtual-lab)
- 论文：[Nature article](https://www.nature.com/articles/s41586-025-09442-9)
- 最近维护：2025-12-31。
- 类型：AI-human 科研协作实验室。
- 能力：多 AI 科学家会议式协作，已用于设计 SARS-CoV-2 nanobody，并进行实验验证。

## SR-Scientist

- 仓库：[GAIR-NLP/SR-Scientist](https://github.com/GAIR-NLP/SR-Scientist)
- 论文：ICLR 2026, arXiv 2510.11661。
- 最近维护：2026-01-27。
- 类型：科学方程发现 agent。
- 能力：分析数据、写代码、实现方程、评估方程、根据反馈优化。

## LLEMA

- 仓库：[scientific-discovery/LLEMA](https://github.com/scientific-discovery/LLEMA)
- 论文：ICLR 2026, arXiv 2510.22503。
- 最近维护：2026-05-10。
- 类型：材料发现。
- 能力：LLM + evolutionary search 做多目标材料发现，提供 14 个材料发现任务。

## ShinkaEvolve

- 仓库：[SakanaAI/ShinkaEvolve](https://github.com/SakanaAI/ShinkaEvolve)
- 论文：ICLR 2026, arXiv 2509.19349。
- 最近维护：2026-05-29。
- 类型：程序进化与科学代码发现。
- 能力：LLM 作为 mutation operator，结合进化搜索持续优化程序。

## AstaBench

- 仓库：[allenai/asta-bench](https://github.com/allenai/asta-bench)
- 论文：[AstaBench paper page](https://allenai.org/papers/astabench)
- 最近维护：2026-05-11。
- 类型：自动科研能力评测。
- 能力：2400+ examples、11 benchmarks，覆盖文献检索、代码执行、数据分析和端到端发现。
