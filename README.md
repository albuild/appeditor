# albuild-appeditor

Yet another unofficial [AppEditor] package for Amazon Linux 2.

## Install and Run (Amazon WorkSpaces)

### System Requirements

### Instructions

1. Download the package from [the Release page](https://github.com/albuild/appeditor/releases/tag/v0.1.0).

1. Install the package.

    ```
    sudo yum -y install albuild-appeditor-0.1.0-0.amzn2.x86_64.rpm
    ```

1. To run AppEditor, click the "AppEditor" menu item under the System Tools category.

## Build (Amazon WorkSpaces)

### System Requirements

* Docker

### Instructions

1. Clone this repository.

    ```
    git clone https://github.com/albuild/appeditor.git
    ```

1. Go to the repository.

    ```
    cd appeditor
    ```

1. Build a new image.

    ```
    bin/build
    ```

1. Extract the built package from the image. The package will be copied to the ./rpm directory.

    ```
    bin/cp
    ```

1. Delete the image.

    ```
    bin/rmi
    ```

[AppEditor]: https://github.com/donadigo/appeditor
