import sys
import numpy as np
import os.path
from GUI.uipy.GUI import Ui_MainWindow
from PyQt5 import QtWidgets, QtCore, QtGui
from matplotlib.figure import Figure
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from Hardware import AllHardware
from Threads.SweepThread import SweepThread
from Threads.CameraImageThread import CameraImageThread
from Threads.HProfileThread import HProfileThread
import matplotlib.pyplot as plt




class mainGUI(QtWidgets.QMainWindow):
    def __init__(self, parent=None):
        QtWidgets.QWidget.__init__(self, parent)
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)

        fig = Figure()
        self.ui.mplMap = FigureCanvas(fig)
        self.ui.mplMap.setParent(self.ui.widget)
        self.ui.mplMap.setGeometry(QtCore.QRect(QtCore.QPoint(0, 0), self.ui.widget.size()))
        self.ui.mplMap.axes = fig.add_subplot(111)

        # camera image widget
        self.figure, self.ax = plt.subplots()
        self.ui.mplMap2 = FigureCanvas(self.figure)
        self.ui.mplMap2.setParent(self.ui.widget_1)
        self.ui.mplMap2.setGeometry(QtCore.QRect(QtCore.QPoint(0, 0), self.ui.widget_1.size()))
        # self.ui.mplMap2.axes = fig2.add_subplot(111)

        # Horizontal line profile
        self.figure2, self.ax2 = plt.subplots()
        self.ui.mplMap3 = FigureCanvas(self.figure2)
        self.ui.mplMap3.setParent(self.ui.widget_2)
        self.ui.mplMap3.setGeometry(QtCore.QRect(QtCore.QPoint(0, 0), self.ui.widget_2.size()))
        # self.ui.mplMap3.axes = fig1.add_subplot(111)

        self.load_defaults()
        self.init_hardware()

        self.ui.pushButtonStart.clicked.connect(self.start)
        self.ui.pushButtonStop.clicked.connect(self.stop)
        self.ui.pushButtonSave.clicked.connect(self.save)
        # self.ui.pushButtonDiscard.clicked.connect(self.discard)

        # button for camera image
        self.ui.pushButtonCameraImage.clicked.connect(self.CameraImage)
        self.ui.pushButtonStopShowing.clicked.connect(self.StopShowing)

        # button for HProfile
        self.ui.pushButtonHprofile.clicked.connect(self.HProfile)
        self.ui.pushButtonHprofileStop.clicked.connect(self.HProfileStop)





    def load_defaults(self, fName='defaults.txt'):
        if fName == 'defaults.txt':
            f = open(os.path.join(os.path.dirname(__file__), fName), 'r')
        else:
            f = open(fName, 'r')
        d = {}
        for line in f.readlines():
            if line[-1] == '\n':
                line = line[:-1]
            [key, value] = line.split('=')
            d[key] = value
        f.close()
        dic = {'StartFreq': self.ui.startFreqLineEdit,
               'StopFreq': self.ui.stopFreqLineEdit,
               'NumOfSteps': self.ui.stepsLineEdit,
               'DwellTime': self.ui.dwellTimeLineEdit,
               'NumOfAvgs': self.ui.numOfAvgsLineEdit,
               'Power': self.ui.powerLineEdit,
               'x_roi': self.ui.x_roiLineEdit,
               'y_roi': self.ui.y_roiLineEdit,
               'roi_width': self.ui.roi_widthLineEdit,
               'roi_height': self.ui.roi_heightLineEdit
               }
        for key, value in d.items():
            dic.get(key).setText(value)



    def save_defaults(self, fName='defaults.txt'):
        pairList = []
        pairList.append(('StartFreq', self.ui.startFreqLineEdit.text()))
        pairList.append(('StopFreq', self.ui.stopFreqLineEdit.text()))
        pairList.append(('NumOfSteps', self.ui.stepsLineEdit.text()))
        pairList.append(('DwellTime', self.ui.dwellTimeLineEdit.text()))
        pairList.append(('NumOfAvgs', self.ui.numOfAvgsLineEdit.text()))
        pairList.append(('Power', self.ui.powerLineEdit.text()))
        pairList.append(('x_roi', self.ui.x_roiLineEdit.text()))
        pairList.append(('y_roi', self.ui.y_roiLineEdit.text()))
        pairList.append(('roi_width', self.ui.roi_widthLineEdit.text()))
        pairList.append(('roi_height', self.ui.roi_heightLineEdit.text()))
        ofile = open(os.path.join(os.path.dirname(__file__), fName), 'w')
        for pair in pairList:
            ofile.write(pair[0] + "=" + pair[1] + "\n")
        ofile.close()

    def init_hardware(self):
        try:
            self.hardware = AllHardware()
            self.hardware.MW_source.init_port(port_num='COM7')
            # self.hardware.camera = self.hardware.sdk.open_camera(self.hardware.cameras[0])
        except BaseException as e:
            print(e)
            return
        self.sThread = SweepThread(self.hardware)
        self.sThread.update.connect(self.update_plot)
        self.sThread.finished.connect(self.stopped)

        self.sThread2 = CameraImageThread(self.hardware)
        self.sThread2.update.connect(self.update_plot2)
        self.sThread2.finished.connect(self.stopped2)

        self.sThread3 = HProfileThread(self.hardware)
        self.sThread3.update.connect(self.update_plot3)
        self.sThread3.finished.connect(self.stopped3)






    @QtCore.pyqtSlot()
    def start(self):
        self.hardware.camera = self.hardware.sdk.open_camera(self.hardware.cameras[0])
        print("roi")
        print(self.hardware.camera.roi)
        # self.hardware.camera.roi = (50, 50)
        # print("roi" + self.hardware.camera.roi)
        # test ROI(upper_left_x_pixels=680, upper_left_y_pixels=540, lower_right_x_pixels=783, lower_right_y_pixels=643)
        self.ui.pushButtonStart.setEnabled(False)
        self.ui.pushButtonStop.setEnabled(True)
        self.parameters = {'StartFreq': eval(self.ui.startFreqLineEdit.text()),
                           'StopFreq': eval(self.ui.stopFreqLineEdit.text()),
                           'NumOfSteps': eval(self.ui.stepsLineEdit.text()),
                           'DwellTime': eval(self.ui.dwellTimeLineEdit.text()),
                           'NumOfAvgs': eval(self.ui.numOfAvgsLineEdit.text()),
                           'Power': eval(self.ui.powerLineEdit.text()),
                           'x_roi': eval(self.ui.x_roiLineEdit.text()),
                           'y_roi': eval(self.ui.y_roiLineEdit.text()),
                           'roi_width': eval(self.ui.roi_widthLineEdit.text()),
                           'roi_height': eval(self.ui.roi_heightLineEdit.text()),
                           }
        self.sThread.parameters = self.parameters
        self.x_arr = np.linspace(self.parameters['StartFreq'], self.parameters['StopFreq'],
                                 self.parameters['NumOfSteps'], endpoint=False)
        self.data = []
        self.sThread.start()

        print(self.hardware.camera.roi)




    @QtCore.pyqtSlot()
    def stop(self):
        self.sThread.running = False

    @QtCore.pyqtSlot()
    def stopped(self):
        self.ui.pushButtonStart.setEnabled(True)
        self.ui.pushButtonStop.setEnabled(False)
        self.ui.pushButtonSave.setEnabled(True)
        if len(self.data) > 1:
            self.plot_data()

    def stopped2(self):
        self.ui.pushButtonCameraImage.setEnabled(True)
        self.ui.pushButtonStopShowing.setEnabled(False)
        # self.ui.pushButtonSave.setEnabled(True)
        if len(self.data2) > 1:
            self.plot_data2()

    def stopped3(self):
        self.ui.pushButtonHprofile.setEnabled(True)
        self.ui.pushButtonHprofileStop.setEnabled(False)
        if len(self.data3) > 1:
            self.plot_data3()





    @QtCore.pyqtSlot()
    def save(self):
        if len(self.data) == 0:
            return
        directory = QtWidgets.QFileDialog.getSaveFileName(self, 'Enter save file', "", "Text (*.txt)")
        directory = str(directory[0].replace('/', '\\'))
        if directory != '':
            f = open(directory, 'w')
            for each_avg in self.data:
                for index in range(len(self.x_arr)):
                    f.write(str(self.x_arr[index]) + '\t' + str(each_avg[index]) + '\n')
            f.close()
        else:
            sys.stderr.write('No file selected\n')

    @QtCore.pyqtSlot()
    def discard(self):
        self.sThread.running = False
        self.parameters = {'is_frame_close': 1}
        self.sThread.parameters = self.parameters

    @QtCore.pyqtSlot()
    def prev(self):
        pass

    @QtCore.pyqtSlot()
    def next(self):
        pass

    # Camera Image
    @QtCore.pyqtSlot()
    def CameraImage(self):
        self.hardware.camera = self.hardware.sdk.open_camera(self.hardware.cameras[0])
        # test ROI(upper_left_x_pixels=680, upper_left_y_pixels=540, lower_right_x_pixels=783, lower_right_y_pixels=643)
        self.ui.pushButtonCameraImage.setEnabled(False)
        self.ui.pushButtonStopShowing.setEnabled(True)
        self.parameters = {'StartFreq': eval(self.ui.startFreqLineEdit.text()),
                           'StopFreq': eval(self.ui.stopFreqLineEdit.text()),
                           'NumOfSteps': eval(self.ui.stepsLineEdit.text()),
                           'DwellTime': eval(self.ui.dwellTimeLineEdit.text()),
                           'NumOfAvgs': eval(self.ui.numOfAvgsLineEdit.text()),
                           'Power': eval(self.ui.powerLineEdit.text()),
                           'x_roi': eval(self.ui.x_roiLineEdit.text()),
                           'y_roi': eval(self.ui.y_roiLineEdit.text()),
                           'roi_width': eval(self.ui.roi_widthLineEdit.text()),
                           'roi_height': eval(self.ui.roi_heightLineEdit.text()),
                           }
        self.sThread2.parameters = self.parameters
        self.x_arr2 = np.linspace(self.parameters['StartFreq'], self.parameters['StopFreq'],
                                 self.parameters['NumOfSteps'], endpoint=False)
        self.data2 = []
        self.sThread2.start()

    @QtCore.pyqtSlot()
    def StopShowing(self):
        self.sThread2.running = False

    # HProfile
    @QtCore.pyqtSlot()
    def HProfile(self):
        self.hardware.camera = self.hardware.sdk.open_camera(self.hardware.cameras[0])
        # test ROI(upper_left_x_pixels=680, upper_left_y_pixels=540, lower_right_x_pixels=783, lower_right_y_pixels=643)
        self.ui.pushButtonHprofile.setEnabled(False)
        self.ui.pushButtonHprofileStop.setEnabled(True)
        self.parameters = {'StartFreq': eval(self.ui.startFreqLineEdit.text()),
                           'StopFreq': eval(self.ui.stopFreqLineEdit.text()),
                           'NumOfSteps': eval(self.ui.stepsLineEdit.text()),
                           'DwellTime': eval(self.ui.dwellTimeLineEdit.text()),
                           'NumOfAvgs': eval(self.ui.numOfAvgsLineEdit.text()),
                           'Power': eval(self.ui.powerLineEdit.text()),
                           'x_roi': eval(self.ui.x_roiLineEdit.text()),
                           'y_roi': eval(self.ui.y_roiLineEdit.text()),
                           'roi_width': eval(self.ui.roi_widthLineEdit.text()),
                           'roi_height': eval(self.ui.roi_heightLineEdit.text()),
                           }
        self.sThread3.parameters = self.parameters
        self.x_arr3 = np.linspace(self.parameters['StartFreq'], self.parameters['StopFreq'],
                                  self.parameters['NumOfSteps'], endpoint=False)
        self.data3 = []
        self.sThread3.start()

    @QtCore.pyqtSlot()
    def HProfileStop(self):
        self.sThread3.running = False





    @QtCore.pyqtSlot(list)
    def update_plot(self, l):
        self.data.append(l)
        # avg = np.mean(self.data, axis=0)
        avg = np.array(l)
        try:
            del self.errorPlot
            self.ui.mplMap.figure.clear()
            self.ui.mplMap.axes = self.ui.mplMap.figure.add_subplot(111)
        except AttributeError:
            pass
        try:
            self.linePlot.set_ydata(avg)
            self.ui.mplMap.axes.set_ylim(np.min(avg) * 0.99, np.max(avg) * 1.01)
        except AttributeError:
            self.linePlot, = self.ui.mplMap.axes.plot(self.x_arr, avg)
            self.ui.mplMap.axes.set_ylim(np.min(avg)*0.99,np.max(avg)*1.1)
        finally:
            self.ui.mplMap.draw()

    def plot_data(self):
        del self.linePlot
        self.ui.mplMap.figure.clear()
        self.ui.mplMap.axes = self.ui.mplMap.figure.add_subplot(111)
        avg = np.mean(self.data, axis=0)
        std = np.std(self.data, axis=0, ddof=1)
        err = std / np.sqrt(len(self.data))
        self.errorPlot = self.ui.mplMap.axes.errorbar(self.x_arr, avg, yerr=err, fmt='.')
        self.ui.mplMap.draw()

    # Camera Image
    def update_plot2(self, l):
        img = l / 4
        print(img)
        self.ax.imshow(img, cmap='gray')
        print(self.ui.roi_heightLineEdit.text())
        print(int(self.ui.roi_heightLineEdit.text()))
        self.ax.set_title('y = ' + str(int(self.ui.roi_heightLineEdit.text()) // 2), fontsize=14, color='r')
        self.ax.axhline(y= int(self.ui.roi_heightLineEdit.text()) // 2, color='r', linestyle='-')
        self.ui.mplMap2.draw()

    # HProfile
    def update_plot3(self, l):
        np_array = l  # Sample numpy array
        row_index = int(self.ui.roi_heightLineEdit.text()) // 2  # Row index to plot
        row_values = np_array[row_index, :]

        self.ax2.clear()
        self.ax2.plot(range(len(row_values)), row_values, color='b', marker='o', linestyle='-', linewidth=0.1)
        self.ax2.set_xlabel('Index')
        self.ax2.set_ylabel('Value')
        self.ax2.set_ylim(0, 1023)
        self.ax2.set_title(f'Plot of Row {row_index} of the Numpy Array')
        # self.ax2.set_title('Plot of Row 82 of the Numpy Array')
        self.ax2.grid(True)
        self.ui.mplMap3.draw()

    def plot_data3(self):
        # del self.linePlot
        # self.ui.mplMap3.figure.clear()
        # self.ui.mplMap3.axes = self.ui.mplMap3.figure.add_subplot(111)
        # self.errorPlot
        pass

    @QtCore.pyqtSlot(QtCore.QEvent)
    def closeEvent(self, event):
        quit_msg = "Save parameters as Defaults?"
        reply = QtWidgets.QMessageBox.question(self, 'Message', quit_msg,
                                               QtWidgets.QMessageBox.Save | QtWidgets.QMessageBox.Discard | QtWidgets.QMessageBox.Cancel)
        if reply == QtWidgets.QMessageBox.Save:
            self.save_defaults()
            event.accept()
        elif reply == QtWidgets.QMessageBox.Discard:
            event.accept()
        else:
            event.ignore()


if __name__ == '__main__':
    app = QtWidgets.QApplication(sys.argv)
    myWindow = mainGUI()
    myWindow.show()
    sys.exit(app.exec_())
