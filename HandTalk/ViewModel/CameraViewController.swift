//
//  CameraViewController.swift
//  HandTalk
//
//  Created by mount_potato on 2021/11/28.
//

import Foundation
import AVFoundation
import UIKit
import Vision
import CoreML


protocol SignDetectedDelegate{
    func foundSign(result: Bool)
    func passValueToRepresentable(letter: String)
}


class CameraVC: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    
    var delegate: SignDetectedDelegate?
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    private let videoDataOutput = AVCaptureVideoDataOutput()
    
    var letterString = ""
    var isFrontCamera: Bool = false //默认后置摄像头
    
    var camera:AVCaptureDevice?

    
    convenience init(sign: String, isFrontCamera: Bool) {

        self.init()
        self.letterString = sign   //目标识别的字母，"scan-mode"下为常识别
        self.isFrontCamera = isFrontCamera  //开启前置或后置摄像头

        
        if self.isFrontCamera{
            camera = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: .video, position: .front)
        }
        else{
            camera = AVCaptureDevice.default(for: .video)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        captureSession = AVCaptureSession()
        

        guard let videoCaptureDevice = self.camera else {
            print("ERR: No camera detected")
            return
        }
        
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch { return }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        }
        
        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        
        self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        self.captureSession.addOutput(self.videoDataOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = self.view.frame
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }
    
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection) {
        
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        
        //进行更新手势识别分类的操作
        self.updateClassifications(in: frame)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        
        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }

    //更新分类
    func updateClassifications(in image: CVPixelBuffer) {

        DispatchQueue.global(qos: .userInitiated).async {
            
            
            let handler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .right, options: [:])
            do {
                
                //from WWDC 2021 10039
                let handPoseRequest = VNDetectHumanHandPoseRequest()
                handPoseRequest.maximumHandCount = 1    //手的数量上限为1
                handPoseRequest.revision = VNDetectHumanHandPoseRequestRevision1
                
                try handler.perform([handPoseRequest])
               
                guard let handPoses = handPoseRequest.results, !handPoses.isEmpty else { return }
              
                let handObservation = handPoses.first
                
                guard let keypointsMultiArray = try? handObservation?.keypointsMultiArray()
                    else { fatalError() }
                
                let model = try ASLHandPoseClassifier(configuration: MLModelConfiguration())
                
                let handPosePrediction:ASLHandPoseClassifierOutput = try model.prediction(poses: keypointsMultiArray)
                
                let confidence = handPosePrediction.labelProbabilities[handPosePrediction.label]!
                
                //置信>0.6时输出最可能的结果
                if confidence > 0.6 {
                    DispatchQueue.main.async {
                        
                        self.delegate?.passValueToRepresentable(letter: handPosePrediction.label)
                        // 检测到目标字母时，更新状态为"found"
                        if handPosePrediction.label.contains(self.letterString){
                            self.delegate?.foundSign(result: true)
                        }
                    }
                }
                        
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
   
            
        }
    }
    

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    

}

