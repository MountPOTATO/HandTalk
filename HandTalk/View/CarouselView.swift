//
//  Carousel.swift
//  HandTalk
//
//  Created by mount_potato on 2021/11/28.
//

import SwiftUI


               
struct Item: Identifiable {
    let id = UUID()
    let image: Image
}

let roles = ["normal tone of voices",
             "ask before help is needed",
             "avoid being self-conscious",
             "talk to them as adults",
             "patience is always vital",
             "listen without judgement",
             "use humor properly",
             "speak with, not speak for",
             "companion saves the day"]

struct CarouselView: View {
    @State var spacing: CGFloat = 10
    @State var headspace: CGFloat = 10
    @State var sidesScaling: CGFloat = 0.8
    @State var isWrap: Bool = false
    @State var autoScroll: Bool = false
    @State var time: TimeInterval = 1
    @State var currentIndex: Int = 0
    
    var body: some View {
        
        GeometryReader{geo in
            let width = geo.size.width
            let height = geo.size.height
            
            VStack {
    //            Text("\(currentIndex + 1)/\(roles.count)")
//                Spacer().frame(height: 40)
                ACarousel(roles,
                          id: \.self,
                          index: $currentIndex,
                          spacing: spacing,
                          headspace: headspace,
                          sidesScaling: sidesScaling,
                          isWrap: isWrap,
                          autoScroll: autoScroll ? .active(time) : .inactive) { name in
                    
                    
                    VStack{
                        Image(name)
                            .resizable()
                            .frame(width: width/1.5, height: height/1.5, alignment: .center)
                        
                        Text(name)
                            .scaledToFill()
                            .cornerRadius(30)
                    }
                }

                Spacer()
            }
    }
    }
}

struct ControlPanel: View {
    
    @Binding var spacing: CGFloat
    @Binding var headspace: CGFloat
    @Binding var sidesScaling: CGFloat
    @Binding var isWrap: Bool
    @Binding var autoScroll: Bool
    @Binding var duration: TimeInterval
    
    var body: some View {
        VStack {
            Group {
                HStack {
                    Text("spacing: ").frame(width: 120)
                    Slider(value: $spacing, in: 0...30, minimumValueLabel: Text("0"), maximumValueLabel: Text("30")) { EmptyView() }
                }
                HStack {
                    Text("headspace: ").frame(width: 120)
                    Slider(value: $headspace, in: 0...30, minimumValueLabel: Text("0"), maximumValueLabel: Text("30")) { EmptyView() }
                }
                HStack {
                    Text("sidesScaling: ").frame(width: 120)
                    Slider(value: $sidesScaling, in: 0...1, minimumValueLabel: Text("0"), maximumValueLabel: Text("1")) { EmptyView() }
                }
                HStack {
                    Toggle(isOn: $isWrap, label: {
                        Text("wrap: ").frame(width: 120)
                    })
                }
                VStack {
                    HStack {
                        Toggle(isOn: $autoScroll, label: {
                            Text("autoScroll: ").frame(width: 120)
                        })
                    }
                    if autoScroll {
                        HStack {
                            Text("duration: ").frame(width: 120)
                            Slider(value: $duration, in: 1...10, minimumValueLabel: Text("1"), maximumValueLabel: Text("10")) { EmptyView() }
                        }
                    }
                }
            }
        }
        .padding([.horizontal, .bottom])
    }
}


struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
