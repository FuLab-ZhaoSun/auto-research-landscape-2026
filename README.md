# Auto Research Landscape 2026

> 自动写论文、自动做科研、AI scientist 与 scientific discovery agent 调研。

本仓库整理截至 **2026-06-02** 的自动科研与自动论文生产项目，重点筛选：

- 半年内仍有维护或发布动态的 GitHub 仓库，窗口为 **2025-12-02 到 2026-06-02**。
- 半年内顶刊、顶会或高影响技术报告中的自动科研系统。
- 能真正参与科研闭环的系统，包括假设生成、实验执行、数据分析、代码优化、论文写作和评测基准。

本仓库不是简单的 awesome list。每个项目会标注它更接近哪一类能力：

- **科研发现**：能提出假设、设计或执行实验、分析数据、迭代结论。
- **科研代码/算法发现**：能写科研代码、优化模型、发现算法或方程。
- **领域科研 agent**：面向生物、医学、材料、天文等具体科研数据。
- **论文生产链**：文献综述、引用核查、LaTeX 写作、图表生成。
- **评测基准**：衡量 AI agent 是否真的具备科研能力。

## 快速结论

如果只精读 10 个方向，我建议按这个顺序：

1. [Google AI Co-Scientist](https://www.nature.com/articles/s41586-026-10644-y)
2. [Robin](https://github.com/Future-House/robin)
3. [ERA](https://github.com/google-research/era)
4. [The AI Scientist](https://github.com/SakanaAI/AI-Scientist)
5. [CellVoyager](https://github.com/zou-group/CellVoyager)
6. [SR-Scientist](https://github.com/GAIR-NLP/SR-Scientist)
7. [LLEMA](https://github.com/scientific-discovery/LLEMA)
8. [ShinkaEvolve](https://github.com/SakanaAI/ShinkaEvolve)
9. [AstaBench](https://github.com/allenai/asta-bench)
10. [PaperOrchestra](https://github.com/Ar9av/PaperOrchestra)

## 仓库内容

- [调研方法](docs/methodology.md)
- [顶刊与顶会系统](docs/top-papers-and-systems.md)
- [半年内维护项目主表](docs/maintained-projects.md)
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

## 当前判断

自动写论文已经比较工程化，最实用的组合是 **PaperQA2 + PaperOrchestra + PaperBanana**。但它解决的是阅读、组织、引用和排版，不保证产生真实新科学。

自动做科研真正有进展的方向，集中在有明确工具和评估函数的场景：

- 生物医学和组学数据分析：Robin、CellVoyager、Biomni、Medea、SpatialAgent。
- 科研代码和实证研究：ERA、RD-Agent、InternAgent、AutoScientists。
- 算法、方程和材料发现：SR-Scientist、LLEMA、ShinkaEvolve、OpenEvolve、SkyDiscover。
- 评测与监督：AstaBench、AIRS-Bench、PostTrainBench。

## 注意事项

- 本调研强调维护活跃度，但活跃不等于可靠。
- 很多项目会执行 LLM 生成的代码，必须使用 Docker、沙箱、网络限制和预算限制。
- 论文写作工具需要人工核查引用、实验结果、统计检验和 novelty。
- 部分顶刊系统并未完整开源，相关非官方复刻需要单独验证。

## License

调研文本采用 CC BY 4.0。仓库中的第三方项目、论文和截图等仍归其原作者所有。
