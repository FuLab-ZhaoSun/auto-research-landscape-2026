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

### 写作层

- [PaperOrchestra](https://github.com/Ar9av/PaperOrchestra)：多 agent 论文写作流程，覆盖 literature review、method、results、discussion 等环节。

### 图表层

- [PaperBanana](https://github.com/dwzhu-pku/PaperBanana)：参考驱动的多 agent 学术插图生成。

## 使用建议

如果目标是提高写作效率：

1. 用 PaperQA2 或 OpenScholar 做文献和引用证据池。
2. 用 PaperOrchestra 生成 LaTeX 初稿。
3. 用 PaperBanana 补方法图和概念图。
4. 人工核对所有引用、实验结果和 claim。

如果目标是自动科研：

论文生产链只能放在最后一步。前面仍需要 ERA、Robin、CellVoyager、SR-Scientist、LLEMA、OpenEvolve 等系统产生可验证结果。
