//
//  ViewController.swift
//  Cubo Flotando
//
//  Created by Rodrigo Martín Martín on 25/09/2018.
//  Copyright © 2018 Rodri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ParametricFunctionViewDataSource {
    
    func startIndexFor(_ functionView: ParametricFunctionView) -> Double {
        return 2.0
    }
    
    func endIndexFor(_ functionView: ParametricFunctionView) -> Double {
        return 2.0
    }
    
    func functionView(_ functionView: ParametricFunctionView, pointAt index: Double) -> FunctionPoint {
        return FunctionPoint(x: 0.0, y: 0.0)
    }
    
    func pointsOfInterestFor(_ functionView: ParametricFunctionView) -> [FunctionPoint] {
        return [FunctionPoint(x: 0.0, y: 0.0)]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

