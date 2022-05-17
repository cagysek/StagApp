import SwiftUI

/// Component of ``StudentScreen``.  Presents single statistics field
struct StatisticLabelView: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(LocalizedStringKey(self.value))
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .truncationMode(.tail)
            Text(LocalizedStringKey(self.label))
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundColor(Color.gray)
        }
    }
}

struct StatisticLabelView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticLabelView(label: "Kredity", value: "80/120")
    }
}
