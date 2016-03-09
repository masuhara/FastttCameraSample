//
//  ViewController.swift
//  FastttCamera
//
//  Created by Masuhara on 2016/03/08.
//  Copyright © 2016年 net.maushara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FastttCameraDelegate {
    
    @IBOutlet weak var cameraView: UIView!
    var camera: FastttFilterCamera = FastttFilterCamera()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        camera.filterImage = UIImage(named: "lookup")
        camera.delegate = self
        self.fastttAddChildViewController(camera)
        camera.view.frame = cameraView.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - FastttCameraDelegate
    func cameraController(cameraController: FastttCameraInterface!, didFinishCapturingImage capturedImage: FastttCapturedImage!) {
        
    }
    
    func cameraController(cameraController: FastttCameraInterface!, didFinishScalingCapturedImage capturedImage: FastttCapturedImage!) {
        
    }
    
    func cameraController(cameraController: FastttCameraInterface!, didFinishNormalizingCapturedImage capturedImage: FastttCapturedImage!) {
        
    }

    
    // MARK: - Private

    @IBAction private func takePhoto() {
        camera.takePicture()
    }
    
    @IBAction private func switchCamera() {
        if FastttCamera.isCameraDeviceAvailable(FastttCameraDevice.Front) {
            if camera.cameraDevice == FastttCameraDevice.Front {
                camera.cameraDevice = FastttCameraDevice.Rear
            }else {
                camera.cameraDevice = FastttCameraDevice.Front
            }
        }
    }
    
    @IBAction private func flash() {
        if FastttCamera.isTorchAvailableForCameraDevice(camera.cameraDevice) {
            if camera.cameraTorchMode == FastttCameraTorchMode.Off {
                camera.cameraTorchMode = FastttCameraTorchMode.On
            }else {
                camera.cameraTorchMode = FastttCameraTorchMode.Off
            }
        }
    }
}

