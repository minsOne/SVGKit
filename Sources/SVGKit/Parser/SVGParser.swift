//
//  SVGParser.swift
//  SVGKit
//
//  Created by minsOne on 11/27/24.
//

import Foundation

// SVGParser: XML을 분석하여 도형 요소들을 추출
final class SVGParser: NSObject, XMLParserDelegate {
    private var elements: [SVGElement] = []
    private var currentElement: String = ""
    private var attributes: [String: String] = [:]

    func parse(data: Data) -> [SVGElement] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return elements
    }

    // XMLParserDelegate - 시작 태그 감지
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]) {
        currentElement = elementName
        attributes = attributeDict
    }

    // XMLParserDelegate - 종료 태그 감지
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        let style = SVGStyle(attributes: attributes)
        let element: SVGElement?
        switch currentElement {
        case "rect":
            element = RectParser(attr: attributes, style: style)?.element
        case "circle":
            element = CircleParser(attr: attributes, style: style)?.element
        case "ellipse":
            element = EllipseParser(attr: attributes, style: style)?.element
        case "line":
            element = LineParser(attr: attributes, style: style)?.element
        case "polygon", "polyline":
            element = PolygonParser(attr: attributes, currentElement: currentElement, style: style)?.element
        case "path":
            element = PathParser(attr: attributes, style: style)?.element
        default:
            element = nil
        }

        if let element {
            elements.append(element)
        }
    }
}
