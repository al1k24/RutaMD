//
//  HomeView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 23.01.2022.
//

import SwiftUI

struct HomeView: View {
    @State var currentType: String = "Popular"
    // MARK: For Smooth Sliding Effect
//    @Namespace var animation
//    @State var _albums: [Album] = albums
    
    @State private var headerOffsets: (CGFloat, CGFloat) = (0, 0)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                HomeHeaderView()
                
                // MARK: Pinned Header with Content
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
//                        SongList()
                            Text("1232131")
                    } header: {
                        HomePinnedHeaderView()
                            .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
                            .modifier(HomeOffsetModifier(offset: $headerOffsets.0, returnFromStart: false))
                            .modifier(HomeOffsetModifier(offset: $headerOffsets.1))
                    }
                }
                .offset(y: -90)
            }
        }
        .overlay(content: {
            Rectangle()
                .fill(.black)
                .frame(height: 50)
                .frame(maxHeight: .infinity,alignment: .top)
                .opacity(headerOffsets.0 < 5 ? 1 : 0)
        })
        .coordinateSpace(name: "SCROLL")
        .ignoresSafeArea(.container, edges: .vertical)
        .background(Color("hexFAFAFA"))
    }
    
    // MARK: Pinned Content
//    @ViewBuilder
//    func SongList()->some View{
//        VStack(spacing: 25){
//            ForEach($_albums){$album in
//                
//                HStack(spacing: 12){
//                    
//                    Text("#\(getIndex(album: album) + 1)")
//                        .fontWeight(.semibold)
//                        .foregroundColor(.gray)
//                    
//                    Image(album.albumImage)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 55, height: 55)
//                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
//                    
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text(album.albumName)
//                            .fontWeight(.semibold)
//                        
//                        Label {
//                            Text("65,587,909")
//                        } icon: {
//                            Image(systemName: "beats.headphones")
//                                .foregroundColor(.white)
//                        }
//                        .foregroundColor(.gray)
//                        .font(.caption)
//                    }
//                    .frame(maxWidth: .infinity,alignment: .leading)
//                    
//                    Button {
//                        album.isLiked.toggle()
//                    } label: {
//                     
//                        Image(systemName: album.isLiked ? "suit.heart.fill" : "suit.heart")
//                            .font(.title3)
//                            .foregroundColor(album.isLiked ? Color("Green") : .white)
//                    }
//                    
//                    Button {
//                    } label: {
//                     
//                        Image(systemName: "ellipsis")
//                            .font(.title3)
//                            .foregroundColor(.white)
//                    }
//                }
//            }
//        }
//        .padding()
//        .padding(.top,25)
//        .padding(.bottom,150)
//    }
    
//    func getIndex(album: Album)->Int{
//        return _albums.firstIndex { currentAlbum in
//            return album.id == currentAlbum.id
//        } ?? 0
//    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
