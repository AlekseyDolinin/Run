import SwiftUI
import Voyager

struct TraningDataView: View {
    
    @EnvironmentObject private var router: Router<AppRoute>
    var traning: Traning!
        
    var body: some View {
//        let _ = Self._printChanges()
        ZStack {
            VStack(alignment: .leading) {
                Spacer()
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: -8) {
                        Text(TimeConverter.shared.convertSecondToHHMMSS(traning.duration))
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Время")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text(String(format: "%0.2f", traning.distance_km))
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Дистанция (км)")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text(String(format: "%0.2f", traning.tempAverage))
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Темп (мин)")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text(String(traning.calories))
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Калории (ккал)")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text(String(format: "%0.2f", traning.speedAverage))
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Скорость (км/ч)")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }
    }
}

#Preview {
    TraningDataView(traning: Traning())
}
