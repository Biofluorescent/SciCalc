//
//  ViewController.swift
//  SciCalc
//
//  Created by Tanner Quesenberry on 12/13/18.
//  Copyright © 2018 Tanner Quesenberry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sin: UIButton!
    @IBOutlet weak var cos: UIButton!
    @IBOutlet weak var tan: UIButton!
    @IBOutlet weak var log: UIButton!
    @IBOutlet weak var ln: UIButton!
    @IBOutlet weak var yToX: UIButton!
    @IBOutlet weak var displayNumber: UILabel!
    @IBOutlet var memoryDisplay: UILabel!
    @IBOutlet var degRadLabel: UILabel!
    @IBOutlet var degRadButton: UIButton!
    
    private var inverseActive : Bool = false
    private var isFinishedTypingNumber : Bool = false
    

    private var memoryValue : Double {
        get {
            guard let number = Double(memoryDisplay.text!) else {
                fatalError("Cannot convert display label text to Double.")
            }
            return number
        }
        set {
            memoryDisplay.text = String(newValue)
        }
    }
 
 
    private var displayValue : Double {
        get {
            guard let number = Double(displayNumber.text!) else {
                fatalError("Cannot convert display label text to Double.")
            }
            return number
        }
        set {
            displayNumber.text = String(newValue)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = calculator.calculate(symbol: "C")
    }

    @IBAction func measureChange(_ sender: UIButton) {
        if sender.titleLabel?.text == "Degree" {
            degRadButton.setTitle("Radian", for: .normal)
            degRadLabel.text = "Rad"
        }else {
            degRadButton.setTitle("Degree", for: .normal)
            degRadLabel.text = "Deg"
        }
        
        calculator.invertAngle()
    }
    
    @IBAction func inverseButtonPressed(_ sender: Any) {
        if inverseActive == false {
            sin.setTitle("sin⁻¹", for: .normal)
            cos.setTitle("cos⁻¹", for: .normal)
            tan.setTitle("tan⁻¹", for: .normal)
            log.setTitle("10ˣ", for: .normal)
            ln.setTitle("eˣ", for: .normal)
            yToX.setTitle("ˣ√y", for: .normal)
            inverseActive = true
        }else {
            sin.setTitle("sin", for: .normal)
            cos.setTitle("cos", for: .normal)
            tan.setTitle("tan", for: .normal)
            log.setTitle("log", for: .normal)
            ln.setTitle("ln", for: .normal)
            yToX.setTitle("yˣ", for: .normal)
            inverseActive = false
        }
    }
    
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            if let result = calculator.calculate(symbol: calcMethod){
                displayValue = result
            }
            
            if calcMethod == "CE" { memoryValue = 0 }
        }
        
    }
    
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
//        print(sender.tag)
        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber {
                displayNumber.text = numValue
                isFinishedTypingNumber = false
            } else {
                
                if numValue == "." {
                    
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                }
                displayNumber.text = displayNumber.text! + numValue
            }
        }
    }
    
    @IBAction func memoryButtonPressed(_ sender: UIButton) {
        
        if let memMethod = sender.currentTitle {
            if let result = calculator.updateMemory(symbol: memMethod, input: displayValue) {
                memoryValue = result
                
                if memMethod == "MR" {
                    displayValue = result
                }
            }
        }
        
    }
    
}

