# Fly volumes.
# - Can only be attached to a single instance
# - tdog writes to db.sqlite, datasette reads from it.
# - These two processes must both belong in the same container instance.
#
# @see https://docs.docker.com/config/containers/multi-service_container/
# @see https://fly.io/docs/app-guides/multiple-processes/

# Create volume.
fly volumes create volume_tdog --region lhr --size 1;

# Upload secrets to Fly.io cloud storage.
# - These are added to the VM instance as environment vars.
flyctl secrets set STRIPE_SECRET_KEY=x;