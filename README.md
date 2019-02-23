This repo contains the instructions to perform
interactive search on the [YFCC100M](http://yfcc100m.appspot.com/) (*Yahoo Flickr Creative Commons 100 Million*) image dataset using the Eureka/OpenDiamond [(paper)](http://elijah.cs.cmu.edu/DOCS/feng-sec2018.pdf) software stack,
and using AWS EC2 as back-end.

We have provided: 
+ A public Amazon Machine Image (AMI) containing an installed Eureka back-end with pre-configured YFCC100M meta data.
+ A VirtualBox image and a KVM image containing the pre-configured front-end GUI

ToC:
- [Launching the Eureka Back-ends on AWS EC2](#launching-the-eureka-back-ends-on-aws-ec2)
  - [TL;DR](#tldr)
  - [Recommended steps](#recommended-steps)
  - [Notes](#notes)
- [Starting the Front-end GUI](#starting-the-front-end-gui)
  - [Prerequisite](#prerequisite)
  - [Option 1: Use a VM (VirtualBox or KVM)](#option-1-use-a-vm-virtualbox-or-kvm)
  - [Option 2: Native Installation](#option-2-native-installation)
- [Built-in Predicates](#built-in-predicates)
- [Security and Privacy Risk](#security-and-privacy-risk)
- [FAQ](#faq)
- [Contact](#contact)


![](FIGS/gui-screen.png)

## Launching the Eureka Back-ends on AWS EC2

### TL;DR
* Region: US West (Oregon), `us-west-2`
* AMI ID: `ami-078829174439aee2c`
* Instance type (recommended): `g3.4xlarge`
* Public IP enabled
* Security group
    * Inbound: TCP 22, TCP 5872
    * Outbound: all

### Recommended steps

1. Create a *security group* `eureka-sg` with inbound rules TCP 22, TCP 5872, and outbound rules all.
2. Create a *launch template* using the aforementioned AMI ID, security group, and recommended instance type.
3. Use the launch template to create subsequent EC2 instances.
4. You can create as many instances as you need.
5. Wait for the launched instances to show "running" in Instance State and "2/2 checks passed" in Status Checks before starting the front-end GUI.
6. *Stop* or *terminate* the EC2 instances when you are done.

### Notes

1. You can use a non-GPU instance type, but GPU filters (e.g., DNN image classification) will be unusable. You can still use other filters. It is recommended to use instance types with =16 vCPUs and >= 64 GiB RAM.
2. You should use US West Oregon (`us-west-2`) because the YFCC100M S3 bucket is in the same region.

## Starting the Front-end GUI

### Prerequisite

You need a pair of **AWS Access Key ID** and **Secret Access Key**.
They may look like `AKIAIOSFODNN7EXAMPLE` and `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY`. 
Whether in a VM or natively,
you must [configure your AWS credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
so that the scripts can obtain the public IPs of your launched EC2 instances.

```bash
$ aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json
```

And, of course, you will pay your own AWS bill.


### Option 1: Use a VM (VirtualBox or KVM)

Download [VirtualBox image (v19.02)*](https://owncloud.cmusatyalab.org/owncloud/index.php/s/9LdyQwlbCB2PTMC) or [KVM image and xml (v19.02)](https://owncloud.cmusatyalab.org/owncloud/index.php/s/ktupvN1qwCUFYFG)

Login: ubuntu / Password: ubuntu

```bash
# Configure AWS credentials as shown above
cd /home/ubuntu/hyperfind/eureka-yfcc100m
./start-search.sh
```

*Tested host: macOS 10.13.6 + VirtualBox 6.0; Ubuntu 18.04 + VirtualBox 6.0


### Option 2: Native Installation

This is basically how the VM image is created.

1. Install [OpenDiamond](https://github.com/cmusatyalab/opendiamond/wiki/Installation-on-Ubuntu-16.04,-18.04). You need to at least have the executable `cookiecutter` from OpenDiamond functioning. 
2. Download and compile [HyperFind](https://github.com/cmusatyalab/hyperfind). This is the front-end GUI.
3. Install the [AWS Command Line Interface](https://aws.amazon.com/cli/)
4. [Configure AWS credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) as mentioned above.
5. Clone this repo in the directory where `hyperfind.jar` is located.

```bash
cd /path/to/hyperfind/dir/
git clone https://github.com/fzqneo/eureka-yfcc100m.git
```

As a result, the directory structure looks like:

```
/path/to/hyperfind/dir/
|-- build.xml
|-- bin/
    |-- edu/
        |-- cmu/
            |-- ...
|-- hyperfind.jar
|-- eureka-yfcc100m/    <------ this repo
    |-- README.md       <------ this file
    |-- ...
    |-- start-search.sh
    |-- ...
```
6. Start the front-end GUI after you launch the EC2 back-ends
```bash
cd /path/to/hyperfind/dir/eureka-yfcc100m
./start-search.sh
```


## Built-in Predicates

See [Brief Descriptions of Built-in Predicates](predicates.md)


## Security and Privacy Risk

The pre-configured Eureka back-end in the AMI has turned off [ScopeCookie](https://github.com/cmusatyalab/opendiamond/wiki/ScopeCookie) verification.
It means anyone who knows the IP addresses of your EC2 instances can use the GUI to connect to your machines and perform the search using them.
Since YFCC100M is a public data set, the privacy risk should be minimal.
To further reduce the risk, you can:

1. *Stop* or *Terminate* your EC2 instances as soon as you are done with your search.
2. Configure your inbound rules to only accept connections from your IP address/range.
3. Turn on ScopeCookie verification. This requires a private key and certificate be set up on the front-end and the back-end, respectively. Contact me for how.


## FAQ

**The progress hangs, not moving forward.**

Be patient! 

There are several cases when this can happen:
- The first search session after the VMs start. The system may still be starting up, or the redis cache is loading from the disk.
- The first time you use a GPU-involving filter. It can take a long time to activate the GPU on EC2 on its first use.
- You use some just-in-time (JIT) machine learning filters that trains an ML model before filtering images. Depending on the algorithm and the training set size, the JIT training time can be considerable.

**The GUI errors with `SocketException`**

Make sure you have opened the necessary port (5872) on the EC2 instances.

Wait for the VMs to be in the "running" Instance State and "2/2 checks passed" in Status Checks.

**I can't create GPU instances on EC2.**

By default, AWS may only allow users to create 0 or 1 GPU instance. You may need to ask Amazon to increase you limit.

## Contact

Ziqiang Feng (Carnegie Mellon University)

zf at cs dot cmu dot edu
