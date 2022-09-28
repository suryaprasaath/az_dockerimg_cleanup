# az_dockerimg_cleanup


## Azure Docker image cleanup (image_cleanup.sh)

Arguments
- Registry
- Repository
- Prefix of the image tag (eg: v1.2)
- Threshold image count (eg: 5 It leaves out latest five images that contains the tag starts with v1.2 and deletes the rest of the tag that start with v1.2)


## Workflow (az_dockerimg_cleanup_schedule.yml)

Schedule for cleanup at 9:00AM(IST) on every day-of-week from Monday through Friday
