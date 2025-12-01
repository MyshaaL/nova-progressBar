let progressInterval = null;

window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.action === 'showProgress') {
        showProgress(data.duration, data.label, data.canCancel);
    } else if (data.action === 'hideProgress') {
        hideProgress();
    }
});

function showProgress(duration, label, canCancel) {
    // Clear any existing progress
    hideProgress();

    const container = document.getElementById('progress-container');
    const labelElement = container.querySelector('.progress-label');
    const fillElement = container.querySelector('.progress-bar-fill');
    const cancelHint = container.querySelector('.progress-cancel-hint');

    // Set label
    labelElement.textContent = label;

    // Show/hide cancel hint
    if (canCancel) {
        cancelHint.classList.remove('hidden');
    } else {
        cancelHint.classList.add('hidden');
    }

    // Show container
    container.classList.remove('hidden');

    // Reset fill
    fillElement.style.width = '0%';
    fillElement.classList.add('pulse');

    // Animate progress
    const startTime = Date.now();
    const updateInterval = 50; // Update every 50ms for smooth animation

    progressInterval = setInterval(() => {
        const elapsed = Date.now() - startTime;
        const progress = Math.min((elapsed / duration) * 100, 100);

        fillElement.style.width = progress + '%';

        if (progress >= 100) {
            clearInterval(progressInterval);
            progressInterval = null;
            
            // Auto hide after completion
            setTimeout(() => {
                hideProgress();
            }, 300);
        }
    }, updateInterval);
}

function hideProgress() {
    if (progressInterval) {
        clearInterval(progressInterval);
        progressInterval = null;
    }

    const container = document.getElementById('progress-container');
    const fillElement = container.querySelector('.progress-bar-fill');

    fillElement.classList.remove('pulse');
    container.classList.add('hidden');

    // Reset fill
    setTimeout(() => {
        fillElement.style.width = '0%';
    }, 300);
}
