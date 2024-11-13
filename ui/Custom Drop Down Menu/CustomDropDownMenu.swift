struct DropDownMenu: View {
    @Binding var status: DeviceStatus
    
    var body: some View {
        VStack {
            Menu(content: {
                Picker("fruits", selection: $status) {
                    ForEach(DeviceStatus.allCases, id: \.self) { option in
                        Text(option.name)
                    }
                }
            }, label: {
                HStack {
                    Text(status.name)
                    Text(Image(systemName: "chevron.down"))
                }
            })
            .padding(.all, 16)
            .foregroundStyle(Color.white)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
