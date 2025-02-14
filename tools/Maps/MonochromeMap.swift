import SwiftUI
import MapKit

struct MonoMap: View {
    
    @State var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 25.67507, longitude: -100.31847),
            span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
        )
    )
    
    var body: some View {
        Map(position: $position)
            .overlay {
                Rectangle()
                    .ignoresSafeArea()
                    .blendMode(.saturation)
                    .allowsHitTesting(false)
            }
            .compositingGroup()
            .colorScheme(.light)
    }
}
