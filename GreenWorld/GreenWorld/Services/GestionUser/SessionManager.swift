import Foundation
/*
class SessionManager {
    static let shared = SessionManager()

    private init() {}

    var authToken: String? {
        get {
            UserDefaults.standard.string(forKey: "token")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "token")
        }
    }

    var user: User? {
        get {
            if let userData = UserDefaults.standard.data(forKey: "userData") {
                let decoder = JSONDecoder()
                if let savedUser = try? decoder.decode(User.self, from: userData) {
                    print("eeeeeeeaezaeazeazeazeazeazeae")
                    print(savedUser)
                    return savedUser
                }
            }
            return nil
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "userData")
            }
        }
    }
    
    var isLogged: Bool {
         return authToken != nil
     }
    
    func logout() {
            // Clear the JWT token from UserDefaults
            authToken = nil

            // Clear the user data from UserDefaults
            user = nil

            // Additional cleanup if needed
            // ...

            // Notify the app that the user has logged out
        NotificationCenter.default.post(name: Notification.Name("UserLoggedOut"), object: nil)
           }
        }

    func clearSession() {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "userData")
    }

*/
