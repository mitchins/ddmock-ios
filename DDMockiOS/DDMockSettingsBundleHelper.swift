import Foundation

class DDMockSettingsBundleHelper {
    private static let statusCode = "_status_code"
    private static let responseTime = "_response_time"
    private static let endpoint = "_endpoint"
    private static let mockFile = "_mock_file"
    
    static func getSelectedMockFile(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: getSettingsBundleKey(key: key) + mockFile)
    }
    
    static func getStatusCode(key: String) -> Int {
        let userDefaultKey = getSettingsBundleKey(key: key) + statusCode
        if (UserDefaults.standard.object(forKey: userDefaultKey) == nil) {
            return MockEntry.defaultStatusCode
        } else {
            return UserDefaults.standard.integer(forKey: userDefaultKey)
        }
    }
    
    static func getResponseTime(key: String) -> Int {
        let userDefaultKey = getSettingsBundleKey(key: key) + responseTime
        if (UserDefaults.standard.object(forKey: userDefaultKey) == nil) {
            return MockEntry.defaultResponseTime
        } else {
            return UserDefaults.standard.integer(forKey: userDefaultKey)
        }
    }
    
    private static func getSettingsBundleKey(key: String) -> String {
        return key.replacingOccurrences(of: "/", with: ".")
    }
}
