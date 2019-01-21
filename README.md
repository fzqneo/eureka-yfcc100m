# eureka-yfcc100m

Scripts to launch AWS EC2 machines to perform interactive search on the [YFCC100M](http://yfcc100m.appspot.com/) (*Yahoo Flickr Creative Commons 100 Million*) image dataset using the Eureka/OpenDiamond [(paper)](http://elijah.cs.cmu.edu/DOCS/feng-sec2018.pdf) software stack.

## Prerequisites

1. Install [Opendiamond](https://github.com/cmusatyalab/opendiamond/wiki/Installation-on-Ubuntu-16.04). You need to at least have the executable `cookiecutter` from Opendiamond functional. 
2. Download and compile [HyperFind](https://github.com/cmusatyalab/hyperfind). This is the front-end GUI.
3. Prepare your AWS Access Key ID and Secret Access Key. They may look like `ABCDEFGHIJKLM` and `pq/vuwxyz1234wxyz1234wxyz1234`. And, of course, you will pay your own AWS bill.
4. Install the [AWS Command Line Interface](https://aws.amazon.com/cli/)



