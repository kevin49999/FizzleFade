//
//  ViewController.swift
//  FIZZLE
//
//  Created by Kevin Johnson on 2/11/20.
//  Copyright © 2020 Kevin Johnson. All rights reserved.
//

import UIKit

// http://fabiensanglard.net/fizzlefade/index.php 🏆

class ViewController: UIViewController {

    let fizzledPixelsPerFrame: Int = 300
    var rndValue: UInt32 = 1
    var buffer: [Color] = .init(repeating: .black, count: 64_000)
    var timer: Timer!

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        renderFrame() // initially all black
        fizzleFade()
    }

    func fizzleFade() {
        let endFizzledFrames = 64_000 / fizzledPixelsPerFrame
        var fizzledFrames = 0

        func runLoop() {
            if fizzledFrames == endFizzledFrames {
                self.timer.invalidate()
                return
            }
            self.fizzleFrame()
            self.renderFrame()
            fizzledFrames += 1
        }

        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { _ in
            runLoop()
        }
    }

    func fizzleFrame() {
        var fizzled = 0
        repeat {
            let y = UInt16(rndValue & 0x000FF)
            let x = UInt16(UInt32(rndValue & 0x1FF00) >> 8)
            let lsb: UInt32 = rndValue & 1
            rndValue >>= 1
            if lsb == 0 {
                rndValue ^= 0x00012000
            }
            if x < 320 && y < 200 {
                fizzlePixel(x: x, y: y)
                fizzled += 1
            }
        } while rndValue != 1 && fizzled <= fizzledPixelsPerFrame
    }

    func fizzlePixel(x: UInt16, y: UInt16, with color: Color = .red) {
        buffer[Int(y * 320 + x)] = color
    }

    func renderFrame() {
        imageView.image = UIImage(bitmap: Bitmap(
            width: 320,
            height: 200,
            pixels: buffer
        ))
    }
}
