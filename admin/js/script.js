// FILE: FRONTEND/admin/js/script.js
document.addEventListener("DOMContentLoaded", function () {

    // 1. TOGGLE SIDEBAR (Ẩn hiện menu trái)
    const menuToggle = document.getElementById('menu-toggle');
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.getElementById('mainContent');

    if (menuToggle && sidebar && mainContent) {
        menuToggle.addEventListener('click', () => {
            // Thêm/Bỏ class 'active' cho cả Sidebar và Main Content cùng lúc
            sidebar.classList.toggle('active');
            mainContent.classList.toggle('active');
        });
    }

    // 2. VẼ BIỂU ĐỒ (CHART.JS)
    const revenueCanvas = document.getElementById('revenueChart');
    const categoryCanvas = document.getElementById('categoryChart');

    if (revenueCanvas && typeof Chart !== 'undefined') {
        const ctx1 = revenueCanvas.getContext('2d');
        const gradient = ctx1.createLinearGradient(0, 0, 0, 400);
        gradient.addColorStop(0, 'rgba(238, 77, 45, 0.5)'); 
        gradient.addColorStop(1, 'rgba(238, 77, 45, 0)');

        new Chart(ctx1, {
            type: 'line',
            data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
                datasets: [{
                    label: 'Doanh thu (Triệu VNĐ)',
                    data: [50, 65, 60, 120, 85, 90, 150, 180, 140, 200, 250, 300],
                    borderColor: '#ee4d2d',
                    backgroundColor: gradient,
                    borderWidth: 2,
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, grid: { borderDash: [2, 4] } },
                    x: { grid: { display: false } }
                }
            }
        });
    }

    if (categoryCanvas && typeof Chart !== 'undefined') {
        const ctx2 = categoryCanvas.getContext('2d');
        new Chart(ctx2, {
            type: 'doughnut',
            data: {
                labels: ['Áo', 'Quần', 'Phụ kiện', 'Giày dép'],
                datasets: [{
                    data: [45, 30, 15, 10],
                    backgroundColor: ['#20262e', '#ee4d2d', '#ffc107', '#6c757d'],
                    borderWidth: 0,
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { position: 'bottom', labels: { usePointStyle: true, padding: 20 } }
                },
                cutout: '75%',
            }
        });
    }
});