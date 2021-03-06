#!/usr/bin/python3

import os, random, string
from os import listdir
from os.path import isfile, join
from PIL import Image

def is16to9(img):
	img.size
	return img.size[0] * 9 == img.size[1] * 16

def cropTo16to9(img):
	original_size = img.size
	if is16to9(img):
		cropped_img = img
	else:
		width = original_size[0]
		height = original_size[0] * 9 / 16
		upper = (original_size[1] - height) / 2
		box = (0, upper, width, upper + height)
		cropped_img = img.crop(box)
	return cropped_img

fileList = [f for f in listdir(".") if isfile(join("", f))]

try:
	os.stat('resized')
except:
	os.mkdir('resized')

for imagefile in fileList:
	im = Image.open(imagefile)
	resizedIm = cropTo16to9(im)
	resizedIm = resizedIm.resize((1920,1080))
	randString = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits + string.ascii_lowercase) for _ in range(10))
	resizedIm.save('resized/'+ randString + 'frame.jpg') 
