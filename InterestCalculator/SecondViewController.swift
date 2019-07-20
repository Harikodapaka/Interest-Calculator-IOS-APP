//
//  SecondViewController.swift
//  InterestCalculator
//
//  Created by Chaitanya Kodapaka on 2019-07-16.
//  Copyright © 2019 Bank. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var principleTF: UITextField!
    @IBOutlet var rateTF: UITextField!
    @IBOutlet var termTF: UITextField!
    var interestType:String = "Simple"
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var totalInterest: UILabel!
    
    
    var pickerData: [String] = ["Monthly", "Quarterly", "Half Yearly", "Annually"]
    var termSelected:String = "Monthly"
    
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            interestType = "Simple"
            self.picker.isUserInteractionEnabled = false
            break
        case 1:
            interestType = "Compound"
            self.picker.isUserInteractionEnabled = true
            break
        default:
            interestType = "Simple"
            break
        }
    }
    
    @IBAction func simpleInterest(_ sender: Any) {

        if Double(principleTF.text!) == nil || Double(principleTF.text!)! <= 0{
            principleTF.layer.borderColor = UIColor.red.cgColor
            principleTF.layer.borderWidth = 1.0
            return
        }
        if Double(rateTF.text!) == nil{
            rateTF.layer.borderColor = UIColor.red.cgColor
            rateTF.layer.borderWidth = 1.0
            return
        }
        if Double(termTF.text!) == nil || Double(termTF.text!)! <= 0{
            termTF.layer.borderColor = UIColor.red.cgColor
            termTF.layer.borderWidth = 1.0
            return
        }
        
        let principle = Double(principleTF.text!)!
        var rate = Double(rateTF.text!)!
        rate = rate / 100
        let term = Double(termTF.text!)!
        
        if(interestType == "Simple"){
            let simpleInt = principle * (1 + (rate * term))
            result.text = String(simpleInt)
            totalInterest.text = String(format: "%.8f", (simpleInt - principle))
        }
        else{
            var n: Double = 12
            if termSelected == "Monthly"{
                n = 12
            }
            
            if termSelected == "Quarterly"{
                n = 4
            }
            
            if termSelected == "Half Yearly"{
                n = 2
            }
            
            if termSelected == "Annually"{
                n = 1
            }
            let temp = pow((1+(rate/n)), (n*term))
            let compInt = principle * temp
            result.text = String(format: "%.8f", compInt)
            totalInterest.text = String(format: "%.4f", (compInt - principle))
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segment.selectedSegmentIndex = 0
        self.picker.isUserInteractionEnabled = false
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension SecondViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        termSelected = pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}

