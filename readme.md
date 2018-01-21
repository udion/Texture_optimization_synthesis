# Texture Optimization Synthesis

This is my implementation of the classic paper on texture synthesis using concepts from image processing.
The synthesis is posed as an optimization (of 'energy') problem which leads to synthesis of given texture.
I also tweak the algorithm by processing image in `YCbCr` space instead of `RGB` space (as proposed in the algorithm)
Which cuts down the processing time by almost 3 times while preserving the synthesized texture.
