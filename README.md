# python-tedge-agent

The goal of this repository is to provide an example of how to implement your own custom child device agent (or connector). The agent makes use of the thin-edge.io services such as MQTT and HTTP to enable a cloud agnostic implementation.

Note: The official thin-edge.io (Rust) `tedge-agent` service can also be run on child devices, so you should check if you can utilize the out-of-the-box functionality first before using adapting the python agent contained in this repository.

## Getting started

Before getting started, you need to install the following tooling:

* [just](https://just.systems/man/en/chapter_5.html)
* [go-c8y-cli](https://goc8ycli.netlify.app/docs/installation/shell-installation/)
* [go-c8y-cli tedge extension](https://github.com/thin-edge/c8y-tedge)

1. Start the demo setup

    ```sh
    just up
    ```

2. Set your target Cumulocity IoT Tenant

    ```sh
    set-session
    ```

3. Bootstrap thin-edge.io

    ```sh
    just bootstrap
    ```

4. Navigate the child device in the Cumulocity IoT Device Management page this is launched by the previous step
