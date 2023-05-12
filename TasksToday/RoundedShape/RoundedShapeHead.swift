//
//  RoundedShapeHead.swift
//  TasksToday
//
//  Created by Isa Rampage on 09.05.23.
//

import SwiftUI

struct RoundedShapeHead: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 650, height: 650))
        
        return Path(path.cgPath)
    }
}
