import sys
import cv2
from PyQt4 import QtGui
from PyQt4 import QtCore
from PyQt4.QtGui import *
from PyQt4.QtCore import *
import matplotlib.pyplot as plt
import moviepy.video.io.ffmpeg_tools
from Tkinter import Tk
from tkFileDialog import askopenfilename
import os, subprocess
import matlab.engine
import time


class Window(QtGui.QMainWindow):

    def __init__(self):
        super(Window, self).__init__()
        self.setGeometry(50, 50, 1000, 500)
        self.setWindowTitle("CVD Interface beta version!!")
        self.setWindowIcon(QtGui.QIcon('screenshot1.png'))
        palette = QtGui.QPalette()

        palette.setColor(QtGui.QPalette.Background,QtGui.QColor(204,204,204))

        self.setPalette(palette)

        # for file menu
        newfilemenu = QtGui.QAction("&New", self)
        newfilemenu.setShortcut("Alt+Insert")
        newfilemenu.setStatusTip('create new file')
        newfilemenu.triggered.connect(self.do_nothing)

        openfilemenu = QtGui.QAction("&Open...", self)
        #openfilemenu.setShortcut("")
        openfilemenu.setStatusTip('Open file from computer')
        openfilemenu.triggered.connect(self.file_open)

        saveasfilemenu = QtGui.QAction("&Save as...", self)
        saveasfilemenu.setShortcut("Ctrl+S")
        saveasfilemenu.setStatusTip('Save file')
        saveasfilemenu.triggered.connect(self.do_nothing)

        settingsfilemenu = QtGui.QAction("&Settings", self)
        settingsfilemenu.setShortcut("Ctrl+Alt+S")
        settingsfilemenu.setStatusTip('Open Settings')
        settingsfilemenu.triggered.connect(self.do_nothing)

        exitfilemenu = QtGui.QAction("&Exit", self)
        exitfilemenu.setShortcut("Q")
        exitfilemenu.setStatusTip('Leave The App')
        exitfilemenu.triggered.connect(self.close_application)

        extractAction = QtGui.QAction("&Work in Progress!!!", self)
        extractAction.setShortcut("Ctrl+Q")
        extractAction.setStatusTip('Leave The App')
        extractAction.triggered.connect(self.close_app)

        #For Edit menu

        undoeditmenu = QtGui.QAction("&Undo..", self)
        undoeditmenu.setShortcut("Ctrl+Z")
        #undoeditmenu.setStatusTip('Save file')
        undoeditmenu.triggered.connect(self.do_nothing)

        redoeditmenu = QtGui.QAction("&Redo..", self)
        redoeditmenu.setShortcut("Ctrl+Shift+Z")
        #redoeditmenu.setStatusTip('Save file')
        redoeditmenu.triggered.connect(self.do_nothing)

        cuteditmenu = QtGui.QAction("&Cut..", self)
        cuteditmenu.setShortcut("Ctrl+X")
        cuteditmenu.setStatusTip('Cut to Clipboard')
        cuteditmenu.triggered.connect(self.do_nothing)

        copyeditmenu = QtGui.QAction("&Copy..", self)
        copyeditmenu.setShortcut("Ctrl+C")
        copyeditmenu.setStatusTip('Copy to Clipboard')
        copyeditmenu.triggered.connect(self.do_nothing)

        pasteeditmenu = QtGui.QAction("&Paste..", self)
        pasteeditmenu.setShortcut("Ctrl+V")
        pasteeditmenu.setStatusTip('Paste Here')
        pasteeditmenu.triggered.connect(self.do_nothing)


        self.statusBar()

        #main menu bar items

        self.mainMenu = self.menuBar()
        self.setStyleSheet("""
        QMenuBar {
            background-color: rgb(204,204,204);
            color: rgb(0,0,0);
            border: 1px solid #808080;
        }

        QMenuBar::item {
            background-color: rgb(204,204,204);
            color: rgb(0,0,0);
        }

        QMenuBar::item::selected {
            background-color: rgb(0,102,255);
        }

        QMenu {
            background-color: rgb(204,204,204);
            color: rgb(0,0,0);
            border: 1px solid #808080;
        }

        QMenu::item::selected {
            background-color: rgb(0,102,255);
        }
    """)
        fileMenu = self.mainMenu.addMenu('&File')
        fileMenu.addAction(extractAction)
        fileMenu.addAction(newfilemenu)
        fileMenu.addAction(openfilemenu)
        fileMenu.addAction(saveasfilemenu)
        fileMenu.addAction(settingsfilemenu)
        fileMenu.addAction(exitfilemenu)

        editMenu = self.mainMenu.addMenu('&Edit')
        editMenu.addAction(undoeditmenu)
        editMenu.addAction(redoeditmenu)
        editMenu.addAction(cuteditmenu)
        editMenu.addAction(copyeditmenu)
        editMenu.addAction(pasteeditmenu)

        runMenu = self.mainMenu.addMenu('&Run')
        runMenu.addAction(extractAction)

        windowMenu = self.mainMenu.addMenu('&Window')
        windowMenu.addAction(extractAction)

        helpMenu = self.mainMenu.addMenu('&Help')
        helpMenu.addAction(extractAction)

        """startprogtoolbar = QtGui.QAction(QtGui.QIcon('Png/16x16/Start.png'), 'Start the program', self)
        startprogtoolbar.triggered.connect(self.do_something)"""

        """self.toolBar = self.addToolBar("Extraction")
        self.toolBar.addAction(startprogtoolbar)"""

        self.home()
        self.window()

    def do_something(self):

        os.chdir(r'D:\beproject')
        print (os.curdir)
        returnCode = subprocess.call("matlab -r dt.m")
        print ("Return Code: ", returnCode)


    def file_open(self):
        name = QtGui.QFileDialog.getOpenFileName(self,'Open File')
        file = open(name,'r')

    def b1_clicked(self):
        dia = QDialog()
	def d1b1_clicked():
            Tk().withdraw()
            filename = askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
            eng = matlab.engine.start_matlab()
            Output4 = eng.protanopia(filename, nargout=3)
            time.sleep(10)
            print(filename)

        def d1b2_clicked():
            Tk().withdraw()
            filename = askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
            eng = matlab.engine.start_matlab()
            eng.vidprotanopia(filename, nargout=0)# show an "Open" dialog box and return the path to the selected file
            print(filename)

        d1b1 = QPushButton(dia)
        d1b1.setText("Image")
        d1b1.move(10,10)
        d1b1.clicked.connect(d1b1_clicked)

        d1b2 = QPushButton(dia)
        d1b2.setText("Video")
        d1b2.move(100,10)
        d1b2.clicked.connect(d1b2_clicked)

        dia.setGeometry(100,100,200,100)
        dia.setWindowTitle("Protanopia")
        dia.show()

        dia.exec_()


    def b2_clicked(self):
        dia = QDialog()
        def d1b1_clicked():
            Tk().withdraw()
            filename = askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*")))
            eng = matlab.engine.start_matlab()
            Output1 = eng.imgdeu(filename, nargout=1) # show an "Open" dialog box and return the path to the selected file
            time.sleep(10)
            print(filename)

        def d1b2_clicked():
            Tk().withdraw()
            filename = askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*")))
            eng = matlab.engine.start_matlab()
            eng.viddeu(filename, nargout=0)# show an "Open" dialog box and return the path to the selected file
            print(filename)

        d1b1 = QPushButton(dia)
        d1b1.setText("Image")
        d1b1.move(10,10)
        d1b1.clicked.connect(d1b1_clicked)

        d1b2 = QPushButton(dia)
        d1b2.setText("Video")
        d1b2.move(100,10)
        d1b2.clicked.connect(d1b2_clicked)

        dia.setGeometry(100,100,200,100)
        dia.setWindowTitle("Deutranopia")
        dia.show()

        dia.exec_()

    def b3_clicked(self):
        dia = QDialog()
        def d1b1_clicked():
            Tk().withdraw()
            filename = askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*")))
            eng = matlab.engine.start_matlab()
            Output2 = eng.imgtri(filename, nargout=3)
            time.sleep(10)
            print(Output2)# show an "Open" dialog box and return the path to the selected file
            print(filename)

        def d1b2_clicked():
            l1 = QLabel()
            l1.setText("Work in progress")

            vbox = QVBoxLayout()
            vbox.addWidget(l1)

            dia.setLayout(vbox)

        d1b1 = QPushButton(dia)
        d1b1.setText("Image")
        d1b1.move(10,10)
        d1b1.clicked.connect(d1b1_clicked)

        d1b2 = QPushButton(dia)
        d1b2.setText("Video")
        d1b2.move(100,10)
        d1b2.clicked.connect(d1b2_clicked)

        dia.setGeometry(100,100,200,100)
        dia.setWindowTitle("Tritanopia")
        dia.show()

        dia.exec_()

    def b4_clicked(self):
        dia = QDialog()

        def d1b1_clicked():
            Tk().withdraw()
            filename = askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*")))
            eng = matlab.engine.start_matlab()
            Output = eng.dt(filename, nargout=4)# show an "Open" dialog box and return the path to the selected file
            time.sleep(10)
            print(filename)
            print(Output)

        def d1b2_clicked():
            Tk().withdraw()
            filename = askopenfilename(filetypes =(("Video File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
            eng = matlab.engine.start_matlab()
            eng.vidprotanopia(filename, nargout=0)# show an "Open" dialog box and return the path to the selected file
            print(filename)

        d1b1 = QPushButton(dia)
        d1b1.setText("Image")
        d1b1.move(10,10)
        d1b1.clicked.connect(d1b1_clicked)

        d1b2 = QPushButton(dia)
        d1b2.setText("Video")
        d1b2.move(100,10)
        d1b2.clicked.connect(d1b2_clicked)

        dia.setGeometry(100,100,200,100)
        dia.setWindowTitle("Protanomaly")
        dia.show()

        dia.exec_()

    def b5_clicked(self):
        dia = QDialog()
        def d1b1_clicked():
            Tk().withdraw()
            filename = askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*")))
            self.cem(filename)# show an "Open" dialog box and return the path to the selected file
            print(filename)

        def d1b2_clicked():
            Tk().withdraw()
            filename = askopenfilename(filetypes =(("video mp4 File", "*.mp4"),("video File", "*.avi"),("All Files","*.*")))
            self.dv(filename)# show an "Open" dialog box and return the path to the selected file
            print(filename)

        d1b1 = QPushButton(dia)
        d1b1.setText("Image")
        d1b1.move(10,10)
        d1b1.clicked.connect(d1b1_clicked)

        d1b2 = QPushButton(dia)
        d1b2.setText("Video")
        d1b2.move(100,10)
        d1b2.clicked.connect(d1b2_clicked)

        dia.setGeometry(100,100,200,100)
        dia.setWindowTitle("Deutanomaly")
        dia.show()

        dia.exec_()

    def b6_clicked():
        dia = QDialog()

        def d1b1_clicked():
            """Tk().withdraw()
            filename = askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
            print(filename)"""
            l2 = QLabel()
            l2.setText("Work in progress")

            vbox = QVBoxLayout()
            vbox.addWidget(l2)

            dia.setLayout(vbox)

        def d1b2_clicked():
            """Tk().withdraw()
            filename = askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
            print(filename)"""
            l3 = QLabel()
            l3.setText("Work in progress")

            vbox = QVBoxLayout()
            vbox.addWidget(l3)

            dia.setLayout(vbox)

        d1b1 = QPushButton(dia)
        d1b1.setText("Image")
        d1b1.move(10,10)
        d1b1.clicked.connect(d1b1_clicked)

        d1b2 = QPushButton(dia)
        d1b2.setText("Video")
        d1b2.move(100,10)
        d1b2.clicked.connect(d1b2_clicked)

        dia.setGeometry(100,100,200,100)
        dia.setWindowTitle("Tritanomaly")
        dia.show()

        dia.exec_()



    def home(self):
        



        l1 = QtGui.QLabel("Select your type: ",self)
        l1.move(100,80)
        l1.setAlignment(Qt.AlignTop)


        b1 = QPushButton("Protanopia",self)
        b1.move(100,100)
        b1.clicked.connect(self.b1_clicked)

        b2 = QPushButton("Deuteranopia",self)
        b2.move(100,200)
        b2.clicked.connect(self.b2_clicked)

        b3 = QPushButton("Tritanopia",self)
        b3.move(100,300)
        b3.clicked.connect(self.b3_clicked)

        b4 = QPushButton("Protanomaly",self)
        b4.move(200,100)
        b4.clicked.connect(self.b4_clicked)

        b5 = QPushButton("Deuteranomaly",self)
        b5.move(200,200)
        b5.clicked.connect(self.b5_clicked)

        b6 = QPushButton("Tritanomaly",self)
        b6.move(200,300)
        b6.clicked.connect(self.b6_clicked)


        self.show()
        
    
    def close_application(self):
        choice = QtGui.QMessageBox.question(self, 'Attention!!!',
                                            "Do you really want to exit?",
                                            QtGui.QMessageBox.Yes | QtGui.QMessageBox.No)
        if choice == QtGui.QMessageBox.Yes:
            print("Closing program!!!!")
            sys.exit()
        else:
            pass
    def close_app(self):
        sys.exit()
    def do_nothing(self):
        print(" pp doing nothing ")

    def cem(self,filename):
        img = cv2.imread(filename)
        img1 = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        imgs = cv2.cvtColor(img1, cv2.COLOR_RGB2BGR)
        sz1,sz2,_ = img.shape
        for x in range(sz1):
            for y in range(sz2):
                blue = imgs.item(x,y,0)
                green = imgs.item(x,y,1)
                red = imgs.item(x,y,2)
                rg = red - green
                if(rg<0):
                    rg = 65

                if((rg<=60 and blue<=110 and red>=145) or (red<=62 and green<=40 and blue<=165) or (red<=30 and green<=30 and blue>=180)):
                    continue

                else:
                    rs = red*0.423 + green*0.781 - blue*0.204
                    gs = red*0.246 + green*0.710 + blue*0.045
                    bs = -red*0.012 + green*0.037 + blue*0.974
                    imgs.itemset((x,y,0),bs)
                    imgs.itemset((x,y,1),gs)
                    imgs.itemset((x,y,2),rs)

        img2 = cv2.cvtColor(imgs, cv2.COLOR_BGR2RGB)


        for x in range(sz1):
            for y in range(sz2):
                blue = img.item(x,y,0)
                green = img.item(x,y,1)
                red = img.item(x,y,2)
                rg1 = abs(red - green)
                rg = red - green
                rb = abs(red - blue)
                gb = abs(green - blue)
                br = blue - red

                if((rg1<=60 and rb<=60 and gb<=60) and (rg1<30)):
                    continue

                elif(br>0 and br<=69 and red>100 and blue>110 and green<=110):
                    green = green + 100
                    if(green>255):
                        green = 255
                    img.itemset((x,y,1),green)
                    img.itemset((x,y,0),blue+50)


                elif((rg1<=60 and blue<=110 and red>=145)  or (red<=70 and green<=90 and blue>=105) or (red<=130 and green<=150 and blue>=150)):
                    continue

                else:
                    if(rg>0):

                        red = red + 80
                        if(red>255):
                            red = 255
                        img.itemset((x,y,0),red)

                        blue = blue + 50
                        if(blue>255):
                            blue = 255
                        img.itemset((x,y,0),blue)

                    elif(rg==0):
                        continue

                    else:
                        blue = blue + 100
                        green = green + 25

                        if(blue>255):
                            blue = 255
                        img.itemset((x,y,0),blue)

                        if(green>255):
                            green = 255
                        img.itemset((x,y,1),green)

        img3 = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)


        for x in range(sz1):
            for y in range(sz2):
                blue = img.item(x,y,0)
                green = img.item(x,y,1)
                red = img.item(x,y,2)
                rg = red - green

                if(rg<0):
                    rg = 65

                if((rg<=60 and blue<=110 and red>=145) or (red<=62 and green<=40 and blue<=165) or (red<=30 and green<=30 and blue>=180)):
                    continue

                else:
                    rs = red*0.423 + green*0.781 - blue*0.204
                    gs = red*0.246 + green*0.710 + blue*0.045
                    bs = -red*0.012 + green*0.037 + blue*0.974
                    img.itemset((x,y,0),bs)
                    img.itemset((x,y,1),gs)
                    img.itemset((x,y,2),rs)

        img4 = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

        plt.subplot(221)
        plt.imshow(img1)
        plt.title('Original Image')
        plt.xticks([]), plt.yticks([])

        plt.subplot(222)
        plt.imshow(img2)
        plt.title('Simulated Image')
        plt.xticks([]), plt.yticks([])

        plt.subplot(223)
        plt.imshow(img3)
        plt.title('Recolored Image')
        plt.xticks([]), plt.yticks([])

        plt.subplot(224)
        plt.imshow(img4)
        plt.title('Simulated Recolored Image')
        plt.xticks([]), plt.yticks([])
        plt.show()
    def dv(self,filename):
	#input original video
        print (filename)
        cap = cv2.VideoCapture(filename)
	moviepy.video.io.ffmpeg_tools.ffmpeg_extract_audio(filename,'Audio/aop.mp3', bitrate=3000, fps=44100)

	fps = int(cap.get(cv2.cv.CV_CAP_PROP_FPS))
        print fps
	width = int(cap.get(3))
	height = int(cap.get(4))
	print width,height

	#fourcc = cv2.cv.CV_FOURCC('X','V','I','D')
	out = cv2.VideoWriter('VideoOpws/simrgbp.avi',-1, (fps/2), (width,height))
	out1 = cv2.VideoWriter('VideoOpws/recrgbp.avi',-1, (fps/2), (width,height))
	out2 = cv2.VideoWriter('VideoOpws/recsrgbp.avi',-1, (fps/2), (width,height))
	count = 0

	while (cap.isOpened()):
	    ret, frame  = cap.read()
	    ret, frame1 = cap.read()

	    if(ret == True):
		sz1,sz2,_ = frame.shape
		key = cv2.waitKey(1)
        
		#cv2.imshow("ORIGINAL",frame)
		#cv2.imwrite("framesip/cbmgt/frame%d.jpg" % count, frame)
        
		# Simulating the video
		for x in range(sz1):
		    for y in range(sz2):
        
			blue = frame1.item(x,y,0)
			green = frame1.item(x,y,1)
			red = frame1.item(x,y,2)
			rg = red - green
			rg1 = abs(red - green)
			rb = abs(red - blue)
			gb = abs(green - blue)
                
			if(rg<0):
			    rg = 65
            
			if((rg1<=60 and rb<=60 and gb<=60) and (rg1<30)): #Not simulating grayscale
                            continue
            
	    		elif((rg<=60 and blue<=110 and red>=145) or (red<=62 and green<=40 and blue<=165) or (red<=30 and green<=30 and blue>=180)):
                            continue

			else:
			    rs = red*0.423 + green*0.781 - blue*0.204
			    gs = red*0.246 + green*0.710 + blue*0.045
			    bs = -red*0.012 + green*0.037 + blue*0.974
			    frame1.itemset((x,y,0),bs)
			    frame1.itemset((x,y,1),gs)
			    frame1.itemset((x,y,2),rs)
        
		out.write(frame1)
		cv2.imshow("SIMULATED ORIGINAL",frame1)
		#cv2.imwrite("framessim/cbmgt/frame%d.jpg" % count, frame1)     # save frame as JPEG file
  
		# Recoloring the Input Video frame by frame
		for x in range(sz1):
                    for y in range(sz2):

			blue = frame.item(x,y,0)
			green = frame.item(x,y,1)
			red = frame.item(x,y,2)
			rg1 = abs(red - green)
			rg = red - green
			rb = abs(red - blue)
			rb1 = red - blue
			gb = abs(green - blue)
			gb1 = green - blue
			br = blue - red
        
			if((rg1<=60 and rb<=60 and gb<=60) and (rg1<30) or (rb1>=50 and rb1<=107 and gb1>=12 and gb1<=55)): # Leaving Grayscale part as it is.
			    continue
        
			elif(br>0 and br<=69 and red>100 and blue>110 and green<=110): # Recoloring purple shade by contrast enhancement
			    green = green + 100
                            if(green>255):
				green = 255
                            frame.itemset((x,y,1),green)
                            frame.itemset((x,y,0),blue+50)
        
			# Leaving yellow and blue shade as it is.
                        elif((rg1<=60 and blue<=110 and red>=145)  or (red<=70 and green<=90 and blue>=105) or (red<=130 and green<=150 and blue>=150)):
    			    continue
        
	    		else:
                       
		    	    if(rg>0): # Check if red is greater than blue
                              
			    	red = red + 80  # Increase red component
				if(red>255):
				    red = 255
				frame.itemset((x,y,0),red)    # Set new red component
                
				blue = blue + 50    # Increase blue component marginally
				if(blue>255):
				    blue = 255
				frame.itemset((x,y,0),blue)   # Set new blue component
            
			    elif(rg==0): # If red and green are equal, leave it.
				continue
            
			    else:
                                # Now for green greater than red
				blue = blue + 100    # Increase blue component significantly
				green = green + 25  # Increase green component marginally
                
				if(blue>255):
                                    blue = 255
				frame.itemset((x,y,0),blue)   # Set blue component
                
				if(green>255):
                                    green = 255
                                frame.itemset((x,y,1),green)  # Set green component
                
                out1.write(frame)        
                cv2.imshow("RECOLORED",frame)
                #cv2.imwrite("framesrec/cbmgt/frame%d.jpg" % count, frame)     # save frame as JPEG file
        
		for x in range(sz1):
                    for y in range(sz2):
        
			blue = frame.item(x,y,0)
			green = frame.item(x,y,1)
			red = frame.item(x,y,2)
			rg = red - green
			rg1 = abs(red - green)
			rb = abs(red - blue)
			gb = abs(green - blue)
                
                        if(rg<0):
	    		    rg = 65
            
                        if((rg1<=60 and rb<=60 and gb<=60) and (rg1<30)): #Not simulating grayscale
			    continue
            
			elif((rg<=60 and blue<=110 and red>=145) or (red<=62 and green<=40 and blue<=165) or (red<=30 and green<=30 and blue>=180)):
			    continue

			else:
                            rs = red*0.423 + green*0.781 - blue*0.204
                            gs = red*0.246 + green*0.710 + blue*0.045
                            bs = -red*0.012 + green*0.037 + blue*0.974
                            frame.itemset((x,y,0),bs)
                            frame.itemset((x,y,1),gs)
			    frame.itemset((x,y,2),rs)

        
		out2.write(frame)
		cv2.imshow("SIMULATED RECOLORED",frame)
		#cv2.imwrite("framesaamir/smh/frame%d.jpg" % count, frame)     # save frame as JPEG file
            
	    	if key & 0xFF == ord('q'):
		   break

		count += 1
        
            else:
                break
    
	cap.release()
	out.release()
	out1.release()
	out2.release()
	cv2.destroyAllWindows()

	# Merging audio to the videos

	moviepy.video.io.ffmpeg_tools.ffmpeg_merge_video_audio('VideoOpws/simrgbp.avi', 'Audio/aop.mp3', 'VideoOps/fsimrgbp.avi', vcodec='copy', acodec='copy', ffmpeg_output=False, verbose=True)
	moviepy.video.io.ffmpeg_tools.ffmpeg_merge_video_audio('VideoOpws/recrgbp.avi', 'Audio/aop.mp3', 'VideoOps/frecrgbp.avi', vcodec='copy', acodec='copy', ffmpeg_output=False, verbose=True)
	moviepy.video.io.ffmpeg_tools.ffmpeg_merge_video_audio('VideoOpws/recsrgbp.avi', 'Audio/aop.mp3', 'VideoOps/frecsrgbp.avi', vcodec='copy', acodec='copy', ffmpeg_output=False, verbose=True)






def run():
    app = QtGui.QApplication(sys.argv)
    GUI = Window()
    sys.exit(app.exec_())


run()
