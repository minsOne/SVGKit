//
//  ContentView.swift
//  SVGKit
//
//  Created by minsOne on 11/27/24.
//

#if DEBUG
import SwiftUI

struct ContentView: View {
    var body: some View {
        // SVG 데이터 입력
        let svgData = """
        <svg xmlns="http://www.w3.org/2000/svg" width="400" height="400">
        <rect x="50" y="50" width="100" height="100" fill="red" stroke="black" stroke-width="2"/>
        <circle cx="200" cy="200" r="50" fill="blue" stroke="black" stroke-width="2"/>
        <ellipse cx="300" cy="150" rx="60" ry="40" fill="green" stroke="black" stroke-width="2"/>
        <line x1="50" y1="200" x2="150" y2="200" stroke="purple" stroke-width="2"/>
        <polygon points="200,50 250,150 150,150" fill="orange" stroke="black" stroke-width="2"/>
        <polyline points="100,100 150,150 100,200" fill="transparent" stroke="black" stroke-width="2"/>
        <path d="M 300 300 C 350 350, 400 350, 450 300" fill="transparent" stroke="black" stroke-width="2"/>
        </svg>
        """
        let parser = SVGParser()
        let elements = parser.parse(data: Data(svgData.utf8))

        return SVGRendererView(svgElements: elements)
    }
}

#Preview {
    ContentView()
}

#endif
