# DESCRIPTION       Pinpoint APM Agent + oracleserverjre
# TO_BUILD          docker build -t pinpoint-agent .
# TO_RUN            docker run --name=pinpoint-agent pinpoint-agent
# or
# TO_RUN            docker run -it \
#                       -e COLLECTOR_IP="192.168.0.18" \
#                       -e PROFILER_APPLICATIONSERVERTYPE="TOMCAT" \
#                       -e PROFILER_TOMCAT_CONDITIONAL_TRANSFORM="false" \
#                       -e PROFILER_SAMPLING_RATE="1" \
#                       -e PROFILER_JSON_JSONLIB="true" \
#                       -e PROFILER_JSON_JACKSON="true"\
#                       -e PROFILER_JSON_GSON="true" \
#                       pinpoint-agent

FROM persapiens/oracleserverjre:8u152
MAINTAINER Marcos Alexandre de Melo Medeiros <marcosamm@gmail.com>

ENV PINPOINT_VERSION 1.6.2
ENV PINPOINT_AGENT_HOME /opt/pinpoint-agent

# update and upgrade
RUN apt-get update -qqy && \
    apt-get upgrade -qqy --no-install-recommends

ADD https://github.com/naver/pinpoint/releases/download/$PINPOINT_VERSION/pinpoint-agent-$PINPOINT_VERSION.tar.gz /tmp
RUN mkdir -p $PINPOINT_AGENT_HOME \
    && tar -xzvf /tmp/pinpoint-agent-$PINPOINT_VERSION.tar.gz -C $PINPOINT_AGENT_HOME \
    && rm /tmp/pinpoint-agent-$PINPOINT_VERSION.tar.gz \
    && cd $PINPOINT_AGENT_HOME \
    && mv pinpoint-bootstrap-$PINPOINT_VERSION.jar pinpoint-bootstrap.jar

# clean temporary files
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*

ADD https://raw.githubusercontent.com/marcosamm/docker-pinpoint/master/pinpoint-agent/configure-agent.sh /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/configure-agent.sh"]
ENTRYPOINT ["/usr/local/bin/configure-agent.sh"]
CMD ["bash"]