# Related Jira task
INIT-6 — Setup load balancing VM infrastructure

INIT-8 — Initial web application setup

## What was done

Created a basic Flask web application structure

Implemented a simple Flask server (app.py) with a root route

Added HTML template (index.html) rendered via Flask

Configured static files handling and added an example image

Added requirements.txt for dependency management

Prepared the project to be runnable on a VM (host 0.0.0.0, port 5000)



## Why it is needed
To have a minimal working web application as a base for further infrastructure setup

To verify that application servers are correctly configured and able to serve HTTP traffic

To prepare the application for future load balancing and deployment steps

To validate VM and networking configuration before adding a load balancer


## Validation

Application was started locally using python app.py

Verified that the Flask server runs without errors

Checked that the main page is accessible in the browser on port 5000

Confirmed that HTML template and static image are rendered correctly
