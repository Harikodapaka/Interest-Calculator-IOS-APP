//
//  FourthViewController.swift
//  InterestCalculator
//
//  Created by Chaitanya Kodapaka on 2019-07-16.
//  Copyright © 2019 Bank. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    @IBOutlet weak var loan: UITextField!
    @IBOutlet weak var rate: UITextField!
    @IBOutlet weak var term: UITextField!
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var totalInterest: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = ["Monthly", "Quarterly", "Half Yearly", "Annually"]
    var termSelected:String = "Monthly"
    
    @IBAction func loanEMI(_ sender: Any) {
        
        if Double(loan.text!) == nil || Double(loan.text!)! <= 0{
            loan.layer.borderColor = UIColor.red.cgColor
            loan.layer.borderWidth = 1.0
            return
        }
        if Double(rate.text!) == nil{
            rate.layer.borderColor = UIColor.red.cgColor
            rate.layer.borderWidth = 1.0
            return
        }
        if Double(term.text!) == nil || Double(term.text!)! <= 0{
            term.layer.borderColor = UIColor.red.cgColor
            term.layer.borderWidth = 1.0
            return
        }
        
        let p = Double(loan.text!)!
        var r = Double(rate.text!)!
        r = r / 100
        let t = Double(term.text!)!

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
        //    A = P × (1 + r/n)nt
        let tem = (1 + r / n)
        let a = p * pow(tem, (n*t))
        
        result.text = String(format: "%.8f", a)
        totalInterest.text = String(format: "%.4f", (a - p))
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension FourthViewController: UIPickerViewDelegate,UIPickerViewDataSource{
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
