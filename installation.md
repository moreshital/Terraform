### Installing Terraform
You will need to install Terraform on your seed machine in order to run through the new deployment process.

### Graphical User Interface
Go to https://terraform.io/downloads.html and select the package corresponding to your OS.

#### Command Line
```
$ wget https://releases.hashicorp.com/terraform/0.6.6/terraform_0.6.6_linux_amd64.zip
$ unzip terraform_0.6.6_linux_amd64.zip -d whatever.directory.you.wish
```
Add the directory where the unzipped contents are located to your PATH variable.

In Unix-based systems, this can be edited by opening ~/.bashrc using your favorite editor, and adding the line PATH=$PATH:<filepath>.
In Windows, this is done by opening up Windows Explorer, right clicking on This PC, and selecting Properties -> Advanced System Settings -> Environment Variables. Select PATH and choose edit. Append the directory to the end of the path variable WITHOUT spaces.
Reload or open a new terminal so the update to your PATH is recognized.

Last, verify your install was successful:
```
$ terraform -v
```
