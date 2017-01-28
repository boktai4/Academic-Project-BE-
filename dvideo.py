import cv2
import numpy as np
import moviepy.video.io.ffmpeg_tools

#input original video
cap = cv2.VideoCapture('VideoIp/smh.mp4')
moviepy.video.io.ffmpeg_tools.ffmpeg_extract_audio('VideoIp/smh.mp4','Audio/aop4.mp3', bitrate=3000, fps=44100)

fps = int(cap.get(cv2.cv.CV_CAP_PROP_FPS))
print fps
width = int(cap.get(3))
height = int(cap.get(4))
print width,height

#fourcc = cv2.cv.CV_FOURCC('X','V','I','D')
out = cv2.VideoWriter('VideoOpws/simsmh.avi',-1, (fps/2), (width,height))
#out1 = cv2.VideoWriter('VideoOpws/recrgbp.avi',-1, (fps/2), (width,height))
#out2 = cv2.VideoWriter('VideoOpws/recsrgbp.avi',-1, (fps/2), (width,height))
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
                
        #out1.write(frame)        
        #cv2.imshow("RECOLORED",frame)
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

        
        #out2.write(frame)
        #cv2.imshow("SIMULATED RECOLORED",frame)
        #cv2.imwrite("framesaamir/smh/frame%d.jpg" % count, frame)     # save frame as JPEG file
            
        if key & 0xFF == ord('q'):
            break
        #count += 1
        
    else:
        break
    
    
cap.release()
out.release()
#out1.release()
#out2.release()
cv2.destroyAllWindows()

# Merging audio to the videos

moviepy.video.io.ffmpeg_tools.ffmpeg_merge_video_audio('VideoOpws/simsmh.avi', 'Audio/aop4.mp3', 'VideoOps/fsimsmh.avi', vcodec='copy', acodec='copy', ffmpeg_output=False, verbose=True)
#moviepy.video.io.ffmpeg_tools.ffmpeg_merge_video_audio('VideoOpws/recrgbp.avi', 'Audio/aop4.mp3', 'VideoOps/frecrgbp.avi', vcodec='copy', acodec='copy', ffmpeg_output=False, verbose=True)
#moviepy.video.io.ffmpeg_tools.ffmpeg_merge_video_audio('VideoOpws/recsrgbp.avi', 'Audio/aop4.mp3', 'VideoOps/frecsrgbp.avi', vcodec='copy', acodec='copy', ffmpeg_output=False, verbose=True)

