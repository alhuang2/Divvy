//
//  ViewController.swift
//  divvy
//
//  Created by Alston Huang on 1/21/17.
//  Copyright © 2017 Alston Huang. All rights reserved.
//

import UIKit
import TesseractOCR
class ViewController: UIViewController, G8TesseractDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func photoLibrary(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImageView.image = image
        }
        else{}
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func convert(_ sender: Any) {
        if let tesseract = G8Tesseract(language: "eng"){
            tesseract.delegate = self
            tesseract.image =  myImageView.image?.g8_blackAndWhite()
            //UIImage(named: "Outline")?.g8_blackAndWhite()
            tesseract.recognize()
            textView.text = tesseract.recognizedText
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

