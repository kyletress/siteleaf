import Alamofire

struct SiteleafAPI {
  
  enum Router: URLRequestConvertible {
    static let baseURLString = "https://api.siteleaf.com/v1"
    
    case Ping
    case GetSites
    case GetMe
    
    
    var method: Alamofire.Method {
      switch self {
      case .Ping:
        return .GET
      case .GetSites:
        return .GET
      case .GetMe:
        return .GET
      }
    }
    
    var path: String {
      switch self {
      case .Ping:
        return "/ping.json"
      case .GetSites:
        return "/sites.json"
      case .GetMe:
        return "/users/me.json"
      }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
      let URL = NSURL(string: Router.baseURLString)!
      let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
      mutableURLRequest.HTTPMethod = method.rawValue
      mutableURLRequest.setValue("Basic a3lsZXRyZXNzQGljbG91ZC5jb206b3YyR2hvdDRhUmI3VXYzZXM0dEg=", forHTTPHeaderField: "Authorization")
      
      switch self {
      default:
        return mutableURLRequest
      }
    }
  }
}