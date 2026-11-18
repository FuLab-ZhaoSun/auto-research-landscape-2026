# 自动论文生产链

自动论文工具要分清两件事：

1. **写出一篇像论文的文档**。
2. **产生真实、可复现、可投稿的新科学结果**。

目前第一件事已经相当工程化，第二件事仍必须依赖实验、评测、人工审查和复现。

## 推荐组合

### 文献和证据层

- [PaperQA2](https://github.com/Future-House/paper-qa)：科学文献 RAG、PDF 问答、引用支撑。
- [OpenScholar](https://github.com/akariasai/OpenScholar)：Nature Methods 级别的文献综合系统，但仓库最近维护不满足半年窗口，故不进主表。
- [GPT Researcher](https://github.com/assafelovic/gpt-researcher)：通用 deep research 报告生成，适合初步资料搜集。
- [Lacuna](https://github.com/tiptreesystems/lacuna-research-mcp)：把论文与学术元数据组织成 ML 研究地图，提供 web / markdown / MCP 三种接口。
- [Paper2Agent](https://github.com/jmiao24/Paper2Agent)：把一篇论文连同代码、数据、工作流转换成可交互 agent，便于复现与追问。

### 写作层

- [PaperOrchestra](https://github.com/Ar9av/PaperOrchestra)：多 agent 论文写作流程，覆盖 literature review、method、results、discussion 等环节。
- [Spark-to-Paper](https://github.com/Spark-To-Paper-Skills/spark-to-paper-skills)：从一句话想法出发的可组合技能链，覆盖文献检索、实验执行、结论修订与可编译 LaTeX 成稿。

### 图表层

- [PaperBanana](https://github.com/dwzhu-pku/PaperBanana)：参考驱动的多 agent 学术插图生成。
- [DrawAI](https://github.com/Renaissance-Mind/DrawAI)：把生成图或截图重建成可编辑的 SVG / PPTX，解决「生成了但改不动」的问题。

### 引用核查层

- [RefWarden](https://github.com/Agents4Academia-AI/citation_verification)：以 (claim, citation) 对为单位核对引用是否真实存在、是否真的支撑该论断。

## 使用建议

如果目标是提高写作效率：

1. 用 PaperQA2 或 OpenScholar 做文献和引用证据池，再用 RefWarden 核对关键论断。
2. 用 PaperOrchestra 或 Spark-to-Paper 生成 LaTeX 初稿。
3. 用 PaperBanana 或 DrawAI 补方法图和概念图。
4. 人工核对所有引用、实验结果和 claim。

如果目标是自动科研：

论文生产链只能放在最后一步。前面仍需要 ERA、Robin、CellVoyager、SR-Scientist、LLEMA、OpenEvolve 等系统产生可验证结果。

## 2026 年的两个新方向

1. **论文 agent 化**：Paper2Agent 把论文变成可交互 agent，读者可以直接追问方法、复现分析，而不只是读 PDF。
2. **技能链式写作**：Spark-to-Paper 把「想法→论文」拆成可组合技能，允许替换其中任一环节，也便于单独评测每个环节。
