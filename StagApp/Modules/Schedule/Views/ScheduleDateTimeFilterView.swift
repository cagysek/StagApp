////
////  ScheduleDateTimeFilterView.swift
////  StagApp
////
////  Created by Jan Čarnogurský on 21.11.2021.
////
//
//import SwiftUI
//
//struct ScheduleDateTimeFilterView: View {
//    
//    @State var selectedIndex = 17;
//
//    var body: some View {
//        ScrollViewReader { proxy in
//            HStack {
//                Text("Listopad 2021")
//                    .font(.system(size: 20, weight: .bold, design: .rounded))
//
//                Spacer()
//
//                Button("Dnes") {
//                    withAnimation {
//                        selectedIndex = 17
//                        proxy.scrollTo(17, anchor: .center)
//                    }
//                }
//                .buttonStyle(WhiteCapsuleButtonStyle())
//
//                Button {
//
//                } label: {
//                    Image(systemName: "slider.horizontal.3")
//                }
//                .buttonStyle(WhiteCapsuleButtonStyle())
//            }
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                LazyHStack() {
//                    ForEach((1...30), id: \.self) { index in
//                        Button {
//                            self.selectedIndex = index
//                        } label: {
//                            if (self.selectedIndex == index)
//                            {
//                                VStack(alignment: .center, spacing: 5) {
//                                    Text("Po")
//                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
//                                        .foregroundColor(.white)
//                                    Text("\(index)")
//                                        .font(.system(size: 14, weight: .bold, design: .rounded))
//                                        .foregroundColor(.white)
//                                }
//                                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
//                                .background(Color.customBlue)
//
//                                .clipShape(RoundedRectangle(cornerRadius: 15))
//                            }
//                            else
//                            {
//                                VStack(alignment: .center, spacing: 5) {
//                                    Text("Po")
//                                        .font(.system(size: 14, weight: .medium, design: .rounded))
//                                        .foregroundColor(.gray)
//                                    Text("\(index)")
//                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
//                                        .foregroundColor(.defaultFontColor)
//                                }
//                                .padding(15)
//                            }
//
//                        }
//
//                        .id(index)
//                    }
//                }
//                .padding()
//
//            }
//            .onAppear(perform: {
//                proxy.scrollTo(self.selectedIndex, anchor: .center)
//            })
//            .frame(height: 60)
//            .background(.white)
//            .clipShape(RoundedRectangle(cornerRadius: 15))
//            .shadow(color: .shadow, radius: 8)
//
//        }
//    }
//}
//
//struct ScheduleDateTimeFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleDateTimeFilterView()
//    }
//}
