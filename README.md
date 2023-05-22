# Perlin Noise Audio Visualizer

## Concept

My idea was to create an audio visualizer that could generate a visual art piece using sound. I wanted to create something that worked well with calmer or classical music, creating a relaxed and calm atmosphere, unlike most audio visualizers that are quite extravagant and more suited to faster music.
A few years ago, I came across the concept of Perlin noise. It is a type of algorithm used in computer graphics to generate random, natural-looking textures and animations. Perlin noise works by creating a grid of random values and then interpolating between them to generate a smooth, continuous noise function. This noise function can be evaluated at any point in space to generate a value that varies smoothly across the domain. The resulting noise appears organic and can be used to create natural-looking landscapes, clouds, fire, and other effects.
Therefore, I decided to use Perlin noise to create an audio visualizer.

## Process

I used the Minim library to analyse a sound wave, using Fourier transforms to break it down into 1024 frequency bands.
Each band was then represented by a particle, with its color and position on the screen determined by whether it was a high or low frequency band. 
I also incorporated beat detection, modifying the particles' color hue when a new beat was detected. 
To generate Perlin noise, I utilized the built-in noise() function, generating noise based on the current value of the corresponding frequency band for each particle.

## Sources

https://editor.p5js.org/BarneyCodes/sketches/2eES4fBEL
https://www.youtube.com/watch?v=YcdldZ1E9gU
https://en.wikipedia.org/wiki/Perlin_noise

## Result

![Screenshot](https://github.com/F-O-N-S-E-C-A/PerlinNoiseAudioVis/blob/main/img.png)
