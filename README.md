# eureka-yfcc100m

Scripts to perform interactive search on the [YFCC100M](http://yfcc100m.appspot.com/) (*Yahoo Flickr Creative Commons 100 Million*) image dataset using the Eureka/OpenDiamond [(paper)](http://elijah.cs.cmu.edu/DOCS/feng-sec2018.pdf) software stack,
using AWS EC2 as back-end.

## Prerequisites

1. Install [Opendiamond](https://github.com/cmusatyalab/opendiamond/wiki/Installation-on-Ubuntu-16.04). You need to at least have the executable `cookiecutter` from Opendiamond functioning. 
2. Download and compile [HyperFind](https://github.com/cmusatyalab/hyperfind). This is the front-end GUI.
3. Install the [AWS Command Line Interface](https://aws.amazon.com/cli/)
4. [Configure AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) with your AWS Access Key ID and Secret Access Key. They may look like `ABCDEFGHIJKLM` and `pq/vuwxyz1234wxyz1234wxyz1234`. And, of course, you will pay your own AWS bill.

## Starting a Search

### Clone this git repository
Clone this repo in the directory where `hyperfind.jar` is located.
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
```

### Obtain Search Filters

```bash
cd eureka-yfcc100m/
./get-filters.sh
```

### Start a search using AWS EC2 as back-ends

1. Launch *N* EC2 VMs based on our public AMI on AWS EC2. *N* is up to you. See the next section for necessary AWS configurations.
2. Wait for the VMs to be in `running` state.
3. Start the search GUI locally:
```bash
cd eureka-yfcc100m/
# Make sure your AWS CLI credential works properly
./start-search.sh
```


## AWS: Public AMI, Network Setting, Instance Type

* Public AMI: `ami-05126af15e9cd3951`
* Recommended network settings: public IP enabled; inbound 22, 5872; outbound all.
 All back-end VMs need inbound permission on port 5872. They also need to access the Internet. 
* Recommended instance type: `g3.4xlarge`. GPU instance is needed to execute DNN filters.
