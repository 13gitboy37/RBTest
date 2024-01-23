//
//  Double + Sugar.swift
//  RBTest
//
//  Created by Никита Мошенцев on 23.01.2024.
//

import Foundation

extension Double {
    func convertToString() -> String {
        String(format: "%.2f", self)
    }
}
