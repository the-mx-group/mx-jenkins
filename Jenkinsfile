def config = [
    registry = "bf000207-a578-4e38-95b3-8bee5458155b"
    jenkins_version = ""
    tags = []
]

parallel([
    amd64: {
        node('mx-devops && docker && linux && amd64') {
            tags.push(build("amd64", config))
        }
    },
    arm64: {
        node('mx-devops && docker && linux && arm64') {
            tags.push(build("arm64", config))
        }
    }
])

// use tags to build a combined cross-platform manifest 
make_manifest(config)

def build(platform, config) {
    def commit_id
    def app, app_tag

    stage("${platform}: Checkout"){
        checkout scm
        sh "git rev-parse HEAD > .git/commit-id"
        commit_id = readFile(".git/commit-id").trim()
        println "Building commit ${commit_id}"
    }
    stage("${platform}: Get Jenkins version") {
        fromline = readFile("Dockerfile").split("\n")[0]
        config.jenkins_version = fromline.split(":")[1]
        println "Detected Jenkins version: ${config.jenkins_version}"
    }
    stage ("${platform}: Build docker image") {
        app = docker.build("themxgroup/jenkins:latest")
    }
    stage ("${platform}: Push build to dockerhub") {
        docker.withRegistry("", registry) {
            app_tag = "${config.jenkins_version}-${platform}"
            app.push("latest-${platform}")
            app.push(app_tag)
            config.tags.push(app_tag)
        }
    }
}

def make_manifest(config) {
    node('mx-devops && docker && linux && arm64') {
        stage("Create manifest") {
            sh "docker buildx imagetools create -t themxgroup/jenkins:${config.jenkins_version} ${config.tags.join(' ')}"
            sh "docker buildx imagetools create -t themxgroup/jenkins:latest ${config.tags.join(' ')}"
            // sh "docker manifest push themxgroup/jenkins:${config.jenkins_version}"
        }
    }
}