-- SMS V1 logical relational schema (SQLite reference)
PRAGMA foreign_keys = ON;
CREATE TABLE staff (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, note TEXT,
  skills_json TEXT NOT NULL DEFAULT '{}', active INTEGER NOT NULL DEFAULT 1
);
CREATE TABLE attendance (
  id TEXT PRIMARY KEY, work_date TEXT NOT NULL, staff_id TEXT NOT NULL REFERENCES staff(id),
  status TEXT NOT NULL, overtime_hours REAL NOT NULL DEFAULT 0 CHECK(overtime_hours >= 0 AND overtime_hours <= 24),
  note TEXT, UNIQUE(work_date, staff_id)
);
CREATE TABLE projects (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, note TEXT, status TEXT NOT NULL DEFAULT '進行中'
);
CREATE TABLE components (
  id TEXT PRIMARY KEY, project_id TEXT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  name TEXT NOT NULL, note TEXT, UNIQUE(project_id, name)
);
CREATE TABLE worklogs (
  id TEXT PRIMARY KEY, work_date TEXT NOT NULL, project_id TEXT NOT NULL REFERENCES projects(id),
  component_id TEXT NOT NULL REFERENCES components(id), work_type TEXT NOT NULL,
  progress TEXT NOT NULL, quantity REAL, unit TEXT, note TEXT
);
CREATE TABLE worklog_workers (
  worklog_id TEXT NOT NULL REFERENCES worklogs(id) ON DELETE CASCADE,
  staff_id TEXT NOT NULL REFERENCES staff(id), PRIMARY KEY(worklog_id, staff_id)
);
CREATE TABLE defects (
  id TEXT PRIMARY KEY, defect_date TEXT NOT NULL, project_id TEXT REFERENCES projects(id),
  component_id TEXT REFERENCES components(id), defect_type TEXT NOT NULL, stage TEXT NOT NULL,
  owner_id TEXT REFERENCES staff(id), description TEXT, status TEXT NOT NULL DEFAULT '待改善'
);
CREATE INDEX idx_attendance_date ON attendance(work_date);
CREATE INDEX idx_attendance_staff_date ON attendance(staff_id, work_date);
CREATE INDEX idx_components_project ON components(project_id);
CREATE INDEX idx_worklogs_project_date ON worklogs(project_id, work_date);
CREATE INDEX idx_defects_status_date ON defects(status, defect_date);
