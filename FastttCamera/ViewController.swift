//
//  ViewController.swift
//  FastttCamera
//
//  Created by Masuhara on 2016/03/08.
//  Copyright © 2016年 net.maushara. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, FastttCameraDelegate {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var camera: FastttFilterCamera!
    var currentFilter: Filter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentFilter = Filter.filterWithType(Filter.FastttFilterType.None)
        camera = FastttFilterCamera(filterImage: self.currentFilter?.filterImage)
        camera.view.frame = cameraView.frame
        camera.delegate = self
        camera.cameraDevice = FastttCameraDevice.Rear
        camera.maxScaledDimension = 600
        self.fastttAddChildViewController(camera)
        
        imageView.image = camera.filterImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - FastttCameraDelegate
    func cameraController(cameraController: FastttCameraInterface!, didFinishCapturingImage capturedImage: FastttCapturedImage!) {

        let image = capturedImage.fullImage
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({ () -> Void in
            PHAssetChangeRequest.creationRequestForAssetFromImage(image)
            }) { (succeed, error) -> Void in
                if succeed == true {
                    print("保存成功!")
                }
                
                if error != nil {
                    print("error")
                }
        }
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
        if FastttFilterCamera.isCameraDeviceAvailable(FastttCameraDevice.Front) {
            if camera.cameraDevice == FastttCameraDevice.Front {
                camera.cameraDevice = FastttCameraDevice.Rear
            }else {
                camera.cameraDevice = FastttCameraDevice.Front
            }
        }
    }
    
    @IBAction private func flash() {
        if FastttFilterCamera.isTorchAvailableForCameraDevice(camera.cameraDevice) {
            if camera.cameraTorchMode == FastttCameraTorchMode.Off {
                camera.cameraTorchMode = FastttCameraTorchMode.On
            }else {
                camera.cameraTorchMode = FastttCameraTorchMode.Off
            }
        }
    }
    
    @IBAction private func changeFilter() {
        self.currentFilter = self.currentFilter!.nextFilter()
        camera.filterImage = self.currentFilter!.filterImage
        imageView.image = camera.filterImage
    }
}

