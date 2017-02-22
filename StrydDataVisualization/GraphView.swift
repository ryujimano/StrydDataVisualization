//
//  GraphView.swift
//  StrydDataVisualization
//
//  Created by Ryuji Mano on 2/21/17.
//  Copyright © 2017 Ryuji Mano. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable class GraphView: UIView {
    @IBOutlet var powerLabel: UILabel!
    @IBOutlet var heartLabel: UILabel!
    
    var startColor: UIColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
    var endColor: UIColor = UIColor.orange.withAlphaComponent(0.7)
    
    var stryd: Stryd?
    
    var isPower = true
    var isHeart = true
    
    var width: CGFloat!
    var height: CGFloat!
    
    var path: UIBezierPath!
    
    var context: CGContext!
    
    var startPoint: CGPoint!
    var endPoint: CGPoint!
    
    let margin:CGFloat = 20
    let topBorder:CGFloat = 60
    let bottomBorder:CGFloat = 50
    var graphHeight:CGFloat!

    override func draw(_ rect: CGRect) {
        
        width = rect.width
        height = rect.height
        
        powerLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        heartLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 10, height: 10))
        path.addClip()
        
        
        let context = UIGraphicsGetCurrentContext()
        
        let colors = [startColor.cgColor, endColor.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations: [CGFloat] = [0, 1]
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)
        
        startPoint = CGPoint.zero
        endPoint = CGPoint(x: 0, y: self.bounds.height)
        
        context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
    
        graphHeight = height - topBorder - bottomBorder
        
        let yLinePath = UIBezierPath()
        yLinePath.move(to: CGPoint(x: margin, y: topBorder))
        yLinePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
        
        yLinePath.move(to: CGPoint(x: margin, y: graphHeight / 2 + topBorder))
        yLinePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 2 + topBorder))
        
        yLinePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        yLinePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        
        yLinePath.move(to: CGPoint(x: margin, y: topBorder))
        yLinePath.addLine(to: CGPoint(x: margin, y: height - bottomBorder))
        
        yLinePath.move(to: CGPoint(x: width - margin, y: topBorder))
        yLinePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        
        let color = UIColor(white: 1, alpha: 0.4)
        color.setStroke()
        
        yLinePath.lineWidth = 1
        yLinePath.stroke()
        
        
        if let stryd = stryd {
            if isPower {
                drawPowerLine(stryd: stryd)
            }
            if isHeart {
                drawHearRateLine(stryd: stryd)
            }
        }

    }
    
    func drawPowerLine(stryd: Stryd) {
        let columnXPoint = { (column: Int) -> CGFloat in
            let gap = (self.width - self.margin * 2 - 4) / CGFloat(stryd.power.count - 1)
            var x = CGFloat(column) * gap
            x += self.margin + 2
            return x
        }
        
        let maxValue = max((stryd.power.max()) ?? 0, (stryd.heartRate.max()) ?? 0)
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            var y = CGFloat(graphPoint) / CGFloat(maxValue) * self.graphHeight
            y = self.graphHeight + self.topBorder - y
            return y
        }
        
        UIColor.blue.setFill()
        UIColor.blue.setStroke()
        
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnXPoint(stryd.power[0])))
        
        
        for i in 1..<stryd.power.count {
            let next = CGPoint(x: columnXPoint(i), y: columnYPoint(stryd.power[i]))
            graphPath.addLine(to: next)
        }
        graphPath.lineWidth = 1
        graphPath.stroke()
    }
    
    func drawHearRateLine(stryd: Stryd) {
        let columnXPoint = { (column: Int) -> CGFloat in
            let gap = (self.width - self.margin * 2 - 4) / CGFloat(stryd.heartRate.count - 1)
            var x = CGFloat(column) * gap
            x += self.margin + 2
            return x
        }
        
        let maxValue = max((stryd.power.max()) ?? 0, (stryd.heartRate.max()) ?? 0)
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            var y = CGFloat(graphPoint) / CGFloat(maxValue) * self.graphHeight
            y = self.graphHeight + self.topBorder - y
            return y
        }
        
        UIColor.red.setFill()
        UIColor.red.setStroke()
        
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnXPoint(stryd.heartRate[0])))
        
        
        for i in 1..<stryd.heartRate.count {
            let next = CGPoint(x: columnXPoint(i), y: columnYPoint(stryd.heartRate[i]))
            graphPath.addLine(to: next)
        }
        graphPath.lineWidth = 1
        graphPath.stroke()
    }

}
