//
//  Bai1ViewController.swift
//  traning_step_2
//
//  Created by Cuong Do on 02/10/2021.
//
// minigame for 5 second

import Foundation
import UIKit

class Bai1ViewController : UIViewController {
    
    @IBOutlet weak var stpTime: UIStepper!
    @IBOutlet weak var lbCountTime: UILabel!
    @IBOutlet weak var lbUserResult: UILabel!
    @IBOutlet weak var lbErrorUserNum: UILabel!
    @IBOutlet weak var edtUserNum: UITextField!
    @IBOutlet weak var lbRandomNum: UILabel!
    @IBOutlet weak var btnPlayNum: UIButton!
    var numberRandom = 0
    var timeRandom = Timer()
    var count = 0
    var sumTime : Double = 0  // 5s random
    let initTime : Double = 0.05
    
    override func viewDidLoad() {
        initData()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timeRandom.invalidate()
    }
    
    // stepper... listener value when user clcik + or -
    @IBAction func onValueListenerStep(_ sender: Any) {
        _setCountTime(values: stpTime.value)
    }
    
    func initData(){
        lbErrorUserNum.isHidden = true
        lbRandomNum.text = String(0)
        edtUserNum.text = String("")
        edtUserNum.isEnabled = true
        btnPlayNum.isEnabled = false
        //set sumTime default with value of stepper
        _setCountTime(values: stpTime.value)
    }
    
    
    @IBAction func doPressPlayRandom(_ sender: Any) {
        edtUserNum.isEnabled = false
        btnPlayNum.isEnabled = false
        progressNumRandom()

    }
    

    @IBAction func listenerChangeText(_ sender: Any) {
        let value = edtUserNum.text ?? ""
        //check blank
        if (value.isEmpty){
            showError(error: "No blank")
            return
        }
        //check is Number
        if (!value.filter { char in (char < "0" || char > "9")}.isEmpty){
            showError(error: "Please enter positive number")
            return
        }
        //check value
        let num = Int(value) ?? 0
        if (num < 0 || num > 100) {
            showError(error: "value in betwen 0 and 100")
            return
        }
        // data is passed
        lbErrorUserNum.isHidden = true
        btnPlayNum.isEnabled = true
        
    }
    
    func showError(error : String) {
        lbErrorUserNum.text = error
        lbErrorUserNum.isHidden = false
        btnPlayNum.isEnabled = false
    }
    
    func progressNumRandom() {
        timeRandom.invalidate()
        count = 0
        timeRandom = Timer.scheduledTimer(
            timeInterval: initTime, target: self,
            selector: #selector(createNumber),
            userInfo: nil, repeats: true)
    }
    
    @objc func createNumber() {
        //create random number not equal before value
        count += 1
        var num = 0
        repeat {
            num = Int.random(in: 0...100)
            
        } while (num == numberRandom)
        numberRandom = num
        lbRandomNum.text = String(numberRandom)
        if (count == Int(sumTime/initTime)){
            timeRandom.invalidate()
            btnPlayNum.isEnabled = true
            edtUserNum.isEnabled = true
            checkResult()
        }
    }
    
    func checkResult(){
        let userNum = Int(edtUserNum.text ?? "0") ?? 0
        if (userNum < numberRandom){
            lbUserResult.text = "Nhỏ quá"
        } else
            if (userNum > numberRandom){
                lbUserResult.text = "Lớn quá"
            } else
                if (userNum == numberRandom){
                    lbUserResult.text = "Thành Công"
                } else {
                    lbUserResult.text = "kết quả"
                }
    }
    
    func _setCountTime(values : Double)  {
        sumTime = values
        lbCountTime.text = "Time: \(sumTime)s"
    }
    
}
