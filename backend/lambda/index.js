const AWS = require('aws-sdk');
const dynamoDB = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
    try {
        // Parse the JSON body from the event
        const body = JSON.parse(event.body);

        // Extract device data from the body
        const deviceData = {
            DeviceID: body.deviceId,  // Ensure this ID is unique for each device
            Timestamp: new Date().toISOString(),
            Browser: body.browser,
            ScreenSize: body.screenSize,
            OS: body.os
        };

        // Define parameters for DynamoDB
        const params = {
            TableName: 'DeviceData', // Replace with your DynamoDB table name
            Item: deviceData
        };

        // Store the data in DynamoDB
        await dynamoDB.put(params).promise();

        // Success response
        return {
            statusCode: 200,
            body: JSON.stringify({ message: 'Data captured successfully' }),
            headers: { 'Content-Type': 'application/json' }
        };
    } catch (error) {
        console.error('Error capturing data:', error);

        // Error response
        return {
            statusCode: 500,
            body: JSON.stringify({ message: 'Error capturing data' }),
            headers: { 'Content-Type': 'application/json' }
        };
    }
};
