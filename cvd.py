import cv2
import numpy as np
import matplotlib.pyplot as plt
from skimage.morphology import reconstruction

scale = 1
delta = 0
ddepth = cv2.CV_16S

img = cv2.imread('nv.jpg')
#img = cv2.GaussianBlur(img,(3,3),0)
img1 = cv2.GaussianBlur(img,(3,3),0)

lab1 = cv2.cvtColor(img,cv2.COLOR_BGR2LAB)
l1,a1,b1 = cv2.split(lab1)

# Gradient-X
grad_x = cv2.Sobel(a1,ddepth,1,0,ksize = 3, scale = scale, delta = delta,borderType = cv2.BORDER_DEFAULT)
#grad_x = cv2.Scharr(gray,ddepth,1,0)

# Gradient-Y
grad_y = cv2.Sobel(a1,ddepth,0,1,ksize = 3, scale = scale, delta = delta, borderType = cv2.BORDER_DEFAULT)
#grad_y = cv2.Scharr(gray,ddepth,0,1)

abs_grad_x = cv2.convertScaleAbs(grad_x)   # converting back to uint8
abs_grad_y = cv2.convertScaleAbs(grad_y)

dst = cv2.addWeighted(abs_grad_x,0.5,abs_grad_y,0.5,0)
#dst = cv2.add(abs_grad_x,abs_grad_y)

cv2.imshow('dst',dst)
cv2.waitKey(0)

sz1,sz2,_ = img1.shape

for x in range(sz1):
    for y in range(sz2):

        blue = img1.item(x,y,0)
        green = img1.item(x,y,1)
        red = img1.item(x,y,2)
        rg = red - green

        if(rg<0):
            rg = 65

        if(rg<=60 and blue<=110):
            continue

        else:
            rs = red*0.423 + green*0.781 - blue*0.204
            gs = red*0.246 + green*0.710 + blue*0.045
            bs = -red*0.012 + green*0.037 + blue*0.974
            img1.itemset((x,y,0),bs)
            img1.itemset((x,y,1),gs)
            img1.itemset((x,y,2),rs)


lab2 = cv2.cvtColor(img1,cv2.COLOR_BGR2LAB)
l2,a2,b2 = cv2.split(lab2)
gray1 = cv2.cvtColor(lab2,cv2.COLOR_BGR2GRAY)

# Gradient-X
grad_x1 = cv2.Sobel(gray1,ddepth,1,0,ksize = 3, scale = scale, delta = delta,borderType = cv2.BORDER_DEFAULT)

# Gradient-Y
grad_y1 = cv2.Sobel(gray1,ddepth,0,1,ksize = 3, scale = scale, delta = delta, borderType = cv2.BORDER_DEFAULT)

abs_grad_x1 = cv2.convertScaleAbs(grad_x1)   # converting back to uint8
abs_grad_y1 = cv2.convertScaleAbs(grad_y1)

dst1 = cv2.addWeighted(abs_grad_x1,0.5,abs_grad_y1,0.5,0)

cv2.imshow('dst1',dst1)
cv2.waitKey(0)

#inaccessible region location
grad = cv2.subtract(dst,dst1)

plt.imshow(grad)
plt.xticks([]), plt.yticks([])
plt.show()

#Thresholding
for x in range(sz1):
    for y in range(sz2):
        if(grad.item(x,y)<=8):
            grad[x,y]=0
        else:
            grad[x,y]=255

cv2.imshow('IR',grad)
cv2.waitKey(0)

"""kernel = np.ones((3,3), np.uint8)

close = cv2.morphologyEx(grad, cv2.MORPH_CLOSE, kernel)
cv2.imshow('Final diff1',close)
cv2.waitKey()

open = cv2.morphologyEx(close, cv2.MORPH_OPEN, kernel)
cv2.imshow('opened',open)
cv2.waitKey()

seed = np.copy(grad)
seed[1:-1, 1:-1] = grad.max()
mask = grad

filled = reconstruction(seed, mask, method='erosion')
cv2.imshow('FILLED',filled)
cv2.waitKey()"""

#Recoloring still left"""For Videos"""

import cv2
import numpy as np
import moviepy.video.io.ffmpeg_tools

#import matplotlib.pyplot as plt

kernel = np.ones((5,5), np.uint8)
kernel1 = np.ones((7,7), np.uint8)

t1 = np.array([[ 0, 0, 0],
              [ -1, 2, -1],
              [ 0, 0, 0]]);

t2 = np.array([[ 0, -1, 0],
              [ 0, 2, 0],
              [ 0, -1, 0]]);

#input original video
cap = cv2.VideoCapture('bbb1.mkv')
moviepy.video.io.ffmpeg_tools.ffmpeg_extract_audio('bbb1.mkv','aop.mp3', bitrate=3000, fps=44100)
fps = cap.get(cv2.cv.CV_CAP_PROP_FPS)
width = int(cap.get(3))
height = int(cap.get(4))
print (width,height)

#fourcc = cv2.cv.CV_FOURCC('X','V','I','D')
out = cv2.VideoWriter('op.avi',-1, fps, (width,height))

while (cap.isOpened()):
    ret, frame  = cap.read()
    #ret, frame1 = cap.read()

    """b,g,r = cv2.split(frame)

    a1 = cv2.morphologyEx(b,cv2.MORPH_GRADIENT,kernel)
    a2 = cv2.morphologyEx(g,cv2.MORPH_GRADIENT,kernel)
    a3 = cv2.morphologyEx(r,cv2.MORPH_GRADIENT,kernel)

    nvg = cv2.add(a1,a2,a3)"""

    #deuteranomalous view

    if(ret == True):
        sz1,sz2,_ = frame.shape
        for x in range(sz1):
            for y in range(sz2):
                blue = frame.item(x,y,0)
                green = frame.item(x,y,1)
                red = frame.item(x,y,2)

                rs = red*0.423 + green*0.781 - blue*0.204
                gs = red*0.246 + green*0.710 + blue*0.045
                bs = -red*0.012 + green*0.037 + blue*0.974

                frame.itemset((x,y,0),bs)
                frame.itemset((x,y,1),gs)
                frame.itemset((x,y,2),rs)

        out.write(frame)

        cv2.imshow("Deuteranomalous View",frame)
        #cv2.waitKey()

        if cv2.waitKey(50) & 0xFF == ord('q'):
            break

    else:
        break


cap.release()
out.release()
cv2.destroyAllWindows()


moviepy.video.io.ffmpeg_tools.ffmpeg_merge_video_audio('op.avi', 'aop.mp3', 'fop.avi', vcodec='copy', acodec='copy', ffmpeg_output=False, verbose=True)
