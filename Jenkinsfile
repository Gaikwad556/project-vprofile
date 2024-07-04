pipeline {
    agent any
    tools {
        jdk "jdk11"
        maven "mvn"
    }

    environment {
        registry = 'ssgaikwad/vprofileapp'
        registryCred = 'dockerhub'
    }

    stages {
        stage ("mvn install") {
            steps {
                sh "mvn install"
            }
            post {
                success {
                    sh "echo archiving artifacts"
                    archiveArtifacts artifacts = "**/target/*.war"
                }
            }
        }

        stage ("mvn test") {
            steps {
                sh "mvn test"
            }
        }

        stage ("mvn checkstyle") {
            steps {
                sh " mvn checkstyle:checkstyle"
            }
        }

        stage('SonarQube analysis') {
            environment {
                scannerHome = tool "SonarScanner4"
            }
            steps  {
                    withSonarQubeEnv('sonarqube') { // If you have configured more than one global server connection, you can specify its name
                    sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                    -Dsonar.projectName=vpro-repo \
                    -Dsonar.projectVersion=1.0 \
                    -Dsonar.source=src/ \
                    -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                    -Dsonar.junit.reportsPath=target/surefire-reports/ \
                    -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                    -Dsonar.java.checkstyle.reportsPath=target/checkstyle-result.xml'''
                }
            }
        }

        stage("Quality Gate") {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage("Docker Image") {
            steps {
                script {
                    dockerImage = docker.build registry + ":V$BUILD_NUMBER"
                }
            }
        }

        stage("Upload Image"){
            steps{
                script {
                    docker.withRegistry('', registryCred){
                        dockerImage.push("V$BUILD_NUMBER")
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage("Helm chart") {
            agent {label 'KOPS'}
                steps {
                    sh "helm upgrade --install --force vprofile-stack helm/vprofilecharts --set appimage=${registry}:V${BUILD_NUMBER} --namespace prod"
                }
           
        }
    }
}
