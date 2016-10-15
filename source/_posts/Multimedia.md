title: Multimedia
date: 2016-05-03 19:27:12
categories: Study Notes
---

# Description
---
The content of this course mainly includes basics about audio, images and videos, lossless and lossy compression algorithms.

# Audio
---
1. Sound is a wave phenomenon like light, but involves molecules of air being compressed and expanded under the actions of some physical device. For example, speaker in an audio system vibrates back and forth and produces a longitudinal pressure wave that we perceive as sound.
2. Human can perceive the sound frequency ranging from 20Hz to 20kHz. Sound frequency less than 20Hz called infrasonic. Sound frequency greater than 20kHz called ultrasonic.
3. SNR(Signal to Noise Ratio)
	The ratio of the power of the correct signal and the noise is called the signal to noise ratio(SNR) -- a measure of the quality of the signal.
	The SNR is usually measured in decibels(dB), where 1 dB is a tenth of a bel. The SNR value, in units of dB, is defined in terms of base-10 logarithms of squared voltages. 6.02
4. Digitization of Sound
	Digitization, means conversion to a stream of numbers, and preferably these numbers should be integers for efficiency.
	- Sampling: using measurements only at evenly spaced time intervals, is simply called, sampling.
	- Sampling in the amplitude or voltage dimension is called quantization.
	Digitization of Sound = Sampling + Quantization

# Image
---
1. Light is an electromagnetic wave. Its color is characterized by the wavelength content of the light.
2. Color only exists in eyes and brain and is the perception result to light.
3. Red, Green, Blue

## Perception of color
1. Hue: red, green, blue, wave length
2. Saturation: 
3. Luminance:

## Color model:
1. RGB: red, green, blue
2. CMY: cyan, magenta, yellow
3. C + R = 1(white), G + M = 1, B + Y = 1

# Video
---
There are two kinds of videos, analog video and digital video.

## Analog Video
Most TV is still sent and received as analog signal.
1. Component Video
3 signal lines, which can be RGB three colors signal respectively.
2. Composite Video
luminance and chroma signal are mixed.

## Digital Video
1. Video can be stored on digital devices or in memory
2. Direct access is possible
3. Ease of encryption and better tolerance to channel noise

# Lossless Compression Algorithm
---
## Huffman coding
Huffman coding is to build a binary tree from bottom up. For example:
XIDIANI
[X D] [A N] ->[2] [2] -> [4] [I] -> [7]
left: 0 right: 1

## Arithmetic coding
{00, 01, 10, 11} {0.1, 0.4, 0.2, 0.3} -> divide [0,1) into 4 intervals, [0, 0.1), [0,1, 0.5), [0.5, 0,7), [0,7, 1)

## Dictionary-based Coding
Checking the string which is compressed. If the string has existed in dictionary, just point to there.
For example:
The source: a b c d x a b c m 
the result: a b c de x p m

# Lossy Compression Algorithm
---
[TODO]
