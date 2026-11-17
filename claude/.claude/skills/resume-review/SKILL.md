---
name: resume-review
description: Review a resume against the 4 writing principles (職責+成就, 強動詞+過去式, 結果導向, 不造假) and the senior-signal checklist. Triggers on /resume-review, "履歷 review", "履歷檢查", "幫我看履歷", "幫我檢查履歷".
---

# Resume Review

審視一份履歷的「工作經歷」段落，依照 4 大撰寫原則 + senior 訊號清單評分，並對每條 bullet 給出具體改寫建議。

## Inputs

- 使用者貼上履歷文字（中英皆可），或指定檔案路徑
- （Optional）目標職缺的 JD — 用來檢查關鍵字命中率
- （Optional）git repo / Linkedin / 個人資料來源 — 用來驗證真實性

如果使用者沒有提供履歷，請先請他貼上。

## Workflow

### Step 1：拆解履歷

將「工作經歷」段落拆成獨立 bullet。每條獨立評分。

### Step 2：對每條 bullet 套用 4 原則評分

| 原則                   | Pass 條件                                                                          | Fail 條件                                                       |
| ---------------------- | ---------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| **1. 職責 + 成就**     | 說了「做了什麼」**且**「換來什麼結果」                                             | 只描述做了什麼、沒有 outcome                                    |
| **2. 強動詞 + 過去式** | Led / Built / Architected / Designed / Reduced / Migrated / Spearheaded / Owned 等 | 弱動詞「協助」「參與」「負責」「進行」「實作」                  |
| **3. 結果導向**        | 至少 1 個**量化數字**（%、絕對值、before/after）                                   | 全篇過程描述，沒 outcome 數字；或寫了「成功」「高效」這種主觀詞 |
| **4. 真實性**          | 與 git log / linkedin / 已知背景相符                                               | 自我膨脹、無 evidence、宣稱「主導」但實際只是參與               |

每條給 **0-10 分**：每個原則 0 / 1 / 2 分（部分過 1，完整過 2，多個強項加分到 10 上限）。

### Step 3：找出 Senior 訊號的缺口

檢查是否有以下 senior 級別的訊號（前端領域）：

- ✅ **效能**：Lighthouse / 載入時間 / Bundle size 改善（量化）
- ✅ **規模**：MAU、團隊規模、處理檔案 / LOC 數量
- ✅ **品質**：測試覆蓋率變化、bug 減少、a11y 改善
- ✅ **流程**：CI/CD、release frequency、deploy 時間縮短
- ✅ **影響力**：mentor / 規範制定 / 跨部門協作 / 帶人
- ✅ **架構**：系統設計、技術選型、重構決策（不只 implementation）
- ✅ **業務**：conversion / engagement / 企業客戶數 / 付費轉換

每個維度標出「**有 / 沒有 / 模糊**」，並指出哪些可以補。

### Step 4：對每條 fail 的 bullet 給具體改寫

格式：

```
原版：<貼回原 bullet>
分數：X/10
問題：<點出哪幾個原則 fail>
改寫：<用 XYZ 公式重寫的版本>
建議補的數字：<列出可以查到的數字>
```

### Step 5：技術關鍵字命中（如有 JD）

若使用者提供 JD：

- 列出 JD 提到的技術關鍵字
- 逐一比對履歷是否有出現
- 缺的關鍵字標記出來（這些是 ATS 過濾關鍵）

### Step 6：總評

- 總分（5 條 × 10 = 50 滿分）
- 整體等級判斷：mid / mid-senior / senior / staff
- Top 3 最該改的點（不要列超過 3 個，避免使用者抓不到重點）

---

## Scoring 範例

**原版：**

> 協助實作前端功能，並與後端工程師合作完成多個專案。

**評分：**

- 1. 職責+成就：❌ 沒有 outcome
- 2. 強動詞：❌ 「協助」「合作」都是弱動詞
- 3. 結果導向：❌ 0 個數字
- 4. 真實性：⚠️ 「合作完成多個專案」太模糊

**分數：1/10**

**改寫範本：**

> Led the rewrite of the legacy checkout flow on the frontend, **reducing page load from 4.2s to 1.6s (-62%) and lifting checkout conversion by 12% across 3 product surfaces**.

---

## 4 原則的執行細則

### 原則 1：職責和成就

- 「做了什麼」是 **what**，「結果」是 **so what**
- 招募官只認 so what
- 缺 so what 的 bullet 一律降到 5 分以下，不論做的有多大

### 原則 2：強動詞 + 過去式

**強動詞分級（前端領域常用）：**

| 等級   | 動詞                                                | 訊號               |
| ------ | --------------------------------------------------- | ------------------ |
| Staff  | Architected / Spearheaded / Pioneered / Established | 從零建立、定義方向 |
| Senior | Led / Designed / Owned / Built / Migrated           | 主導、設計、決策   |
| Mid    | Developed / Implemented / Refactored / Optimized    | 執行、改善         |
| Junior | Helped / Assisted / Participated / Supported        | 協助               |

**用 senior+ 動詞時，必須能在面試證明自己真的擔任那個角色** — 否則會被識破。

### 原則 3：結果導向

- 過程細節（「跨部門溝通」「數週開發」）→ **刪掉**，留給面試講
- 每條至少 1 個 outcome 數字
- 結果在前、技術手段在後（招募官 6 秒掃描）

**XYZ 公式**：Achieved [X] as measured by [Y] by doing [Z]

- X：做了什麼具體成就
- Y：用什麼指標衡量
- Z：用什麼技術手段達成

### 原則 4：不要造假

- 「主導」「Led」要對應真的有主導的事實
- 數字要可以追溯到 evidence（git log / analytics / 內部文件）
- 沒做過的工具 / 框架不要寫進 skill 列表
- 履歷夠不夠豐富 ≠ 履歷夠不夠好看；造假只會在面試被識破

---

## Output Format

每次 review 輸出固定 4 個段落：

1. **逐條評分表**（每 bullet 分數 + 哪幾個原則 fail）
2. **Senior 訊號缺口表**（7 個維度逐一檢查）
3. **改寫建議**（針對 < 7 分的 bullet）
4. **總評 + Top 3 改進建議**

## Tone

- 直接、不客氣，但有理有據
- 點出哪條寫得好（鼓勵）、哪條寫得差（要改）
- 不要無腦稱讚 — 履歷 review 最忌諱客套
- 改寫建議要具體可執行，不要說「可以更好一點」這種空話

## Edge Cases

- **履歷整體很短（< 3 bullet）**：先請使用者補經歷，再做 review
- **使用者堅持不寫數字**：解釋為什麼數字是必要的，但最終尊重他的選擇
- **使用者寫的 outcome 看起來假**：直接質疑「這數字怎麼來的？能在面試證明嗎？」
- **使用者英文不確定**：可以先 review 中文版，再協助翻譯

## 不要做的事

- 不要替使用者編造他沒做過的成就
- 不要把弱動詞包裝成強動詞但實際工作沒做到那個程度（這是教使用者造假）
- 不要一次列超過 5 個改進建議（focus 才有效）
- 不要漏掉真實性檢查 — 這是這個 skill 的核心防呆
