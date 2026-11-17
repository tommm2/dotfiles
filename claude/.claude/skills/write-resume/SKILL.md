---
name: write-resume
description: 從 git log + 訪談把真實成果整理成誠實、結果導向的履歷 bullet，並更新到履歷檔（維持一頁）。核心是「素材 → 可追溯的 bullet」這段生成工作；評分交給 resume-review。Triggers on /write-resume, "更新履歷", "寫履歷", "幫我加履歷", "根據 git 整理成果".
---

# Write Resume

把使用者真實做過的事，變成招募官 6 秒內看懂價值的履歷 bullet。這個 skill 專做**生成/更新**：挖 git、訪談補事實、必要時當場量測、寫成結果導向 bullet、落地到履歷檔。

評分與改寫檢查是 [[resume-review]] 的工作，不在這裡重做。寫完 bullet 後，引導使用者接著跑 [[resume-review]] 做一次評分。求職信是 [[cover-letter]]。

## 這個 skill 跟 resume-review 的分界

| | write-resume（本 skill） | resume-review |
| --- | --- | --- |
| 輸入 | git repo + 訪談答案 + 現有履歷 | 現成履歷文字 |
| 工作 | 生成/更新 bullet、落地到檔 | 對現成 bullet 評分 + 改寫建議 |
| 時機 | 「我做了一堆事，幫我整理進履歷」 | 「幫我看這份履歷寫得好不好」 |

兩者共用一套原則（4 原則、強動詞分級、senior 訊號）。這些**評分尺**在 [[resume-review]]，本 skill 引用、不重寫。但「不造假 + 數字可追溯」這組**生成當下的守門規則**內嵌在本 skill（見下方「誠實守門鐵則」），因為要在寫下 bullet 的那一刻就擋住，不能等事後 review。

## Inputs

1. **git repo 路徑**（主要素材來源，必要）— 沒有就退而請使用者貼貢獻清單。
2. **現有履歷檔**（決定語言、格式、既有 bullet，用來更新而非重寫）。
3. **目標職缺 JD**（選用）— 只有在要做「逐公司微調 pass」時才需要。base 版不需要。

## Workflow

### Step 1：挖 git（主要引擎）

目標是找出**真實做過的事 + 可追溯的真數字**。使用者自己回想一定會漏（常見：記得做過效能優化，忘了當初量的是什麼）。

1. **作者 filter 要涵蓋所有 alias**。先列出使用者在這個 repo 的所有 email / name：
   ```
   git log --no-merges --pretty=format:"%an <%ae>" | sort | uniq -c | sort -rn
   ```
   一個人常有多個身分（例：`alice` / `alice-work` / `Alice Chen` 共用一個 email，或跨機器有不同 name）。全部納入，否則漏掉一半貢獻。
2. **抓有價值的 commit**。優先 `feat` / `perf` / `refactor` / `fix(安全)`；略過 `chore(deps)` / `style` / 純 i18n。按時間窗（預設近 3–6 個月，或自上次更新履歷以來）。
3. **讀 commit body，不只 subject**。真數字通常藏在 body：
   ```
   git show --stat --pretty=format:"%s%n%n%b" <hash>
   ```
   例：一條 `build: compile TypeScript with the native Go compiler` 的 body 裡寫著實測 `tsc --noEmit 20.2s -> 3.6s (5.6x)`、`build 44.5s -> 29.4s (-34%)`。這種是金礦——測過、可在面試重現。
4. **按主題分群**，不要逐條列。把 commit 歸成幾個主題（例：dashboard/charts、auth/SSO、chat 可靠度、工具鏈、架構），每個主題對應一條未來的 bullet。

### Step 2：訪談 gate（git 挖不到的事實，動筆前必問）

git 看不出團隊規模、你的角色、誰主導、有沒有 business outcome。這些決定 bullet 能不能用強動詞、能不能宣稱 impact。**挖完 git、生成前，固定問這四題**（一次問清，不要一題一回合拖）：

1. **團隊規模 + 你在裡面的角色**。幾人？你是唯一前端還是其中之一？帶不帶人、review 誰的 PR？
   —— 擋過期假設。別預設「唯一前端」：團隊會變，記憶會過期，寫錯會在面試穿幫。
2. **逐一確認每個主題成果是「主導」還是「參與」**。對應 [[resume-review]] 的動詞分級：主導才能用 Led / Drove / Architected，參與只能用 Developed / Implemented。
3. **有沒有可誠實講的規模 / business 數字**？MAU、客戶數、租戶數、轉換率、解鎖了哪個客群。沒有就質化，不硬湊。
4. **現有履歷 / 記憶裡有沒有要更正的舊資訊**？公司定位、職稱、年資、技術棧。

### Step 3：當場量測（選用，挖不到數字時）

某個想寫的數字 git 挖不到、也沒 baseline 時，可當場量**現值**。

- **動手前先問**。跑 build / benchmark 會慢、會失敗、會動到環境，先徵得同意。
- **優先讀現成產物**：既有 `dist/`、coverage report、既有 benchmark 檔。不行才跑 build。
- **量的是現值，不是 delta**。除非能同時誠實取得 baseline，否則只寫「現為 X」（例「bundle 現為 X KB gzip」「coverage 現為 Y%」），不假裝有改善幅度。
- 量不到就退質化描述。

### Step 4：生成 bullet

把每個主題寫成一條 bullet，目標形狀是 [[resume-review]] 的 XYZ 公式（結果在前、手段在後）。經驗證的三種強 bullet（這些具體範式本 skill 自帶，動詞分級/評分尺引用 resume-review）：

- **before → after 數字**：`Drove the migration to the TS 7 compiler, cutting tsc from 20.2s to 3.6s (5.6×) across a 4,875-file codebase.`
- **scope 數字**（沒有 delta 時）：`Enforced layer-boundary rules as CI errors, removing 10 feature barrels to block cross-layer imports.`
- **business / capability outcome**（feature 型，數字可免）：`Built enterprise SSO via Microsoft Entra ID with step-up MFA, letting enterprise users onboard with their own identities.`

規則：
- 至少一半 bullet 帶數字（真數字）。
- 語言跟現有履歷走（本 repo 履歷是英文就產英文），主動提可另出中文。
- 更新既有履歷時，保留寫得好的舊 bullet，只補 / 改需要的，不整份重寫。

### Step 5：chat 確認（落地前的防呆關卡）

**bullet 寫進履歷檔前，先在 chat 用 markdown 貼出來給使用者過目。** 這是誠實關卡——使用者是唯一知道「這數字當初量什麼」「這件事是不是我主導」的人。附上每條的來源（哪個 commit / 哪次量測 / 哪題訪談答案），讓他能逐條核對。

### Step 6：寫進履歷檔（維持一頁）

- 沿用現有履歷格式。docx 用「複製現檔再改 `word/document.xml`」的方式（參考 [[project_appier_application]] 的做法）。
- **強制一頁**。超出時，列出可砍的 bullet 請使用者選，不要自己亂刪或縮字級。
- base 版存回主履歷檔。

### Step 7：逐公司微調 pass（需要時）

履歷通常每家微調。這是獨立的輕量 pass，不重寫全部：

- 讀該公司 JD（接 [[cover-letter]] 的「做公司功課」邏輯）。
- 重排 bullet 順序，把最對口的推到前兩條。
- 補 2–4 個 JD 的 ATS 關鍵字（自然帶入，不塞）。
- 另存成 `resume-<公司>.docx`，不覆蓋 base。

寫完後引導：「接著跑 [[resume-review]] 做一次評分。」

## 誠實守門鐵則（本 skill 核心，內嵌）

生成的每一刻都套用，不等事後 review：

1. **數字要可追溯**。只寫能在面試證明的數字——來自 commit body 的實測、當場量測、或使用者確認的 analytics。講不出算法的數字一律不寫。
2. **挖不到 baseline 的 delta 不准掰**。想要 before/after % 但 squash merge / rebase 還原不出 baseline → 改成當場量現值，或退質化。（見 [[feedback_ai_workflow_quantify]]）
3. **當場量的是現值不是 delta**（見 Step 3）。
4. **主導 vs 參與要對應事實**。用 Led / Drove 前，Step 2 必須確認過他真的主導。
5. **受益描述緊貼成果真正帶來的差異**，不套聽起來合理但無關的商業利益。（見 [[feedback_resume_framing]]）
6. **沒做過的工具 / 框架不寫進技能列表。**
7. **去 AI 口吻、不用力過猛**：不要「獨立扛下」「一手包辦」這類表演感動詞。（見 [[feedback_tone_natural]]）

## Tone

- 直接、有據。點出哪條最有料、哪條數字站不住。
- 不無腦稱讚，但也不是 review——這裡是幫他把真東西寫出來。
- 使用者想放講不出依據的數字 → 點出面試風險，給質化替代版，最終尊重他的選擇。

## 不要做的事

- 不要替使用者編造沒做過的成就 / 沒有的數字 / 還原不出的 delta。
- 不要預設團隊結構或職稱（先問，Step 2）。
- 不要把弱動詞包裝成強動詞而實際沒做到那個角色。
- 不要整份重寫既有履歷——更新，不是推倒重來。
- 不要跳過 chat 確認直接寫檔（Step 5 是防呆核心）。
- 不要為了塞內容破壞一頁限制。
- 不要重抄 resume-review 的評分尺——引用它。

## Edge Cases

- **沒有 git repo**：退而請使用者貼貢獻清單，Step 1 跳過，其餘照跑。
- **git 全是 squash merge**：subject/body 仍可挖到成果與數字，但 delta 類（%）多半還原不出 → 鐵則 2。
- **使用者有多個 git 身分**：Step 1 先把 alias 全撈出來，別漏作者。
- **現有履歷不同語言**：跟現有語言走（Step 4），要投純中文在地職缺再轉。
- **成果太多塞不下一頁**：Step 6 請使用者選砍哪些，focus 比塞滿重要。
