node('docker && linux') {

    def commit_id
	def jenkins_version
    def app, app_tag

    stage('Checkout'){
        checkout scm
        sh "git rev-parse HEAD > .git/commit-id"
        commit_id = readFile(".git/commit-id").trim()
        println "Building commit ${commit_id}"
    }
	stage('Get Jenkins version') {
		fromline = readFile("Dockerfile").split("\n")[0]
		jenkins_version = fromline.split(":")[1]
		println "Detected Jenkins version: ${jenkins_version}"
	}
    stage ('Build docker image') {
        app = docker.build("themxgroup/jenkins:latest")
    }
    stage ('Push build to dockerhub') {
        docker.withRegistry("", "bf000207-a578-4e38-95b3-8bee5458155b") {
            app.push('latest')
            app.push(jenkins_version)
        }
    }
}