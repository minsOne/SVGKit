//
//  SVGElement.swift
//  SVGKit
//
//  Created by minsOne on 11/27/24.
//

import Foundation
import SwiftUI

// SVG 도형 데이터 구조체
enum SVGElement: Hashable {
    case rect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, style: SVGStyle)
    case circle(cx: CGFloat, cy: CGFloat, r: CGFloat, style: SVGStyle)
    case ellipse(cx: CGFloat, cy: CGFloat, rx: CGFloat, ry: CGFloat, style: SVGStyle)
    case line(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, style: SVGStyle)
    case polygon(points: [CGPoint], style: SVGStyle)
    case polyline(points: [CGPoint], style: SVGStyle)
    case path(data: String, style: SVGStyle)
}

