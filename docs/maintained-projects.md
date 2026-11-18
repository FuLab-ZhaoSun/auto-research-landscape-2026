# 维护项目主表

本轮滚动窗口为 **2026-05-18 到 2026-11-18**（上一版为 2025-12-02 到 2026-06-02）。
「最近维护」取该仓库默认分支最后一次提交的日期，均以调研当日 GitHub API 返回值为准；
带 `*` 的项目最近提交早于本轮窗口起点，因属里程碑或代表性工作而保留，日期照实标注。

## 端到端自动科研与科研代码

| 项目 | 最近维护 | 证据等级 | 定位 |
|---|---:|---:|---|
| [InternAgent](https://github.com/InternScience/InternAgent) | 2026-07-29 | B | 长程自动科学发现，覆盖算法发现、论文复现、deep research、干湿实验任务；2026-07 发布 InternAgent-1.5。 |
| [AutoScientists](https://github.com/mims-harvard/AutoScientists) | 2026-05-28 | B | 去中心化 AI agent 团队，长时间计算实验与共享经验。 |
| [AutoResearchClaw](https://github.com/aiming-lab/AutoResearchClaw) | 2026-08-19 | C | idea 到 paper 的自主/协作科研流水线，含 HITL 和 ARC-Bench。 |
| [RD-Agent](https://github.com/microsoft/RD-Agent) | 2026-09-23 | B | 微软自动 R&D agent，偏数据科学、模型研发和金融因子开发。 |
| [Denario](https://github.com/AstroPilot-AI/Denario) | 2026-10-02 | A | 天文/宇宙学多智能体科研助手，覆盖想法、文献、代码、图表与论文草稿；PRX Intelligence 2026 系统论文。 |
| [cmbagent](https://github.com/CMBAgents/cmbagent) | 2026-11-16 | B | Denario 的研究分析后端之一。 |
| [MIND](https://github.com/IMMS-Ewha/MIND) | 2026-03-16* | C | 材料研究 co-scientist，把自然语言研究请求转成 MLIP-ready 实验规格。 |
| [Kaimen Co-Scientist](https://github.com/Kaimen-Inc/Co-Scientist) | 2026-08-03 | C | Google AI Co-Scientist 的非官方开源复刻。 |
| [Arbor](https://github.com/RUC-NLPIR/Arbor) | 2026-11-03 | B | 把自主研究建模为假设树精炼：提出子假设、执行实验、按证据剪枝，用持久假设树维持长程一致性。 |
| [The Agentic Scientist (AI-Scientist-v3)](https://github.com/SakanaAI/AI-Scientist-v3) | 2026-11-17 | B | Sakana AI 第三代 AI Scientist：用编码 agent 编排取代固定模板，做想法生成、并行实验树搜索与 LaTeX 写作。 |
| [OmniScientist](https://github.com/Omni-Scientist/OmniScientist) | 2026-09-26 | B | 全模态、全学科端到端 AI scientist：直接消费图像、信号、音频、视频、3D 结构等原始证据，覆盖构思、实验与写作。 |
| [PRAXIST](https://github.com/sapientinc/PRAXIST) | 2026-09-23 | B | 面向可度量、可计算机执行研究的自主系统：并行研究 peer、任务自有评测与持久证据，把实验产物沉淀为 solution lineage。 |
| [ScholarLoop](https://github.com/r2m-ai/scholar-loop) | 2026-11-16 | B | 开源多 agent 自主科研闭环：文献综述、方向图、想法锦标赛、对照实验、审稿与分段写作，用代码护栏核对引用与数字。 |
| [ScienceDiscovery (openJiuwen)](https://github.com/openJiuwen-ai/sciencediscovery) | 2026-11-18 | B | 华为 openJiuwen 社区的一站式 AI 科研工作台：文献阅读、假设、写代码、试错与调参收进同一本地环境，工具走 MCP、产物内容寻址溯源。 |
| [EurekAgent](https://github.com/THU-Team-Eureka/EurekAgent) | 2026-08-10 | B | 面向指标驱动任务的自主科研系统，基于编码 agent 构建环境与评测反馈闭环，强调环境工程而非提示词。 |
| [StatefulDiscovery](https://github.com/SUSTech-GenAI/StatefulDiscovery) | 2026-10-20 | A | 把调查状态外化为显式对象，驱动前沿选择、证据获取与主张裁定，缓解自主发现 agent 的过度解读；EMNLP 2026 Findings。 |

## 算法、代码、方程与材料发现

| 项目 | 最近维护 | 证据等级 | 定位 |
|---|---:|---:|---|
| [MLEvolve](https://github.com/InternScience/MLEvolve) | 2026-11-16 | B | Kaggle/MLE-bench 式自动 ML 工程系统，InternAgent 的优化核心。 |
| [OpenEvolve](https://github.com/algorithmicsuperintelligence/openevolve) | 2026-11-18 | B | 进化式代码优化和算法发现。 |
| [SkyDiscover](https://github.com/skydiscover-ai/skydiscover) | 2026-09-14 | B | 科学和算法发现框架，统一比较 OpenEvolve、ShinkaEvolve、GEPA 等。 |
| [A-Evolve](https://github.com/A-EVO-Lab/a-evolve) | 2026-11-06 | C | 让 agent 自我进化的通用基础设施。 |
| [karpathy/autoresearch](https://github.com/karpathy/autoresearch) | 2026-03-26* | C | 小型 LLM 训练实验的自动研究循环，适合理解最小自动科研系统。 |
| [LLM4AD_Next](https://github.com/Optima-CityU/LLM4AD_Next) | 2026-11-18 | B | LLM4AD 平台下一代：自然语言描述问题即可生成可运行的进化算法搜索工程，可作为算法改进器接入自动科研流水线。 |
| [MatOS](https://github.com/DingyangLyu/MatOS) | 2026-10-25 | B | 材料科研智能体操作系统：把数据、知识、工具、技能与工作流组织成带依赖的科学资产图，用有状态自适应工作流执行并随运行证据演化。 |
| [VALG](https://github.com/DechenZhang/VALG-ML-Theory-Agent) | 2026-08-15 | B | 面向 ML 理论研究的 agentic 系统：多级验证、自适应问题表述与图结构化证明开发，按依赖顺序构造并评审局部证明。 |
| [SwarmResearch](https://github.com/SwarmResearch/SwarmResearch) | 2026-07-07 | B | 用 Shepherd agent 调度一群各自在 git worktree 中并行改代码的编码 agent，以种群式搜索与多分支父代选择做开放式发现。 |
| [SRHarness](https://github.com/tsinghua-fib-lab/SRHarness) | 2026-10-17 | B | 面向 agentic 符号回归的运行时：统一分析、拟合、求值、执行与公式提交接口，持久化候选、复杂度与 Pareto 排序。 |
| [HACO](https://github.com/kiyoung98/HACO) | 2026-06-24 | B | 人机协同算法发现：跨领域搜索建模范式，在稀疏人工引导下自动搜索并改进训练代码，用于晶体结构预测算法发现。 |
| [CVEvolve](https://github.com/AdvancedPhotonSource/CVEvolve) | 2026-07-20 | C | 阿贡国家实验室先进光子源的自主算法发现系统：agent 自行配置开发环境与评测 harness，迭代改进科学数据处理算法。 |

## 生物、医学与组学 agent

| 项目 | 最近维护 | 证据等级 | 定位 |
|---|---:|---:|---|
| [Biomni](https://github.com/snap-stanford/Biomni) | 2026-11-16 | A | 通用生物医学 AI agent：自动发现 25 个领域的工具、数据库与协议；Science 2026 系统论文。 |
| [BioAgents](https://github.com/bio-xyz/BioAgents) | 2026-06-15 | C | 生物文献和数据分析 agent 框架；仓库已于 2026-06 归档，保留作参考。 |
| [Medea](https://github.com/mims-harvard/Medea) | 2026-07-17 | B | 多组学治疗靶点发现 agent。 |
| [ToolUniverse](https://github.com/mims-harvard/ToolUniverse) | 2026-11-16 | B | 面向 AI scientist 的科学工具和 MCP 平台。 |
| [SpatialAgent](https://github.com/Genentech/SpatialAgent) | 2026-09-22 | B | 空间转录组、单细胞和分子生物学 agent。 |
| [STAgent](https://github.com/LiuLab-Bioelectronics-Harvard/STAgent) | 2026-10-11 | C | 空间转录组交互式分析和报告生成。 |
| [SpikeAgent](https://github.com/SpikeAgent/SpikeAgent) | 2026-10-04 | C | 神经电生理 spike sorting 和分析 agent。 |
| [OpenScientist](https://github.com/openscientist-io/openscientist) | 2026-11-17 | A | 开源 agentic AI co-scientist：用 Agent Skills 与 MCP 工具做迭代假设-执行-检索，完成可验证的生物医学数据分析；Nature Medicine 2026-11-16。 |
| [ChemGraph](https://github.com/argonne-lcf/ChemGraph) | 2026-11-17 | A | 阿贡国家实验室的 agentic 计算化学与材料框架：自然语言接到 ASE/RDKit/MLIP 工作流并经 MCP 暴露，支持 HPC 高通量筛选。 |
| [PRAXIS](https://github.com/RomeroLab/PRAXIS) | 2026-08-17 | B | Duke Romero 实验室的自驱动蛋白工程平台：蛋白语言模型负责序列设计，机器人实验室完成基因组装、表达与表征，形成干湿实验闭环。 |
| [OmicsClaw](https://github.com/TianGzlab/OmicsClaw) | 2026-10-07 | C | 面向单细胞、空间与 bulk 转录组等组学数据的记忆型科研 agent，带领域 skill 集与 CLI/桌面端，对接到本机 Python/R 工具链。 |
| [STAT](https://github.com/YangLabHKUST/STAT-agent) | 2026-10-16 | B | 空间转录组专用 agent：自然语言提出需求后自动规划、选方法、检查数据、跑代码并纠错解释，配组织可视化与可复现分析流程。 |
| [Chorus](https://github.com/pinellolab/chorus) | 2026-11-16 | B | 把 Enformer、Borzoi、ChromBPNet、AlphaGenome 等基因组「序列→功能」模型统一成一个接口，以 MCP 工具提供变异效应预测与逐 track 校准。 |
| [NS-Copilot](https://github.com/FrankLiu1102/ns-copilot) | 2026-09-16 | A | 神经科学端到端多智能体分析系统：Planner/Coder/Controller/Interpreter 在沙箱中自动挑选神经模型、生成并迭代分析代码；EMNLP 2026 Findings。 |
| [MARS](https://github.com/SkynetRTN/MARS) | 2026-11-16 | C | UNC Skynet 机器人望远镜网络的 MCP 天文研究套件：把 SIMBAD、NED、VizieR、MAST、ADS 等查询与测光/变星/脉冲星管线封装成 agent 工具。 |

## 自动论文生产链

| 项目 | 最近维护 | 证据等级 | 定位 |
|---|---:|---:|---|
| [PaperOrchestra](https://github.com/Ar9av/PaperOrchestra) | 2026-11-04 | B | 多 agent 论文写作技能包，把研究材料转成 LaTeX 论文。 |
| [PaperBanana](https://github.com/dwzhu-pku/PaperBanana) | 2026-11-12 | B | 自动生成学术插图、方法图和论文图表。 |
| [PaperQA2](https://github.com/Future-House/paper-qa) | 2026-10-26 | A | 科学文献 RAG、问答和引用支撑。 |
| [GPT Researcher](https://github.com/assafelovic/gpt-researcher) | 2026-11-09 | B | 通用 deep research 报告生成，适合资料汇总。 |
| [Local Deep Research](https://github.com/LearningCircuit/local-deep-research) | 2026-11-18 | C | 本地化 deep research 报告。 |
| [Spark-to-Paper](https://github.com/Spark-To-Paper-Skills/spark-to-paper-skills) | 2026-08-18 | B | 把一句话研究想法端到端做成论文的可组合技能集：文献检索、实验设计执行、证据修订、原生矢量论文图与可编译 LaTeX。 |
| [Paper2Agent](https://github.com/jmiao24/Paper2Agent) | 2026-09-17 | A | 把研究论文自动转换为可交互 AI agent，把论文的代码、数据与工作流暴露为 agent-native 知识；Nature 2026-09-16。 |
| [DrawAI](https://github.com/Renaissance-Mind/DrawAI) | 2026-10-12 | B | 把生成图或截图栅格图重建为可编辑 SVG/PPTX 的 agentic 工作流，并配 DrawAI-Bench 同时评保真度与对象级可编辑性。 |
| [RefWarden](https://github.com/Agents4Academia-AI/citation_verification) | 2026-10-20 | B | 以 (claim, citation) 对为单位的引用核查 agent：校验文献真实存在与元数据正确，再判断被引论文是否真的支撑该论断。 |
| [Lacuna](https://github.com/tiptreesystems/lacuna-research-mcp) | 2026-11-15 | B | 用 LLM 把论文与学术元数据组织成 ML 研究地图，提供 web/markdown/MCP 三种接口与 deep research 报告 agent；ICML 2026。 |

## 评测基准

| 项目 | 最近维护 | 证据等级 | 定位 |
|---|---:|---:|---|
| [AstaBench](https://github.com/allenai/asta-bench) | 2026-11-10 | A | 自动科研 agent 综合评测。 |
| [AIRS-Bench](https://github.com/facebookresearch/airs-bench) | 2026-05-05* | B | 面向前沿 AI research science agents 的任务套件；本轮窗口外但保留。 |
| [PostTrainBench](https://github.com/aisa-group/PostTrainBench) | 2026-11-12 | B | 评估 CLI agent 是否能自动做 LLM post-training。 |
| [NatureBench](https://github.com/FrontisAI/NatureBench) | 2026-11-15 | B | 从 Nature 系论文蒸馏 90 个跨学科科学 ML 任务，考察编码 agent 能否达到原文已发表 SOTA，并维护公开 leaderboard。 |
| [Into the Unknown](https://github.com/prometheus-eval/into-the-unknown) | 2026-10-20 | B | 与 DOE 国家实验室科学家合作，把未发表的后续研究方向作为开放科研题，考察 agent 能否写出满足专家预设条件的跟进论文。 |
| [AISLE](https://github.com/MasterAI-EAM/ai-scientists-last-exam) | 2026-11-18 | B | AI Scientists' Last Exam：面向干湿实验闭环的公开基准，在 Docker 中运行 agent 并给实验记录打分，含实时 leaderboard。 |
| [BAISBench](https://github.com/EperLuo/BaisBench) | 2026-03-18* | B | 评估 AI scientist 能否从真实单细胞转录组数据中得出生物学发现的基准；论文 2026-07 发表于 Bioinformatics。 |
| [RIDAR](https://github.com/THU-KEG/RIDAR) | 2026-10-25 | C | 清华 THU-KEG 的自主科研诚信护栏：自动检测数据泄漏、指标误用、事后挑选等失效模式并做运行时干预。 |
