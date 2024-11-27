//
//  SVGParser+Helper.swift
//  SVGKit
//
//  Created by minsOne on 11/27/24.
//

import Foundation

extension SVGParser {
    struct RectParser {
        let element: SVGElement

        init?(attr: [String: String], style: SVGStyle) {
            guard
                let x = attr["x"],
                let y = attr["y"],
                let width = attr["width"],
                let height = attr["height"],
                let xVal = Double(x),
                let yVal = Double(y),
                let wVal = Double(width),
                let hVal = Double(height)
            else { return nil }

            element = .rect(
                x: CGFloat(xVal),
                y: CGFloat(yVal),
                width: CGFloat(wVal),
                height: CGFloat(hVal),
                style: style
            )
        }
    }
}

extension SVGParser {
    struct CircleParser {
        let element: SVGElement
        init?(attr: [String: String], style: SVGStyle) {
            guard
                let cx = attr["cx"],
                let cy = attr["cy"],
                let r = attr["r"],
                let cxVal = Double(cx),
                let cyVal = Double(cy),
                let rVal = Double(r)
            else { return nil }

            element = .circle(
                cx: CGFloat(cxVal),
                cy: CGFloat(cyVal),
                r: CGFloat(rVal),
                style: style
            )
        }
    }
}

extension SVGParser {
    struct EllipseParser {
        let element: SVGElement
        init?(attr: [String: String], style: SVGStyle) {
            guard
                let cx = attr["cx"],
                let cy = attr["cy"],
                let rx = attr["rx"],
                let ry = attr["ry"],
                let cxVal = Double(cx),
                let cyVal = Double(cy),
                let rxVal = Double(rx),
                let ryVal = Double(ry)
            else { return nil }

            element = .ellipse(
                cx: CGFloat(cxVal),
                cy: CGFloat(cyVal),
                rx: CGFloat(rxVal),
                ry: CGFloat(ryVal),
                style: style
            )
        }
    }
}

extension SVGParser {
    struct LineParser {
        let element: SVGElement
        init?(attr: [String: String], style: SVGStyle) {
            guard
                let x1 = attr["x1"],
                let y1 = attr["y1"],
                let x2 = attr["x2"],
                let y2 = attr["y2"],
                let x1Val = Double(x1),
                let y1Val = Double(y1),
                let x2Val = Double(x2),
                let y2Val = Double(y2)
            else { return nil }

            element = .line(
                x1: CGFloat(x1Val),
                y1: CGFloat(y1Val),
                x2: CGFloat(x2Val),
                y2: CGFloat(y2Val),
                style: style
            )
        }
    }
}

extension SVGParser {
    struct PolygonParser {
        let element: SVGElement
        init?(attr: [String: String], currentElement: String, style: SVGStyle) {
            guard
                let points = attr["points"]
            else { return nil }

            let pointsArray = points
                .split(separator: " ")
                .compactMap { point -> CGPoint? in
                    let coords = point.split(separator: ",").compactMap { Double($0) }
                    guard coords.count == 2 else { return nil }
                    return CGPoint(x: CGFloat(coords[0]),
                                   y: CGFloat(coords[1]))
                }
            if currentElement == "polygon" {
                element = .polygon(
                    points: pointsArray,
                    style: style
                )
            } else {
                element = .polyline(
                    points: pointsArray,
                    style: style
                )
            }
        }
    }
}

extension SVGParser {
    struct PathParser {
        let element: SVGElement
        init?(attr: [String: String], style: SVGStyle) {
            guard
                let d = attr["d"]
            else { return nil }

            element = .path(
                data: d,
                style: style
            )
        }
    }
}
