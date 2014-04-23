# MapKitDragAndDrop 3.2

iOS/iPhone OS MapKit sample for draggable AnnotationView with CoreAnimation pin lift/drop/bounce effects.

## Features

* Support both **iPhone OS 3.1.x, 3.2 and iOS 4** at the same time, in the same source code.
* Use iOS 4 MapKit built-in draggable support (Yes, you got **retina display** high resolution support for free!)
* Use legacy MapKit techniques to create draggable annotations on iPhone OS 3.1.x and 3.2.
* Use **Core Animation** to create pin effects you saw in built-in Maps.app on iPhone OS 3.1.x and 3.2.

## Requirements

* iOS SDK 4.2 or later.
* Project file (.xcodeproj) needs to:

  1. Base SDK (SDKROOT) should be "iPhone Device 4.2"
  2. Deployment Target (IPHONEOS_DEPLOYMENT_TARGET) can be "iPhone OS 3.1" if you want.

## Change

1. Starting from MapKitDragAndDrop 3.2, DDAnnotationView provides a class method <code>+annotationViewWithAnnotation:reuseIdentifier:mapView:</code> to create annotation view, it will return either DDAnnotationView (on iOS3) or draggble-enabled MKPinAnnotationView (on iOS4).

2. I previously enabled Objective-C 2.0 ABI (to use *synthesized by default* feature) in MapKitDragAndDrop 3.0, which cause a lot of headaches for many developers. After considering, I changed my mind, no more *synthesized by default* in this version, and you are allowed to use either GCC or LLVM Compiler with it now.
 
## Screenshot

![](https://github.com/digdog/MapKitDragAndDrop/raw/master/Screenshots/DDAnnotationViewiPodTouch312.png)

## License 

This project is released under MIT License.
