import SwiftUI
import MAUL

struct AvatarScreen: View {
  
  let initials = "WW"
  let img = Image("avatar")
  
  var testScreen: some View {
    VStack {
      HStack(alignment: .top) {
        MAULAvatar(image: img, size: .small)
        MAULAvatar(image: img, size: .medium)
        MAULAvatar(image: img, size: .large)
        MAULAvatar(image: img, size: .extraLarge)
      }
      HStack(alignment: .top) {
        MAULAvatar(initials: initials, size: .small)
        MAULAvatar(initials: initials, size: .medium)
        MAULAvatar(initials: initials, size: .large)
        MAULAvatar(initials: initials, size: .extraLarge)
      }
      HStack(alignment: .top) {
        MAULAvatar(icon: Image.MAUL.userFill, size: .small)
        MAULAvatar(icon: Image.MAUL.userFill, size: .medium)
        MAULAvatar(icon: Image.MAUL.userFill, size: .large)
        MAULAvatar(icon: Image.MAUL.userFill, size: .extraLarge)
      }
    }
  }
  
  var body: some View {
    let stack = testScreen
    VStack {
      stack
      stack.disabled(true)
    }
  }
}

struct AvatarScreen_Previews: PreviewProvider {
  
  static var previews: some View {
    AvatarScreen()
  }
}
