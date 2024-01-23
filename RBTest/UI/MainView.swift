//
//  MainView.swift
//  RBTest
//
//  Created by Никита Мошенцев on 23.01.2024.
//

import SwiftUI

struct MainView: View {
    let winCoefficient = 1.94
    let loseCoefficient = 2.17
    let refundCoefficient = 1.26
    let totalCoefficient = 3.0

    enum ProgressViewStyle {
        case win
        case lose
        case refund

        var color: Color {
            switch self {
            case .win:
                return Color.green
            case .lose:
                return Color.red
            case .refund:
                return Color.gray
            }
        }
    }
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Средние коэффиценты")
                    .font(.headline)

                makeCoefficentView(
                    progressStyle: .win,
                    title: "Выигрыш",
                    coefficient: winCoefficient
                )
                makeCoefficentView(
                    progressStyle: .lose,
                    title: "Проигрыш",
                    coefficient: loseCoefficient
                )
                makeCoefficentView(
                    progressStyle: .refund,
                    title: "Возврат",
                    coefficient: refundCoefficient
                )

            }
            .padding(8)
            .background(
                Rectangle()
                    .stroke(Color.black, lineWidth: 1)
            )
        }
        .padding()
    }

    private func makeCoefficentView(progressStyle: ProgressViewStyle, title: String, coefficient: Double) -> some View {
        HStack(spacing: 8) {
            ProgressView(value: coefficient, total: totalCoefficient)
                .progressViewStyle(BarProgressStyle(color: progressStyle.color))
                .frame(width: UIScreen.main.bounds.width * 0.6, height: 4)

            Text(title)
                .font(.system(size: 10))
                .foregroundStyle(Color.gray)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(coefficient.convertToString())
                .font(.caption2)
                .bold()
                .frame(alignment: .trailing)
        }
    }
}

#Preview {
    MainView()
}
