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


// Display the captured information on the web page
document.getElementById('capturedData').innerHTML = `
    <p><strong>Device ID:</strong> ${userData.deviceId}</p>
    <p><strong>Browser Name:</strong> ${userData.browserName}</p>
    <p><strong>Browser Version:</strong> ${userData.browserVersion}</p>
    <p><strong>OS:</strong> ${userData.os}</p>
    <p><strong>Device Type:</strong> ${userData.deviceType}</p>
    <p><strong>Device Vendor:</strong> ${userData.deviceVendor}</p>
    <p><strong>Device Model:</strong> ${userData.deviceModel}</p>
`;

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

