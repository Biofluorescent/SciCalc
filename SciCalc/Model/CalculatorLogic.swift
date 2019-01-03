//
//  CalculatorLogic.swift
//  SciCalc
//
//  Created by Tanner Quesenberry on 1/2/19.
//  Copyright © 2019 Tanner Quesenberry. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var number: Double?
    
    // Optional Tuple
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double){
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double? {
        
        if let n = number {
            switch symbol {
            case "+/-":
                return n * -1
            case "C":
                return 0
            case "%":
                return n * 0.01
            case "=":
                return performTwoNumberCalculation(n2: n)
            default:
                intermediateCalculation = (n1: n, calcMethod: symbol)
            }
            
        }
        return nil
    }
    
    private func performTwoNumberCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod {
            
            switch operation {
            case "+":
                return n1 + n2
            case "*":
                return n1 * n2
            case "÷":
                return n1 / n2
            case "-":
                return n1 - n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
            
        }
        return nil
    }
    
}
