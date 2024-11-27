//
//  SVGPathParser.swift
//  SVGKit
//
//  Created by minsOne on 11/27/24.
//

import Foundation
import SwiftUI

// SVGPathParser: SVG의 <path> 데이터를 SwiftUI Path로 변환
enum SVGPathParser {
    // SVG Path 명령어를 Path로 변환
    static func parse(pathData: String) -> Path {
        var path = Path()
        var currentPoint: CGPoint = .zero
        var startPoint: CGPoint = .zero
        
        let commands = pathData.split(separator: " ").map { String($0) }
        
        var index = 0
        while index < commands.count {
            let command = commands[index]
            
            switch command {
            case "M": // Move to
                if let x = Double(commands[index + 1]),
                   let y = Double(commands[index + 2])
                {
                    let newPoint = CGPoint(x: x, y: y)
                    path.move(to: newPoint)
                    currentPoint = newPoint
                    startPoint = newPoint
                    index += 3
                }
            case "C": // Cubic Bézier Curve
                if let x1 = Double(commands[index + 1]),
                   let y1 = Double(commands[index + 2]),
                   let x2 = Double(commands[index + 3]),
                   let y2 = Double(commands[index + 4]),
                   let x = Double(commands[index + 5]),
                   let y = Double(commands[index + 6])
                {
                    path.addCurve(to: CGPoint(x: x, y: y),
                                  control1: CGPoint(x: x1, y: y1),
                                  control2: CGPoint(x: x2, y: y2))
                    currentPoint = CGPoint(x: x, y: y)
                    index += 7
                }
            case "Q": // Quadratic Bézier Curve
                if let x1 = Double(commands[index + 1]),
                   let y1 = Double(commands[index + 2]),
                   let x = Double(commands[index + 3]),
                   let y = Double(commands[index + 4])
                {
                    path.addQuadCurve(to: CGPoint(x: x, y: y),
                                      control: CGPoint(x: x1, y: y1))
                    currentPoint = CGPoint(x: x, y: y)
                    index += 5
                }
            case "A": // Arc
                if let rx = Double(commands[index + 1]),
                   let ry = Double(commands[index + 2]),
                   let xAxisRotation = Double(commands[index + 3]),
                   let largeArcFlag = Int(commands[index + 4]),
                   let sweepFlag = Int(commands[index + 5]),
                   let x = Double(commands[index + 6]),
                   let y = Double(commands[index + 7])
                {
                    let endPoint = CGPoint(x: x, y: y)
                    path.addArc(center: computeArcCenter(from: currentPoint,
                                                         to: endPoint,
                                                         rx: rx, ry: ry,
                                                         xAxisRotation: xAxisRotation,
                                                         largeArcFlag: largeArcFlag,
                                                         sweepFlag: sweepFlag),
                                radius: CGFloat(rx),
                                startAngle: .zero,
                                endAngle: Angle(degrees: 360),
                                clockwise: sweepFlag == 0)
                    currentPoint = endPoint
                    index += 8
                }
            case "Z": // Close Path
                path.closeSubpath()
                currentPoint = startPoint
                index += 1
            default:
                index += 1
            }
        }
        
        return path
    }
    
    /// 타원의 중심 계산
    static func computeArcCenter(from startPoint: CGPoint,
                                 to endPoint: CGPoint,
                                 rx: Double,
                                 ry: Double,
                                 xAxisRotation: Double,
                                 largeArcFlag: Int,
                                 sweepFlag: Int) -> CGPoint
    {
        // (이 부분은 실제 구현 필요 - 타원 중심 계산 수식 필요)
        return CGPoint(x: (startPoint.x + endPoint.x) / 2,
                       y: (startPoint.y + endPoint.y) / 2)
    }
}
