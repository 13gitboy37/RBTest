//
//  BarProgressStyle.swift
//  RBTest
//
//  Created by Никита Мошенцев on 23.01.2024.
//

import SwiftUI

struct BarProgressStyle: ProgressViewStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0

        GeometryReader { proxy in
            Rectangle()
                .fill(Color(uiColor: .systemGray5))
                .frame(width: proxy.size.width)
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(color)
                        .frame(width: proxy.size.width * progress)
                }
        }
    }
}
