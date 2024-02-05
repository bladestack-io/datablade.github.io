// Include ua-parser-js to parse the user agent string
var parser = new UAParser();
var result = parser.getResult();

// Prepare userData object with detailed device information
var userData = {
    deviceId: 'device-' + Date.now(), // Generate a unique ID for the device
    browserName: result.browser.name,
    browserVersion: result.browser.version,
    os: result.os.name + ' ' + result.os.version,
    deviceType: result.device.type || 'unknown', // Device type (mobile, tablet, etc.)
    deviceVendor: result.device.vendor || 'unknown', // Device manufacturer
    deviceModel: result.device.model || 'unknown' // Device model
};

// Send the userData object to the backend
fetch('${invoke_url}', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify(userData),
})
.then(response => {
    if (!response.ok) {
        throw new Error('Network response was not ok');
    }
    return response.json();
})
.then(data => {
    console.log('Data sent successfully:', data);
    document.getElementById('result').innerText = 'Data sent successfully!';
})
.catch(error => {
    console.error('Failed to send data:', error);
    document.getElementById('result').innerText = `Failed to send data: $${error.message}`;
});
