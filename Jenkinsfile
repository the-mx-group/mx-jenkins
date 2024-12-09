parallel([
    amd64: {
        node('mx && docker && linux && amd64') {
            build("amd64")
        }
    },
    arm64: {
        node('mx && docker && linux && arm64') {
            build("arm64")
        }
    }
])

def build(platform) {
    def commit_id
    def jenkins_version
    def app, app_tag

    stage("${platform}: Checkout"){
        checkout scm
        sh "git rev-parse HEAD > .git/commit-id"
        commit_id = readFile(".git/commit-id").trim()
        println "Building commit ${commit_id}"
    }
    stage("${platform}: Get Jenkins version") {
        fromline = readFile("Dockerfile").split("\n")[0]
        jenkins_version = fromline.split(":")[1]
        println "Detected Jenkins version: ${jenkins_version}"
    }
    stage ("${platform}: Build docker image") {
        app = docker.build("themxgroup/jenkins:latest")
    }
    stage ("${platform}: Push build to dockerhub") {
        docker.withRegistry("", "bf000207-a578-4e38-95b3-8bee5458155b") {
            app.push('latest')
            app.push(jenkins_version)
        }
    }
}