node {
    stage 'Checkout'
        // Get some code from a GitHub repository
        git url: 'https://github.com/michaelmcclintock/JenkinsPlaygound.git' 
    
    stage 'Stage 2'
        def tfHome = tool name: 'Terraform', type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
        env.PATH = "${tfHome}:${env.PATH}"
  
        // Mark the code build 'plan'....
        stage name: 'Plan', concurrency: 1
            withCredentials([string(credentialsId: 'c8178bdb-a72f-4ede-91d3-190d6a11af15', variable: 'ACCESS_KEY'), string(credentialsId: 'db568c29-c2e0-407b-a93b-463f604a3553', variable: 'SECRETE_KEY')]) {
                    // Output Terraform version
                sh "terraform --version"
                //Remove the terraform state file so we always start from a clean state
                if (fileExists(".terraform/terraform.tfstate")) {
                    sh "rm -rf .terraform/terraform.tfstate"
                }
                if (fileExists("status")) {
                    sh "rm status"
                }
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
