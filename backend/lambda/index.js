const AWS = require('aws-sdk');
const dynamoDB = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
    try {
        // Assuming the body of the request is a JSON string
        const body = JSON.parse(event.body);

        // Replace with DynamoDB table name if it changes
        const tableName = 'DeviceData';

        // Prepare the data for DynamoDB
        // Ensure the keys here match your DynamoDB table's column names
        const item = {
            "DeviceID": body.deviceId, // This should match the primary key in your DynamoDB table
            "Timestamp": new Date().toISOString(),
            "Browser": body.browser,
            "ScreenSize": body.screenSize,
            "OS": body.os
        };

        // Parameters for DynamoDB
        const params = {
            TableName: tableName,
            Item: item
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
        console.error('Error capturing data:', error);

        // Error response
        return {
            statusCode: 500,
            body: JSON.stringify({ message: 'Error capturing data' }),
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*' // Update this for stricter CORS rules
            }
        };
    }
};
