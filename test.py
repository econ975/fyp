import time
import matplotlib.pyplot as plt
import numpy as np
from numpy.random import rand
from PIL import Image

if __name__ == '__main__':


    imshape = (64, 64, 3)
    imdata = np.zeros(imshape)
    # Enable interactive mode.
    plt.ion()
    # Create a figure and a set of subplots.
    figure, ax = plt.subplots()
    # return AxesImage object for using.
    im = ax.imshow(imdata, cmap='gray')
    for n in range(600):
        fp = open('new.png', 'rb')

        pic = Image.open(fp)
        pic_array = np.array(pic)  # Convert to numpy array

        # A template of data generate...
        imdata = pic_array

        # update image data
        im.set_data(imdata)
        # draw and flush the figure .
        figure.canvas.draw()
        figure.canvas.flush_events()
        time.sleep(0.01)
        fp.close()
