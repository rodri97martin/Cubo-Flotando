//
//  CubeModel.swift
//  Cubo Flotando
//
//  Created by Rodrigo Martín Martín on 25/09/2018.
//  Copyright © 2018 Rodri. All rights reserved.
//

import Foundation

class CubeModel {
 
    let g = 9.8
    
    func omega(_ size: Double) -> Double {
        let w = sqrt(2 * g / size)
        return w
    }
    
    func cubePosition(time: Double, size: Double) -> Double {
        
        let w = omega(size)
        let z = size * cos(w * time) / 2
        return z
    }
    
    func cubeSpeed(time: Double, size: Double) -> Double {
        
        let w = omega(size)
        let v = -size * w * sin(w * time) / 2
        return v
    }
    
    func cubeAceleration(time: Double, size: Double) -> Double {

        let w = omega(size)
        let a = -g * cos(w * time)
        return a
    }
}
