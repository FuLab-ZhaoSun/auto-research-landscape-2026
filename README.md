# Auto Research Landscape 2026

> 自动写论文、自动做科研、AI scientist 与 scientific discovery agent 调研。

本仓库整理截至 **2026-11-18** 的自动科研与自动论文生产项目（上一版截至 2026-06-02），重点筛选：

- 本轮滚动窗口 **2026-05-18 到 2026-11-18** 内仍有维护或发布动态的 GitHub 仓库。
- 窗口内顶刊、顶会或高影响技术报告中的自动科研系统。
- 能真正参与科研闭环的系统，包括假设生成、实验执行、数据分析、代码优化、论文写作和评测基准。
- 本轮增量窗口为 **2026-06-02 到 2026-11-18**；上一版已收录、但最近提交早于本轮窗口的里程碑项目保留在主表中，以 `*` 标注。

本仓库不是简单的 awesome list。每个项目会标注它更接近哪一类能力：

- **科研发现**：能提出假设、设计或执行实验、分析数据、迭代结论。
- **科研代码/算法发现**：能写科研代码、优化模型、发现算法或方程。
- **领域科研 agent**：面向生物、医学、材料、天文等具体科研数据。
- **论文生产链**：文献综述、引用核查、LaTeX 写作、图表生成。
- **评测基准**：衡量 AI agent 是否真的具备科研能力。

## 快速结论

如果只精读 10 个方向，我建议按这个顺序（2026-11 版）：

1. [Google AI Co-Scientist](https://www.nature.com/articles/s41586-026-10644-y)：假设生成与排序，目前最重要的系统级证据。
2. [Biomni](https://github.com/snap-stanford/Biomni)：Science 2026 系统论文，通用生物医学 agent。
3. [Robin](https://github.com/Future-House/robin)：Nature 2026，端到端生物发现。
4. [Arbor](https://github.com/RUC-NLPIR/Arbor)：用假设树做长程自主研究的代表。
5. [The Agentic Scientist (AI-Scientist-v3)](https://github.com/SakanaAI/AI-Scientist-v3)：编排编码 agent 做端到端科研。
6. [PRAXIST](https://github.com/sapientinc/PRAXIST)：面向可度量、可执行研究的自主系统。
7. [OpenScientist](https://github.com/openscientist-io/openscientist)：Nature Medicine 2026，开源 co-scientist。
8. [Paper2Agent](https://github.com/jmiao24/Paper2Agent)：Nature 2026，把论文变成可交互 agent。
9. [Spark-to-Paper](https://github.com/Spark-To-Paper-Skills/spark-to-paper-skills)：想法到论文的技能链。
10. [NatureBench](https://github.com/FrontisAI/NatureBench)：看 agent 能否达到 Nature 系论文已发表 SOTA。

完整数据见 [data/projects.json](data/projects.json)（70 条），按分类整理的主表见 [docs/maintained-projects.md](docs/maintained-projects.md)。

## 仓库内容

- [调研方法](docs/methodology.md)
- [顶刊与顶会系统](docs/top-papers-and-systems.md)
- [维护项目主表（滚动窗口 2026-05-18 至 2026-11-18）](docs/maintained-projects.md)
- [自动论文生产链](docs/writing-pipeline.md)
- [评测基准](docs/benchmarks.md)
- [排除与背景项目](docs/excluded-background.md)
- [机器可读项目数据](data/projects.json)

## 发布到 GitHub

仓库提供两套等价脚本：Windows 用 PowerShell 版，macOS / Linux 用 bash 版。

### 前置条件

- `git`；bash 版还需要 `curl` 和 `python3`（解析 GitHub API 响应）。
- 一个能创建仓库并推送代码的 GitHub 凭证：设置 `GITHUB_TOKEN` 或 `GH_TOKEN`；
  bash 版在两者都缺失时会自动回退到 `gh auth token`，因此也可以先执行 `gh auth login`。

### macOS / Linux（bash）

```bash
export GITHUB_TOKEN="<token with repo permission>"   # 或者先 gh auth login
./scripts/publish.sh                                  # 发布到当前账号
./scripts/publish.sh --owner <github-owner> --repo-name <repo-name>
./scripts/fork-projects.sh --owner <github-owner>
./scripts/publish-and-fork.sh --owner <github-owner> --repo-name auto-research-landscape-2026
```

每个脚本都支持 `--help` 查看全部参数（`publish.sh --branch` 可指定推送分支，默认 `main`）。

### Windows（PowerShell）

```powershell
$env:GITHUB_TOKEN = "<token with repo permission>"
.\scripts\publish.ps1
.\scripts\publish.ps1 -Owner "<github-owner>" -RepoName "<repo-name>"
.\scripts\fork-projects.ps1 -Owner "<github-owner>"
.\scripts\publish-and-fork.ps1 -Owner "<github-owner>" -RepoName "auto-research-landscape-2026"
```

### 脚本对照

| 作用 | PowerShell | bash（macOS / Linux） |
| --- | --- | --- |
| 创建仓库并推送 | `publish.ps1` | `publish.sh` |
| fork 调研项目 | `fork-projects.ps1` | `fork-projects.sh` |
| 一键发布 + fork | `publish-and-fork.ps1` | `publish-and-fork.sh` |

两套脚本字段和结果一致，可以互相覆盖：bash 版把 `data/fork-results.json` 写成**无 BOM 的 UTF-8**（2 空格缩进），PowerShell 版带 BOM；上游列表在 bash 版按 ASCII 排序去重。

GitHub fork 会创建成账号或组织下的独立仓库，不能嵌套在这个调研仓库内部。已识别的可 fork 仓库清单见 [data/forkable-repos.txt](data/forkable-repos.txt)。脚本只记录"是否成功发起 fork"，实际的 fork 状态可用 GitHub API 核对（`GET /repos/{owner}/{repo}` 的 `fork` 字段，或 `gh repo view`）。

## 当前判断（2026-11 更新）

自动写论文已经比较工程化，最实用的组合是 **PaperQA2 + PaperOrchestra（或 Spark-to-Paper）+ PaperBanana / DrawAI**，并用 **RefWarden** 核查引用。但它解决的是阅读、组织、引用和排版，不保证产生真实新科学。

自动做科研真正有进展的方向，集中在有明确工具和评估函数的场景：

- 生物医学和组学数据分析：Biomni、Robin、CellVoyager、OpenScientist、Medea、SpatialAgent、ChemGraph。
- 科研代码和实证研究：ERA、RD-Agent、InternAgent、AutoScientists、PRAXIST。
- 算法、方程和材料发现：SR-Scientist、SRHarness、LLEMA、ShinkaEvolve、OpenEvolve、SkyDiscover、MatOS。
- 长程自主研究：Arbor、OmniScientist、The Agentic Scientist、ScholarLoop。
- 评测与监督：AstaBench、NatureBench、AISLE、AIRS-Bench、PostTrainBench、RIDAR。

本轮窗口（2026-06 至 2026-11）有三个明显变化：

1. **端到端系统从「固定流水线」转向「编排通用编码 agent」**：Arbor 的假设树、Sakana AI-Scientist-v3 的并行实验树、SwarmResearch 的编码 agent 种群，都把「怎么组织研究过程」而不是「怎么提示模型」当成核心。
2. **开源 co-scientist 进入顶刊**：OpenScientist（Nature Medicine）、Biomni（Science）、Paper2Agent（Nature）说明该方向开始有可复现的系统级证据。
3. **评测转向真实数据与真实实验**：NatureBench、BAISBench 用真实数据，AISLE 直接接湿实验；同时 PNAS 2026 的系统性批评指出基准选择、数据泄漏、指标误用与事后挑选四类问题，值得当成使用前的检查清单。

## 注意事项

- 本调研强调维护活跃度，但活跃不等于可靠。
- 很多项目会执行 LLM 生成的代码，必须使用 Docker、沙箱、网络限制和预算限制。
- 论文写作工具需要人工核查引用、实验结果、统计检验和 novelty；RefWarden 这类工具只能辅助，不能替代人工判断。
- 部分顶刊系统并未完整开源（如 AlphaEvolve），相关非官方复刻需要单独验证。
- 2026 年已有系统性研究指出开源 AI scientist 存在数据泄漏、指标误用和事后挑选等隐患（见 [排除与背景项目](docs/excluded-background.md)），横向比较前应先确认数据隔离与评测脚本版本。
- 仓库归档时间较新的项目（如 BioAgents）保留在主表但已标注归档状态，选型时优先考虑仍在维护的替代品。

## 更新记录

- **2026-11-18**：滚动窗口推进到 2026-05-18 至 2026-11-18。
  - `data/projects.json` 从 27 条扩到 **70 条**：补录 10 条此前只在文档中出现的项目，新增 33 条窗口内项目。
  - 主表 5 个分区同步更新，窗口外里程碑项目以 `*` 标注；`data/forkable-repos.txt` 扩到 69 个仓库。
  - 新增 Nature / Science / Nature Medicine 级系统 3 个（Biomni、Paper2Agent、OpenScientist），新 benchmark 4 个（NatureBench、Into the Unknown、AISLE、BAISBench）。
  - **核验方式**：每个仓库用 GitHub API 校验存在性、归档状态与默认分支最后提交日期；论文链接逐个验证可达；所有新增条目均可在 `data/projects.json` 中回溯。
- **2026-06-02**：首版调研（27 条）。

## License

调研文本采用 CC BY 4.0。仓库中的第三方项目、论文和截图等仍归其原作者所有。
