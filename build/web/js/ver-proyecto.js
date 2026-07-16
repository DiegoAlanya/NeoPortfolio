// =============================================
// VER PROYECTO - Efectos Especiales
// Bloodpunk Infernal Effects
// Soporte para 16 semanas con 32 capturas
// =============================================

document.addEventListener('DOMContentLoaded', () => {
    initParticleBackground();
    initScrollReveal();
    initCaptureModal();
    initFireBorders();
    initHoverEffects();
    initWeekNavigation();
    initKeyboardNavigation();
    initProjectAnimations();
    showEasterEgg();
});

// =============================================
// PARTÍCULAS DE FONDO
// =============================================
function initParticleBackground() {
    const canvas = document.createElement('canvas');
    canvas.id = 'vpParticleCanvas';
    canvas.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        pointer-events: none;
        z-index: 0;
    `;
    document.body.appendChild(canvas);
    
    const ctx = canvas.getContext('2d');
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    
    const particles = [];
    const maxParticles = 50;
    
    for (let i = 0; i < maxParticles; i++) {
        particles.push({
            x: Math.random() * canvas.width,
            y: Math.random() * canvas.height,
            radius: Math.random() * 2 + 1,
            speedY: Math.random() * 0.3 + 0.1,
            speedX: (Math.random() - 0.5) * 0.2,
            opacity: Math.random() * 0.4 + 0.1,
            pulse: Math.random() * Math.PI * 2,
        });
    }
    
    function animate() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        
        particles.forEach(p => {
            p.pulse += 0.02;
            const alpha = Math.sin(p.pulse) * 0.2 + p.opacity;
            
            ctx.beginPath();
            ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2);
            ctx.fillStyle = `rgba(255, 30, 30, ${alpha})`;
            ctx.fill();
            
            ctx.beginPath();
            ctx.arc(p.x, p.y, p.radius * 3, 0, Math.PI * 2);
            ctx.fillStyle = `rgba(255, 30, 30, ${alpha * 0.15})`;
            ctx.fill();
            
            p.y -= p.speedY;
            p.x += p.speedX;
            
            if (p.y < -10) {
                p.y = canvas.height + 10;
                p.x = Math.random() * canvas.width;
            }
            if (p.x < -10) p.x = canvas.width + 10;
            if (p.x > canvas.width + 10) p.x = -10;
        });
        
        requestAnimationFrame(animate);
    }
    
    animate();
    
    window.addEventListener('resize', () => {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    });
}

// =============================================
// SCROLL REVEAL
// =============================================
function initScrollReveal() {
    const elements = document.querySelectorAll(
        '.vp-stack-section, .vp-captures-section, .vp-capture-card, .vp-actions, .vp-bottom-navigation'
    );
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry, index) => {
            if (entry.isIntersecting) {
                setTimeout(() => {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                    entry.target.style.transition = 'all 0.8s cubic-bezier(0.165, 0.84, 0.44, 1)';
                }, index * 100);
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.15,
        rootMargin: '0px 0px -30px 0px'
    });
    
    elements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(40px)';
        observer.observe(el);
    });
}

// =============================================
// MODAL PARA CAPTURAS
// =============================================
function initCaptureModal() {
    const captureCards = document.querySelectorAll('.vp-capture-card');
    
    captureCards.forEach(card => {
        card.addEventListener('click', () => {
            const img = card.querySelector('.vp-capture-img');
            const imgSrc = img.getAttribute('src');
            const label = card.querySelector('.vp-capture-label').textContent;
            
            const modal = document.createElement('div');
            modal.className = 'vp-modal';
            modal.style.cssText = `
                position: fixed;
                inset: 0;
                background: rgba(0, 0, 0, 0.95);
                z-index: 100000;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                cursor: pointer;
                animation: vpModalFadeIn 0.3s ease;
            `;
            
            modal.innerHTML = `
                <div style="max-width: 90vw; max-height: 90vh; position: relative;">
                    <img src="${imgSrc}" alt="${label}" style="max-width: 100%; max-height: 80vh; object-fit: contain; border: 2px solid #dc2626; box-shadow: 0 0 60px rgba(220, 38, 38, 0.5);">
                    <p style="text-align: center; color: #dc2626; font-family: 'Orbitron', sans-serif; font-size: 14px; margin-top: 15px; letter-spacing: 3px;">${label}</p>
                </div>
                <button class="vp-modal-close" style="
                    position: absolute;
                    top: 30px;
                    right: 30px;
                    background: none;
                    border: 2px solid #dc2626;
                    color: #dc2626;
                    width: 50px;
                    height: 50px;
                    font-size: 24px;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                ">✕</button>
            `;
            
            document.body.appendChild(modal);
            document.body.style.overflow = 'hidden';
            
            const closeModal = () => {
                modal.style.animation = 'vpModalFadeOut 0.3s ease';
                setTimeout(() => {
                    modal.remove();
                    document.body.style.overflow = '';
                }, 280);
            };
            
            modal.addEventListener('click', (e) => {
                if (e.target === modal || e.target.classList.contains('vp-modal-close')) {
                    closeModal();
                }
            });
            
            const escHandler = (e) => {
                if (e.key === 'Escape') {
                    closeModal();
                    document.removeEventListener('keydown', escHandler);
                }
            };
            document.addEventListener('keydown', escHandler);
        });
    });
    
    if (!document.getElementById('vpModalStyles')) {
        const modalStyles = document.createElement('style');
        modalStyles.id = 'vpModalStyles';
        modalStyles.textContent = `
            @keyframes vpModalFadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }
            @keyframes vpModalFadeOut {
                from { opacity: 1; }
                to { opacity: 0; }
            }
            .vp-modal-close:hover {
                background: rgba(220, 38, 38, 0.2) !important;
                box-shadow: 0 0 30px rgba(220, 38, 38, 0.6) !important;
                transform: scale(1.1);
            }
        `;
        document.head.appendChild(modalStyles);
    }
}

// =============================================
// BORDES CON EFECTO FUEGO
// =============================================
function initFireBorders() {
    const projectCard = document.querySelector('.vp-project-card');
    const bottomNavBtns = document.querySelectorAll('.vp-bottom-nav-btn');
    
    if (projectCard) {
        projectCard.addEventListener('mousemove', (e) => {
            const rect = projectCard.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            projectCard.style.setProperty('--mouse-x', `${x}px`);
            projectCard.style.setProperty('--mouse-y', `${y}px`);
        });
        
        projectCard.addEventListener('mouseleave', () => {
            projectCard.style.setProperty('--mouse-x', '50%');
            projectCard.style.setProperty('--mouse-y', '50%');
        });
    }
    
    bottomNavBtns.forEach(btn => {
        btn.addEventListener('mousemove', (e) => {
            const rect = btn.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            btn.style.setProperty('--mouse-x', `${x}px`);
            btn.style.setProperty('--mouse-y', `${y}px`);
        });
    });
}

// =============================================
// EFECTOS HOVER
// =============================================
function initHoverEffects() {
    const titles = document.querySelectorAll('.vp-project-title, .vp-nav-title');
    
    titles.forEach(title => {
        title.addEventListener('mouseenter', () => {
            let count = 0;
            const maxCount = 6;
            
            const glitchInterval = setInterval(() => {
                if (count >= maxCount) {
                    clearInterval(glitchInterval);
                    title.style.textShadow = '';
                    title.style.transform = '';
                    return;
                }
                
                const offset = (Math.random() - 0.5) * 4;
                title.style.textShadow = `
                    ${offset}px ${offset}px 0 rgba(255, 30, 30, 0.7),
                    ${-offset}px ${-offset}px 0 rgba(139, 0, 0, 0.7)
                `;
                title.style.transform = `translate(${(Math.random() - 0.5) * 2}px, ${(Math.random() - 0.5) * 2}px)`;
                count++;
            }, 40);
        });
        
        title.addEventListener('mouseleave', () => {
            title.style.textShadow = '';
            title.style.transform = '';
        });
    });
    
    const tags = document.querySelectorAll('.vp-tag');
    tags.forEach(tag => {
        tag.addEventListener('mouseenter', function() {
            this.style.animation = 'vpPulse 0.5s ease-in-out';
            setTimeout(() => {
                this.style.animation = '';
            }, 500);
        });
    });
    
    const actionBtns = document.querySelectorAll('.vp-btn');
    actionBtns.forEach(btn => {
        btn.addEventListener('mousedown', function() {
            this.style.transform = 'scale(0.95)';
        });
        btn.addEventListener('mouseup', function() {
            this.style.transform = '';
        });
        btn.addEventListener('mouseleave', function() {
            this.style.transform = '';
        });
    });
}

// =============================================
// NAVEGACIÓN CON TECLADO
// =============================================
function initKeyboardNavigation() {
    document.addEventListener('keydown', (e) => {
        if (e.key === 'ArrowLeft' && !e.target.closest('input, textarea')) {
            const prevBtn = document.querySelector('.vp-bottom-nav-btn.vp-prev');
            if (prevBtn) {
                window.location.href = prevBtn.getAttribute('href');
            }
        }
        
        if (e.key === 'ArrowRight' && !e.target.closest('input, textarea')) {
            const nextBtn = document.querySelector('.vp-bottom-nav-btn.vp-next');
            if (nextBtn) {
                window.location.href = nextBtn.getAttribute('href');
            }
        }
        
        if (e.key === 'b' && e.ctrlKey && !e.target.closest('input, textarea')) {
            e.preventDefault();
            window.location.href = 'trabajos.jsp';
        }
    });
}

// =============================================
// ANIMACIÓN DE ENTRADA DE LA SEMANA
// =============================================
function initWeekNavigation() {
    const urlParams = new URLSearchParams(window.location.search);
    const currentWeek = urlParams.get('week') || '01';
    
    const weekBadge = document.querySelector('.vp-week-badge');
    if (weekBadge) {
        weekBadge.style.animation = 'vpPulse 2s ease-in-out 3';
        setTimeout(() => {
            weekBadge.style.animation = '';
        }, 6000);
    }
    
    const currentWeekSpan = document.querySelector('.vp-current-week');
    if (currentWeekSpan) {
        currentWeekSpan.style.animation = 'vpPulse 3s infinite';
    }
    
    console.log(`%c☠ CARGANDO WEEK_${currentWeek} ☠`, 'color: #dc2626; font-size: 16px;');
}

// =============================================
// ANIMACIONES DEL PROYECTO
// =============================================
function initProjectAnimations() {
    const title = document.querySelector('.vp-project-title');
    if (title) {
        title.style.opacity = '0';
        title.style.transform = 'translateY(30px)';
        setTimeout(() => {
            title.style.transition = 'all 1s cubic-bezier(0.165, 0.84, 0.44, 1)';
            title.style.opacity = '1';
            title.style.transform = 'translateY(0)';
        }, 300);
    }
    
    const description = document.querySelector('.vp-project-description');
    if (description) {
        description.style.opacity = '0';
        description.style.transform = 'translateX(-20px)';
        setTimeout(() => {
            description.style.transition = 'all 0.8s cubic-bezier(0.165, 0.84, 0.44, 1)';
            description.style.opacity = '1';
            description.style.transform = 'translateX(0)';
        }, 600);
    }
    
    const tags = document.querySelectorAll('.vp-tag');
    tags.forEach((tag, index) => {
        tag.style.opacity = '0';
        tag.style.transform = 'scale(0.8)';
        setTimeout(() => {
            tag.style.transition = 'all 0.5s cubic-bezier(0.165, 0.84, 0.44, 1)';
            tag.style.opacity = '1';
            tag.style.transform = 'scale(1)';
        }, 900 + (index * 200));
    });
    
    const captures = document.querySelectorAll('.vp-capture-card');
    captures.forEach((capture, index) => {
        capture.style.opacity = '0';
        capture.style.transform = 'translateY(30px)';
        setTimeout(() => {
            capture.style.transition = 'all 0.7s cubic-bezier(0.165, 0.84, 0.44, 1)';
            capture.style.opacity = '1';
            capture.style.transform = 'translateY(0)';
        }, 1200 + (index * 200));
    });
}

// =============================================
// EASTER EGG
// =============================================
function showEasterEgg() {
    const urlParams = new URLSearchParams(window.location.search);
    const week = urlParams.get('week') || '01';
    
    console.log(`
%c⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡
%c☠ NEO PORTFOLIO - VER PROYECTO ☠
%cWEEK_${week} - MISSION ACTIVE
%cHELL SYSTEM ONLINE v6.6.6
%cBloodpunk Cyber Demon Interface
%c⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡ ⬡
%c💀 TIP: Flechas ← → para navegar entre semanas
%c💀 TIP: Ctrl+B para volver a misiones
    `,
        'color: #991b1b;',
        'color: #dc2626; font-size: 20px; font-weight: bold;',
        'color: #ef4444; font-size: 16px;',
        'color: #dc2626; font-size: 14px;',
        'color: #6b7280; font-size: 12px;',
        'color: #991b1b;',
        'color: #dc2626; font-size: 11px;',
        'color: #dc2626; font-size: 11px;'
    );
}