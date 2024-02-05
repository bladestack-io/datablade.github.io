const AWS = require('aws-sdk');
const dynamoDB = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
    try {
        // Assuming the body of the request is a JSON string
        const body = JSON.parse(event.body);

        const params = {
            TableName: 'DeviceData', // Update DynamoDB table name if it changes
            Item: {
                DeviceID: body.deviceId, // Use the unique deviceId as the primary key
                BrowserName: body.browserName,
                BrowserVersion: body.browserVersion,
                OS: body.os,
                DeviceType: body.deviceType,
                DeviceVendor: body.deviceVendor,
                DeviceModel: body.deviceModel,
                Timestamp: new Date().toISOString() // Add a timestamp for when the data was inserted
            }
        };

        // Write to DynamoDB
        await dynamoDB.put(params).promise();

        // Successful response
        return {
            statusCode: 200,
            body: JSON.stringify({ message: 'Data captured successfully' }),
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*' // Update this for stricter CORS rules
            }
        };
    } catch (error) {
        console.error('Error:', error);

        // Detailed error response
        return {
            statusCode: 500,
            body: JSON.stringify({
                message: 'Error capturing data',
                error: {
                    name: error.name,
                    message: error.message,
                    stack: error.stack
                }
            }),
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*' // Adjust for production
            }
        };
    }
};
