import SwiftUI

struct ContentView: View {
    @State private var now = Date()
    @State private var showCountdown = true
    let targetDate: Date = {
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: Date())
        components.month = 12
        components.day = 7
        components.hour = 23
        components.minute = 30
        components.second = 0
        components.timeZone = TimeZone(identifier: "America/Los_Angeles")
        return calendar.date(from: components)!
    }()

    let sinceDate: Date = {
        var components = DateComponents()
        components.year = 2024
        components.month = 12
        components.day = 7
        components.hour = 23
        components.minute = 30
        components.second = 0
        components.timeZone = TimeZone(identifier: "America/Los_Angeles")
        return Calendar.current.date(from: components)!
    }()

    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.now = Date()
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 10) {
                Text("Time Till Dating 💙Aniversary💜")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)

                let diff = showCountdown ? Calendar.current.dateComponents([.month, .weekOfMonth, .day, .hour, .minute, .second, .nanosecond], from: now, to: targetDate)
                                         : Calendar.current.dateComponents([.year, .month, .weekOfMonth, .day, .hour, .minute, .second, .nanosecond], from: sinceDate, to: now)

                if !showCountdown {
                    Text(String(format: "%02d YRS", diff.year ?? 0))
                        .foregroundColor(.red)
                        .font(.system(size: 48, weight: .bold))
                }

                Text(String(format: "%02d MONTHS", diff.month ?? 0))
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                Text(String(format: "%02d WEEKS", diff.weekOfMonth ?? 0))
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                Text(String(format: "%02d DAYS", diff.day ?? 0))
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                Text(String(format: "%02d HRS", diff.hour ?? 0))
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                Text(String(format: "%02d MIN", diff.minute ?? 0))
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                Text(String(format: "%02d SEC", diff.second ?? 0))
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                Text(String(format: "%03d MS", (diff.nanosecond ?? 0) / 1000000))
                    .font(.system(size: 40))
                    .foregroundColor(.white)

                Button(action: {
                    showCountdown.toggle()
                }) {
                    Text(showCountdown ? "Switch to Stopwatch" : "Switch to Countdown")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(10)
                }.padding(.top, 20)
            }.onAppear {
                _ = self.timer
            }
        }
    }
}

#Preview {
    ContentView()
}
