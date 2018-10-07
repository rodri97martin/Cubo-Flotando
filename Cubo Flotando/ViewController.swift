//
//  ViewController.swift
//  Cubo Flotando
//
//  Created by Rodrigo "Steve Jobs" Martín Martín on 25/09/2018.
//  Copyright © 2018 Rodri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ParametricFunctionViewDataSource {
    
    let model = CubeModel()
    
    @IBOutlet weak var positionFuncView: ParametricFunctionView!
    @IBOutlet weak var speedFuncView: ParametricFunctionView!
    @IBOutlet weak var acelerationFuncView: ParametricFunctionView!
    @IBOutlet weak var speedPositionFuncView: ParametricFunctionView!
    
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var timeSlider: UISlider!
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var func1Label: UILabel!
    @IBOutlet weak var func2Label: UILabel!
    @IBOutlet weak var func3Label: UILabel!
    
    
    let colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.orange, UIColor.yellow, UIColor.gray, UIColor.brown, UIColor.cyan, UIColor.darkGray, UIColor.lightGray, UIColor.magenta, UIColor.purple]
    
    var time: Double = 0.0 {
        didSet {
            positionFuncView.setNeedsDisplay()
            speedFuncView.setNeedsDisplay()
            acelerationFuncView.setNeedsDisplay()
            speedPositionFuncView.setNeedsDisplay()
        }
    }
    
    var size: Double = 1.0 {
        didSet {
            positionFuncView.setNeedsDisplay()
            speedFuncView.setNeedsDisplay()
            acelerationFuncView.setNeedsDisplay()
            speedPositionFuncView.setNeedsDisplay()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        positionFuncView.dataSource = self
        speedFuncView.dataSource = self
        acelerationFuncView.dataSource = self
        speedPositionFuncView.dataSource = self
        
        defaultColors()

        timeSlider.sendActions(for: .valueChanged)
        sizeSlider.sendActions(for: .valueChanged)
    }
    
    
    @IBAction func updateTime(_ sender: UISlider) {
        
        time = Double(sender.value)
        let t = round(100*time)/100
        timeLabel.text = String(t) + " s"
        
        let z = model.cubePosition(time: time, size: size)
        let label1 = round(100*z)/100
        func1Label.text = String(label1) + " m"
        
        let v = model.cubeSpeed(time: time, size: size)
        let label2 = round(100*v)/100
        func2Label.text = String(label2) + " m/s"
        
        let a = model.cubeAceleration(time: time, size: size)
        let label3 = round(100*a)/100
        func3Label.text = String(label3) + " m/s^2"
    
    }
    
    @IBAction func updateSize(_ sender: UISlider) {
        
        size = Double(sender.value)
        let s = round(100*size)/100
        sizeLabel.text = String(s) + " m"
        
        let z = model.cubePosition(time: time, size: size)
        let label1 = round(100*z)/100
        func1Label.text = String(label1) + " m"
        
        let v = model.cubeSpeed(time: time, size: size)
        let label2 = round(100*v)/100
        func2Label.text = String(label2) + " m/s"
        
        let a = model.cubeAceleration(time: time, size: size)
        let label3 = round(100*a)/100
        func3Label.text = String(label3) + " m/s^2"
        
    }
    
    @IBAction func setDefaultValues(_ sender: UILongPressGestureRecognizer) {
        timeSlider.value = 5
        sizeSlider.value = 13
        updateSize(sizeSlider)
        updateTime(timeSlider)
        defaultColors()
    }
    
    @IBAction func nextColorForPTFunc(_ sender: UISwipeGestureRecognizer) {
        nextColor(positionFuncView)
    }
    
    @IBAction func nextColorForSTFunc(_ sender: UISwipeGestureRecognizer) {
        nextColor(speedFuncView)
    }
    
    @IBAction func nextColorForATFunc(_ sender: UISwipeGestureRecognizer) {
        nextColor(acelerationFuncView)
    }
    
    @IBAction func nextColorForSPFunc(_ sender: UISwipeGestureRecognizer) {
        nextColor(speedPositionFuncView)
    }
    
    @IBAction func previousColorForPTFunc(_ sender: UISwipeGestureRecognizer) {
        previousColor(positionFuncView)
    }
    
    @IBAction func previousColorForSTFunc(_ sender: UISwipeGestureRecognizer) {
        previousColor(speedFuncView)
    }
    
    @IBAction func previousColorForATFunc(_ sender: UISwipeGestureRecognizer) {
        previousColor(acelerationFuncView)
    }
    
    @IBAction func previousColorForSPFunc(_ sender: UISwipeGestureRecognizer) {
        previousColor(speedPositionFuncView)
    }
    
    func startIndexFor(_ functionView: ParametricFunctionView) -> Double {
        return 0
    }
    
    func endIndexFor(_ functionView: ParametricFunctionView) -> Double {
        return 10
    }
    
    func functionView(_ functionView: ParametricFunctionView, pointAt index: Double) -> FunctionPoint {
        
        setScale(functionView)
        let t = index
        switch functionView {
        case positionFuncView:
            let z = model.cubePosition(time: t, size: size)
            return FunctionPoint(x: t, y: z)
        case speedFuncView:
            let v = model.cubeSpeed(time: t, size: size)
            return FunctionPoint(x: t, y: v)
        case acelerationFuncView:
            let a = model.cubeAceleration(time: t, size: size)
            return FunctionPoint(x: t, y: a)
        case speedPositionFuncView:
            let z = model.cubePosition(time: t, size: size)
            let v = model.cubeSpeed(time: t, size: size)
            return FunctionPoint(x: z, y: v)
        default:
            return FunctionPoint(x: 0, y: 0)
        }
    }
    
    func pointsOfInterestFor(_ functionView: ParametricFunctionView) -> [FunctionPoint] {
        
        let t = time
        switch functionView {
        case positionFuncView:
            let z = model.cubePosition(time: t, size: size)
            return [FunctionPoint(x: t, y: z)]
        case speedFuncView:
            let v = model.cubeSpeed(time: t, size: size)
            return [FunctionPoint(x: t, y: v)]
        case acelerationFuncView:
            let a = model.cubeAceleration(time: t, size: size)
            return [FunctionPoint(x: t, y: a)]
        case speedPositionFuncView:
            let z = model.cubePosition(time: t, size: size)
            let v = model.cubeSpeed(time: t, size: size)
            return [FunctionPoint(x: z, y: v)]
        default:
            return [FunctionPoint(x: 0, y: 0)]
        }
    }
    
    func setScale(_ functionView: ParametricFunctionView){
        if functionView == speedPositionFuncView {
            functionView.scaleX = Double((functionView.bounds.size.width * 8) / 414)
            functionView.scaleY = Double((functionView.bounds.size.height * 8) / 337.5)
        } else {
            functionView.scaleX = Double((functionView.bounds.size.width * 21) / 414)
            functionView.scaleY = Double((functionView.bounds.size.height * 2) / 112.5)
        }
    }
    
    func defaultColors() {
        positionFuncView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        speedFuncView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        acelerationFuncView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        speedPositionFuncView.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
    }
    
    func nextColor(_ functionView :ParametricFunctionView) {
        let newColor = (functionView.counter + 1) % colors.count
        functionView.counter += 1
        functionView.backgroundColor = colors[newColor].withAlphaComponent(0.5)
    }
    
    func previousColor(_ functionView :ParametricFunctionView) {
        let newColor = (functionView.counter + colors.count - 1) % colors.count
        functionView.counter += (colors.count - 1)
        functionView.backgroundColor = colors[newColor].withAlphaComponent(0.5)
    }
}

