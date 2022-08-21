//
//  RouteScheduleView+HeaderView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 03.05.2022.
//

import SwiftUI

extension RouteScheduleView {
    struct HeaderView: View {
        @EnvironmentObject private var routeViewModel: RouteViewModel
        @EnvironmentObject private var viewModel: RouteScheduleViewModel
        
        @Namespace private var animation
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .center, spacing: 0) {
                    Text(viewModel.toDisplay())
                    
                    Spacer()
                    
                    Image("ic_calendar")
                }
                .font(.title2.bold())
                .foregroundColor(Color.Theme.Text.primary)
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        HStack(spacing: 10) {
                            ForEach(routeViewModel.dates, id: \.id) { dateModel in
                                dateView(dateModel)
                            }
                        }
                        .padding(.horizontal)
                        .onAppear { scrollToSelectedDate(proxy: proxy) }
                    }
                }
                .frame(height: 90, alignment: .center)
            }
            .background(Color.Theme.background)
        }
        
        @ViewBuilder
        private func dateView(_ dateModel: DateModel) -> some View {
            let isToday: Bool = viewModel.isToday(dateModel)
            
            VStack(spacing: 10) {
                Text(dateModel.date.toDisplay(format: "dd"))
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                
                Text(dateModel.date.toDisplay(format: "EEE"))
                    .font(.system(size: 14))
                
                Circle()
                    .fill(Color.hexFFFFFF)
                    .frame(width: 8, height: 8)
                    .opacity(isToday ? 1 : 0)
            }
            .id(dateModel.id)
            .frame(width: 45, height: 90)
            .foregroundColor(isToday ? Color.hexFFFFFF : Color.Theme.Text.secondary)
            .background(capsuleView(isEnabled: isToday))
            .onTapGesture {
                viewModel.select(dateModel)
                UIDevice.vibrate(.light)
            }
            .disabled(isToday)
        }
        
        @ViewBuilder
        private func capsuleView(isEnabled: Bool) -> some View {
            ZStack {
                if isEnabled {
                    Capsule()
                        .fill(Color.hex3C71FF)
                        .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                }
            }
            .animation(.spring(), value: viewModel.date)
        }
        
        private func scrollToSelectedDate(proxy: ScrollViewProxy) {
            guard let id = viewModel.scrollToDate?.id else {
                return
            }
            
            viewModel.scrollToDate = nil
            proxy.scrollTo(id, anchor: .center)
        }
    }
}
