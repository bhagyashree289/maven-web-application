node {
    
    echo "Jenkins Home dir is : ${env.JENKINS_HOME}"
    echo "Job url is : ${env.JOB_URL}"
    echo "Build number is : ${env.BUILD_NUMBER}"
    
    properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '2', daysToKeepStr: '', numToKeepStr: '5')), [$class: 'JobLocalConfiguration', changeReasonComment: ''], pipelineTriggers([pollSCM('* * * * *')])])
    
    def mavenHome = tool name : 'maven3.9.4'
    
    stage('CheckoutCode'){
        git branch: 'development', credentialsId: 'b2d56741-633f-424b-93fc-de56ac05f0ea', url: 'https://github.com/bhagyashree289/maven-web-application.git'
    }
    stage('Build'){
        sh "${mavenHome}/bin/mvn clean package"
    }
    stage('ExecuteSonarqubeReport'){
        sh "${mavenHome}/bin/mvn clean sonar:sonar"
    }
    stage('UplodArtifactToNexus'){
        sh "${mavenHome}/bin/mvn clean deploy"
    }
    stage('DeployAppIntoTomcatServer'){
        sshagent(['2e70d25f-12f4-49d0-87c8-ffdf688477b1']) {
        sh "scp -o  StrictHostKeyChecking=no target/maven-web-application.war ec2-user@172.31.46.222:/opt/apache-tomcat-9.0.80/webapps"
    }
    
    }
}
