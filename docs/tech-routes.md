# 技术路线归类

> 与应用领域正交的另一套视角：按「系统怎么组织科研过程」把项目分成 8 条技术路线。

主表按领域分组（生物 / 算法 / 论文链 / 基准），本页按**技术路线**分组。每个项目取一条主路线，
跨路线的角色记在同名项目的括号说明里。分类依据是仓库 README、论文摘要与代码结构，不依据 star 数。

## 路线总览

| 路线 | 一句话 | 项目数 | A/B/C | 代表项目 |
|---|---|---:|---:|---|
| [编码 agent 编排（Harness orchestration）](#orchestration) | 把通用编码 agent 当执行引擎，外层只做流程、状态与评测脚手架。 | 9 | 2/6/1 | The AI Scientist、ERA、InternAgent |
| [显式研究状态（Explicit research state）](#state) | 把假设、证据、证明依赖外化成可操作对象，用状态而不是对话历史驱动研究。 | 4 | 1/3/0 | Arbor、StatefulDiscovery、MatOS |
| [进化与程序搜索（Evolutionary search）](#evolution) | LLM 作变异算子，靠执行反馈做选择，在程序/公式/算法空间里搜索。 | 13 | 3/7/3 | SR-Scientist、LLEMA、ShinkaEvolve |
| [工具与动作空间（Tools & action space）](#tools) | 先解决「能做什么」：把数据库、软件、协议抽象成 agent 可调用的工具与 MCP。 | 9 | 3/4/2 | Biomni、ToolUniverse、ChemGraph |
| [多智能体角色分工（Role decomposition）](#roles) | 把科研拆成固定角色（规划者/执行者/批判者/写作者），靠角色协作拼出闭环。 | 18 | 7/6/5 | Google AI Co-Scientist、Kaimen Co-Scientist、Robin |
| [干湿实验闭环（Physical loop）](#physical) | agent 不只操作代码，还驱动真实实验或机器人，闭环落在物理世界。 | 1 | 0/1/0 | PRAXIS |
| [科研知识产物（Knowledge artifact）](#artifact) | 把论文、图表、引用、文献地图当作一等对象来生产或改造。 | 7 | 1/5/1 | PaperOrchestra、PaperBanana、GPT Researcher |
| [评测与审计（Verification layer）](#verification) | 不产生科研，而是判定科研：基准、审计、诚信检测。 | 9 | 1/7/1 | AstaBench、AIRS-Bench、PostTrainBench |

合计 70 条项目，覆盖 8 条路线，无重复归类。

## 路线之间的关系

```
  工具与动作空间（能做什么）
        │
        ├──► 编码 agent 编排（怎么组织流程）──► 科研知识产物（怎么表达结果）
        │            │
        │            └──► 评测与审计（怎么判定可信）
        │
        ├──► 显式研究状态（把过程外化）
        │
        └──► 进化与程序搜索（在空间里搜索）
                     │
                     └──► 干湿实验闭环（把闭环落到物理世界）
```

其中**工具层是底座**，决定其他路线的能力上限；**评测与审计是瓶颈**，决定其他路线的结论可不可信。

<a id="orchestration"></a>

## 编码 agent 编排（Harness orchestration）

**把通用编码 agent 当执行引擎，外层只做流程、状态与评测脚手架。**

### 核心机制

- 研究过程被写成「规划 → 派发 → 执行 → 评判」的外层循环，执行器直接复用 Claude Code / Codex 这类通用编码 agent。
- 系统自己的核心资产是**流程与约束**（任务分解、并行实验、重试、护栏），而不是模型或工具库。
- 判断标准：拆掉外层脚手架，底层 agent 就退化成普通写码工具。

### 代表项目

| 项目 | 等级 | 最近维护 | 归类依据 |
|---|---:|---:|---|
| [The AI Scientist](https://github.com/SakanaAI/AI-Scientist) | A | 2025-12-19 | 最早把「想法→实验→论文→评审」写成固定流水线 |
| [ERA](https://github.com/google-research/era) | A | 2026-10-13 | 面向实证研究的写码 agent，把科研软件生产流程化 |
| [InternAgent](https://github.com/InternScience/InternAgent) | B | 2026-07-29 | 统一框架承载长程多任务科研流程 |
| [RD-Agent](https://github.com/microsoft/RD-Agent) | B | 2026-09-23 | R&D 流程自动化（数据/模型研发） |
| [AutoResearchClaw](https://github.com/aiming-lab/AutoResearchClaw) | C | 2026-08-19 | idea→paper 流水线，带 HITL 与自带评测 |
| [The Agentic Scientist (AI-Scientist-v3)](https://github.com/SakanaAI/AI-Scientist-v3) | B | 2026-11-17 | 编排编码 agent + 并行实验树搜索，取代固定模板 |
| [EurekAgent](https://github.com/THU-Team-Eureka/EurekAgent) | B | 2026-08-10 | 以 Claude Code 为执行核，强调「环境工程」而非提示词 |
| [ScholarLoop](https://github.com/r2m-ai/scholar-loop) | B | 2026-11-16 | 多 agent 闭环，用确定性代码护栏核对引用与数字 |
| [PRAXIST](https://github.com/sapientinc/PRAXIST) | B | 2026-09-23 | 并行研究 peer + 代际综合，把产物沉淀为 solution lineage（状态路线：solution lineage 是显式状态） |

### 能力边界

瓶颈在「谁来评判」：外层能编排实验，但选题价值、结果可信度仍依赖评测函数或人工。也最容易出现 rubric 下的 reward hacking。

<a id="state"></a>

## 显式研究状态（Explicit research state）

**把假设、证据、证明依赖外化成可操作对象，用状态而不是对话历史驱动研究。**

### 核心机制

- 研究过程被建模成数据结构：假设树、资产图、证明依赖图、证据状态机。
- 每一步都读写这个结构，剪枝、回溯、去重、审计都变成对结构的操作，而不是让模型自己记。
- 判断标准：系统的能力上限取决于状态表示的表达力，而不是上下文窗口。

### 代表项目

| 项目 | 等级 | 最近维护 | 归类依据 |
|---|---:|---:|---|
| [Arbor](https://github.com/RUC-NLPIR/Arbor) | B | 2026-11-03 | 假设树精炼：子假设→实验→按证据剪枝（编排路线：外层 agent 循环与假设树耦合） |
| [StatefulDiscovery](https://github.com/SUSTech-GenAI/StatefulDiscovery) | A | 2026-10-20 | 显式调查状态驱动前沿选择、证据获取与主张裁定 |
| [MatOS](https://github.com/DingyangLyu/MatOS) | B | 2026-10-25 | 科研资产图（数据/知识/工具/技能）+ 有状态工作流 |
| [VALG](https://github.com/DechenZhang/VALG-ML-Theory-Agent) | B | 2026-08-15 | 图结构化证明状态，按依赖顺序构造并评审局部证明 |

### 能力边界

状态设计是手工活：粒度太粗会丢证据、太细会爆炸；跨任务复用状态结构目前没有通用方案。

<a id="evolution"></a>

## 进化与程序搜索（Evolutionary search）

**LLM 作变异算子，靠执行反馈做选择，在程序/公式/算法空间里搜索。**

### 核心机制

- 循环是「采样候选 → 执行评测 → 保留/淘汰 → 再变异」，LLM 负责生成有意义的改动。
- 关键组件是评测器与选择策略：目标函数定义得好不好，直接决定能不能发现新东西。
- 判断标准：有没有可复现的「超过已知最优」的结果，而不是流程看起来自动。

### 代表项目

| 项目 | 等级 | 最近维护 | 归类依据 |
|---|---:|---:|---|
| [SR-Scientist](https://github.com/GAIR-NLP/SR-Scientist) | A | 2026-01-27 | 方程发现：生成-求解-评估的搜索循环 |
| [LLEMA](https://github.com/scientific-discovery/LLEMA) | A | 2026-05-10 | 进化搜索 + LLM 变异，做多目标材料发现 |
| [ShinkaEvolve](https://github.com/SakanaAI/ShinkaEvolve) | A | 2026-11-18 | LLM 作变异算子 + 种群进化，强调样本效率 |
| [OpenEvolve](https://github.com/algorithmicsuperintelligence/openevolve) | B | 2026-11-18 | AlphaEvolve 的开源复刻，进化式代码优化 |
| [SkyDiscover](https://github.com/skydiscover-ai/skydiscover) | B | 2026-09-14 | 统一对比 OpenEvolve / ShinkaEvolve / GEPA 等后端 |
| [MLEvolve](https://github.com/InternScience/MLEvolve) | B | 2026-11-16 | MLE-bench 上的 agentic 搜索与迭代 |
| [A-Evolve](https://github.com/A-EVO-Lab/a-evolve) | C | 2026-11-06 | agent 自我进化的通用基础设施 |
| [SwarmResearch](https://github.com/SwarmResearch/SwarmResearch) | B | 2026-07-07 | 多 git worktree 编码 agent 种群 + 多分支父代选择（编排路线：本质是调度编码 agent 的 harness） |
| [LLM4AD_Next](https://github.com/Optima-CityU/LLM4AD_Next) | B | 2026-11-18 | 自然语言描述问题 → 生成可运行的进化算法工程 |
| [HACO](https://github.com/kiyoung98/HACO) | B | 2026-06-24 | 跨领域搜索建模范式，稀疏人工引导下发现晶体算法 |
| [SRHarness](https://github.com/tsinghua-fib-lab/SRHarness) | B | 2026-10-17 | 符号回归的搜索运行时：候选/复杂度/Pareto 持久化 |
| [CVEvolve](https://github.com/AdvancedPhotonSource/CVEvolve) | C | 2026-07-20 | agent 自建评测 harness，迭代改进科学数据处理算法 |
| [karpathy/autoresearch](https://github.com/karpathy/autoresearch) | C | 2026-03-26 | 最小可用闭环：训练实验 → 反馈 → 下一轮改动 |

### 能力边界

强依赖可自动评测的任务；开放式科研里目标函数本身就要人来定，这是这类系统最难跨过的边界。

<a id="tools"></a>

## 工具与动作空间（Tools & action space）

**先解决「能做什么」：把数据库、软件、协议抽象成 agent 可调用的工具与 MCP。**

### 核心机制

- 核心工作量在动作空间建设：从文献/协议里挖掘工具，包装成统一接口（MCP / skill / CLI）。
- agent 的能力边界约等于工具库覆盖度，因此这类系统往往同时是领域基础设施。
- 判断标准：换一个更强的模型，能力是否立刻提升？提升越大说明瓶颈在模型；反之说明价值在工具层。

### 代表项目

| 项目 | 等级 | 最近维护 | 归类依据 |
|---|---:|---:|---|
| [Biomni](https://github.com/snap-stanford/Biomni) | A | 2026-11-16 | 从数千文献挖掘 25 域工具/数据库/协议，构建统一动作空间（角色路线：底层是多 agent 协作） |
| [ToolUniverse](https://github.com/mims-harvard/ToolUniverse) | B | 2026-11-16 | 面向 AI scientist 的科学工具与 MCP 平台 |
| [ChemGraph](https://github.com/argonne-lcf/ChemGraph) | A | 2026-11-17 | ASE/RDKit/MLIP 工作流封装为 agent 工具，支持 HPC |
| [Chorus](https://github.com/pinellolab/chorus) | B | 2026-11-16 | 9 个基因组「序列→功能」模型统一为 MCP 工具 |
| [MARS](https://github.com/SkynetRTN/MARS) | C | 2026-11-16 | 天文数据库与测光管线封装为 MCP 工具 |
| [OmicsClaw](https://github.com/TianGzlab/OmicsClaw) | C | 2026-10-07 | 88 个组学 skill + 本机 Python/R 工具链 |
| [Lacuna](https://github.com/tiptreesystems/lacuna-research-mcp) | B | 2026-11-15 | ML 研究地图，提供 web / markdown / MCP 三种接口（产物路线：研究地图是知识产物） |
| [ScienceDiscovery (openJiuwen)](https://github.com/openJiuwen-ai/sciencediscovery) | B | 2026-11-18 | 一站式科研 workbench，工具走 MCP、产物内容寻址（编排路线：workbench 同时承担流程编排） |
| [PaperQA2](https://github.com/Future-House/paper-qa) | A | 2026-10-26 | 文献检索与引用支撑的工具层（产物路线：文献层的证据生产） |

### 能力边界

工具层本身不产生科学结论；覆盖广度容易堆，但工具质量、参数正确性和跨工具组合仍是主要失败点。

<a id="roles"></a>

## 多智能体角色分工（Role decomposition）

**把科研拆成固定角色（规划者/执行者/批判者/写作者），靠角色协作拼出闭环。**

### 核心机制

- 流程被拆给多个 agent 角色，角色之间通过消息或共享工作区协作。
- 优势是工程简单、可解释：每步都能定位到某个角色；也是当前数量最多的一类系统。
- 判断标准：角色划分是否带来真实的纠错增益，还是只是把单 agent 的一次调用拆成四次。

### 代表项目

| 项目 | 等级 | 最近维护 | 归类依据 |
|---|---:|---:|---|
| [Google AI Co-Scientist](https://www.nature.com/articles/s41586-026-10644-y) | A | official full code not confirmed | 生成/批判/演化/排序多角色协作产出假设 |
| [Kaimen Co-Scientist](https://github.com/Kaimen-Inc/Co-Scientist) | C | 2026-08-03 | Google Co-Scientist 的开源复刻 |
| [Robin](https://github.com/Future-House/robin) | A | 2026-04-21 | 多 agent 端到端生物发现 |
| [CellVoyager](https://github.com/zou-group/CellVoyager) | A | 2026-06-02 | 计算生物学分析 agent，带代码执行与迭代（工具路线：依赖可执行的生信工具链） |
| [Virtual Lab](https://github.com/zou-group/virtual-lab) | A | 2025-12-31 | AI 科学家会议式协作，含湿实验验证（物理路线：含湿实验验证环节） |
| [AutoScientists](https://github.com/mims-harvard/AutoScientists) | B | 2026-05-28 | 自组织 agent 团队做长时计算实验 |
| [Medea](https://github.com/mims-harvard/Medea) | B | 2026-07-17 | 多组学治疗推理 agent |
| [Denario](https://github.com/Denario-AI/Denario) | A | 2026-10-02 | 天文科研多模块 agent（想法/文献/代码/写作） |
| [BioAgents](https://github.com/bio-xyz/BioAgents) | C | 2026-06-15 | 生物文献与数据分析 agent 框架 |
| [cmbagent](https://github.com/CMBAgents/cmbagent) | B | 2026-11-16 | 多 agent 编排宇宙学分析任务 |
| [SpatialAgent](https://github.com/Genentech/SpatialAgent) | B | 2026-09-22 | 空间转录组与单细胞分析 agent |
| [MIND](https://github.com/IMMS-Ewha/MIND) | C | 2026-03-16 | 材料研究 co-scientist，输出 MLIP-ready 规格 |
| [STAgent](https://github.com/LiuLab-Bioelectronics-Harvard/STAgent) | C | 2026-10-11 | 空间转录组交互式分析与报告 |
| [SpikeAgent](https://github.com/SpikeAgent/SpikeAgent) | C | 2026-10-04 | 神经电生理 spike sorting 与分析 |
| [OmniScientist](https://github.com/Omni-Scientist/OmniScientist) | B | 2026-09-26 | 构思/实验/写作三 agent，直接消费多模态原始证据（跨模态：直接消费图像/信号/音频/视频/3D 证据） |
| [OpenScientist](https://github.com/openscientist-io/openscientist) | A | 2026-11-17 | Agent Skills + MCP 的开源 co-scientist |
| [STAT](https://github.com/YangLabHKUST/STAT-agent) | B | 2026-10-16 | 空间组学多 agent 分析 |
| [NS-Copilot](https://github.com/FrankLiu1102/ns-copilot) | A | 2026-09-16 | Planner/Coder/Controller/Interpreter 四角色 |

### 能力边界

角色增加不等于能力增加；没有可靠的外部评测时，多 agent 容易变成互相附和（sycophancy），错误会被放大而不是纠正。

<a id="physical"></a>

## 干湿实验闭环（Physical loop）

**agent 不只操作代码，还驱动真实实验或机器人，闭环落在物理世界。**

### 核心机制

- 循环包含真实实验：设计 → 下单/执行 → 测量 → 反馈 → 下一轮设计。
- 难点从「模型会不会写」变成「实验能不能跑、结果能不能回来、失败怎么归因」。
- 判断标准：有没有真实湿实验证据，而不是只有 in-silico 宣称。

### 代表项目

| 项目 | 等级 | 最近维护 | 归类依据 |
|---|---:|---:|---|
| [PRAXIS](https://github.com/RomeroLab/PRAXIS) | B | 2026-08-17 | 蛋白语言模型设计序列 + 机器人实验室执行，真实干湿闭环 |

### 能力边界

成本与周期是硬约束；可复用性低（每个实验室不同），因此这类系统目前最少，但一旦跑通，可信度最高。

<a id="artifact"></a>

## 科研知识产物（Knowledge artifact）

**把论文、图表、引用、文献地图当作一等对象来生产或改造。**

### 核心机制

- 目标不是新发现，而是让已有研究更可生产、可消费：写作、插图、综述、引用核查、论文→agent。
- 这类系统工程化程度最高，也最容易评估（产物可直接检查）。
- 判断标准：产物是否可验证、可编辑、可追溯；只追求「像论文」的系统价值有限。

### 代表项目

| 项目 | 等级 | 最近维护 | 归类依据 |
|---|---:|---:|---|
| [PaperOrchestra](https://github.com/Ar9av/PaperOrchestra) | B | 2026-11-04 | 多 agent 论文写作流水线 |
| [PaperBanana](https://github.com/dwzhu-pku/PaperBanana) | B | 2026-11-12 | 参考驱动的学术插图生成 |
| [GPT Researcher](https://github.com/assafelovic/gpt-researcher) | B | 2026-11-09 | 通用 deep research 报告生成 |
| [Local Deep Research](https://github.com/LearningCircuit/local-deep-research) | C | 2026-11-18 | 本地化 deep research 报告 |
| [Paper2Agent](https://github.com/jmiao24/Paper2Agent) | A | 2026-09-17 | 论文→可交互 agent，暴露代码/数据/工作流 |
| [Spark-to-Paper](https://github.com/Spark-To-Paper-Skills/spark-to-paper-skills) | B | 2026-08-18 | 可组合技能链：一句话想法→可编译论文 |
| [DrawAI](https://github.com/Renaissance-Mind/DrawAI) | B | 2026-10-12 | 栅格图→可编辑 SVG/PPTX，配可编辑性基准 |

### 能力边界

解决的是传播与组织，不产生新科学；引用与事实核查仍需人工兜底。

<a id="verification"></a>

## 评测与审计（Verification layer）

**不产生科研，而是判定科研：基准、审计、诚信检测。**

### 核心机制

- 把「agent 是否真的具备科研能力」变成可测量问题：任务集、评分器、隔离环境、审计规则。
- 关键设计是防泄漏与防挑选：数据隔离、评测脚本版本、事后挑选检测。
- 判断标准：能不能区分「看起来可信」和「真的可信」。

### 代表项目

| 项目 | 等级 | 最近维护 | 归类依据 |
|---|---:|---:|---|
| [AstaBench](https://github.com/allenai/asta-bench) | A | 2026-11-10 | 自动科研 agent 综合评测 |
| [AIRS-Bench](https://github.com/facebookresearch/airs-bench) | B | 2026-05-05 | 前沿 AI research 任务套件 |
| [PostTrainBench](https://github.com/aisa-group/PostTrainBench) | B | 2026-11-12 | 评估 CLI agent 能否自动做 LLM post-training |
| [NatureBench](https://github.com/FrontisAI/NatureBench) | B | 2026-11-15 | 能否达到 Nature 系论文已发表 SOTA |
| [Into the Unknown](https://github.com/prometheus-eval/into-the-unknown) | B | 2026-10-20 | 开放科研题：写满足专家条件的跟进论文 |
| [AISLE](https://github.com/MasterAI-EAM/ai-scientists-last-exam) | B | 2026-11-18 | 干湿实验闭环基准，湿实验与实时 leaderboard（物理路线：唯一接真实湿实验的基准） |
| [BAISBench](https://github.com/EperLuo/BaisBench) | B | 2026-03-18 | 真实单细胞转录组数据驱动的发现评测 |
| [RIDAR](https://github.com/THU-KEG/RIDAR) | C | 2026-10-25 | 数据泄漏/指标误用/事后挑选检测与运行时干预 |
| [RefWarden](https://github.com/Agents4Academia-AI/citation_verification) | B | 2026-10-20 | 引用断言核查：文献是否存在、是否支撑论断（产物路线：写作链里的引用核查环节） |

### 能力边界

基准本身会被过拟合；开放式科研的评分仍依赖专家，规模化困难。

## 2026 年的路线级判断

1. **从「固定流水线」转向「编排 + 状态」**：早期系统（The AI Scientist、AutoResearchClaw）把步骤写死，
   2026 年新增的 end-to-end 系统（AI-Scientist-v3、Arbor、PRAXIST）都在解决同一件事——
   如何让通用编码 agent 在长程任务里不跑偏。显式状态（假设树、solution lineage）是目前最有效的答案。
2. **进化搜索是唯一有硬发现的路线**：AlphaEvolve、ShinkaEvolve、SR-Scientist 在数学/算法/方程上有可核验的「超过已知最优」，
   但前提是存在自动评测函数。开放式科研（选题本身没有目标函数）目前还没有同类证据。
3. **工具层决定领域 agent 的天花板**：Biomni、ToolUniverse、ChemGraph、Chorus 的差异不在模型，而在动作空间覆盖度。
   选型时先看工具库质量，再看 agent 框架。
4. **评测与审计成了独立赛道**：NatureBench、AISLE、RIDAR 说明社区开始把「怎么判定可信」当成一等问题；
   同时 PNAS 2026 的批评指出，多数系统在基准选择、数据泄漏、指标误用和事后挑选上失守。
5. **干湿闭环仍然稀缺**：70 个项目里只有 PRAXIS 真正驱动机器人实验，AISLE 是唯一接湿实验的基准。
   这条路线成本最高、样本最少，但一旦跑通，可信度远超纯 in-silico 系统。

## 数据说明

- 分类是**单主路线**：每个项目取最能解释其能力来源的那条；跨路线角色记在括号里。
- 等级与维护日期来自 [data/projects.json](../data/projects.json)，与主表一致。
- 路线划分是编辑判断，不是论文里的既有分类；如果你看到项目被放错，直接改本页表格即可。
