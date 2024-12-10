def registry = "bf000207-a578-4e38-95b3-8bee5458155b"
def tags = []
def jenkins_version

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

// use tags to build a combined cross-platform manifest 
make_manifest(jenkins_version, tags)

def build(platform) {
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
        jenkins_version = fromline.split(":")[1]
        println "Detected Jenkins version: ${jenkins_version}"
    }
    stage ("${platform}: Build docker image") {
        app = docker.build("themxgroup/jenkins:latest")
    }
    stage ("${platform}: Push build to dockerhub") {
        docker.withRegistry("", registry) {
            app_tag = "${jenkins_version}-${platform}"
            app.push("latest-${platform}")
            app.push(app_tag)
        }
    }
    return app_tag
}

def make_manifest(version, tags) {
    node('mx-devops && docker && linux && arm64') {
        stage("Create manifest") {
            sh "docker buildx imagetools create -t themxgroup/jenkins:${version} ${tags.join(' ')}"
            sh "docker buildx imagetools create -t themxgroup/jenkins:latest ${tags.join(' ')}"
            // sh "docker manifest push themxgroup/jenkins:${version}"
        }
    }
}