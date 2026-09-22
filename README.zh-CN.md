# 单物种鸣声特征分析工作流

这是一套面向本科生和生态声学初学者的图解式教学材料。它以长尾缝叶莺（*Orthotomus sutorius*）为案例，展示如何把被动声学监测录音整理成可解释、可追溯的生态分析。

<p align="center">
  <img src="assets/workflow-overview.png" alt="从野外录音到生态推断的单物种鸣声特征分析流程" width="100%">
</p>

**[开始学习](docs/00-orientation.md) · [Audition 图解](docs/09-audition-audio-preparation.md) · [Avisoft 图解](docs/10-avisoft-vocal-trait-measurement.md) · [运行分析](analysis/README.md) · [后续计划](TODO.md) · [English](README.md)**

## 你将学会什么

- 从 WAV 文件建立清楚的文件清单和数据谱系；
- 用声音事件检测和 BirdNET 筛选目标种候选；
- 用听辨和声谱图完成逐条人工核验；
- 从鸣声片段提取七项时间与频率特征；
- 将片段聚合为分钟数据和站点时段数据；
- 分别用 BLMM 和 GAM 回答短期声景关联与生境关联问题；
- 用模型诊断和置信度敏感性分析检查结果的稳定性。

## 三步开始

```bash
git clone https://github.com/Fly-Carrot/single-species-vocal-trait-workflow.git
cd single-species-vocal-trait-workflow
python3 scripts/01_audio_manifest.py --input data/demo --output outputs/audio_manifest.csv
```

生成 2 秒教学切片：

```bash
python3 scripts/02_segment_audio.py \
  --input data/demo/common-tailorbird-denoised.wav \
  --output outputs/clips \
  --seconds 2
```

下载公开分析表并核查数据规模：

```bash
python3 analysis/download_public_data.py
Rscript analysis/01_data_check.R
```

## 两条学习路线

**快速入门**：查看波形和声谱图，建立音频清单，理解候选检测、人工核验和鸣声测量之间的关系。

**完整分析**：读取公开数据，检查 2,776 条分钟记录，运行时空检验，查看 14 个 BLMM 和 4 个 GAM 的模型结构，并复核敏感性分析。

## 案例数据规模

完整 PAM 网络包含 21 个站点。目标种鸣声特征分析使用 20 个站点、9,142 个已核验鸣声片段、2,776 条分钟记录和 59 条站点时段记录。

## 文件结构

```text
assets/      流程图与音频示意图
data/        教学音频与记录模板
docs/        分步骤教学
scripts/     音频清单、切片与绘图脚本
analysis/    公开数据下载与 R 分析脚本
TODO.md      后续材料与开发计划
```

论文对应的公开数据表位于 [Fly-Carrot/JAPPL-2026-01502-Supplementary](https://github.com/Fly-Carrot/JAPPL-2026-01502-Supplementary)。
