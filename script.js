window.onload = function() {
    var userData = {
        deviceId: 'device-' + Date.now(), // Simple unique ID generation
        browser: navigator.userAgent,
        screenSize: `${window.innerWidth} x ${window.innerHeight}`,
        os: navigator.platform
    };

    // Update with API URL if it changes between deployments
    fetch('https://05vc2ysui8.execute-api.us-east-1.amazonaws.com/prod', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(userData),
    })
    .then(response => response.json())
    .then(data => {
        document.getElementById('result').innerText = 'Data sent successfully!';
    })
    .catch((error) => {
        console.error('Error:', error);
        document.getElementById('result').innerText = 'Failed to send data.';
    });
};
