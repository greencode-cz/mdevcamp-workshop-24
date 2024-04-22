import SwiftUI

struct DatePickerScreen: View {

  @State private var date = Date()

  var body: some View {
    Form {

      let picker = DatePicker(selection: $date, label: { Text("Date") })

      picker.datePickerStyle(DefaultDatePickerStyle())
      picker.datePickerStyle(CompactDatePickerStyle())
      picker.datePickerStyle(GraphicalDatePickerStyle())
#if os(iOS)
      picker.datePickerStyle(WheelDatePickerStyle())
#endif
    }
  }
}

struct DatePickerScreen_Previews: PreviewProvider {
  static var previews: some View {
    DatePickerScreen()
      .setupMAULForPreviews()
  }
}
