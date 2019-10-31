//
//  ViewController.swift
//  ImagePickerSheetController
//
//  Created by RTC-HN154 on 10/29/19.
//  Copyright © 2019 RTC-HN154. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    @IBOutlet weak var imageFace: UIImageView!
    
    private var profileImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onClickChooseImage(_ sender: UITapGestureRecognizer) {
        
        let authorization = PHPhotoLibrary.authorizationStatus()
        if authorization == .notDetermined {
            PHPhotoLibrary.requestAuthorization { _ in
                DispatchQueue.main.async {
                    self.onClickChooseImage(sender)
                }
            }
        }
        if authorization == .authorized {
            let controller = ImagePickerSheetController()
            controller.addAction(action: ImageAction(title: NSLocalizedString("Take Photo or Video", comment: "Action Title"), secondaryTitle: NSLocalizedString("Use this one", comment: "Action Title"), handler: { _ in
                self.presentCamera()
            }, secondaryHandler: { action, numberOfPhotos in
                controller.getSelectedImagesWithCompletion(completion: { images in
                    self.profileImage = images[0]
                    self.imageFace.image = self.profileImage
                })
            }))
            controller.addAction(action: ImageAction(title: NSLocalizedString("Cancel", comment: "Action Title"), style: .Cancel, handler: nil, secondaryHandler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func presentCamera()
    {
        print("拍照")
    }
}

