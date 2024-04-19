
import Foundation

enum APIError: String, Error {
    case internalError
    case serverError
    case parsingError
}

enum Method {
    case GET
    case POST
}

