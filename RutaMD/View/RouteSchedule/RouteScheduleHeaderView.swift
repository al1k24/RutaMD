//
//  RouteScheduleHeaderView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 03.05.2022.
//

import SwiftUI

struct RouteScheduleHeaderView: View {
    @EnvironmentObject private var routeViewModel: RouteViewModel
    @ObservedObject private var viewModel: RouteScheduleViewModel
    
    @Namespace private var animation
    
    init(viewModel: RouteScheduleViewModel) {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.getSelectedDateValue())
                .font(.title2.bold())
                .foregroundColor(Color.Theme.Text.primary)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack(spacing: 10) {
                        ForEach(routeViewModel.dates, id: \.id) { dateModel in
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
                            .foregroundColor(isToday ? Color.hexFFFFFF : Color.Theme.Text.secondary)
                            // MARK: Capsule Shape
                            .frame(width: 45, height: 90)
                            .background(
                                ZStack {
                                    // MARK: Matched Geometry Effect
                                    if isToday {
                                        Capsule()
                                            .fill(Color.hex3C71FF)
                                            .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                    }
                                }
                            )
                            .contentShape(Capsule())
                            .onTapGesture {
//                                let generator = UINotificationFeedbackGenerator()
//                                    generator.notificationOccurred(.warning)
                                // Updating Current Day
                                withAnimation {
                                    viewModel.select(dateModel)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .onAppear {
                        scrollToSelectedDate(proxy: proxy)
                    }
                }
            }
            .frame(height: 90, alignment: .center)
        }
        .background(Color.Theme.background)
    }
    
    private func scrollToSelectedDate(proxy: ScrollViewProxy) {
        guard let id = viewModel.scrollToDate?.id else {
            return
        }
        
        viewModel.scrollToDate = nil
        proxy.scrollTo(id, anchor: .center)
    }
}

struct RouteScheduleHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
