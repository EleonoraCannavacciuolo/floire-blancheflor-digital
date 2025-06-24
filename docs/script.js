const scrollBtn = document.getElementById("scrollToTop");

if (scrollBtn) {
  window.addEventListener("scroll", () => {
    if (window.scrollY > 300) {
      scrollBtn.classList.add("show");
    } else {
      scrollBtn.classList.remove("show");
    }
  });

  scrollBtn.addEventListener("click", () => {
    window.scrollTo({
      top: 0,
      behavior: "smooth"
    });
  });
}

const colA = document.getElementById('colA');
  const colB = document.getElementById('colB');
  const colC = document.getElementById('colV');

  // Load and insert HTML content
  async function loadText(col, url) {
    const response = await fetch(url);
    const html = await response.text();
    col.innerHTML = html;
  }

  Promise.all([
    loadText(colA, 'xii/A_text-only.html'),
    loadText(colB, 'xii/B_text-only.html'),
    loadText(colC, 'xii/V_text-only.html')
  ]).then(() => {
    // Scroll sync
    const columns = [colA, colB, colC];
    columns.forEach(col => {
      col.addEventListener('scroll', () => {
        const top = col.scrollTop;
        columns.forEach(c => {
          if (c !== col) c.scrollTop = top;
        });
      });
    });
  });