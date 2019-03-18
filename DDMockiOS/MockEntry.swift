import Foundation

struct MockEntry: Codable {
    let path: String
    var files = [String]()
    var selectedFile = 0
    private var statusCode = 200
    var responseTime = 400 as Int64
    
    init(path: String, files: [String]) {
        self.path = path
        self.files = files
    }
    
    func getSelectedFile() -> Int {
        return DDMockSettingsBundleHelper.getSelectedMockFile(key: path)
    }
    
    func getStatusCode() -> Int {
        return DDMockSettingsBundleHelper.getStatusCode(key: path)
    }
}
