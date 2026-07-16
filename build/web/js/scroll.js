// =============================================
// NEO PORTFOLIO - Scroll Animations
// AAA Cinematic Reveal Effects
// =============================================

document.addEventListener('DOMContentLoaded', () => {
    initScrollReveal();
    initParallaxEffects();
    initCounterAnimation();
});

// Scroll Reveal Animation
function initScrollReveal() {
    const revealElements = document.querySelectorAll(
        '.blood-card, .skill-card, .contact-card, .hero-title, .section-title, .stat-item'
    );
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
                entry.target.style.transition = 'all 0.8s cubic-bezier(0.165, 0.84, 0.44, 1)';
                
                // Add stagger effect for cards
                if (entry.target.classList.contains('blood-card')) {
                    const parent = entry.target.parentElement;
                    const index = Array.from(parent.children).indexOf(entry.target);
                    entry.target.style.transitionDelay = (index * 0.1) + 's';
                }
                
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.15,
        rootMargin: '0px 0px -50px 0px'
    });
    
    revealElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(50px)';
        observer.observe(el);
    });
}

// Parallax Effects
function initParallaxEffects() {
    const parallaxElements = document.querySelectorAll('.hero-image-circle, .hero-aura');
    
    window.addEventListener('scroll', () => {
        const scrolled = window.pageYOffset;
        
        parallaxElements.forEach(el => {
            const speed = 0.5;
            const offset = scrolled * speed;
            el.style.transform = `translateY(${offset * 0.3}px)`;
        });
    });
}

// Counter Animation
function initCounterAnimation() {
    const counters = document.querySelectorAll('.stat-number');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const counter = entry.target;
                const target = parseInt(counter.getAttribute('data-target'));
                const duration = 2000; // 2 seconds
                const steps = 60;
                const stepValue = target / steps;
                let current = 0;
                
                const updateCounter = () => {
                    current += stepValue;
                    if (current <= target) {
                        counter.textContent = Math.floor(current);
                        requestAnimationFrame(updateCounter);
                    } else {
                        counter.textContent = target;
                    }
                };
                
                updateCounter();
                observer.unobserve(counter);
            }
        });
    }, { threshold: 0.5 });
    
    counters.forEach(counter => {
        observer.observe(counter);
    });
}