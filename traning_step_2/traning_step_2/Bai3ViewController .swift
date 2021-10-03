//
//  Bai3ViewController .swift
//  traning_step_2
//
//  Created by Cuong Do on 03/10/2021.
//

import UIKit

class Bai3ViewController  : UIViewController {
    
    @IBOutlet weak var kimGiay: UIImageView!
    @IBOutlet weak var kimPhut: UIImageView!
    @IBOutlet weak var kimGio: UIImageView!
    @IBOutlet weak var lbRealTime: UILabel!
    var timmer = Timer()
    
    override func viewDidLoad() {
        transFormTime( dateNow : Date())
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timmer.invalidate()
        
    }
    func startTimer() {
        timmer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doAnimate), userInfo: nil, repeats: true)
    }
    
    @objc func doAnimate() {
        //here,  1.5s is necessary to  second is smooth
        UIView.animate(withDuration: 1.5) {
            self.transFormTime(dateNow: Date.now)
        }
        
    }
    
    func transFormTime(dateNow: Date){
        let calendar = Calendar.current
        let hour   = calendar.component(.hour, from: dateNow)
        let minute = calendar.component(.minute, from: dateNow)
        let second = calendar.component(.second, from: dateNow)
        // real value  to hour and minute is smooth  eg 9h15 = 9,25
        var hourReal : Double = Double(hour) + Double(minute) / 60 + Double(second) / 3600
        let minuteReal : Double = Double(minute) +  Double(second) / 60
        hourReal = (hourReal < 12 ) ? hourReal : hourReal - 12
        // transform coordinate
        transformRadius( viewRoot: kimGio,  num : hourReal / 12.0 )
        transformRadius( viewRoot: kimPhut, num :  minuteReal / 60.0 )
        transformRadius( viewRoot: kimGiay, num : Double(second) / 60.0 )
        
       // because second is animate in 1.5s so need delay 0.75s to sync between (TextTime and clock)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "HH : mm : ss"
            self.lbRealTime.text = inputFormatter.string(for: dateNow)
        }
    }
    
    func transformRadius( viewRoot : UIView , num : Double ){
        viewRoot.transform = CGAffineTransform(rotationAngle: .pi * 2 * num )
    }
    
}
