<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>JSP 파일 업로드 UI</title>
  <style>
    #fileInput { display: none; }
    .file-upload-btn {
      background-color: #3498db;
      color: white;
      padding: 10px 16px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 15px;
    }
    .file-list { margin-top: 15px; }
    .file-item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      border: 1px solid #ccc;
      padding: 8px;
      margin-bottom: 6px;
      border-radius: 4px;
      background: #f9f9f9;
    }
    .file-item.error { color: red; border-color: red; }
    .remove-btn {
      background: #e74c3c;
      color: white;
      border: none;
      border-radius: 4px;
      padding: 4px 10px;
      cursor: pointer;
    }
  </style>
</head>
<body>

<h2>📂 파일 업로드</h2>

<input type="file" id="fileInput" multiple>
<button type="button" class="file-upload-btn" id="customFileBtn">파일 찾기</button>

<div class="file-list" id="fileList"></div>

<!-- JS 로직 -->
<script>
  const allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'txt'];
  const maxFileSizeMB = 5;

  const fileInput = document.getElementById('fileInput');
  const customFileBtn = document.getElementById('customFileBtn');
  const fileList = document.getElementById('fileList');

  let selectedFiles = [];

  customFileBtn.addEventListener('click', () => {
    fileInput.click();
  });

  fileInput.addEventListener('change', () => {
    const newFiles = Array.from(fileInput.files);

    newFiles.forEach(file => {
      const ext = file.name.split('.').pop().toLowerCase();
      const sizeMB = file.size / (1024 * 1024);

      // 중복 제거
      const isDuplicate = selectedFiles.some(f => f.file.name === file.name && f.file.size === file.size);
      if (isDuplicate) return;

      const isValid = allowedExtensions.includes(ext) && sizeMB <= maxFileSizeMB;

      selectedFiles.push({ file, isValid });
    });

    fileInput.value = ''; // 초기화해서 동일 파일도 다시 선택 가능
    renderFileList();
  });

  function renderFileList() {
    fileList.innerHTML = '';
    selectedFiles.forEach((item, index) => {
      const div = document.createElement('div');
      div.className = 'file-item';
      if (!item.isValid) div.classList.add('error');

      const fileSizeKB = (item.file.size / 1024).toFixed(1);
      const label = item.isValid
        ? `✅ ${item.file.name} (${fileSizeKB} KB)`
        : `❌ ${item.file.name} - 허용 안됨`;

      div.innerHTML = `
        <span>${label}</span>
        <button class="remove-btn" data-index="${index}">삭제</button>
      `;

      fileList.appendChild(div);
    });

    document.querySelectorAll('.remove-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        const idx = parseInt(btn.getAttribute('data-index'));
        selectedFiles.splice(idx, 1);
        renderFileList();
      });
    });
  }
</script>

</body>
</html>

