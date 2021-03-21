//
//  CameraView.swift
//  SwiftUICamera
//
//  Created by Zheng on 3/21/21.
//

import SwiftUI
import AVFoundation

struct SwiftUICameraView: UIViewRepresentable {
    
    let avSession = AVCaptureSession()
    let videoDataOutput = AVCaptureVideoDataOutput()
    @State var cameraDevice: AVCaptureDevice?
    
    func makeUIView(context: Context) -> CameraView {
        let cameraView = CameraView()
        configureCamera(with: cameraView)
        
        return cameraView
    }

    func updateUIView(_ uiView: CameraView, context: Context) {
    }
    func configureCamera(with cameraView: CameraView) {
        cameraView.session = avSession
        if let cameraDevice = getCamera() {
            DispatchQueue.main.async {
                self.cameraDevice = cameraDevice
            }
            
            do {
                let captureDeviceInput = try AVCaptureDeviceInput(device: cameraDevice)
                if avSession.canAddInput(captureDeviceInput) {
                    avSession.addInput(captureDeviceInput)
                }
            }
            catch {
                print("Error occured \(error)")
                return
            }
            avSession.sessionPreset = .photo
            
            if avSession.canAddOutput(videoDataOutput) {
                avSession.addOutput(videoDataOutput)
            }
            cameraView.videoPreviewLayer.videoGravity = .resizeAspectFill
            avSession.startRunning()
        }
    }
    
    
    func getCamera() -> AVCaptureDevice? {
        if let cameraDevice = AVCaptureDevice.default(.builtInDualCamera,
                                                      for: .video, position: .back) {
            return cameraDevice
        } else if let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                             for: .video, position: .back) {
            return cameraDevice
        } else {
            print("Missing Camera.")
            return nil
        }
    }
}

class CameraView: UIView {
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer. Check PreviewView.layerClass implementation.")
        }
        return layer
    }
    var session: AVCaptureSession? {
        get {
            return videoPreviewLayer.session
        }
        set {
            videoPreviewLayer.session = newValue
        }
    }
    // MARK: UIView
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}
