#Pavan Sai Gopinadh Reddy Arimanda G01478272
#Venkat Dinesh Indupuri  
#Nemali Sudheer Reddy
#Datta Naga Vamseedhar Gunnampalli

# This Dockerfile sets up a Tomcat server with a deployed web application.
# It uses the official Tomcat image, copies the application WAR file,
# and exposes port 8080 for incoming traffic.

FROM tomcat:10.1-jdk17

COPY target/studentsurveyform.war /usr/local/tomcat/webapps

EXPOSE 8080
