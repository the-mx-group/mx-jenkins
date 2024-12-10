def tags = []
parallel([
    amd64: {
        node('mx-devops && docker && linux && amd64') {
            tags.push(build("amd64"))
        }
    },
    arm64: {
        node('mx-devops && docker && linux && arm64') {
            tags.push(build("arm64"))
        }
    }
])

// TODO: use tags to build a combined cross-platform manifest 

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
            app.push("latest-${platform}")
            app.push("${jenkins_version}-${platform}")
        }
    }
}
