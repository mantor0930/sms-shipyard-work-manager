# SMS 船廠工作管理 V1.0

這是可安裝到 Android 主畫面的 PWA 第一版專案。

## 已包含功能
- 每天、每位員工獨立記錄出勤狀態
- 直接輸入每日加班總時數（支援 0.5 小時）
- 工程與構件：一個工程可建立多個構件
- 施工紀錄：工程、構件、施工人員、項目、進度、數量、備註
- 人員名單及五項焊接技能評級
- 品質缺失：責任工序、責任人、改善狀態
- 出勤、加班、工程統計
- JSON 完整備份／還原、CSV 報表匯出
- IndexedDB 本機資料庫；無需登入帳號

## 重要限制
1. 本版是個人單機版，資料只存在目前瀏覽器／裝置的網站資料空間，不會自動同步到其他手機。
2. 請定期使用首頁「匯出完整備份」。清除網站資料、重設瀏覽器或更換手機可能導致資料遺失。
3. PWA 安裝需要 HTTPS 網址（或 localhost）。直接點開 HTML 檔可以測試主要介面，但瀏覽器可能不允許完整安裝及離線快取。
4. 本版尚未包含登入、多人權限、雲端同步、照片附件上傳、薪資與加班費計算、正式稽核軌跡。

## Android 安裝方式
1. 將整個專案部署到支援 HTTPS 的靜態網站空間（例如自有主機或靜態網站代管服務）。
2. 用 Android Chrome 開啟網站。
3. 點 Chrome 選單「安裝應用程式」或「新增至主畫面」。
4. 安裝後從手機桌面開啟 SMS。

## 本機測試
可使用支援靜態檔案的本機伺服器開啟 index.html；不要只把檔案傳到手機後當成正式資料庫備份方式。

## V1.0 資料模型
- staff(id, name, note, skills)
- attendance(id, date, staffId, status, overtime, note)
- projects(id, name, note)
- components(id, projectId, name, note)
- worklogs(id, date, projectId, componentId, workerIds, type, progress, quantity, unit, note)
- defects(id, date, projectId, componentId, type, stage, ownerId, note, status)

資料表以 IndexedDB object stores 實作；各筆資料以唯一 id 關聯。
