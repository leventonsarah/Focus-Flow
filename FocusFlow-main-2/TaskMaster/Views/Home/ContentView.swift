import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isUserLoggedIn = false
    @StateObject private var countdownViewModel = CountdownViewModel()

    var body: some View {
        Group {
            if isUserLoggedIn {
                NavigationView {
                    VStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("FocusFlow")
                                .font(.system(size: 32, weight: .heavy, design: .rounded))
                                .foregroundColor(.primary)

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 40)
                        .padding(.horizontal)

                        Spacer()

                        VStack(spacing: 16) {
                            
                            NavigationLink(destination: CountdownListView()) {
                                    HomeButtonView(title: "Countdowns", systemImage: "hourglass")
                                }
                            
                            NavigationLink(destination: TaskListView()) {
                                HomeButtonView(title: "To-Do List", systemImage: "checkmark.circle")
                            }
                            
                            NavigationLink(destination: PomodoroTimerView()) {
                                HomeButtonView(title: "Pomodoro Timer", systemImage: "timer")
                            }
                            
                            NavigationLink(destination: CalendarView()) {
                                HomeButtonView(title: "Calendar", systemImage: "calendar")
                            }
                            
                            NavigationLink(destination: MotivationView()) {
                                HomeButtonView(title: "Motivation", systemImage: "sparkles")
                            }
                            
                            NavigationLink(destination: AnalyticsView(taskViewModel: TaskViewModel(), pomodoroViewModel: PomodoroViewModel())) {
                                HomeButtonView(title: "Analytics", systemImage: "chart.bar.xaxis")
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGroupedBackground).ignoresSafeArea())
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                do {
                                    try Auth.auth().signOut()
                                    isUserLoggedIn = false
                                } catch {
                                    print("Error signing out: \(error.localizedDescription)")
                                }
                            }) {
                                Label("Log Out", systemImage: "arrow.right.square")
                                    .font(.subheadline.bold())
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(Color.red.opacity(0.1))
                                    .foregroundColor(.red)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
                .environmentObject(countdownViewModel)
            } else {
                LoginView(isUserLoggedIn: $isUserLoggedIn)
                    .padding()
                    .background(Color(.systemGroupedBackground).ignoresSafeArea())
            }
        }
        .onAppear {
            checkUserLoginStatus()
        }
    }

    func checkUserLoginStatus() {
        isUserLoggedIn = Auth.auth().currentUser != nil
    }

    func daysLeft(until date: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: Date(), to: date)
        return components.day ?? 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}

