import PerfectLib

class BaseRequestHandler: RequestHandler {
    enum ActionResponse {
        case Output(templatePath: String?, values: [String: Any])
        case Redirect(url: String)
        case Error(status: Int, message: String)
    }
    
    var request: WebRequest!
    var response: WebResponse!
    var db: SQLite!
    
    
    func handleRequest(request: WebRequest, response: WebResponse) {
        //  initialize
        self.request = request
        self.response = response
        
        defer {
            response.requestCompletedCallback()
        }
        
        do {
            db = try SQLite(Config.dbPath)
            try response.getSession(Config.sessionName, withConfiguration: SessionConfiguration(Config.sessionName, expires: Config.sessionExpires))
        } catch (let e) {
            print(e)
        }
    }
    
 
}

