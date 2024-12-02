//
//  BackButtonView.swift
//  CharactersApp
//
//  Created by Sarah Gamal on 30/11/2024.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(action: {
            dismiss()
        }) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 45, height: 45)

                Image(systemName: "arrow.backward")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .medium))
            }
        }
        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.2))
    }
}
