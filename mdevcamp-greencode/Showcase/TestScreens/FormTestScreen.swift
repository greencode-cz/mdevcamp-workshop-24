import SwiftUI

struct FormTestScreen: View {
  var body: some View {
    Form {
      TextField("Title", text: .constant("Text"))
      SecureField("Title", text: .constant("text"))
    }
  }
}

struct FormTestScreen_Previews: PreviewProvider {
  static var previews: some View {
    FormTestScreen()
  }
}
