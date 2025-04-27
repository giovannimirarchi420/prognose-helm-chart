# Resource Management Helm Chart

This Helm chart deploys a resource management application consisting of a backend service, frontend service, and an event processor service. 

## Chart Structure

The chart includes the following files:

- **Chart.yaml**: Contains metadata about the Helm chart, including the chart name, version, and description.
- **values.yaml**: Defines the default configuration values for the chart. Users can override these values when installing the chart.
- **templates/**: Contains the Kubernetes resource templates for the application:
  - **be-configmap.yaml**: ConfigMap for the backend service.
  - **be-deployment.yaml**: Deployment resource for the backend service.
  - **be-ingress.yaml**: Ingress resource for the backend service.
  - **be-secret.yaml**: Secret resource for sensitive information related to the backend service.
  - **be-service.yaml**: Service resource for the backend service.
  - **event-processor-configmap.yaml**: ConfigMap for the event processor service.
  - **event-processor-deployment.yaml**: Deployment resource for the event processor service.
  - **event-processor-secret.yaml**: Secret resource for sensitive information related to the event processor service.
  - **fe-configmap.yaml**: ConfigMap for the frontend service.
  - **fe-deployment.yaml**: Deployment resource for the frontend service.
  - **fe-ingress.yaml**: Ingress resource for the frontend service.
  - **fe-service.yaml**: Service resource for the frontend service.
- **NOTES.txt**: Notes displayed to the user after the chart is installed.
- **_helpers.tpl**: Helper templates that can be reused throughout the other template files.

## Installation Instructions

To install the chart, use the following command:

```bash
helm install <release-name> ./resource-management-chart
```

Replace `<release-name>` with your desired release name.

## Usage Examples

After installation, you can access the backend service, frontend service, and event processor service using the defined Ingress resources. Make sure to configure your DNS settings to point to the Ingress controller's external IP.

## Configuration

You can customize the deployment by modifying the `values.yaml` file. This file contains all the configurable parameters for the chart.

## License

This project is licensed under the MIT License.