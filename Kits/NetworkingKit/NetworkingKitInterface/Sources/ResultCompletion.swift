import Foundation

public typealias ResultCompletion<ReturnType, ErrorType: Error> = (Result<ReturnType, ErrorType>) -> Void
public typealias ActionCompletion<ErrorType: Error> = (Result<Void, ErrorType>) -> Void
