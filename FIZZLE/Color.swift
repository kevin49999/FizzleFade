//
//  Color.swift
//  FIZZLE
//
//  Created by Kevin Johnson on 2/11/20.
//  Copyright © 2020 Kevin Johnson. All rights reserved.
//

import Foundation

struct Color {
    let a: UInt8
    let r: UInt8
    let g: UInt8
    let b: UInt8

    init(a: UInt8 = 0, r: UInt8, g: UInt8, b: UInt8) {
        self.a = a
        self.r = r
        self.g = g
        self.b = b
    }
}

extension Color {
    static let black = Color(r: 0, g: 0, b: 0)
    static let red = Color(r: 255, g: 0, b: 0)
}
