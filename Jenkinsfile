pipeline {
    agent any
    tools {
        jdk "jdk11"
        maven "mvn"
    }
    environment {
        docker_hub_cred='dockercred'
        docker_image="ssgaikwad/vprotomcatapp"
        awscred='ecr:us-west-1:awscreds'
        registry_url='891377177922.dkr.ecr.us-west-1.amazonaws.com/ssgaikwad/vprotomcatapp'
        vprofile_url_registry='https://891377177922.dkr.ecr.us-west-1.amazonaws.com'
    }
    
    stages{
        stage ("git"){
            steps {
                git branch: 'main',url: 'https://github.com/Gaikwad556/project-vprofile.git'
            }
        }

        stage ("maven test") {
            steps {
                sh "mvn test"
            }
        }
        stage ("maven checkstyle") {
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
        }

        stage('SonarQube analysis') {
            environment {
                scannerHome= tool 'sonar4.7'
            }
            steps {
                withSonarQubeEnv('sonar') { // If you have configured more than one global server connection, you can specify its name
                    sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                    -Dsonar.projectName=vpro-repo \
                    -Dsonar.projectVersion=1.0 \
                    -Dsonar.sources=src \
                    -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                    -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                    -Dsonar.java.checkstyle.reportsPath=target/checkstyle-result.xml \
                    -Dsonar.junit.reportsPath=target/surefire-reports/'''
                }
            }          
        }

        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'MINUTES') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage ("image build") {
            steps {
                script {
                    dockerImage = docker.build("${docker_image}:${BUILD_NUMBER}")
                }
            }
        }
        
        // stage ("Push image to docker") {
        //     steps {
        //         script {
        //             docker.withRegistry('',docker_hub_cred) {
        //                 dockerImage.push("$BUILD_NUMBER")
        //                 dockerImage.push("latest")
        //             }
        //         }
        //     }
        // } 

        stage ("Push image to ecr") {
            steps {
                script {
                    docker.withRegistry(vprofile_url_registry,awscred) {
                        dockerImage.push("$BUILD_NUMBER")
                        dockerImage.push("latest")
                    }
                }
            }
        } 

        stage ("Deploy application to kubernetes using helm") {
            agent { label 'KOPS'}
            steps {
                sh "helm upgrade --install --force vprofile-stack helm/vprofilecharts --namespace prod --set appimage=${registry_url}:${BUILD_NUMBER}"
            }
        }           
    }
}
