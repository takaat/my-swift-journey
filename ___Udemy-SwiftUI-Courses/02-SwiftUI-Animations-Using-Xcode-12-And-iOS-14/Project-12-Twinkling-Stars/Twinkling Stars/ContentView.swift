import SwiftUI

struct ContentView: View {
    @State private var animateYellow = false
    @State private var animateBlue = false
    @State private var animateRed = false
    @State private var animatePurple = false
    @State private var animateGreen = false
    @State private var starThickness: CGFloat = 0.0
    var starPoints: Int = 0
    
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND IMAGE
            Image("stars").resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all)
            
            VStack {
                // Change the amount of points to create a sun effect
                CreateStar(starPoints: 4, starThickness: $starThickness, animateStar: $animateYellow, fillColor: .yellow, starSizeStart: 0.2, starSizeEnd: 0.4, shadowColor: .yellow)
                    .offset(y: 100)
                    .onAppear() {
                        withAnimation (Animation.easeOut(duration: 2.3).repeatForever(autoreverses: true)){
                            animateYellow.toggle()
                            starThickness = 0.35
                        }
                    }
                
                CreateStar(starPoints: 6, starThickness: $starThickness, animateStar: $animateBlue, fillColor: .blue, starSizeStart: 0.1, starSizeEnd: 0.3, shadowColor: .blue)
                    .offset(x: 70, y: -60)
                    .onAppear() {
                        withAnimation (Animation.easeOut(duration: 3.3).repeatForever(autoreverses: true)){
                            animateBlue.toggle()
                            starThickness = 0.35
                        }
                    }
                
                CreateStar(starPoints: 6, starThickness: $starThickness, animateStar: $animateRed, fillColor: .red, starSizeStart: 0.2, starSizeEnd: 0.4, shadowColor: .red)
                    .offset(x: -70, y: -150)
                    .onAppear() {
                        withAnimation (Animation.easeOut(duration: 3.3).repeatForever(autoreverses: true)){
                            animateRed.toggle()
                            starThickness = 0.35
                        }
                    }
                
                CreateStar(starPoints: 6, starThickness: $starThickness, animateStar: $animatePurple, fillColor: .purple, starSizeStart: 0.2, starSizeEnd: 0.4, shadowColor: .purple)
                    .offset(x: 80, y: -120)
                    .onAppear() {
                        withAnimation (Animation.easeOut(duration: 3.3).repeatForever(autoreverses: true)){
                            animatePurple.toggle()
                            starThickness = 0.35
                        }
                    }
                
                CreateStar(starPoints: 6, starThickness: $starThickness, animateStar: $animateGreen, fillColor: .green, starSizeStart: 0.2, starSizeEnd: 0.4, shadowColor: .green)
                    .offset(x: -80, y: -170)
                    .onAppear() {
                        withAnimation (Animation.easeOut(duration: 3.3).repeatForever(autoreverses: true)){
                            animateGreen.toggle()
                            starThickness = 0.35
                        }
                    }
            }
        }
    }
}

struct Star: Shape {
    let starPoints: Int
    var starThickness: CGFloat
    
    var animatableData: CGFloat {
        get { starThickness }
        set { starThickness = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        /// Make sure the star has at least 3 points
        guard starPoints >= 3 else { return Path() }
        
        // Make the value negative and they move across the sky
        /// Create an x and y point to start the drawing from
        let drawPoint = CGPoint(x: rect.width / 1.2, y: rect.height / 0.5)
        
        /// Make the angle of the star straight up (change this value to change the stars angle)
        var starAngle = -CGFloat.pi / 2
        
        /// Adjust the stars angle based on how many points are chosen
        let adjustedStarAngle = .pi * 2 / CGFloat(starPoints * 2)
        
        /// Adjust the inner x and y points of the star based on the stars thickness
        let pointX = drawPoint.x * starThickness
        let pointY = drawPoint.y * starThickness
        
        /// Create a path instance to start the drawing
        var path = Path()
        
        /// Start the path off at the initial position we set drawPoint to be...we'll use a little math here to move the path along on the x and y points
        path.move(to: CGPoint(x: drawPoint.x * cos(starAngle), y: drawPoint.y * sin(starAngle)))
        
        /// Keep track of the lowest point so we can center it
        var bottomEdge: CGFloat = 0
        
        /// Loop over all the points and figure out the location of this point with some math
        for corner in 0..<starPoints * 2 {
            let sinAngle = sin(starAngle)
            let cosAngle = cos(starAngle)
            let bottom: CGFloat
            
            // Change the value to 8 to create a raindrop if you want
            /// Check to see if we are a multiple of two, if so, then we are drawing the outer edge of the star
            if corner.isMultiple(of: 2) {
                /// Store this position in bottom
                bottom = drawPoint.y * sinAngle
                
                /// Add a line to there
                path.addLine(to: CGPoint(x: drawPoint.x * cosAngle, y: bottom))
            } else {
                /// In the else, we're not a multiple of 2, so we are drawing an inner point
                /// Store this y position in bottom
                bottom = pointY * sinAngle
                
                /// Add a line to there
                path.addLine(to: CGPoint(x: pointX * cosAngle, y: bottom))
            }
            /// Check the bottom var, if this new bottom point is our lowest, store it in bottomEdge for later
            if bottom > bottomEdge {
                bottomEdge = bottom
            }
            /// Move on to the next corner
            starAngle += adjustedStarAngle
        }
        
        /// Calculate how much unused space we have at the bottom of our drawing rectangle
        let bottomSpace = (rect.height / 2 - bottomEdge) / 2
        
        /// Create and add a transform that oves the path down by that amount, centering the shape vertically
        let transform = CGAffineTransform(translationX: drawPoint.x, y: drawPoint.y + bottomSpace)
        return path.applying(transform)
    }
}

struct CreateStar: View {
    var starPoints: Int
    @Binding var starThickness: CGFloat
    @Binding var animateStar: Bool
    
    var fillColor: Color
    var starSizeStart: CGFloat
    var starSizeEnd: CGFloat
    var shadowColor: Color
    
    var body: some View {
        VStack {
            Star(starPoints: starPoints, starThickness: starThickness)
                .fill(fillColor)
                .frame(width: 80, height: 80)
                .scaleEffect(animateStar ? starSizeStart : starSizeEnd)
                .shadow(color: shadowColor, radius: 20, x: 3, y: 3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
