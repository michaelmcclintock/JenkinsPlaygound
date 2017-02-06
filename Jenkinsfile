node {
    stage 'Build'
       echo 'Hello World 1'
    stage 'Stage 2'
      def tfHome = tool name: 'Terraform', type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
   env.PATH = "${tfHome}:${env.PATH}"
    wrap([$class: 'AnsiColorBuildWrapper', colorMapName: 'xterm']) {
 
            // Mark the code build 'plan'....
            stage name: 'Plan', concurrency: 1
            // Output Terraform version
            sh "terraform --version"
            //Remove the terraform state file so we always start from a clean state
            if (fileExists(".terraform/terraform.tfstate")) {
                sh "rm -rf .terraform/terraform.tfstate"
            }
            if (fileExists("status")) {
                sh "rm status"
            }
            sh "./init"
            sh "terraform get"
            sh "set +e; terraform plan -out=plan.out -detailed-exitcode; echo \$? &gt; status"
            def exitCode = readFile('status').trim()
            def apply = false
            echo "Terraform Plan Exit Code: ${exitCode}"
            if (exitCode == "0") {
                currentBuild.result = 'SUCCESS'
            }
            if (exitCode == "1") {
               currentBuild.result = 'FAILURE'
            }
            if (exitCode == "2") {
                stash name: "plan", includes: "plan.out"
                 try {
                    input message: 'Apply Plan?', ok: 'Apply'
                    apply = true
                } catch (err) {
                    apply = false
                    currentBuild.result = 'UNSTABLE'
                }
            }
    }
}
