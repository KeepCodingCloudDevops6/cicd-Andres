multibranchPipelineJob('Git-Terraform') {
    branchSources {
        git {
           id('1')
            remote('git@github.com:KeepCodingCloudDevops6/cicd-Andres.git')
          	credentialsId('ssh-github-key')
        }
    }
}

multibranchPipelineJob('Storage') {
    branchSources {
        git {
           id('2')
            remote('git@github.com:KeepCodingCloudDevops6/cicd-Andres.git')
          	credentialsId('ssh-github-key')
        }
    }
    factory {
        workflowBranchProjectFactory {
            scriptPath('Storage/Jenkinsfile')
        }
    }
}