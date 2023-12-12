/*import Foundation
import Combine
import SwiftUI




struct UserServices {
    enum NetworkError: Error {
        case invalidURL
        case requestFailed
        case invalidResponse
        case decodingError
    }
  static let shared = UserServices()

 private let baseURL = "http://127.0.0.1:9090"
// Loginnn
  func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
    let urlString = baseURL + "/auth/login"
    guard let url = URL(string: urlString) else {
      completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
      return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let parameters: [String: Any] = [
      "email": email,
      "password": password
    ]

    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
    } catch {
      completion(.failure(error))
      return
    }

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }

      guard let httpResponse = response as? HTTPURLResponse, let data = data else {
        completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
        return
      }

      if (200..<300).contains(httpResponse.statusCode) {
     
            
            if let cookies = httpResponse.allHeaderFields["Set-Cookie"] as? [String] {
                      let components = cookies[0].components(separatedBy: ";")
                      var jwtToken: String?
                      for cookie in components {
                        if cookie.contains("jwt=") {
                          jwtToken = cookie.replacingOccurrences(of: "jwt=", with: "").trimmingCharacters(in: .whitespaces)
                        }
                      }

                      guard let token = jwtToken else {
                        completion(.failure(NetworkError.invalidResponse))
                        return
                      }

                      do {
                        let user = try JSONDecoder().decode(User.self, from: data)

                        // Store the received JWT token in the session manager
                          SessionManager.shared.authToken = token

                        // Save the user in the user defaults
                        UserDefaults.standard.set(user, forKey: "currentUser")

                        completion(.success(user))
                      } catch {
                        completion(.failure(error))
                      }
                    } else {
                      completion(.failure(NetworkError.invalidResponse))
                    }
                  } else {
                    completion(.failure(NetworkError.requestFailed))
                  }
                }

                task.resume()
              }

    


    func UserSignUp(name: String, lastName: String, password: String, numTel: String, dateNaiss: String, otp: String, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = baseURL + "/users"
        guard let url = URL(string: "\(baseURL)/users") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        let parameters: [String: Any] = [
            "name": name,
            "lastName": lastName,
            "password": password,
            "numTel": numTel,
            "dateNaiss": dateNaiss,
            
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                if let message = json?["message"] as? String {
                    completion(.success(message))
                } else if let errorMessage = json?["error"] as? String {
                    completion(.failure(NSError(domain: errorMessage, code: 0, userInfo: nil)))
                } else {
                    completion(.failure(NSError(domain: "Unexpected response", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
    
    
    
    
    
    
    //curent User
    
    
              func getCurrentUser() -> AnyPublisher<User, Error> {
                return Future<User, Error> { promise in
                  if let user = UserDefaults.standard.value(forKey: "currentUser") as? User {
                    promise(.success(user))
                  } else {
                    promise(.failure(NetworkError.invalidResponse))
                  }
                }.eraseToAnyPublisher()
              }
    
    
    
    
    
    
            }
 */




import Foundation

class UserService {
    static let shared = UserService()
    private let baseURL = "http://172.18.24.23:9091"

    
  
    
    
            

        
       

    
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let loginURL = URL(string: "\(baseURL)/auth/login")!
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginData = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: loginData)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
           
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 200 {
                // Login successful
                if let data = data {
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        
                        // Save user ID to UserDefaults
                        UserDefaults.standard.set(user._id, forKey: "userID")
                        
                        completion(.success(user))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NetworkError.noData))
                }
            } else {
                // Login failed
                completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
            }
        }.resume()
    }
    
    
    
    func signUp(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        let signUpURL = URL(string: "\(baseURL)/user")!
        var request = URLRequest(url: signUpURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        request.httpBody = try? encoder.encode(user)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 200 {
                // Signup successful
                completion(.success(()))
            } else {
                // Signup failed
                completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
            }
        }.resume()
    }
    
    func getUser(userID: String, completion: @escaping (Result<User, Error>) -> Void) {
            let getUserURL = URL(string: "\(baseURL)/user/\(userID)")!
            print("useruser")
            URLSession.shared.dataTask(with: getUserURL) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let user = try decoder.decode(User.self, from: data)
                            completion(.success(user))
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        completion(.failure(NetworkError.noData))
                    }
                } else if httpResponse.statusCode == 404 {
                    completion(.failure(NetworkError.noData))
                } else {
                    completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
                }
            }.resume()
        }
    
    
    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
            let forgotPasswordURL = URL(string: "\(baseURL)/User/sendResetCode")!
            var request = URLRequest(url: forgotPasswordURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let forgotPasswordData = ["email": email]
            request.httpBody = try? JSONSerialization.data(withJSONObject: forgotPasswordData)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    // Reset OTP sent successfully
                    completion(.success(()))
                } else {
                    // Failed to send reset OTP
                    completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
                }
            }.resume()
        }
        
    func verifyOTP(email: String, otpCode: String, completion: @escaping (Result<Bool, Error>) -> Void) {
            let verifyOTPURL = URL(string: "\(baseURL)/User/otp")!
            var request = URLRequest(url: verifyOTPURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let otpData: [String: Any] = [
                "email": email,
                "otpCode": otpCode
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: otpData)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let isOTPValid = json["isOTPValid"] as? Bool {
                            completion(.success(isOTPValid))
                        } else {
                            completion(.failure(NetworkError.invalidResponse))
                        }
                    } else {
                        completion(.failure(NetworkError.invalidResponse))
                    }
                } else {
                    completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
                }
            }.resume()
        }
    
    func updatePassword(userId: String, currentPassword: String, newPassword: String, confirmNewPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
        let updatePasswordURL = URL(string: "\(baseURL)/user/updatePassword/\(userId)")!

        var request = URLRequest(url: updatePasswordURL)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "currentPassword": currentPassword,
            "newPassword": newPassword,
            "confirmNewPassword": confirmNewPassword
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "NetworkError", code: 0, userInfo: nil)))
                return
            }

            do {
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let message = responseJSON?["message"] as? String {
                    completion(.success(message))
                } else {
                    completion(.failure(NSError(domain: "InvalidResponse", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func updateUserEmail(email: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let userID = UserDefaults.standard.string(forKey: "UserID") else {
            completion(.failure(NetworkError.userIDNotFound))
            return
        }
        
        guard let url = URL(string: "\(baseURL)/User/email/\(userID)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "email": email
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(UserServiceError.noData))
                return
            }
            
            do {
                let updatedUser = try JSONDecoder().decode(User.self, from: data)
                completion(.success(updatedUser))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
  
    func deleteUser(userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userID = UserDefaults.standard.string(forKey: "UserID") else {
            completion(.failure(NetworkError.userIDNotFound))
            return
        }
        
        guard let url = URL(string: "\(baseURL)/User/delete/\(userID)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var request = URLRequest(url: url)

        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Process the response if needed
            
            completion(.success(()))
        }.resume()
    }
    
    func sendResetPasswordOTP(email: String, completion: @escaping (Result<String, Error>) -> Void) {
            // Make a network request to your server endpoint
            guard let url = URL(string: "\(baseURL)/User/sms") else {
                let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let params = ["email": email]
            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data,
                   let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = responseJSON["message"] as? String {
                    completion(.success(message))
                } else {
                    let error = NSError(domain: "Invalid response", code: 0, userInfo: nil)
                    completion(.failure(error))
                }
            }.resume()
        }
    
    
    
    }
    
    


enum NetworkError: Error {
    case userIDNotFound
    case invalidURL
    case invalidResponse
    case requestFailed(Int)
    case noData
}


enum UserServiceError: Error {
    case invalidURL
    case noData
}

