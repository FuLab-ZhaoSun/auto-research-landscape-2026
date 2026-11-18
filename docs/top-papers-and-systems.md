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

## Biomni（Science 2026）

- 仓库：[snap-stanford/Biomni](https://github.com/snap-stanford/Biomni)
- 论文：[Science 2026](https://www.science.org/doi/10.1126/science.adz4351)
- 最近维护：2026-11-16。
- 类型：通用生物医学 AI agent。
- 能力：action-discovery agent 从数千篇文献里挖掘 25 个领域的工具、数据库与实验协议，构建统一 agentic 环境，再用 LLM 推理 + RAG 规划 + 代码执行动态组合工作流。
- 判断：把「生物医学 agent 能做什么」从论文里的单点 demo 推进到系统化动作空间，是 2026 年该方向引用最高的系统论文之一。

## OpenScientist（Nature Medicine 2026）

- 仓库：[openscientist-io/openscientist](https://github.com/openscientist-io/openscientist)
- 论文：[Nature Medicine 2026](https://www.nature.com/articles/s41591-026-04808-6)
- 最近维护：2026-11-17。
- 类型：开源的 agentic AI co-scientist。
- 能力：以 Agent Skills + MCP 工具在「假设 → 执行 → 检索 → 修订」循环里做可验证的数据分析，五个生物医学案例由领域专家盲评。
- 判断：第一次有开源 co-scientist 以顶刊系统论文的形式出现，可直接对照复现。

## Paper2Agent（Nature 2026）

- 仓库：[jmiao24/Paper2Agent](https://github.com/jmiao24/Paper2Agent)
- 论文：[Nature 2026](https://www.nature.com/articles/s41586-026-11044-y)
- 最近维护：2026-09-17。
- 类型：论文转 agent 框架。
- 能力：把论文正文、补充材料、数据集、代码与工作流一起转换成可交互 agent，充当「虚拟通讯作者」。
- 判断：改变论文的消费方式，也顺带解决复现问题——agent 直接调用原文代码而不是让读者自己拼环境。

## The Agentic Scientist（AI-Scientist-v3，2026）

- 仓库：[SakanaAI/AI-Scientist-v3](https://github.com/SakanaAI/AI-Scientist-v3)
- 论文：[arXiv 2610.18933](https://arxiv.org/abs/2610.18933)（预印本，故证据等级记 B）
- 最近维护：2026-11-17。
- 类型：端到端自动科研。
- 能力：不再使用固定模板流水线，而是编排通用编码 agent 完成想法生成、并行实验树搜索与 LaTeX 论文撰写，并显式讨论 rubric 下的 reward hacking。
- 判断：与 2024 版 The AI Scientist 是两个不同的仓库和方法，代表「编排编码 agent」这条路线。

## Arbor（2026）

- 仓库：[RUC-NLPIR/Arbor](https://github.com/RUC-NLPIR/Arbor)
- 论文：[arXiv 2606.11926](https://arxiv.org/abs/2606.11926)（预印本，故证据等级记 B）
- 最近维护：2026-11-03。
- 类型：通用长程自主研究 agent。
- 能力：把研究过程建模成假设树精炼——提出子假设、执行实验、按证据剪枝，用持久假设树而非对话历史维持长程一致性。
- 判断：2026 年下半年最受关注的长程自主研究范式之一。

## AlphaEvolve（背景）

- 论文：[PNAS 2026](https://doi.org/10.1073/pnas.2536158123)，以及 Google DeepMind 2025 技术报告。
- 开源状态：官方未开源；开源复刻 [OpenEvolve](https://github.com/algorithmicsuperintelligence/openevolve) 已进主表。
- 判断：用进化式编码 agent 在 67 个数学问题上复现或改进已知最优解，是「自动算法/数学发现」目前最强的公开证据，但因不开源只作为背景。
