// =============================================
// NEO PORTFOLIO - Blood Particle System
// Dark Fantasy AAA Effects
// =============================================

class BloodParticleSystem {
    constructor() {
        this.canvas = document.getElementById('particleCanvas');
        if (!this.canvas) {
            this.canvas = document.createElement('canvas');
            this.canvas.id = 'particleCanvas';
            document.body.appendChild(this.canvas);
        }
        this.ctx = this.canvas.getContext('2d');
        this.particles = [];
        this.lines = [];
        this.maxParticles = 100;
        this.maxLines = 30;
        this.mouseX = 0;
        this.mouseY = 0;
        
        this.init();
    }
    
    init() {
        this.resize();
        this.createParticles();
        this.createLines();
        this.bindEvents();
        this.animate();
    }
    
    resize() {
        this.canvas.width = window.innerWidth;
        this.canvas.height = window.innerHeight;
    }
    
    createParticles() {
        for (let i = 0; i < this.maxParticles; i++) {
            this.particles.push({
                x: Math.random() * this.canvas.width,
                y: Math.random() * this.canvas.height,
                radius: Math.random() * 3 + 1,
                speedX: (Math.random() - 0.5) * 0.5,
                speedY: (Math.random() - 0.5) * 0.5,
                opacity: Math.random() * 0.5 + 0.2,
                pulse: Math.random() * Math.PI * 2,
                color: this.getBloodColor()
            });
        }
    }
    
    getBloodColor() {
        const colors = [
            '255, 0, 0',      // Pure blood
            '204, 17, 17',    // Infernal red
            '139, 0, 0',      // Dark blood
            '180, 0, 0',      // Deep red
            '220, 20, 20'     // Bright blood
        ];
        return colors[Math.floor(Math.random() * colors.length)];
    }
    
    createLines() {
        for (let i = 0; i < this.maxLines; i++) {
            this.lines.push({
                points: this.generateLinePoints(),
                opacity: Math.random() * 0.3 + 0.1,
                speed: Math.random() * 0.2 + 0.1
            });
        }
    }
    
    generateLinePoints() {
        const points = [];
        const numPoints = Math.floor(Math.random() * 5) + 3;
        let x = Math.random() * this.canvas.width;
        let y = Math.random() * this.canvas.height;
        
        for (let i = 0; i < numPoints; i++) {
            points.push({ x, y });
            x += (Math.random() - 0.5) * 200;
            y += (Math.random() - 0.5) * 200;
        }
        
        return points;
    }
    
    bindEvents() {
        window.addEventListener('resize', () => this.resize());
        document.addEventListener('mousemove', (e) => {
            this.mouseX = e.clientX;
            this.mouseY = e.clientY;
        });
    }
    
    animate() {
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
        
        // Draw particles
        this.particles.forEach(particle => {
            particle.pulse += 0.02;
            const pulseSize = Math.sin(particle.pulse) * 0.5 + 1;
            
            this.ctx.beginPath();
            this.ctx.arc(particle.x, particle.y, particle.radius * pulseSize, 0, Math.PI * 2);
            this.ctx.fillStyle = `rgba(${particle.color}, ${particle.opacity})`;
            this.ctx.fill();
            
            // Glow effect
            this.ctx.beginPath();
            this.ctx.arc(particle.x, particle.y, particle.radius * pulseSize * 2, 0, Math.PI * 2);
            this.ctx.fillStyle = `rgba(${particle.color}, ${particle.opacity * 0.2})`;
            this.ctx.fill();
            
            // Move particles
            particle.x += particle.speedX;
            particle.y += particle.speedY;
            
            // Mouse interaction
            const dx = particle.x - this.mouseX;
            const dy = particle.y - this.mouseY;
            const distance = Math.sqrt(dx * dx + dy * dy);
            
            if (distance < 150) {
                particle.x += dx * 0.01;
                particle.y += dy * 0.01;
            }
            
            // Wrap around screen
            if (particle.x < -10) particle.x = this.canvas.width + 10;
            if (particle.x > this.canvas.width + 10) particle.x = -10;
            if (particle.y < -10) particle.y = this.canvas.height + 10;
            if (particle.y > this.canvas.height + 10) particle.y = -10;
        });
        
        // Draw connected lines
        this.lines.forEach(line => {
            this.ctx.beginPath();
            this.ctx.moveTo(line.points[0].x, line.points[0].y);
            
            for (let i = 1; i < line.points.length; i++) {
                const xc = (line.points[i].x + line.points[i - 1].x) / 2;
                const yc = (line.points[i].y + line.points[i - 1].y) / 2;
                this.ctx.quadraticCurveTo(line.points[i - 1].x, line.points[i - 1].y, xc, yc);
            }
            
            this.ctx.strokeStyle = `rgba(255, 0, 0, ${line.opacity})`;
            this.ctx.lineWidth = 1;
            this.ctx.shadowColor = 'rgba(255, 0, 0, 0.5)';
            this.ctx.shadowBlur = 10;
            this.ctx.stroke();
            
            // Animate lines
            line.points.forEach(point => {
                point.y += line.speed;
                if (point.y > this.canvas.height + 50) {
                    point.y = -50;
                }
            });
        });
        
        // Draw ambient fog
        const gradient = this.ctx.createRadialGradient(
            this.canvas.width / 2, this.canvas.height / 2, 0,
            this.canvas.width / 2, this.canvas.height / 2, this.canvas.width / 2
        );
        gradient.addColorStop(0, 'rgba(0, 0, 0, 0)');
        gradient.addColorStop(0.5, 'rgba(139, 0, 0, 0.02)');
        gradient.addColorStop(1, 'rgba(0, 0, 0, 0.8)');
        
        this.ctx.fillStyle = gradient;
        this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
        
        requestAnimationFrame(() => this.animate());
    }
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    new BloodParticleSystem();
});