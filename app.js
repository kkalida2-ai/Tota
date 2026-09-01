/* ===== تخزين البيانات (localStorage) ===== */
const DB = {
  KEY_STUDENTS: 'att_students',
  KEY_RECORDS: 'att_records',

  read(key, fallback) {
    try {
      const raw = localStorage.getItem(key);
      return raw ? JSON.parse(raw) : fallback;
    } catch (e) {
      return fallback;
    }
  },
  write(key, value) {
    localStorage.setItem(key, JSON.stringify(value));
  },

  // [{id, name}]
  students() { return DB.read(DB.KEY_STUDENTS, []); },
  saveStudents(list) { DB.write(DB.KEY_STUDENTS, list); },

  // { "2026-09-01": { "<id>": "present" | "absent" } }
  records() { return DB.read(DB.KEY_RECORDS, {}); },
  saveRecords(rec) { DB.write(DB.KEY_RECORDS, rec); },

  addStudent(name) {
    const list = DB.students();
    const clean = name.trim().replace(/\s+/g, ' ');
    if (!clean) return { ok: false, msg: 'الرجاء إدخال اسم الطالب' };
    if (list.some(s => s.name === clean)) return { ok: false, msg: 'هذا الاسم موجود مسبقاً' };
    list.push({ id: 's' + Date.now() + Math.floor(Math.random() * 1000), name: clean });
    DB.saveStudents(list);
    return { ok: true, msg: 'تمت إضافة الطالب' };
  },

  removeStudent(id) {
    DB.saveStudents(DB.students().filter(s => s.id !== id));
    const rec = DB.records();
    Object.keys(rec).forEach(date => {
      delete rec[date][id];
      if (!Object.keys(rec[date]).length) delete rec[date];
    });
    DB.saveRecords(rec);
  },

  setStatus(date, studentId, status) {
    const rec = DB.records();
    if (!rec[date]) rec[date] = {};
    rec[date][studentId] = status;
    DB.saveRecords(rec);
  }
};

/* ===== أدوات مساعدة ===== */
function today() {
  const d = new Date();
  const pad = n => String(n).padStart(2, '0');
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;
}

function formatDate(iso) {
  const [y, m, d] = iso.split('-');
  return `${d}/${m}/${y}`;
}

function toast(msg) {
  let el = document.querySelector('.toast');
  if (!el) {
    el = document.createElement('div');
    el.className = 'toast';
    document.body.appendChild(el);
  }
  el.textContent = msg;
  el.classList.add('show');
  clearTimeout(toast._t);
  toast._t = setTimeout(() => el.classList.remove('show'), 2000);
}

function studentName(id) {
  const s = DB.students().find(x => x.id === id);
  return s ? s.name : 'طالب محذوف';
}

/* إحصائيات كل طالب: أيام الحضور والغياب والنسبة */
function statsFor(studentId) {
  const rec = DB.records();
  let present = 0, absent = 0;
  Object.keys(rec).forEach(date => {
    const st = rec[date][studentId];
    if (st === 'present') present++;
    else if (st === 'absent') absent++;
  });
  const total = present + absent;
  return {
    present,
    absent,
    total,
    percent: total ? Math.round((present / total) * 100) : 0
  };
}

/* تفعيل رابط الصفحة الحالية في القائمة */
document.addEventListener('DOMContentLoaded', () => {
  const page = location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('nav a').forEach(a => {
    if (a.getAttribute('href') === page) a.classList.add('active');
  });
});
