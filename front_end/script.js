window.onload = function() {
    var userData = {
        browser: navigator.userAgent,
        screenSize: `${window.innerWidth} x ${window.innerHeight}`,
        os: navigator.platform
    };

    displayData(userData);
};

function displayData(data) {
    var infoDiv = document.getElementById('info');
    infoDiv.innerHTML = `<p><strong>Browser (User Agent):</strong> ${data.browser}</p>
                         <p><strong>Screen Size:</strong> ${data.screenSize}</p>
                         <p><strong>Operating System:</strong> ${data.os}</p>`;
}