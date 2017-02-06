node {
    stage 'Build'
       echo 'Hello World 1'
    stage 'Stage 2'
      def tfHome = tool name: 'Terraform', type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
    env.PATH = "${tfHome}:${env.PATH}"
      sh "terraform --version"
    stage 'Stage 3'
       echo 'Hello World 3'
    stage 'Stage 4'
       echo 'Hello World 4'
}
