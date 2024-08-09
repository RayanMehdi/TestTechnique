//
//  AsyncViewDidLoadModifier.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 08/08/2024.
//

import SwiftUI

struct AsyncViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: (() async  -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    Task {
                        await action?()
                    }
                }
            }
    }
}

extension View {
    func onAsyncViewDidLoad(perform action: @escaping () async -> Void) -> some View {
        self.modifier(AsyncViewDidLoadModifier(action: action))
    }
}
