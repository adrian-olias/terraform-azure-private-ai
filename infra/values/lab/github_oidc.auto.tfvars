github_oidcs = {
  app-privateai-lab-github = {
    name       = "app-privateai-lab-github"
    repository = "adrian-olias/azure-private-ai-cicd"

    # CI (plan, build) runs with no environment, so its subject is pull_request.
    # The deploy job runs in a GitHub environment, so its subject is that environment.
    subjects = {
      pull-request = "pull_request"
      dev          = "environment:Dev"
      production   = "environment:Production"
    }
  }
}
