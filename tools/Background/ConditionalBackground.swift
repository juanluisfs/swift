Image(systemName: "circle.fill")
    .background(Group {
       if self.buttonPressed { BackgroundView1() }
         else { BackgroundView2() }
    }) 
