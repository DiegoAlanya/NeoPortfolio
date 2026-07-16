// =============================================
// NEO PORTFOLIO - Main Controller
// =============================================

document.addEventListener('DOMContentLoaded', () => {
    initHeaderScroll();
    initMobileMenu();
    initSkillBars();
    initScrollProgress();
    initSmoothScroll();
    initGlitchEffects();
    initCardHoverEffects();
    initFormValidation();
    initScrollToTop();
    setActiveNavLink();
});

// Set Active Navigation Link based on current page
function setActiveNavLink() {
    const currentPage = window.location.pathname.split('/').pop();
    const navLinks = document.querySelectorAll('.nav-link');
    
    navLinks.forEach(link => {
        const href = link.getAttribute('href');
        if (href === currentPage || (currentPage === '' && href === 'index.jsp')) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });
}

// Header Scroll Effect
function initHeaderScroll() {
    const header = document.querySelector('.neo-header');
    let lastScroll = 0;
    
    window.addEventListener('scroll', () => {
        const currentScroll = window.pageYOffset;
        
        if (currentScroll > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
        
        lastScroll = currentScroll;
    });
}

// Mobile Menu Toggle
function initMobileMenu() {
    const toggle = document.querySelector('.menu-toggle');
    const nav = document.querySelector('.neo-nav');
    
    if (toggle && nav) {
        toggle.addEventListener('click', () => {
            toggle.classList.toggle('active');
            nav.classList.toggle('active');
        });
        
        // Close menu on link click
        const links = nav.querySelectorAll('.nav-link');
        links.forEach(link => {
            link.addEventListener('click', () => {
                toggle.classList.remove('active');
                nav.classList.remove('active');
            });
        });
    }
}

// Skill Bars Animation
function initSkillBars() {
    const skillBars = document.querySelectorAll('.skill-bar');
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const bar = entry.target;
                const targetWidth = bar.getAttribute('data-width');
                if (targetWidth) {
                    bar.style.width = targetWidth;
                }
                observer.unobserve(bar);
            }
        });
    }, { threshold: 0.5 });
    
    skillBars.forEach(bar => {
        const width = bar.style.width || '0%';
        bar.style.width = '0%';
        bar.setAttribute('data-width', width);
        observer.observe(bar);
    });
}

// Scroll Progress Bar
function initScrollProgress() {
    const progressBar = document.createElement('div');
    progressBar.className = 'scroll-progress';
    document.body.appendChild(progressBar);
    
    window.addEventListener('scroll', () => {
        const windowHeight = document.documentElement.scrollHeight - window.innerHeight;
        const scrolled = (window.pageYOffset / windowHeight) * 100;
        progressBar.style.width = scrolled + '%';
    });
}

// Smooth Scroll
function initSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

// Glitch Effects
function initGlitchEffects() {
    const glitchElements = document.querySelectorAll('.hero-name, .section-title');
    
    glitchElements.forEach(element => {
        element.addEventListener('mouseenter', () => {
            element.style.animation = 'glitch-text 0.3s infinite';
        });
        
        element.addEventListener('mouseleave', () => {
            element.style.animation = '';
        });
    });
}

// Card Hover 3D Effect
function initCardHoverEffects() {
    const cards = document.querySelectorAll('.blood-card');
    
    cards.forEach(card => {
        card.addEventListener('mousemove', (e) => {
            const rect = card.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            
            const centerX = rect.width / 2;
            const centerY = rect.height / 2;
            
            const rotateX = (y - centerY) / centerY * -5;
            const rotateY = (x - centerX) / centerX * 5;
            
            card.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) translateY(-10px)`;
        });
        
        card.addEventListener('mouseleave', () => {
            card.style.transform = 'perspective(1000px) rotateX(0) rotateY(0) translateY(0)';
        });
    });
}

// Form Validation
function initFormValidation() {
    const form = document.querySelector('.contact-form');
    
    if (form) {
        form.addEventListener('submit', (e) => {
            e.preventDefault();
            
            const name = form.querySelector('[name="nombre"]');
            const email = form.querySelector('[name="email"]');
            const subject = form.querySelector('[name="asunto"]');
            const message = form.querySelector('[name="mensaje"]');
            
            let isValid = true;
            
            if (name && !name.value.trim()) {
                showError(name, 'NAME REQUIRED');
                isValid = false;
            }
            
            if (email && (!email.value.trim() || !isValidEmail(email.value))) {
                showError(email, 'VALID EMAIL REQUIRED');
                isValid = false;
            }
            
            if (subject && !subject.value.trim()) {
                showError(subject, 'SUBJECT REQUIRED');
                isValid = false;
            }
            
            if (message && !message.value.trim()) {
                showError(message, 'MESSAGE REQUIRED');
                isValid = false;
            }
            
            if (isValid) {
                showSuccess();
                form.reset();
            }
        });
    }
}

function showError(input, message) {
    input.style.borderColor = '#ff0000';
    input.style.boxShadow = '0 0 20px rgba(255, 0, 0, 0.5)';
    input.style.animation = 'shake 0.5s ease';
    setTimeout(() => {
        input.style.animation = '';
    }, 500);
}

function showSuccess() {
    const button = document.querySelector('.form-submit');
    if (button) {
        button.textContent = 'TRANSMISSION SENT';
        button.style.background = 'linear-gradient(135deg, #00ff00, #008000)';
        
        setTimeout(() => {
            button.textContent = 'ENVIAR TRANSMISIÓN';
            button.style.background = '';
        }, 3000);
    }
}

function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

// Scroll to Top Button
function initScrollToTop() {
    const button = document.createElement('button');
    button.className = 'scroll-top-btn';
    button.innerHTML = '⬆';
    button.style.cssText = `
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 50px;
        height: 50px;
        background: rgba(0, 0, 0, 0.8);
        border: 2px solid #ff0000;
        color: #ff0000;
        font-size: 24px;
        cursor: pointer;
        z-index: 9999;
        opacity: 0;
        visibility: hidden;
        transition: all 0.3s ease;
        box-shadow: 0 0 20px rgba(255, 0, 0, 0.3);
        clip-path: polygon(5px 0, 100% 0, calc(100% - 5px) 100%, 0 100%);
    `;
    
    document.body.appendChild(button);
    
    window.addEventListener('scroll', () => {
        if (window.pageYOffset > 500) {
            button.style.opacity = '1';
            button.style.visibility = 'visible';
        } else {
            button.style.opacity = '0';
            button.style.visibility = 'hidden';
        }
    });
    
    button.addEventListener('click', () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
    
    button.addEventListener('mouseenter', () => {
        button.style.background = 'rgba(255, 0, 0, 0.2)';
        button.style.boxShadow = '0 0 40px rgba(255, 0, 0, 0.6)';
        button.style.transform = 'translateY(-5px)';
    });
    
    button.addEventListener('mouseleave', () => {
        button.style.background = 'rgba(0, 0, 0, 0.8)';
        button.style.boxShadow = '0 0 20px rgba(255, 0, 0, 0.3)';
        button.style.transform = 'translateY(0)';
    });
}