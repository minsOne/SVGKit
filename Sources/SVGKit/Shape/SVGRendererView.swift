//
//  SVGRendererView.swift
//  SVGKit
//
//  Created by minsOne on 11/27/24.
//

import Foundation
import SwiftUI

struct SVGRendererView: View {
    let svgElements: [SVGElement]
    
    var body: some View {
        ZStack {
            ForEach(self.svgElements, id: \.self) { element in
                switch element {
                case let .rect(x, y, width, height, style):
                    SVGRect(x: x, y: y, width: width, height: height)
                        .applyStyle(style)
                case let .circle(cx, cy, r, style):
                    SVGCircle(cx: cx, cy: cy, r: r)
                        .applyStyle(style)
                        .background(Color.red)
                    
                case let .ellipse(cx, cy, rx, ry, style):
                    SVGEllipse(cx: cx, cy: cy, rx: rx, ry: ry)
                        .applyStyle(style)
                        .background(Color.blue)
                    
                case let .line(x1, y1, x2, y2, style):
                    SVGLine(x1: x1, y1: y1, x2: x2, y2: y2)
                        .applyStyle(style)
                    
                case let .polygon(points, style):
                    SVGPolygon(points: points, isClosed: true)
                        .applyStyle(style)
                    
                case let .polyline(points, style):
                    SVGPolygon(points: points, isClosed: false)
                        .applyStyle(style)
                    
                case let .path(data, style):
                    SVGPathParser.parse(pathData: data)
                        .applyStyle(style)
                }
            }
        }
    }
}

// 스타일 적용 Modifier
extension Shape {
    func applyStyle(_ style: SVGStyle) -> some View {
        self.fill(style.fill ?? .clear)
            .overlay(self.stroke(style.stroke ?? .clear, lineWidth: style.strokeWidth ?? 1))
    }
}
