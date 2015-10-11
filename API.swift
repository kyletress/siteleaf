import Alamofire

enum Router: URLRequestConvertible {
  static let baseURLString = "https://api.siteleaf.com/v1"
  static var OAuthToken: String?
  
  case Ping
  
  
  var method: Alamofire.Method {
    switch self {
    case .Ping:
      return .GET
    }
  }
  
  var path: String {
    switch self {
    case .Ping:
      return "/ping.json"
    }
  }
  
  // MARK: URLRequestConvertible
  
  var URLRequest: NSMutableURLRequest {
    let URL = NSURL(string: Router.baseURLString)!
    let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
    mutableURLRequest.HTTPMethod = method.rawValue
    
    if let token = Router.OAuthToken {
      mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    
    switch self {
    default:
      return mutableURLRequest
    }
  }
}