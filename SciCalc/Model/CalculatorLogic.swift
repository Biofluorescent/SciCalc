//
//  CalculatorLogic.swift
//  SciCalc
//
//  Created by Tanner Quesenberry on 1/2/19.
//  Copyright © 2019 Tanner Quesenberry. All rights reserved.
//

import Foundation
import Darwin

struct CalculatorLogic {
    
    private var number: Double?
    private var memory: Double = 0.0
    private var angle: String = "Rad"
    
    // Optional Tuple
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double){
        self.number = number
    }
    
    mutating func invertAngle() {
        if angle == "Rad" {
            angle = "Deg"
        } else {
            angle = "Rad"
        }
    }
    
    mutating func calculate(symbol: String) -> Double? {
        
        if let n = number {
            switch symbol {
            case "+/-":
                return n * -1
            case "C":
                return 0
            case "CE":
                memory = 0
                return 0
            case "%":
                return n * 0.01
            case "n!":
                return factorial(num: n)
            case "1/x":
                return 1 / n
            case "π":
                return Double.pi
            case "√":
                if n < 0 {
                    return n
                } else {
                    return sqrt(n)
                }
            case "10ˣ":
                return pow(10, n)
            case "log":
                return logC(val: n, forBase: 10)
            case "ln":
                return logC(val: n, forBase: Darwin.M_E)
            case "eˣ":
                return pow(Darwin.M_E, n)
            case "sin":
                if angle == "Deg" { return __sinpi(n/180.0) }
                return sin(n)
            case "sin⁻¹":
                if angle == "Deg" { return asin(n)*180.0/Double.pi }
                return asin(n)
            case "cos":
                if angle == "Deg" { return __cospi(n/180.0) }
                return cos(n)
            case "cos⁻¹":
                if angle == "Deg" { return acos(n)*180.0/Double.pi }
                return acos(n)
            case "tan":
                if angle == "Deg" { return __tanpi(n/180.0) }
                return tan(n)
            case "tan⁻¹":
                if angle == "Deg" { return atan(n)*180.0/Double.pi }
                return atan(n)
                
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
            case "EXP":
                return n1 * pow(10.0, n2)
            case "yˣ":
                return pow(n1, n2)
            case "ˣ√y":
                return pow(n1, (1.0/n2))
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
            
        }
        return nil
    }
    
    private func factorial(num: Double) -> Double {
        if num <= 1 { return num }
        return num * factorial(num: num - 1)
    }
    
    
    mutating func updateMemory(symbol: String, input: Double) -> Double? {
        
        switch symbol {
        case "MC":
            memory = 0
            return 0
        case "MS":
            memory = input
            return memory
        case "MR":
            return memory
        case "M+":
            memory += input
            return memory
        case "M-":
            memory -= input
            return memory
        default:
            fatalError("The operation passed in does not match any of the cases.")
        }
        
    }
    
    func recallMemory() -> Double {
        return memory
    }
    
    private func logC(val: Double, forBase base: Double) -> Double {
        return log(val)/log(base)
    }
    
}
