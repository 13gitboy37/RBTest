//
//  MainView.swift
//  RBTest
//
//  Created by Никита Мошенцев on 23.01.2024.
//

import SwiftUI

struct MainView: View {
    private enum ProgressViewStyle {
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

    let winCoefficient = 1.94
    let loseCoefficient = 2.17
    let refundCoefficient = 1.26
    let maxCoefficient = 3.0

    let winCount = 16
    let loseCount = 11
    let refundCount = 5

    var totalCount: Int {
        winCount + loseCount + refundCount
    }

    private let progressBarHeight = 4.0

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Средние коэффиценты")
                    .font(.subheadline)
                    .bold()

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

            VStack(alignment: .leading, spacing: 0) {
                Text("Выигрыши/проигрыши по букмекерам")
                    .font(.subheadline)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(alignment: .bottom) {
                    Image("1xbet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)

                    Text("\(totalCount) ставки")
                        .font(.system(size: 12, weight: .semibold))
                }
                .padding(.top, 16)

                makeWinLoseRefundGraphicView(
                    winCount: winCount,
                    loseCount: loseCount,
                    refundCount: refundCount
                )
                .padding(.top, 8)
            }
            .padding(8)
            .background(
                Rectangle()
                    .stroke(Color.black, lineWidth: 1)
            )
        }
        .padding()
    }

    private func makeCoefficentView(
        progressStyle: ProgressViewStyle,
        title: String,
        coefficient: Double
    ) -> some View {
        HStack(spacing: 8) {
            ProgressView(value: coefficient, total: maxCoefficient)
                .progressViewStyle(BarProgressStyle(color: progressStyle.color))
                .frame(width: UIScreen.main.bounds.width * 0.6, height: progressBarHeight)

            Text(title)
                .font(.caption2)
                .foregroundStyle(Color(uiColor: .systemGray3))
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(coefficient.convertToString())
                .font(.caption2)
                .bold()
                .frame(alignment: .trailing)
        }
    }

    private func makeWinLoseRefundGraphicView(
        winCount: Int,
        loseCount: Int,
        refundCount: Int
    ) -> some View {
        let winPercent = Double(winCount) / Double(totalCount)
        let losePercent = Double(loseCount) / Double(totalCount)
        let refundPercent = Double(refundCount) / Double(totalCount)

        return GeometryReader { proxy in
            HStack(spacing: 5) {
                VStack(alignment: .leading) {
                    Rectangle()
                        .fill(ProgressViewStyle.win.color)
                        .frame(height: progressBarHeight)

                    Text("\(winCount)(\(winPercent.convertPercentToString())%)")
                        .font(.system(size: 8))
                }
                .frame(width: proxy.size.width * winPercent)

                VStack(alignment: .leading) {
                    Rectangle()
                        .fill(ProgressViewStyle.lose.color)
                        .frame(height: progressBarHeight)

                    Text("\(loseCount)(\(losePercent.convertPercentToString())%)")
                        .font(.system(size: 8))
                }
                .frame(width: proxy.size.width * losePercent)

                VStack(alignment: .trailing) {
                    Rectangle()
                        .fill(ProgressViewStyle.refund.color)
                        .frame(height: progressBarHeight)

                    Text("\(refundCount)(\(refundPercent.convertPercentToString())%)")
                        .font(.system(size: 8))
                }
            }
        }
        .frame(height: 25)
    }
}

#Preview {
    MainView()
}
