import sys
from PyQt4.QtCore import *
from PyQt4.QtGui import *
from Tkinter import Tk
from tkFileDialog import askopenfilename



def window():
    app = QApplication(sys.argv)
    win = QWidget()


    l1 = QLabel()
    l1.setText("Select your type: ")
    l1.move(10,20)
    l1.setAlignment(Qt.AlignTop)

    vbox = QVBoxLayout()
    vbox.addWidget(l1)
    win.setLayout(vbox)
    win.setWindowTitle("Welcome to CVD")


    b1 = QPushButton(win)
    b1.setText("Protanopia")
    b1.move(100,100)
    b1.clicked.connect(b1_clicked)

    b2 = QPushButton(win)
    b2.setText("Deutranopia")
    b2.move(250,100)
    b2.clicked.connect(b2_clicked)

    b3 = QPushButton(win)
    b3.setText("Tritanopia")
    b3.move(100,200)
    b3.clicked.connect(b3_clicked)

    b4 = QPushButton(win)
    b4.setText("Protanomaly")
    b4.move(250,200)
    b4.clicked.connect(b4_clicked)

    b5 = QPushButton(win)
    b5.setText("Deutanomaly")
    b5.move(100,300)
    b5.clicked.connect(b5_clicked)

    b6 = QPushButton(win)
    b6.setText("Tritanomaly")
    b6.move(250,300)
    b6.clicked.connect(b6_clicked)

    win.setGeometry(100,100,1000,600)



    win.show()
    sys.exit(app.exec_())


def b1_clicked():
    dia = QDialog()

    def d1b1_clicked():
        root = tk.Tk()
        root.withdraw()
        filename = filedialog.askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
        print(filename)

    def d1b2_clicked():
        root = tk.Tk()
        root.withdraw()
        filename = filedialog.askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
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


def b2_clicked():
    dia = QDialog()

    def d1b1_clicked():
        root = tk.Tk()
        root.withdraw()
        filename = filedialog.askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
        print(filename)

    def d1b2_clicked():
        root = tk.Tk()
        root.withdraw()
        filename = filedialog.askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
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

def b3_clicked():
    dia = QDialog()

    def d1b1_clicked():
        root = tk.Tk()
        root.withdraw()
        filename = filedialog.askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
        print(filename)

    def d1b2_clicked():
        l1 = QLabel()
        l1.setText("Not yet done")

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

def b4_clicked():
    dia = QDialog()

    def d1b1_clicked():
        root = tk.Tk()
        root.withdraw()
        filename = filedialog.askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
        print(filename)

    def d1b2_clicked():
        root = tk.Tk()
        root.withdraw()
        filename = filedialog.askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
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

def b5_clicked():
    dia = QDialog()

    def d1b1_clicked():
        root = tk.Tk()
        root.withdraw()
        filename = filedialog.askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
        print(filename)

    def d1b2_clicked():
        root = tk.Tk()
        root.withdraw()
        filename = filedialog.askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
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
        root = tk.Tk()
        root.withdraw()
        filename = filedialog.askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
        print(filename)

    def d1b2_clicked():
        root = tk.Tk()
        root.withdraw()
        filename = filedialog.askopenfilename(filetypes =(("Matlab File", "*.m"),("All Files","*.*"))) # show an "Open" dialog box and return the path to the selected file
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
    dia.setWindowTitle("Tritanomaly")
    dia.show()

    dia.exec_()


if __name__ == '__main__':
   window()
