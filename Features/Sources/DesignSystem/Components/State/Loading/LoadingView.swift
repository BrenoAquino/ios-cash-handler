//
//  LoadingView.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import SwiftUI
import Common

struct LoadingView: View {
    
    @State private var loadingOpacity: CGFloat = 0
    @State private var startDashCircle: CGFloat = 1
    @State private var mainRotation: Double = 0
    @State private var circleGuiderRotation: Double = -180
    
    private let radius: CGFloat = 100
    
    var body: some View {
        ZStack {
            BlurView()
                .opacity(loadingOpacity)
                .edgesIgnoringSafeArea(.all)
            
            Group {
                Group {
                    Circle()
                        .frame(width: radius * 0.25, height: radius * 0.25)
                        .foregroundColor(.gray)
                    
                    Circle()
                        .trim(from: 1/2, to: 1)
                        .frame(width: radius / 2, height: radius / 2)
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(mainRotation))
                        .onAppear {
                            withAnimation(.linear(duration: 8).repeatForever()) {
                                self.mainRotation = -360
                            }
                        }
                }
                
                Group {
                    Circle()
                        .stroke(lineWidth: 2)
                        .frame(width: radius, height: radius)
                        .foregroundColor(.white)
                    
                    Circle()
                        .trim(from: startDashCircle, to: 1)
                        .stroke(style: StrokeStyle(lineWidth:5,
                                                   lineCap:.round,
                                                   lineJoin:.round,
                                                   dash: [50, 50],
                                                   dashPhase: -50))
                        .frame(width: radius * 1.1, height: radius * 1.1)
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(90))
                        .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                        .onAppear {
                            withAnimation(.easeInOut(duration: 4).repeatForever()) {
                                self.startDashCircle = 0
                            }
                        }
                }
                
                Group {
                    Circle()
                        .frame(width: radius * 0.1, height: radius * 0.1)
                        .foregroundColor(.white)
                        .offset(y: radius / 2 * 1.1)
                        .rotationEffect(.degrees(circleGuiderRotation))
                        .onAppear {
                            withAnimation(.easeInOut(duration: 4).repeatForever()) {
                                self.circleGuiderRotation = 180
                            }
                        }
                }
            }
            .opacity(loadingOpacity)
        }
        .onAppear {
            withAnimation(.linear) {
                self.loadingOpacity = 1
            }
        }
    }
}


#if DEBUG
// MARK: - Preview
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
#endif
