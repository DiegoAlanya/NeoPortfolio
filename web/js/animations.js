// =============================================
// NEO PORTFOLIO - Special Animations
// Bloodpunk Cinematic Effects
// =============================================

document.addEventListener('DOMContentLoaded', () => {
    initBloodDrips();
    initGlitchText();
    initFogEffect();
    initPulseAnimation();
});

// Random Blood Drip Effect
function initBloodDrips() {
    const createBloodDrip = () => {
        const drip = document.createElement('div');
        drip.className = 'blood-drip';
        drip.style.cssText = `
            position: fixed;
            width: 2px;
            height: ${Math.random() * 100 + 50}px;
            background: linear-gradient(to bottom, transparent, #ff0000);
            left: ${Math.random() * 100}%;
            top: -50px;
            opacity: ${Math.random() * 0.3 + 0.1};
            z-index: 9999;
            pointer-events: none;
            animation: bloodDrip ${Math.random() * 3 + 2}s linear infinite;
        `;
        
        document.body.appendChild(drip);
        
        // Remove drip after animation
        setTimeout(() => {
            drip.remove();
        }, 5000);
    };
    
    // Create random drips
    setInterval(() => {
        if (Math.random() > 0.7) {
            createBloodDrip();
        }
    }, 2000);
}

// Glitch Text Effect
function initGlitchText() {
    const glitchTargets = document.querySelectorAll('.hero-name, .card-week-number, .section-title');
    
    glitchTargets.forEach(target => {
        target.addEventListener('mouseenter', () => {
            let glitchCount = 0;
            const maxGlitches = 10;
            
            const glitchInterval = setInterval(() => {
                if (glitchCount >= maxGlitches) {
                    clearInterval(glitchInterval);
                    target.style.textShadow = '';
                    return;
                }
                
                const xOffset = (Math.random() - 0.5) * 10;
                const yOffset = (Math.random() - 0.5) * 5;
                
                target.style.textShadow = `
                    ${xOffset}px ${yOffset}px 0 rgba(255, 0, 0, 0.7),
                    ${-xOffset}px ${-yOffset}px 0 rgba(139, 0, 0, 0.7)
                `;
                
                glitchCount++;
            }, 50);
        });
        
        target.addEventListener('mouseleave', () => {
            target.style.textShadow = '';
        });
    });
}

// Fog/Humo Effect
function initFogEffect() {
    const fogContainer = document.createElement('div');
    fogContainer.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        pointer-events: none;
        z-index: -1;
    `;
    
    for (let i = 0; i < 5; i++) {
        const fog = document.createElement('div');
        fog.style.cssText = `
            position: absolute;
            width: ${Math.random() * 400 + 200}px;
            height: ${Math.random() * 100 + 50}px;
            background: radial-gradient(ellipse at center, rgba(139, 0, 0, 0.05) 0%, transparent 70%);
            top: ${Math.random() * 100}%;
            left: ${Math.random() * 100}%;
            filter: blur(${Math.random() * 30 + 20}px);
            animation: fogFloat ${Math.random() * 20 + 10}s linear infinite;
            animation-delay: ${Math.random() * 5}s;
        `;
        
        fogContainer.appendChild(fog);
    }
    
    document.body.appendChild(fogContainer);
}

// Pulse Animation on Interactive Elements
function initPulseAnimation() {
    const pulseTargets = document.querySelectorAll('.btn-blood-primary, .card-button, .form-submit');
    
    pulseTargets.forEach(target => {
        target.addEventListener('mouseenter', () => {
            target.style.animation = 'red-pulse 1s infinite';
        });
        
        target.addEventListener('mouseleave', () => {
            target.style.animation = '';
        });
    });
}