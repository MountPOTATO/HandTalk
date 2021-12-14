# HandTalk

Tongji Univ. SSE IOS Application Development coursework (final project) : An Demo based on American Sign Language Classfier 

## Development information

- Environment: macOS Monterey 12.1
- Dev tool: Xcode 13, Xcode 13 Simulator , CreateML, Netron
- Language: Swift
- Interface: SwiftUI
- Third-party service: This application uses extentional package ACarousel (github url: https://github.com/JWAutumn/ACarousel ) to present carousel view
- requirements: IOS 12.0+ (for use) ; macOS 10.14+ (for source code debug)

## Model Overview

The dataset link: https://www.kaggle.com/grassknoted/asl-alphabet

The final version of mlmodel originates from the latest techniques from WWDC 2021 (https://developer.apple.com/videos/play/wwdc2021/10039/). Previous version includes using CreateML Image Classifier model, and an transformed mlmodel from Pytorch model (using coremltools) , which gave disappointing performance on real-time debugging.

A diagram of the model structure can be seen in Snapshots. 



