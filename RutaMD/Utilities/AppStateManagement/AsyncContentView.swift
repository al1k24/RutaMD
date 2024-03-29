//
//  AsyncContentView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 19.04.2022.
//

import SwiftUI

struct AsyncContentView<ViewModel: LoadableObject, Content: View>: View {
    @ObservedObject private var viewModel: ViewModel
    
    private var content: (ViewModel.Output) -> Content

    init(viewModel: ViewModel, @ViewBuilder content: @escaping (ViewModel.Output) -> Content) {
        self.viewModel = viewModel
        self.content = content
    }
    
    var body: some View {
        contentView()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.Theme.background)
    }
    
    @ViewBuilder
    private func contentView() -> some View {
        switch viewModel.state {
        case .idle:
            Color.clear
                .onAppear(perform: viewModel.load)
        case .loading:
            ProgressView()
        case .failed(let error):
            Text(LocalizedStringKey(error.localizedKey))
        case .loaded(let output):
            content(output)
        }
    }
}
