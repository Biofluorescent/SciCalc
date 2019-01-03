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
    
    private var inverseActive : Bool = false
    private var isFinishedTypingNumber : Bool = false
    var memoryNumber : Double = 0
    
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
        // Do any additional setup after loading the view, typically from a nib.
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
    
    
}

