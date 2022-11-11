# PHP application in ECS demo with New Relic

A simple demo app that can be deployed onto a ECS cluster, with New Relic PHP APM agent installed.
Together with New Relic's Firelens log router, PHP logs (with in-context) can be sent to New Relic for Observability.

## To start
1. Update the Dockerfile and replace `XXX` with your Ingest License Key.
2. Build and push the Docker image to your registry of choice.
3. Set up your ECS cluster, and add New Relic's Firelens log router as part of the Task Definition.
4. Deploy and simulate some activity on the PHP application.