import Alamofire

enum Router: URLRequestConvertible {
  static let baseURLString = "https://api.siteleaf.com/v1"
  static var apiKey: String?
  static var apiSecret: String?
  
  case Ping
  case GetUser
  case GetSite(String)
  case UpdateUser(String, [String: AnyObject])
  case DestroyUser(String)
  
  var method: Alamofire.Method {
    switch self {
    case .Ping:
      return .GET
    case .GetUser:
      return .GET
    case .GetSite:
      return .GET
    case .UpdateUser:
      return .PUT
    case .DestroyUser:
      return .DELETE
    }
  }
  
  var path: String {
    switch self {
    case .Ping:
      return "/ping.json"
    case .GetUser:
      return "/users/me.json"
    case .GetSite(let siteID):
      return "/v1/sites/\(siteID).json"
    case .UpdateUser(let username, _):
      return "/users/\(username)"
    case .DestroyUser(let username):
      return "/users/\(username)"
    }
  }
  
  // MARK: URLRequestConvertible
  
  var URLRequest: NSURLRequest {
    let URL = NSURL(string: Router.baseURLString)!
    let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
    mutableURLRequest.HTTPMethod = method.rawValue
    
    if let key = Router.apiKey {
      mutableURLRequest.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
    }
    
    switch self {
    case .Ping:
      return mutableURLRequest
    case .GetUser:
      return mutableURLRequest
    case .UpdateUser(_, let parameters):
      return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
    default:
      return mutableURLRequest
    }
  }
}
