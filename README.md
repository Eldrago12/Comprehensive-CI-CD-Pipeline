# CI/CD Pipeline with Jenkins, Maven, Git, SonarQube, Ansible, AWS ECR, LoadBalancer, Prometheus, Grafana, and Terraform

## Overview

This project demonstrates a robust Continuous Integration and Continuous Deployment (CI/CD) pipeline using various tools and technologies. The pipeline automates the building, testing, and deployment process, ensuring a streamlined and efficient software delivery lifecycle. The following components are integrated into the pipeline:

- Jenkins
- Maven
- Git
- SonarQube
- Ansible
- AWS ECR (Elastic Container Registry)
- AWS Load Balancer
- Prometheus
- Grafana
- Terraform

## Project Structure

The project is organized into the following directories:

- **jenkins/:** Contains Jenkins configuration files and scripts.
- **ansible/:** Includes Ansible playbooks for configuration management.
- **terraform/:** Consists of Terraform configurations for AWS infrastructure.
- **app/:** The application source code.
- **docker/:** Dockerfile for building the application image.

## CI/CD Pipeline Steps

1. **Source Code Management:**
   - The project uses Git for version control.

2. **Continuous Integration with Jenkins:**
   - Jenkins is configured to trigger a build on every code commit.
   - Maven is used to build the application.

3. **Static Code Analysis with SonarQube:**
   - SonarQube is integrated to perform static code analysis and provide insights into code quality.

4. **Docker Image Creation and Push to ECR:**
   - The application is containerized using Docker.
   - The Docker image is built and pushed to AWS ECR for versioned storage.

5. **Infrastructure as Code with Terraform:**
   - Terraform is used to provision and manage AWS infrastructure.

6. **Deployment with Ansible:**
   - Ansible playbooks are used for configuring and deploying the application on AWS instances.

7. **Load Balancer Configuration:**
   - AWS Load Balancer is set up to distribute incoming traffic among multiple instances.

8. **Monitoring with Prometheus and Grafana:**
   - Prometheus is used to collect metrics and monitor the application.
   - Grafana provides a graphical representation of the collected metrics.

## Getting Started

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/Eldrago12/Comprehensive-CI-CD-Pipeline.git
   cd Comprehensive-CI-CD-Pipeline
   ```

2. **Configure Jenkins:**
   - Set up Jenkins with the necessary plugins (Git, Maven, AWS, etc.).
   - Create Jenkins pipelines based on the scripts in the `jenkins/` directory.

3. **Configure AWS Credentials:**
   - Set up AWS credentials in Jenkins for Terraform and AWS ECR.

4. **Configure Ansible:**
   - Update Ansible playbooks in the `ansible/` directory with your application-specific configurations.

5. **Configure Terraform:**
   - Update Terraform configurations in the `terraform/` directory with your AWS-specific configurations.

6. **Build and Run:**
   - Trigger the Jenkins pipeline, and the CI/CD process will be initiated.

## Monitoring the Application

1. Access Grafana:
   - Visit the Grafana dashboard to monitor application metrics.

2. Prometheus Setup:
   - Prometheus should be configured to scrape metrics from the deployed application.

## Contributing

Feel free to contribute to this project by submitting issues or pull requests. Your feedback and contributions are highly appreciated.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
