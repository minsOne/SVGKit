//
//  SVGRect.swift
//  SVGKit
//
//  Created by minsOne on 11/27/24.
//

import SwiftUI

// Rectangle
struct SVGRect: Shape {
    let x: CGFloat
    let y: CGFloat
    let width: CGFloat
    let height: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: x, y: y, width: width, height: height))
        return path
    }
}

// Circle
struct SVGCircle: Shape {
    let cx: CGFloat
    let cy: CGFloat
    let r: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: CGRect(x: cx - r, y: cy - r, width: 2 * r, height: 2 * r))
        return path
    }
}

// Ellipse
struct SVGEllipse: Shape {
    let cx: CGFloat
    let cy: CGFloat
    let rx: CGFloat
    let ry: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: CGRect(x: cx - rx, y: cy - ry, width: 2 * rx, height: 2 * ry))
        return path
    }
}

// Line
struct SVGLine: Shape {
    let x1: CGFloat
    let y1: CGFloat
    let x2: CGFloat
    let y2: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: x1, y: y1))
        path.addLine(to: CGPoint(x: x2, y: y2))
        return path
    }
}

// Polygon/Polyline
struct SVGPolygon: Shape {
    let points: [CGPoint]
    let isClosed: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard let firstPoint = points.first else { return path }
        path.move(to: firstPoint)
        for point in points.dropFirst() {
            path.addLine(to: point)
        }
        if isClosed {
            path.closeSubpath()
        }
        return path
    }
}
