//
//  ViewController.swift
//  Final Grade Calculator
//
//  Created by Michael Karpov on 10/1/19.
//  Copyright © 2019 mkarpov@bhs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Importing all of the required outlets
    @IBOutlet weak var currentGrade: UITextField!
    @IBOutlet weak var finalWeight: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var explicitGrade: UITextField!
    @IBOutlet weak var helpCurrentGrade: UILabel!
    @IBOutlet weak var helpWeight: UILabel!
    @IBOutlet weak var letterGrade: UISegmentedControl!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var Errorbox: UILabel!
    
    //Making the help functions
    @IBAction func helpGrade(_ sender: Any) {
        if helpCurrentGrade.alpha == 0 {
            helpCurrentGrade.alpha = 1
        } else {
            helpCurrentGrade.alpha = 0
        }
    }
    
    @IBAction func helpFinalWeight(_ sender: Any) {
        if helpWeight.alpha == 0 {
            helpWeight.alpha = 1
        } else {
            helpWeight.alpha = 0
        }
    }
    
    // Main code
    var DesiredGrade:Float = 90.0 // declaring desired grade
    var CurrentGrade:Float = 100.0 // declaring current grade
    var examWeight:Float = 0.20 //
    
    @IBAction func selectGradeType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            letterGrade.isHidden = true
            explicitGrade.isHidden = false
            calculateButton.isHidden = false
        case 1:
            letterGrade.isHidden = false
            explicitGrade.isHidden = true
            calculateButton.isHidden = true
        default:
            break
        }
    }
    
    func updateValues() {
        view.endEditing(true)
        if let placeHolderCG = Float(currentGrade.text!) {
            CurrentGrade = placeHolderCG
            
            if let placeHolderEW = Float(finalWeight.text!) {
                examWeight = placeHolderEW / 100
                //get explicit grade
                if let placeholderDG = Float(explicitGrade.text!) {
                    DesiredGrade = placeholderDG
                }
                
            } else {
                Errorbox.text = "ERROR; No weight specified"
            }
        } else {
            Errorbox.text = "ERROR; No current grade specified"
        }
    }
    
    @IBAction func calculateGrade(_ sender: Any) {
    

        updateValues()
        
        let requiredGrade = (DesiredGrade-(1-examWeight)*CurrentGrade)/examWeight
        
        if requiredGrade > 100 || requiredGrade < 0 {
            view.backgroundColor = .red
            Errorbox.text = "You cannot get your desired grade"
        } else {
            view.backgroundColor = .green
            Errorbox.text = ""
        }
        
        outputLabel.text = "%" + String(round(num: requiredGrade))
    }
    
    func round(num: Float) -> Float {
        return Float(floorf(100*num)/100)
    }
    
    @IBAction func letterGradeChosen(_ sender: UISegmentedControl) {
    
    updateValues()
        switch sender.selectedSegmentIndex {
        case 0:
            DesiredGrade = 60
        case 1:
            DesiredGrade = 70
        case 2:
            DesiredGrade = 80
        case 3:
            DesiredGrade = 90
        default:
            break
        }
        
        let requiredGrade = (DesiredGrade-(1-examWeight)*CurrentGrade)/examWeight
        
        if requiredGrade > 100 || requiredGrade < 0 {
            view.backgroundColor = .red
            Errorbox.text = "You cannot get your desired grade"
            
        } else {
            view.backgroundColor = .green
            Errorbox.text = ""
        }
        
        outputLabel.text =  String(round(num: requiredGrade)) + "%"
    }
    

}

