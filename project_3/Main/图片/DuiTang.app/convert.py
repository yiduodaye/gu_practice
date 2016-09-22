import os
from PIL import Image

def convert(path):
    parts = path.split("@2x")
    if len(parts) > 1:
        newpath = "%s%s" % (parts[0], parts[1])
        img = Image.open(path)
        newsize = img.size[0]/2, img.size[1]/2
        img.thumbnail(newsize, Image.ANTIALIAS)
        img.save(newpath, 'PNG')

def displayDir(dir):
    yid = os.walk(dir)
    for rootDir,pathList,fileList in yid:
        for file in fileList:
            path = os.path.join(rootDir,file)
            print path
            convert(path)


if __name__ == '__main__':
    print displayDir(".")
#img = Image.open(i.avatar.file)
#if img.size[0] > 1024 or img.size[1] > 1000:
#    newWidth = 1024
#    newHeight = float(1024) / img.size[0] * img.size[1]
#    img.thumbnail((newWidth,newHeight),Image.ANTIALIAS)
#
#saveToPath = path.join(getUserUploadDirRoot(loginUser.id) , 'original.jpg')
#img.save(saveToPath,"JPEG")
