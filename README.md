# Prognose Helm Chart

This Helm chart deploys a resource management application consisting of a backend service, frontend service, and an event processor service. It also provides the option to deploy a PostgreSQL database instance alongside the application or connect to an external database (PostgreSQL or Oracle).

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
  - **postgres-configmap.yaml**: ConfigMap for the internal PostgreSQL service (if enabled).
  - **postgres-deployment.yaml**: Deployment resource for the internal PostgreSQL service (if enabled).
  - **postgres-pvc.yaml**: PersistentVolumeClaim for the internal PostgreSQL service (if enabled and persistence is enabled).
  - **postgres-secret.yaml**: Secret resource for the internal PostgreSQL service (if enabled).
  - **postgres-service.yaml**: Service resource for the internal PostgreSQL service (if enabled).
- **NOTES.txt**: Notes displayed to the user after the chart is installed.
- **_helpers.tpl**: Helper templates that can be reused throughout the other template files.

## Installation Instructions

To install the chart, use the following command:

```bash
helm install <release-name> ./prognose-helm-chart
```

Replace `<release-name>` with your desired release name.

## Configuration

You can customize the deployment by modifying the `values.yaml` file or by providing your own values file during installation (`helm install -f my-values.yaml ...`). This file contains all the configurable parameters for the chart.

Key configuration sections in `values.yaml`:

*   **`app`**: Application name.
*   **`namespace`**: Target namespace for deployment.
*   **`be` (Backend)**:
    *   `replicaCount`: Number of backend pods.
    *   `image`: Backend container image repository and tag.
        *   **Important**: Use the image tag ending in `-postgres` if using PostgreSQL (either internal or external). Use the tag ending in `-oracle` if using an external Oracle database.
    *   `containerPort`: Port the backend container listens on.
    *   `config`: Backend application configuration.
        *   `dbUrl`: **Required only if `postgresql.enabled` is `false`**. The JDBC URL for the external database.
        *   `keycloakAuthServerUrl`: URL of the Keycloak authentication server.
        *   `keycloakRealm`: Keycloak realm name.
    *   `secrets`: Base64 encoded secrets for the backend.
        *   `dbUser`, `dbPassword`: **Required only if `postgresql.enabled` is `false`**. Credentials for the external database.
        *   `keycloakClientSecret`: Keycloak client secret.
        *   `keycloakAdminUser`, `keycloakAdminPassword`: Keycloak admin credentials.
    *   `ingress`: Ingress configuration (host, path).
    *   `resources`: CPU/Memory resource limits and requests.
*   **`fe` (Frontend)**:
    *   `replicaCount`: Number of frontend pods.
    *   `image`: Frontend container image repository and tag.
    *   `config`: Frontend application configuration.
        *   `keycloakClientId`: Keycloak client ID for frontend authentication.
        *   `documentationUrl`: URL for the official documentation. Leave empty to hide the documentation menu item in the application.
    *   `ingress`: Ingress configuration (host).
    *   `resources`: CPU/Memory resource limits and requests.
*   **`eventProcessor`**:
    *   `replicaCount`: Number of event processor pods.
    *   `image`: Event processor container image repository and tag.
        *   **Important**: Use the image tag ending in `-postgres` if using PostgreSQL (either internal or external).
    *   `containerPort`: Port the event processor container listens on.
    *   `resources`: CPU/Memory resource limits and requests.
*   **`postgresql`**:
    *   `enabled`: Set to `true` to deploy a PostgreSQL instance within the cluster using this chart. Set to `false` to use an external database.
    *   `image`: PostgreSQL container image repository and tag.
    *   `auth`: Credentials for the internal PostgreSQL instance (used if `enabled: true`).
        *   `username`, `password`: Base64 encoded database credentials.
        *   `database`: Name of the database to create.
    *   `persistence`: Configuration for PostgreSQL data persistence (PVC).
        *   `enabled`: Enable/disable persistent volume.
        *   `storageClass`: Storage class for the PVC.
        *   `size`: Size of the PVC.

### Database Configuration Examples

**1. Deploying with Internal PostgreSQL:**

Set `postgresql.enabled: true`. Configure `postgresql.auth` with the desired base64 encoded username and password. Ensure the `be.image.tag` and `eventProcessor.image.tag` end with `-postgres`. Do **not** set `be.config.dbUrl`, `be.secrets.dbUser`, or `be.secrets.dbPassword`.

**2. Using an External PostgreSQL Database:**

Set `postgresql.enabled: false`. Provide the external database connection details:
*   `be.config.dbUrl`: e.g., `jdbc:postgresql://your-external-postgres-host:5432/your-db`
*   `be.secrets.dbUser`: Base64 encoded username.
*   `be.secrets.dbPassword`: Base64 encoded password.
Ensure the `be.image.tag` and `eventProcessor.image.tag` end with `-postgres`.

**3. Using an External Oracle Database:**

Set `postgresql.enabled: false`. Provide the external database connection details:
*   `be.config.dbUrl`: e.g., `jdbc:oracle:thin:@//your-external-oracle-host:1521/your-service-name`
*   `be.secrets.dbUser`: Base64 encoded username.
*   `be.secrets.dbPassword`: Base64 encoded password.
Ensure the `be.image.tag` ends with `-oracle`. (Note: The event processor might not support Oracle, check its documentation).

## Usage Examples

After installation, you can access the backend service, frontend service, and event processor service using the defined Ingress resources. Make sure to configure your DNS settings to point to the Ingress controller's external IP.

## License

This project is licensed under the MIT License.
