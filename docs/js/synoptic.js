
async function buildSynopticEdition() {
  const alignment = await fetch("alignment.json").then(r => r.json());

  const [aDoc, bDoc, vDoc] = await Promise.all([
    fetch("xii/A_text-only.html").then(r => r.text()).then(t => new DOMParser().parseFromString(t, "text/html")),
    fetch("xii/B_text-only.html").then(r => r.text()).then(t => new DOMParser().parseFromString(t, "text/html")),
    fetch("xii/V_text-only.html").then(r => r.text()).then(t => new DOMParser().parseFromString(t, "text/html")),
  ]);

  const colA = document.getElementById("colA");
  const colB = document.getElementById("colB");
  const colV = document.getElementById("colV");

  for (const row of alignment) {
    const alignId = row.align;
    const lineA = row.A ? aDoc.getElementById(row.A) : null;
    const lineB = row.B ? bDoc.getElementById(row.B) : null;
    const lineV = row.V ? vDoc.getElementById(row.V) : null;

    function makeLineHTML(line, id) {
      if (!line) return `<p class="line gap" data-align="\${id}">[gap]</p>`;
      line.setAttribute("data-align", id);
      return line.outerHTML;
    }

    colA.innerHTML += makeLineHTML(lineA, alignId);
    colB.innerHTML += makeLineHTML(lineB, alignId);
    colV.innerHTML += makeLineHTML(lineV, alignId);
  }

  document.querySelectorAll('.line').forEach(el => {
    el.addEventListener('click', () => {
      const alignId = el.getAttribute('data-align');
      document.querySelectorAll(`.line[data-align="${alignId}"]`).forEach(target => {
        target.scrollIntoView({ behavior: 'smooth', block: 'center' });
        target.classList.add('highlight');
        setTimeout(() => target.classList.remove('highlight'), 1000);
      });
    });
  });
}

document.addEventListener("DOMContentLoaded", buildSynopticEdition);