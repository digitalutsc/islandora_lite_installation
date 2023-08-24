# Public to Private Filesystem Conversion Scripts
This directory contains scripts that can be used to convert a public filesystem to a private filesystem in Drupal. The scripts are intended to be run from the command line. They manipulate the Drupal database directly, converting data items in the database from public to private. The target is to achieve this workflow:

- List all public files in the filesystem.
- Copy all public files to a specified private filesystem.
- Remove all public files from the public filesystem.
- Convert all public files to private in the database.
- Open a window of time for the user to edit the field settings in the Ui (which they cannot do as long as there are items in the database)
- Close the aforementioned window

## Usage
### In Dockerized environments, run
```bash
./docker_master_script <path_to_public_filesystem> <path_to_private_filesystem>
```
You can find path_to_public_filesystem and path_to_private_filesystem under Home > Administration > Configuration > Media > File System. If there is no private file path present in the UI, then you have not yet set it up. A good resource for setting this up can be found [here](https://www.youtube.com/watch?app=desktop&v=c5XAC7ZgvM4).

**NOTE:** You MUST add a "/" at the end of any supplied file path. For instance, if your public file path is "/var/www/html/sites/default/files", then you must supply "/var/www/html/sites/default/files/" as the path_to_public_filesystem argument.

**NOTE:** The paths supplied to the script must be absolute paths within the *container*, not the host. So, refrain from supplying a path relative to the installation directory. Instead, enter Docker, navigate to the directory you want, and run `pwd`. This will give you the absolute path to the directory within the container, which you should then supply to the script. 

### In non-Dockerized environments, run
```bash
./standard_master_script <path_to_public_filesystem> <path_to_private_filesystem>
```
Here, the paths supplied to the script must be absolute paths on the host machine. See above for steps on how to obtain these paths.
