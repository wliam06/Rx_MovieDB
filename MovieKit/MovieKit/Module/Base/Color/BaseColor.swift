//
//  BaseColor.swift
//  MovieKit
//
//  Created by William on 14/08/22.
//

import UIKit

public extension UIColor {
    convenience init?(hex: String) {
        let rColor, gColor, bColor, aColor: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    rColor = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    gColor = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    bColor = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    aColor = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(
                        red: rColor,
                        green: gColor,
                        blue: bColor,
                        alpha: aColor
                    )

                    return
                }
            }
        }

        return nil
    }
}

public extension UIColor {
    class var yellowStar: UIColor { UIColor(hex: "#efa906FF")! }
}
