# Table of Contents
* [Creating a new GitHub repository](#creating-a-new-github-repository)
* [Customizing your newly provisioned GitHub repository](#customizing-your-newly-provisioned-github-repository)
* [Standard Module Structure](#standard-module-structure)
* [Contributing & Approving Changes](#contributing--approving-changes)
* [Maintaining the changelog](#maintaining-the-changelog)
* [Creating a Release](#creating-a-release)
* [Roles & Permissions](#roles--permissions)


# Creating a new GitHub repository
## When to write a module
* In principle any combination of resources and other constructs can be factored out into a module, but over-using modules can make your overall Terraform configuration harder to understand and maintain, so we recommend moderation.
* A good module should raise the level of abstraction by describing a new concept in your architecture that is constructed from resource types offered by providers.
* A new repo should be requested for each module as iPipeline is taking a polyrepo approach to our Terraform modules.  It may make sense to have a limited number of submodules in the repo as long as [semantic versioning](https://semver.org/) is enforced.
* It is not recommend to write modules that are just thin wrappers around single other resource types. If you have trouble finding a name for your module that isn't the same as the main resource type inside it, that may be a sign that your module is not creating any new abstraction and so the module is adding unnecessary complexity. Just use the resource type directly in the calling module instead.
## How to request a new GitHub repository for your module
* An email should be sent to git-admins@ipipeline.com with the following information to request a new GitHub repo for a Terraform module:
  * Name of the repo following the terraform-\<PROVIDER\>-\<NAME\> [standard](https://www.terraform.io/docs/cloud/registry/publish.html). Examples: terraform-google-vault or terraform-aws-ec2-instance
  * Based on the [terraform-module-template](https://github.com/ipipeline/terraform-module-template)
  * Please grant the "All Employees" Team Write permissions to the new repository.
  * List of GitHub Member usernames who should be granted the [Admin role](https://help.github.com/en/github/setting-up-and-managing-organizations-and-teams/repository-permission-levels-for-an-organization) in the repo.


# Customizing your newly provisioned GitHub repository
* You should add a short description explaining the functionality of the Terraform module(s) in your repository to the repository description.
* You should be using Topics to help classify your repository.  Topics are labels placed on repositories to help users find repositories of interest. Furthermore, when a user clicks on the link of a topic, they will be taken to related repositories. Repository admins should choose topics that help label their repo based on its intended use, language, community, and/or subject area. For more info  on topics [Here](https://help.github.com/en/github/administering-a-repository/classifying-your-repository-with-topics).
* The .github/CODEOWNERS file in the template grants permissions to the code owners in the template repository. You should modify the [.github/CODEOWNERS](.github/CODEOWNERS) in your repository with your code owners.


# Standard Module Structure
The [standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure) is a file and directory layout we recommend for reusable modules distributed in separate repositories. Terraform tooling is built to understand the standard module structure and use that structure to generate documentation, index modules for the module registry, and more.

```
├── README.md
├── main.tf
├── outputs.tf
├── variables.tf
├── ...
├── modules/
│   ├── nestedA/
│   │   ├── README.md
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   ├── nestedB/
│   ├── .../
├── examples/
│   ├── exampleA/
│   │   ├── main.tf
│   ├── exampleB/
│   ├── .../
```

# Contributing & Approving Changes
* All contributions should follow the guidelines explained in [CONTRIBUTING.md](CONTRIBUTING.md).

# Maintaining the CHANGELOG 
* A CHANGELOG is a file which contains a curated, chronologically ordered list of notable changes for each [semantic version](https://semver.org/) of the Terraform module.
* When contributing to this repository, users are required to maintain the [CHANGELOG.md](CHANGELOG.md). Maintaining the CHANGELOG makes it easier for users and contributors to see precisely what notable changes have been made between each release/version of the Terraform module.
* What makes a good CHANGELOG?
  * It is made for humans, not machines, so legibility is crucial.
  * Easy to link to any section (hence [Markdown](https://guides.github.com/features/mastering-markdown/) over plain text).
  * One sub-section per version.
  * List releases in reverse-chronological order (newest on top).
  * Write all dates in `YYYY-MM-DD` format. (Example `2020-09-25` for `September 25th, 2020`).
  * Each version should:
    * List its release date in the above format.
    * Group changes to describe their impact on the project, as follows:
      * `Added` for new features.
      * `Changed` for changes in existing functionality.
      * `Deprecated` for once-stable features removed in upcoming releases.
      * `Removed` for deprecated features removed in this release.
      * `Fixed` for any bug fixes.
      * `Refactor` for changes in code that do not add/remove/change existing functionality
      * `Security` to invite users to upgrade in case of vulnerabilities.

### Example CHANGELOG.md file with markdown syntax:
```
# 0.2.0 (2020-08-25)

### Fixed

* Fixed issue where S3 bucket was using the wrong key to encrypt content

### Refactor

* Removing hard-coded environment in EC2 instance and replacing with variable containing the environment
* Removing hard-coded environment value in the callback url for the user pool client and replacing with variable
* Renaming S3 bucket IAM role policy resource
* Refactored tags property to use map variable passed in from Terragrunt file


### Changed

* Added code to create Lambda function module for QA environment  
* Adding resources for Cognito user pool, Cognito user pool domain and Cognito user pool client
* Adding S3 module for UAT environment
* Adding UAT terragrunt file for Cognito user pool


# 0.1.1 (2020-08-24)

### Fixed

* Fixed a bug which caused a circular reference between the security group, security group rules and EC2 instances


# 0.1.0 (2020-08-22)

### Changed

* Creating new ALB and ECS resources for autoscaling group
* Updating S3 bucket properties to enable versioning and encryption
```

# Creating a Release
* Modules should always be pinned to a [specific version](https://www.terraform.io/docs/modules/sources.html#selecting-a-revision-1) so it is important that tags are created to publish versions.
* The best way to create a version tag is by creating a [release](/release), but you can just create a tag directly.
* Most importantly, the tag must follow the [semantic versioning](https://semver.org/) pattern of vMAJOR.MINOR.PATCH (i.e. v1.2.23) where:
  * MAJOR version when you make incompatible API changes,
  * MINOR version when you add functionality in a backwards compatible manner, and
  * PATCH version when you make backwards compatible bug fixes.  
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.
* When drafting a release, the semantic version must match the latest version listed on the CHANGELOG.md file. Ensuring these match makes it easier for users and contributors to see what code is contained in a specific release.

# Quality of Code
* It is important to think of your module as a product you are delivering to the rest of the organization and therefore they are dependent on stable, quality, reliable releases.
* The repository template has included some rudimentary quality checks that automatically run on pull requests to help inform the approving reviewers of the quality of the code being contributed.
  * [Terraform Format](https://www.terraform.io/docs/commands/fmt.html) - checks that the Terraform configuration files conform to a canonical format and style.
  * [Terraform Init](https://www.terraform.io/docs/commands/init.html) - initializes a working directory containing Terraform configuration files which ensures that all references to 3rd party components are valid (i.e. child modules, plugins, etc.).
  * [Terraform Validate](https://www.terraform.io/docs/commands/validate.html) - runs checks that verify whether a configuration is syntactically valid and internally consistent, regardless of any provided variables or existing state. It is thus primarily useful for general verification of reusable modules, including correctness of attribute names and value types.
  * [Checkov Security Analysis](https://www.checkov.io/) - scans cloud infrastructure managed in Terraform and detects *some*  misconfigurations.
* As your modules mature, gain wider adoption & potentially get more complex, it is important to also expand the depth & breadth of your testing suite.  Here are some tools to consider (in no particular order):
  * [terraform-compliance](https://terraform-compliance.com/)
  * [Terraform Plan](https://www.terraform.io/docs/commands/plan.html)
  * [terratest](https://terratest.gruntwork.io/)
  * [Regula](https://github.com/fugue/regula)
  * [tfsec](https://github.com/liamg/tfsec)
  * [terrascan](https://github.com/cesar-rodriguez/terrascan)
  * [terraform-aws-secure-baseline](https://github.com/nozaq/terraform-aws-secure-baseline)

# Roles & Permissions
### Contributors
These users are assigned the *Write* role in order to push to your project, although the master branch is protected from contributors.  The terraform-contributors team members will have *write* role to encourage contribution to the repository.
### Code Owners
These users are also assigned the *Write* role in order to push to your project, but they are also listed in the CODEOWNERS file in order to approve pull requests and push to the master branch.  There should be at least 2 code owners assigned per repository.
### Becoming a Code Owner (https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/about-code-owners)
  * Create a branch off of the master branch.
  * Add your GitHub username to the appropriate line in the CODEOWNERS file in the repo.
  * Push the changes up to the branch that you have created.
  * Create a pull request.
  * If the pull request is approved and all of the GitHub actions pass you will become a code owner of the repo.
### Maintainers
Users assigned the *Admin* role will have full access to the project.  This role should be limited to a select few individuals. Organizational and Account admins would also have repository admin role privileges if they were required so it may not be required for every repository to have admins explicitly assigned.

See [Repository permission levels for an organization](https://help.github.com/en/github/setting-up-and-managing-organizations-and-teams/repository-permission-levels-for-an-organization) for more detailed information on permission levels.
