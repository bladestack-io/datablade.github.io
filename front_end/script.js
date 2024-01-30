window.onload = function() {
    var userData = {
        deviceId: 'some-unique-device-id', // Generate or define a unique ID
        browser: navigator.userAgent,
        screenSize: `${window.innerWidth} x ${window.innerHeight}`,
        os: navigator.platform
    };

    fetch('https://55zyxaaql6.execute-api.us-east-1.amazonaws.com/prod', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(userData),
    })
    .then(response => response.json())
    .then(data => console.log('Data sent successfully:', data))
    .catch((error) => console.error('Error:', error));
};
