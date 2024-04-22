import SwiftUI
import MAUL

struct StepperScreen: View {
  @State private var value = 0
  let step = 1
  let range = 0...6
  
  let colors: [Color] = [.orange, .red, .gray, .blue,
                         .green, .purple, .pink]
  
  func incrementStep() {
    value += 1
    if value >= colors.count { value = 0 }
  }
  
  func decrementStep() {
    value -= 1
    if value < 0 { value = colors.count - 1 }
  }
  
  var body: some View {
    let view = Form {
      Stepper(value: $value, in: range, step: step) {
        Text("Value \(value) in range 0-6 and step 1")
          .font(.MAUL.regular())
      }
      Stepper {
        HStack {
          RoundedRectangle(cornerRadius: 5)
            .fill(colors[value])
            .frame(maxWidth: 10)
          Text("Value: \(value) Color: \(colors[value].description)")
            .font(.MAUL.regular())
            .foregroundColor(colors[value])
        }
      } onIncrement: {
        incrementStep()
      } onDecrement: {
        decrementStep()
      }
      
    }.background(Color.MAUL.Background.primary)
    
    VStack {
      view.environment(\.colorScheme, .light)
      view.environment(\.colorScheme, .dark)
    }
  }
}

struct StepperScreen_Previews: PreviewProvider {
  static var previews: some View {
    StepperScreen()
      .setupMAULForPreviews()
  }
}
