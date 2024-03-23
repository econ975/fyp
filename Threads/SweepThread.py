import threading

from PyQt5 import QtCore
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt
import cv2
import sys, numpy
import keyboard
import os



class SweepThread(QtCore.QThread):
    """
    Sweeping module as a thread, based on PyQt5.QtCore.QThread
    parameters:
    @hardware: python object of hardware control
    """

    SIGNAL_update = QtCore.pyqtSignal(list, name='update')

    def __init__(self, hardware=None, parent=None):
        super().__init__(parent)
        self._hardware = hardware
        self.parameters = {'StartFreq': 2.8,
                           'StopFreq': 2.95,
                           'NumOfSteps': 300,
                           'DwellTime': 20,
                           'NumOfAvgs': 0,
                           'Power': 0,
                           'x_roi': 705,
                           'y_roi': 596,
                           'roi_width': 720,
                           'roi_height': 540
                           }

    def run(self):
        self.running = True
        # fig = plt.figure()
        self.start_freq = float(self.parameters['StartFreq']) * 1000.0
        self.stop_freq = float(self.parameters['StopFreq']) * 1000.0
        self.num_of_step = int(self.parameters['NumOfSteps'])
        self.dwell_time = int(self.parameters['DwellTime'])
        self.num_of_ave = int(self.parameters['NumOfAvgs'])
        self.power = float(self.parameters['Power'])
        self.x_roi = int(self.parameters['x_roi'])
        self.y_roi = int(self.parameters['y_roi'])
        self.roi_width = int(self.parameters['roi_width'])
        self.roi_height = int(self.parameters['roi_height'])
        x_roi = self.x_roi
        y_roi = self.y_roi
        self.roi_width = self.roi_width - 4
        self.roi_height = self.roi_height - 4
        self._hardware.MW_source.set_power(power=self.power)
        self._hardware.MW_source.switch(state=True)
        self._hardware.camera.exposure_time_us = int(self.dwell_time * 1000)
        self._hardware.camera.frames_per_trigger_zero_for_unlimited = 0  # start camera in continuous mode
        self._hardware.camera.image_poll_timeout_ms = 1000
        old_roi = self._hardware.camera.roi
        self._hardware.camera.roi = (x_roi - self.roi_width//2, y_roi - self.roi_height//2, x_roi + self.roi_width//2, y_roi + self.roi_height//2)
        print("roi2")
        print(self._hardware.camera.roi)
        # self._hardware.camera.roi = (725, 600, 775, 650)
        # print(self._hardware.camera.roi)
        print(self._hardware.camera.image_width_pixels,
              self._hardware.camera.image_height_pixels)  # The area of ROI must be at least 80*4, and in the scale of 4*4 (e.g. roi: 101*5 pixels = 104*8)
        if self._hardware.camera.gain_range.max > 0:  # set gain
            # db_gain = self.gains
            db_gain = 0
            gain_index = self._hardware.camera.convert_decibels_to_gain(db_gain)
            self._hardware.camera.gain = gain_index
            print(f"Set camera gain to {self._hardware.camera.convert_gain_to_decibels(self._hardware.camera.gain)}")
        # self._hardware.pulser.mw_aom_on()
        self._hardware.camera.arm(2)
        self._hardware.camera.issue_software_trigger()
        NUM_FRAMES = 1
        self.freq_points = np.linspace(self.start_freq, self.stop_freq, self.num_of_step, endpoint=False)
        for loop in range(self.num_of_ave):
        # while self.running is True:

            data_loop = []
            if self.running is False:
                break
            for freq in self.freq_points:
                try:


                    self._hardware.MW_source.set_freq(freq=freq)
                    # self._hardware.trigger_counter.init_task()
                    # self._hardware.trigger_counter.counter_start()
                    sum_roi = 0
                    for j in range(1, NUM_FRAMES + 1):
                        frame = self._hardware.camera.get_pending_frame_or_null()
                        # print("frame is", np.array(frame).shape)
                        if frame is not None:
                            # print("frame #{} received!".format(frame.frame_count))
                            # frame.image_buffer  # .../ perform operations using the data from image_buffer

                            image_buffer_copy = np.copy(frame.image_buffer)
                            # actual_roi = image_buffer_copy    # [10:25, 7:22]
                            actual_roi = image_buffer_copy[10:25, 7:22]
                            a = int(np.sum(actual_roi))  # mean/sum pixel value of the ROI in 1 frame
                            sum_roi += a

                    mean_roi = sum_roi // NUM_FRAMES // 225


                    # print("Average intensity in {} frames = {}".format(NUM_FRAMES, mean_roi))
                    data_loop.append(mean_roi)

                except BaseException as e:
                    print(e)
                    self._hardware.MW_source.switch(state=False)
                    # self._hardware.trigger_counter.close_task()
                    # self._hardware.pulser.mw_aom_off()

                    self.running = False
                    return
            self.update.emit(data_loop)
            # print(data_loop)

        try:
            self._hardware.MW_source.switch(state=False)
            # self._hardware.pulser.mw_off()
            self._hardware.camera.disarm()
            self._hardware.camera.roi = old_roi  # reset the roi back to the original roi
            self._hardware.camera.dispose()
            self.running = False
        except BaseException as e:
            print(e)
            pass


