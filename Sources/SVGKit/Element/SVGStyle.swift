//
//  SVGStyle.swift
//  SVGKit
//
//  Created by minsOne on 11/28/24.
//

import SwiftUI

// SVG 스타일 구조체
struct SVGStyle: Hashable {
    var fill: Color?
    var stroke: Color?
    var strokeWidth: CGFloat?

    init(attributes: [String: String]) {
        self.fill = attributes["fill"]
            .flatMap { $0 == "none" ? nil : Color(hex: $0) }
        self.stroke = attributes["stroke"].flatMap { Color(hex: $0) }
        self.strokeWidth = attributes["stroke-width"]
            .flatMap { Double($0) }
            .map { CGFloat($0) }
    }
}
