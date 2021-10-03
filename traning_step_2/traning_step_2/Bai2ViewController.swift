//
//  Bai2ViewController.swift
//  traning_step_2
//
//  Created by Cuong Do on 03/10/2021.
//

import UIKit

class Bai2ViewController : UIViewController {
    
    @IBOutlet weak var btnRandom: UIButton!
    @IBOutlet weak var imgRandom: UIImageView!
    let imgArrs = ["imgTiger", "imgMouse", "imgDog"]
    var imgResult : String = "" {
        didSet{
            if (imgResult != oldValue){
                showImageToView()
            }else {
                creatRandomImage()
            }
        }
    }
    
    override func viewDidLoad() {
        //init first Image from imgArrs
        creatRandomImage()
    }
    
    func showImageToView() {
        btnRandom.isEnabled = true
        if (!imgResult.isEmpty){
            imgRandom.image = UIImage(named:imgResult)
        }
    
    }
    
    func creatRandomImage() {
        imgResult = imgArrs.randomElement() ?? ""
    }
    
    @IBAction func doPressStartRandom(_ sender: Any) {
        btnRandom.isEnabled = false
        creatRandomImage()
    
    }
}
