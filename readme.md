# Simple Matlab Image Processing Application (Some features still in progress :))
The following repository contains a simple image processing app which you may run on Matlab using the gui_test2.m code and the corresponding design code is provided in gui_test2.fig.
It is there to demonstrate simple image processing applications.

## Visit My website - .... to download a stand alone version of the above application. PS-The code is yet to be documented (on it ;( )
## Built With/Things Needed to implement experiments

* [Matlab](https://www.mathworks.com/academia.html?s_tid=gn_acad) - Matlab

![alt text](https://github.com/raun1/Simple_Image_processing_App/blob/master/figures/example_of_ui.PNG)
```
The code in this repository has the source code for the implementaion of the Image Processing app in the above image.
Feel free to edit the functions as you wish.
```

## Some guidelines to create the GUI
```

Install Matlab and Matlab GUIDE for making simple Matlab GUI
Install Matlab Image processing toolbox
Type guide in the command prompt. This will create your .fig file which is the GUI design.
In the UI drag and drop elements as needed
Make sure to have atleast one Axes element (this is your display)
Add buttons as you wish
Activate the Axes element first by right clicking that object in your .fig file -> ViewCallBacks -> Create Fcn
Next you can code for any functionality of the buttons using the same right click -> ViewCallBacks -> Callbacks 


```
## Functionality

![alt text](https://github.com/raun1/Simple_Image_processing_App/blob/master/figures/Kirsh_operator.PNG)
This screen shot demonstrates one use of an operator on the earlier image.

##### Load/save image - Loads and Saves an image. (Currently its hardcoded to save only using .png option) During loading and saving image please select file type to all files
##### Add Noise - Salt Pepper, Gaussian, Poisson, Spekle noises. Please see wikipedia for more information but in general they all introduce some basic noise elements
##### Noise Reduction - Smoothing - Low Pass filters
###### Average filtering: provides the average of sorrounding pixel depending on the mask specified by user.
###### Median Filtering: sorts all the pixels depending on user input of mask and then takes the median.
##### Componenet Labelling - Displays (currently in terminal) the number of components in the image.
##### Binarize - 
###### Simple threshold: Depending on user input it sets all pixels over that intensity to max/white and the ones below to white.
###### P-Tile Method : Colors the pixels over nth percent to white
###### Iterative-Thresholding : Iteratively takes the median of median to find the perfect spot of where to do a threshold
##### High-Pass-Filters - Edge detectors -
###### Roberts, Sobel, Prewitt, laplacian uses mask as presented on their respective Wikipedia Page
###### Kirsh(I like this the best) Uses masks (-1 0 1, -1 0 1, -1 0 1) , (1 1 1 ,0 0 0,-1 -1 -1) , (0 1 1 , -1 0 1, -1 -1 0) , (1 1 0, 1 0 -1, 0 -1 -1). Then take pixelwise max of all of those images.
##### Pyramidal scheme (Decomposes an image into 6 smaller version each 1/2 the size of original)
##### Zero order hold scheme (Helps to visualize the image of the pyramid at the same resolution as the base of the pyramid. Creates Boxing effect)



## Contribution

The code was written by me. Please email (rd31879@uga.edu) if you need any assistance. Please note this code is not optimized but just a toy project. 

## Resources which helped me during the learning process - 
#### https://www.youtube.com/watch?v=zyxi_1OyZ2I - Basic GUIDE usage
#### https://www.mathworks.com/matlabcentral/?s_tid=gn_mlc - Matlab Community support, has a lot of good answer from how to use a filter without using imfilter to how to transform array etc