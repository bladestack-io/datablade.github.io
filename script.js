window.onload = function() {
    var userData = {
        deviceId: 'device-' + Date.now(), // Simple unique ID generation
        browser: navigator.userAgent,
        screenSize: `${window.innerWidth} x ${window.innerHeight}`,
        os: navigator.platform
    };

    fetch('https://05vc2ysui8.execute-api.us-east-1.amazonaws.com/prod', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(userData),
    })
    .then(response => {
        // Check if the response is successful
        if (!response.ok) {
            // If not successful, parse and throw the error
            return response.json().then(errorData => {
                throw new Error(`Error from server: ${errorData.error.message}`);
            });
        }
        return response.json();
    })
    .then(data => {
        document.getElementById('result').innerText = 'Data sent successfully!';
    })
    .catch((error) => {
        console.error('Error:', error);
        document.getElementById('result').innerText = `Failed to send data: ${error.message}`;
    });
};
