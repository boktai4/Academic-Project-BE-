import cv2
import matplotlib.pyplot as plt


class Cod():
    def cem(self):
        img = cv2.imread('New folder\1.png')
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








