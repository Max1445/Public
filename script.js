const canvas = document.getElementById("galaxy");
const ctx = canvas.getContext("2d");

canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

let stars = [];
const numStars = 1000;

// Create stars
for (let i = 0; i < numStars; i++) {
  stars.push({
    angle: Math.random() * Math.PI * 2,
    radius: Math.random() * canvas.width / 2,
    speed: Math.random() * 0.002 + 0.0005,
    size: Math.random() * 2
  });
}

// Animate galaxy
function animate() {
  ctx.fillStyle = "rgba(0, 0, 0, 0.2)";
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  ctx.save();
  ctx.translate(canvas.width / 2, canvas.height / 2);

  stars.forEach(star => {
    star.angle += star.speed;

    const x = Math.cos(star.angle) * star.radius;
    const y = Math.sin(star.angle) * star.radius;

    ctx.beginPath();
    ctx.arc(x, y, star.size, 0, Math.PI * 2);
    ctx.fillStyle = "white";
    ctx.fill();
  });

  ctx.restore();

  requestAnimationFrame(animate);
}

animate();

// Resize fix
window.addEventListener("resize", () => {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
});

// Button interaction
document.getElementById("exploreBtn").addEventListener("click", () => {
  alert("🚀 Welcome to the universe!");
});