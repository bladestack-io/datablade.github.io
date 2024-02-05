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

// Testing: Log the captured information to the console
// TODO: Remove this logging after verification
console.log('Captured user data:', userData);

// The following part is where you would send userData to your backend.
// Temporarily commented out for testing. Uncomment to enable.
/*
fetch('YOUR_API_GATEWAY_ENDPOINT', {
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
    document.getElementById('result').innerText = `Failed to send data: ${error.message}`;
});
*/

