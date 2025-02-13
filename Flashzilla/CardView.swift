//
//  CardView.swift
//  Flashzilla
//
//  Created by Ayrton Parkinson on 2024/08/04.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: ((Bool) -> Void)? = nil
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    accessibilityDifferentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width == 0 ? .white : offset.width > 1 ? .green : .red)
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityVoiceOverEnabled {
                        Text(isShowingAnswer ? card.answer : card.prompt)
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    } else {
                        Text(card.prompt)
                            .font(.largeTitle)
                            .foregroundStyle(.black)

                        if isShowingAnswer {
                            Text(card.answer)
                                .font(.title)
                                .foregroundStyle(.secondary)
                        }
                    }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width * 5)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if offset.width > 0 {
                            removal?(false)
                        } else {
                            removal?(true)
                            offset = .zero
                        }
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.bouncy, value: offset)
        .accessibilityAddTraits(.isButton)
        
    }
}

#Preview {
    CardView(card: .example)
}
