# Pavan Sai Gopinadh Reddy Arimanda G01478272
# Venkat Dinesh Indupuri  G01464737
# Nemali Sudheer Reddy    G01410008
# Datta Naga Vamseedhar Gunnampalli G01478792

# This Dockerfile sets up a Tomcat server with a deployed web application.
# It uses the official Tomcat image, copies the application WAR file,
# and exposes port 8080 for incoming traffic.

FROM tomcat:10.1-jdk17

COPY target/studentsurveyform.war /usr/local/tomcat/webapps

EXPOSE 8080
