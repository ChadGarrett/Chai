//
//  StyleHelper.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/11.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import UIKit

struct Style {
    struct fontSize {
        static let s: CGFloat = 13
        static let m: CGFloat = 15
        static let l: CGFloat = 17
        static let xl: CGFloat = 19
    }
    
    struct padding {
        static let xxs: CGFloat = 4
        static let xs: CGFloat = 8
        static let s: CGFloat = 12
        static let m: CGFloat = 16
        static let l: CGFloat = 20
        static let xl: CGFloat = 24
    }
    
    struct colors {
        public static let turquoise: UIColor = UIColor(red: 0.10, green: 0.74, blue: 0.61, alpha: 1.0)
        public static let greenSea: UIColor = UIColor(red: 0.09, green: 0.63, blue: 0.52, alpha: 1.0)
        public static let mediumTurquoise: UIColor = UIColor(red: 0.31, green: 0.80, blue: 0.77, alpha: 1.0)
        public static let lightSeaGreen: UIColor = UIColor(red: 0.11, green: 0.64, blue: 0.61, alpha: 1.0)
        public static let emerald: UIColor  = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1.0)
        public static let nephritis: UIColor = UIColor(red: 0.15, green: 0.68, blue: 0.38, alpha: 1.0)
        public static let gossip: UIColor = UIColor(red: 0.53, green: 0.83, blue: 0.49, alpha: 1.0)
        public static let salem: UIColor = UIColor(red: 0.12, green: 0.51, blue: 0.30, alpha: 1.0)
        public static let peterRiver: UIColor = UIColor(red: 0.20, green: 0.60, blue: 0.85, alpha: 1.0)
        public static let belizeHole: UIColor = UIColor(red: 0.16, green: 0.50, blue: 0.73, alpha: 1.0)
        public static let riptide: UIColor = UIColor(red: 0.53, green: 0.89, blue: 0.84, alpha: 1.0)
        public static let dodgerBlue: UIColor = UIColor(red:0.10, green: 0.71, blue: 1.00, alpha: 1.0)
        public static let amethyst: UIColor = UIColor(red: 0.61, green: 0.35, blue: 0.71, alpha: 1.0)
        public static let wisteria: UIColor = UIColor(red: 0.56, green: 0.27, blue: 0.68, alpha: 1.0)
        public static let lightWisteria: UIColor = UIColor(red: 0.75, green: 0.56, blue: 0.83, alpha: 1.0)
        public static let plum: UIColor = UIColor(red: 0.57, green: 0.24, blue: 0.53, alpha: 1.0)
        public static let wetAsphalt: UIColor = UIColor(red: 0.20, green: 0.29, blue: 0.37, alpha: 1.0)
        public static let midnightBlue: UIColor = UIColor(red: 0.17, green: 0.24, blue: 0.31, alpha: 1.0)
        public static let hoki: UIColor = UIColor(red: 0.40, green: 0.50, blue: 0.62, alpha: 1.0)
        public static let ebonyClay: UIColor = UIColor(red: 0.13, green: 0.19, blue: 0.25, alpha: 1.0)
        public static let sunflower: UIColor = UIColor(red: 0.95, green: 0.77, blue: 0.06, alpha: 1.0)
        public static let tangerine: UIColor = UIColor(red: 0.95, green: 0.61, blue: 0.07, alpha: 1.0)
        public static let confetti: UIColor = UIColor(red: 0.91, green: 0.83, blue: 0.38, alpha: 1.0)
        public static let capeHoney: UIColor = UIColor(red: 0.99, green: 0.89, blue: 0.65, alpha: 1.0)
        public static let carrot: UIColor = UIColor(red: 0.90, green: 0.49, blue: 0.13, alpha: 1.0)
        public static let pumpkin: UIColor = UIColor(red: 0.83, green: 0.33, blue: 0.00, alpha: 1.0)
        public static let ecstasy: UIColor = UIColor(red: 0.98, green: 0.41, blue: 0.05, alpha: 1.0)
        public static let jaffa: UIColor = UIColor(red: 0.95, green: 0.47, blue: 0.21, alpha: 1.0)
        public static let alizarin: UIColor = UIColor(red: 0.91, green: 0.30, blue: 0.24, alpha: 1.0)
        public static let pomegranate: UIColor = UIColor(red: 0.75, green: 0.22, blue: 0.17, alpha: 1.0)
        public static let monza: UIColor = UIColor(red: 0.81, green: 0.00, blue: 0.06, alpha: 1.0)
        public static let thunderbird: UIColor = UIColor(red: 0.85, green: 0.12, blue: 0.09, alpha: 1.0)
        public static let clouds: UIColor = UIColor(red: 0.93, green: 0.94, blue: 0.95, alpha: 1.0)
        public static let silver: UIColor = UIColor(red: 0.74, green: 0.76, blue: 0.78, alpha: 1.0)
        public static let gallery: UIColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.0)
        public static let iron: UIColor = UIColor(red: 0.85, green: 0.87, blue: 0.88, alpha: 1.0)
        public static let concrete: UIColor = UIColor(red: 0.58, green: 0.65, blue: 0.65, alpha: 1.0)
        public static let asbestos: UIColor = UIColor(red: 0.50, green: 0.55, blue: 0.55, alpha: 1.0)
        public static let pumice: UIColor = UIColor(red: 0.82, green: 0.84, blue: 0.83, alpha: 1.0)
        public static let lynch: UIColor = UIColor(red: 0.42, green: 0.48, blue: 0.54, alpha: 1.0)
        public static let lynchColor: UIColor = UIColor(red: 0.42, green: 0.48, blue: 0.54, alpha: 1.0)
    }
    
    // MARK: Text styles
    
    static let leftParagraphStyle: NSMutableParagraphStyle = {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        return paragraph
    }()
    
    static let centerParagraphStyle: NSMutableParagraphStyle = {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        return paragraph
    }()
    
    static let rightParagraphStyle: NSMutableParagraphStyle = {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .right
        return paragraph
    }()
    
    static let heading_1: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Style.fontSize.l),
        NSAttributedString.Key.paragraphStyle: leftParagraphStyle
    ]
    
    static let heading_1_center: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Style.fontSize.l),
        NSAttributedString.Key.paragraphStyle: centerParagraphStyle
    ]
    
    static let heading_1_right: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Style.fontSize.l),
        NSAttributedString.Key.paragraphStyle: rightParagraphStyle
    ]
    
    
    static let heading_2: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Style.fontSize.m)]
    static let heading_3: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Style.fontSize.s)]
    
    static let body: [NSAttributedString.Key: Any] = [:]
    static let body_center: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.darkGray,
        .paragraphStyle: centerParagraphStyle
    ]
}
