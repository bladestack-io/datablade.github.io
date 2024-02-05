# Device Data Capture Project
This project is designed to capture detailed device information (such as device type, OS, browser version, etc.) from users visiting a web page hosted on GitHub Pages (datablade.github.io). The captured data is sent to an AWS DynamoDB table via AWS Lambda and API Gateway.

# Viewing the Web Page
The web page is hosted by GitHub pages. You can directly visit this URL or scan the provided QR code to access it from a mobile device.

URL - https://bladestack-io.github.io/datablade.github.io/

<img src="images/datablade_qr_code.png" width="200" height="200" alt="QR Code">

# Architecture
**Frontend:** A static web page hosted on GitHub Pages that captures device information using JavaScript.  
**Backend:** Comprises AWS Lambda for request processing, API Gateway as the HTTP endpoint, and DynamoDB for storing the captured data.

## Technologies Used
- HTML/CSS/JavaScript for the frontend.
- AWS Lambda, AWS API Gateway, and AWS DynamoDB for the backend.
- Terraform for infrastructure as code.
- GitHub Actions for CI/CD.

# Deployment Instructions

## Prerequisites
- An AWS account.
- Terraform installed on your local machine.
- Node.js and npm installed (for any local JavaScript development).
- Configured AWS CLI or exported AWS credentials as environment variables.

## Deploy Backend Infrastructure with Terraform
Navigate to the backend directory containing the Terraform configuration files.

```
$ cd backend
```

## Initialize Terraform and apply the configuration:
```
terraform init
terraform apply
```

## Update Frontend Configuration
After deploying your backend, Terraform will output a file in the root directory named `script.js`` the invoke URL populated. This is to ensure the frontend communicates with the correct backend endpoint.

## Push Updates to GitHub
Commit the updated script.js file and push it to the `datablade.github.io` repository to kick off GitHub Actions:

```
git add script.js
git commit -m "Update API Gateway invoke URL"
git push origin main
```

**GitHub Actions will automatically deploy your changes to GitHub Pages**

## Cleaning Up AWS Resources
To avoid unnecessary charges, remember to destroy the AWS resources when they are no longer needed:
```
terraform destroy
```

# Repository Structure
- The backend directory contains all Terraform configuration files for setting up AWS resources.
- The root directory hosts the frontend code, including index.html, style.css, and the generated script.js.

# Contributing
Feel free to fork the repository and submit pull requests with any enhancements or fixes.