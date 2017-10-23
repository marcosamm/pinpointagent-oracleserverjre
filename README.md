# pinpointagent-oracleserverjre
Pinpoint Agent and Oracle Server JRE Dockerfile

### To run container
```
docker run -it --rm \
   -e COLLECTOR_IP="192.168.0.18" \
   -p 8080:8080 \
   -v /PATH/TO/YOUR/SPRINGBOOT-APP.jar:/opt/apps/app.jar \
   marcosamm/pinpointagent-oracleserverjre \
   /bin/sh -c "java -javaagent:/opt/pinpoint-agent/pinpoint-bootstrap.jar -Dpinpoint.agentId=YOURAGENTID -Dpinpoint.applicationName=YOURAPPNAME -jar /opt/apps/app.jar"
```

### To access
http://localhost:8080


### Notes
* The following environment variables can be used to set pinpoint-agent configuration properties (pinpoint.config):
   - COLLECTOR_IP
   - PROFILER_APPLICATIONSERVERTYPE
   - PROFILER_TOMCAT_CONDITIONAL_TRANSFORM
   - PROFILER_SAMPLING_RATE
   - PROFILER_INCLUDE
   - PROFILER_ENTRYPOINT
   - PROFILER_JSON_JSONLIB
   - PROFILER_JSON_JACKSON
   - PROFILER_JSON_GSON
* You can map a custom configuration file as a volume with the option: -v /path/to/pinpoint.config:/opt/pinpoint-agent/pinpoint.config:rw
* If the pinpoint.config file is mapped only with read permission (ro), do not use any environment variable to modify pinpoint-agent configuration parameters, this will cause errors.