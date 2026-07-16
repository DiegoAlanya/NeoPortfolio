let currentZoom = 100;
let currentRotation = 0;

function zoomIn() {
    if (currentZoom < 300) {
        currentZoom += 25;
        applyZoom();
    }
}

function zoomOut() {
    if (currentZoom > 50) {
        currentZoom -= 25;
        applyZoom();
    }
}

function resetZoom() {
    currentZoom = 100;
    currentRotation = 0;
    applyZoom();
    applyRotation();
}

function applyZoom() {
    const embed = document.getElementById('pdfEmbed');
    const zoomEl = document.getElementById('zoomLevel');
    if (embed) {
        embed.style.transform = `scale(${currentZoom / 100})`;
        embed.style.transformOrigin = 'top left';
    }
    if (zoomEl) zoomEl.textContent = currentZoom + '%';
}

function rotateLeft() {
    currentRotation -= 90;
    applyRotation();
}

function rotateRight() {
    currentRotation += 90;
    applyRotation();
}

function applyRotation() {
    const embed = document.getElementById('pdfEmbed');
    if (embed) {
        embed.style.transform = `rotate(${currentRotation}deg) scale(${currentZoom / 100})`;
        embed.style.transformOrigin = 'center center';
        embed.style.transition = 'transform 0.3s ease';
        if (currentRotation >= 360 || currentRotation <= -360) {
            currentRotation = currentRotation % 360;
        }
        setTimeout(() => { embed.style.transition = ''; }, 300);
    }
}

function toggleFullscreen() {
    const container = document.querySelector('.pdf-viewer-container');
    if (!document.fullscreenElement) {
        container?.requestFullscreen?.();
    } else {
        document.exitFullscreen?.();
    }
}

document.addEventListener('fullscreenchange', () => {
    document.querySelector('.pdf-viewer-container')?.classList.toggle('fullscreen', !!document.fullscreenElement);
});

// Keyboard shortcuts
document.addEventListener('keydown', (e) => {
    if (e.target.closest('input, textarea')) return;
    
    switch(e.key) {
        case '+': case '=': e.preventDefault(); zoomIn(); break;
        case '-': e.preventDefault(); zoomOut(); break;
        case '0': e.preventDefault(); resetZoom(); break;
        case 'f': if (!e.ctrlKey) { e.preventDefault(); toggleFullscreen(); } break;
        case 'Escape': if (document.fullscreenElement) document.exitFullscreen(); break;
    }
});

// Check if PDF exists
window.addEventListener('load', () => {
    const embed = document.getElementById('pdfEmbed');
    const noFile = document.getElementById('pdfNoFile');
    
    if (embed && noFile) {
        embed.addEventListener('error', () => {
            noFile.style.display = 'flex';
        });
        
        setTimeout(() => {
            try {
                if (!embed.contentDocument?.body?.innerHTML?.trim()) {
                    noFile.style.display = 'flex';
                }
            } catch(e) {}
        }, 5000);
    }
});

console.log('%c☠ VISOR PDF ACTIVO %c| %cHELL SYSTEM v6.6.6',
    'color:#dc2626;font-weight:bold;', 'color:#6b7280;', 'color:#dc2626;');