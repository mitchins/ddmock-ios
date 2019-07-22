import Foundation

public class DDMockProtocol: URLProtocol {
    
    public static func initialise(config: URLSessionConfiguration) {
        var protocolClasses = config.protocolClasses
        if protocolClasses == nil {
            protocolClasses = [AnyClass]()
        }
        protocolClasses!.insert(DDMockProtocol.self, at: 0)
        config.protocolClasses = protocolClasses
    }
    
    override public class func canInit(with request: URLRequest) -> Bool {
        return DDMock.shared.getMockEntry(request: request) != nil
    }
    
    override public class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override public func startLoading() {
        // fetch item
        if let path = self.request.url?.path.split(separator: "?")[0].description,
            let method = self.request.httpMethod {
            if let entry = DDMock.shared.getMockEntry(path: path, method: method) {
                // create mock response
                let data: Data? = DDMock.shared.getData(entry)
                var headers = [String: String]()
                headers["Content-Type"] = "application/json"
                if let data = data {
                    headers["Content-Length"] = "\(data.count)"
                }
                let response = HTTPURLResponse(url: self.request.url!, statusCode: entry.getStatusCode(), httpVersion: "HTTP/1.1", headerFields: headers)!
                
                // Simulate response time
                sleep(UInt32(entry.responseTime))
                
                // send response
                self.client!.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                
                // send response data if available
                if let data = data {
                    self.client!.urlProtocol(self, didLoad: data)
                }
                
                // finish up
                self.client!.urlProtocolDidFinishLoading(self)
            }
        }
    }
    
    override public func stopLoading() {
        //do nothing
    }
}
