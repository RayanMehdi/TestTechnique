//
//  LoaderView.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 08/08/2024.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    LoaderView()
}
