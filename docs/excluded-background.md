# 排除与背景项目

这些项目重要，但没有进入主表。原因通常是最近维护不满足半年窗口，或代码/系统开放程度不足。

| 项目 | 最近可见维护 | 说明 |
|---|---:|---|
| [Agent Laboratory](https://github.com/SamuelSchmidgall/AgentLaboratory) | 2025-08 | 重要的端到端科研 workflow，但不满足半年维护窗口。 |
| [ResearchAgent](https://github.com/JinheonBaek/ResearchAgent) | 2025-08 | 文献驱动的 idea generation 系统，维护不满足窗口。 |
| [AI-Researcher](https://github.com/HKUDS/AI-Researcher) | 2025-10 | 自动科学创新平台，维护不满足窗口。 |
| [OpenResearcher](https://github.com/GAIR-NLP/OpenResearcher) | 2024-10 | arXiv 科研问答助手，维护较旧。 |
| [ChemCrow](https://github.com/ur-whitelab/chemcrow-public) | 2024-12 | 经典化学工具 agent，维护较旧。 |
| [ChemMCP](https://github.com/OSU-NLP-Group/ChemMCP) | 2025-06 | 化学 MCP 工具包，接近但未落在半年窗口内。 |
| [OpenScholar](https://github.com/akariasai/OpenScholar) | 2025-08 | 文献综合方向很重要，但仓库维护不满足本次窗口。 |
| Google AI Co-Scientist official code | 未见完整开源 | Nature 论文重要，但官方完整 repo 未确认。 |
| AlphaEvolve official code | 2025-05 技术报告 / PNAS 2026 | Google DeepMind 的进化式算法发现 agent，官方未开源；开源复刻 OpenEvolve 已进主表。 |

这些项目适合作为历史脉络或方法参考，但本仓库主表优先收录半年内仍活跃维护的项目。

## 值得一读的批评

- *The more you automate, the less you see: Hidden pitfalls of autonomous AI scientists*（PNAS 2026，DOI 10.1073/pnas.2610214123）系统分析开源 AI scientist 的四类问题：不合适的基准选择、数据泄漏、指标误用、事后挑选。结论是这些缺陷在最终论文层面几乎不可见，建议把数据隔离、评测脚本版本和选择偏差检查作为使用任何自动科研系统前的必查项。
- *Autonomous Research Agents: A Survey of AI Scientists and the Verification Gap*（arXiv 2608.05179）从「验证缺口」角度梳理了当前系统在可验证性上的共性问题。
