# Brief Descriptions of Built-in Predicates

For predicates whose usage and parameters are not obvious.

**DNN + JIT SVM**: Binary classification. Just-in-time train an SVM using the provided zip file as training set. The zip file should contain a `positive/` folder and a `negative/` folder. The input feature to the SVM is extracted using a pre-trained DNN (e.g., MobileNet trained on ImageNet).

**DNN ImageNet Classify**: Classification. Use a pre-trained DNN to classify the images into the [1000 ImageNet classes](https://gist.github.com/yrevar/942d3a0ac09ec9e5eb3a). You should give labels from those 1000 class names.

**SS + DNN + JIT SVM**: Object detection. Use selective search as the region proposal algorithm. Then chose a small number of regions and run **DNN + JIT SVM** on them.

**TPOD Wrapper**: Object detection. Wrap an object detector created using [TPOD](https://github.com/junjuew/TPOD) (A Tool for Painless Object Detection) developed at CMU.

**SIFT/SURF homography**: Key point matching/object detection. Match the images with the provided example patches using SIFT or SURF. The filter will pass an image if at least one example patch matches.