import SwiftUI
import MapKit

struct BranchMapView: View {
    @Binding var currentScreen: String
    
    @FetchRequest(
        entity: Branch.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Branch.name, ascending: true)]
    ) var storedBranches: FetchedResults<Branch>
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 53.8850, longitude: 27.5500),
        span: MKCoordinateSpan(latitudeDelta: 0.12, longitudeDelta: 0.12)
    )

    var body: some View {
        ZStack(alignment: .top) {
            if !storedBranches.isEmpty {
                //MARK: - Map Component
                Map(coordinateRegion: $region, annotationItems: storedBranches) { branch in
                    MapMarker(
                        coordinate: CLLocationCoordinate2D(latitude: branch.lat, longitude: branch.lon),
                        tint: .blue
                    )
                }
                .ignoresSafeArea()
            } else {
                Color(white: 0.98).ignoresSafeArea()
                ProgressView("loading_branches")
            }
            
            VStack {
                HStack {
                    Button(action: { currentScreen = "menu" }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                            .background(Color.blue.opacity(0.8))
                            .clipShape(Circle())
                    }
                    .padding(.leading, 20)
                    .padding(.top, 10)
                    Spacer()
                }
                
                Spacer()
                
                if let nearest = storedBranches.first {
                    VStack(spacing: 8) {
                        Text("nearest_branch")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.secondary)
                        
                        Text(nearest.name ?? "")
                            .font(.system(size: 18, weight: .bold))
                        
                        Text(nearest.address ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 25)
                    .frame(width: 340)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color: Color.black.opacity(0.15), radius: 15, x: 0, y: 5)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}
