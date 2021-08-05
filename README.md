![example workflow](https://github.com/cjrohrbach/BA-GT-Roassal/actions/workflows/runG.yml/badge.svg)

The project BA-GT-Roassal brings some key components of [Roassal3](https://github.com/ObjectProfile/Roassal3) in [GlamourousToolkit (GT)](https://gtoolkit.com). In particular, the project defines a very simple API to build [polymetric views](https://ieeexplore.ieee.org/document/1232284) in GT.

This project is the result of my Bachelor thesis, supervised by [Oscar Nierstrasz](http://scg.unibe.ch/staff/oscar) and [Alexandre Bergel](http://bergel.eu).


____
## Installation

The project can be simply loaded in GT by executing the following in a GT playground:

```Smalltalk
Metacello new
	baseline: 'BAGTRoassal';
	repository: 'github://cjrohrbach/BA-GT-Roassal/src';
	load
 ```

Loading should takes a few seconds.
____
## Some examples

The main class of the project is `CRMondrian`. Here is a simple example:

```Smalltalk
v := CRMondrian new.
v nodes with: (1 to: 10).
v
```
This gives the following result:
<img width="1156" alt="image" src="https://user-images.githubusercontent.com/393742/128203947-f08df5ad-fa13-4015-8e7e-3b9d30c76611.png">


Many more examples are offered by the class [`CRMondrianExamples`](https://github.com/cjrohrbach/BA-GT-Roassal/blob/master/src/CR-Graph/CRMondrianExamples.class.st)
