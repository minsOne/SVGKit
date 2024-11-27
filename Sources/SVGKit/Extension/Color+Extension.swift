//
//  Color+Extension.swift
//  SVGKit
//
//  Created by minsOne on 11/28/24.
//

import SwiftUI

extension Color {
    /// 16진수 색상 문자열로 Color 객체 생성
    /// - Parameter hex: `#RRGGBB` 또는 `#RRGGBBAA` 형식의 문자열
    init?(hex: String) {
        // 문자열에서 `#` 제거
        var hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

        // 색상 값의 길이에 따라 처리
        if hexString.count == 6 {
            hexString.append("FF") // 투명도 값 추가 (불투명)
        }

        guard hexString.count == 8, let hexValue = UInt64(hexString, radix: 16) else {
            return nil // 유효하지 않은 입력 처리
        }

        // 색상 컴포넌트 추출
        let red = Double((hexValue >> 24) & 0xFF) / 255.0
        let green = Double((hexValue >> 16) & 0xFF) / 255.0
        let blue = Double((hexValue >> 8) & 0xFF) / 255.0
        let alpha = Double(hexValue & 0xFF) / 255.0

        // SwiftUI Color 생성
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
