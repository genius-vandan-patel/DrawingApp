//
//  CanvasImageView.swift
//  DrawingApp
//
//  Created by Vandan Patel on 12/8/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import UIKit

class CanvasImageView: UIImageView {
    
    var lineColor: UIColor!
    var lineWidth: CGFloat!
    var startingPoint: CGPoint!
    var touchPoint: CGPoint!
    var path: UIBezierPath!
    var drawMode = false
    
    override func layoutSubviews() {
        self.isMultipleTouchEnabled = true
        
        lineColor = .black
        lineWidth = 2.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startingPoint = touch?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        touchPoint = touch?.location(in: self)
        
        path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: touchPoint)
        startingPoint = touchPoint
        if self.drawMode { drawShapeLayer() }
    }
    
    func drawShapeLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
        self.setNeedsDisplay()
    }
    
    func clearCanvas() {
        path.removeAllPoints()
        self.layer.sublayers = nil
        self.setNeedsDisplay()
    }
}







