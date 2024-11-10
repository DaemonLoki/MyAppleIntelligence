//
//  BlobShape.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 06.11.24.
//

import SwiftUI

struct BlobShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.16427*width, y: 0.36126*height))
        path.addCurve(to: CGPoint(x: 0.25589*width, y: 0.18325*height), control1: CGPoint(x: 0.20113*width, y: 0.29298*height), control2: CGPoint(x: 0.17954*width, y: 0.226*height))
        path.addCurve(to: CGPoint(x: 0.62238*width, y: 0.10471*height), control1: CGPoint(x: 0.33224*width, y: 0.14049*height), control2: CGPoint(x: 0.52727*width, y: 0.09991*height))
        path.addCurve(to: CGPoint(x: 0.82657*width, y: 0.21204*height), control1: CGPoint(x: 0.7175*width, y: 0.10951*height), control2: CGPoint(x: 0.78207*width, y: 0.1538*height))
        path.addCurve(to: CGPoint(x: 0.8894*width, y: 0.45419*height), control1: CGPoint(x: 0.87107*width, y: 0.27029*height), control2: CGPoint(x: 0.89136*width, y: 0.39092*height))
        path.addCurve(to: CGPoint(x: 0.81479*width, y: 0.59162*height), control1: CGPoint(x: 0.88743*width, y: 0.51745*height), control2: CGPoint(x: 0.82657*width, y: 0.52029*height))
        path.addCurve(to: CGPoint(x: 0.81872*width, y: 0.8822*height), control1: CGPoint(x: 0.80301*width, y: 0.66296*height), control2: CGPoint(x: 0.87456*width, y: 0.83159*height))
        path.addCurve(to: CGPoint(x: 0.47971*width, y: 0.89529*height), control1: CGPoint(x: 0.76287*width, y: 0.93281*height), control2: CGPoint(x: 0.56719*width, y: 0.91907*height))
        path.addCurve(to: CGPoint(x: 0.29385*width, y: 0.73953*height), control1: CGPoint(x: 0.39223*width, y: 0.87151*height), control2: CGPoint(x: 0.36802*width, y: 0.78992*height))
        path.addCurve(to: CGPoint(x: 0.03469*width, y: 0.59293*height), control1: CGPoint(x: 0.21968*width, y: 0.68914*height), control2: CGPoint(x: 0.05628*width, y: 0.65598*height))
        path.addCurve(to: CGPoint(x: 0.16427*width, y: 0.36126*height), control1: CGPoint(x: 0.01309*width, y: 0.52989*height), control2: CGPoint(x: 0.1274*width, y: 0.42954*height))
        path.addCurve(to: CGPoint(x: 0.25589*width, y: 0.18325*height), control1: CGPoint(x: 0.20113*width, y: 0.29298*height), control2: CGPoint(x: 0.17954*width, y: 0.226*height))
        return path
    }
}

#Preview {
    BlobShape()
        .frame(width: 300, height: 300)
}
