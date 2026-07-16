// Partículas para el login
document.addEventListener('DOMContentLoaded', () => {
    const container = document.querySelector('.login-particles');
    if (container) {
        for (let i = 0; i < 30; i++) {
            const particle = document.createElement('div');
            particle.style.cssText = `
                position: fixed;
                width: ${Math.random() * 4 + 1}px;
                height: ${Math.random() * 4 + 1}px;
                background: #dc2626;
                border-radius: 50%;
                left: ${Math.random() * 100}%;
                top: ${Math.random() * 100}%;
                opacity: ${Math.random() * 0.5 + 0.1};
                animation: float ${Math.random() * 5 + 3}s linear infinite;
                pointer-events: none;
            `;
            container.appendChild(particle);
        }
    }
});