
//: A SwiftUI based Playground for testing out views

import SwiftUI

struct ContentView: View {
    
    @State var dragOffset: CGSize = .zero
    @State var isDragging: Bool = false
    @State var isFlipped: Bool = false
    
    var body: some View {
        
        ZStack {
            
            //Front of the card
            if !isFlipped {
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(LinearGradient(
                        gradient: .init(colors: [.red, .orange, .yellow]),
                        startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width: 300, height: 200)
                    .shadow(radius: 15)
                    .overlay(
                        Text("✨ Interactive Card")
                            .font(.title)
                            .foregroundStyle(.white)
                            .underline()
                    )
            } else {
                //Back of the card
                RoundedRectangle(cornerRadius: 25)
                    .fill(LinearGradient(
                        gradient: .init(colors: [.blue, .purple, .pink]),
                        startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width: 300, height: 200)
                    .shadow(radius: 15)
                    .overlay(
                        Text("Card Back!")
                            .font(.title)
                            .foregroundStyle(.white)
                            .underline()
                    )
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
        }
        
        
        
        //: code for the movement
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(.init(degrees: Double(dragOffset.width) / 10), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(.init(degrees: Double(dragOffset.height) / -10), axis: (x: 1, y: 0, z: 0))
        .gesture(DragGesture().onChanged { value in
            isDragging = true
            dragOffset = value.translation
        }.onEnded { _ in
            isDragging = false
            withAnimation(.spring) { dragOffset = .zero }
        })
        .onTapGesture {
            withAnimation(.spring) {
                isFlipped.toggle()
            }
        }
        
        
        
        .animation(isDragging ? .none : .spring(), value: dragOffset)
        
        //: to simulate the Iphone background
        .frame(width: 375, height: 667)
        .background(Color.white)
    }
}


#Preview {
    ContentView()
}
