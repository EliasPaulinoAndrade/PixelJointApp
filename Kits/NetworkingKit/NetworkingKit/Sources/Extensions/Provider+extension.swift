import Foundation
import NetworkingKitInterface

public extension Provider {
    var asAny: AnyProvider<ReturnType> {
        AnyProvider(provider: self)
    }
    
    var includeCaching: AnyProvider<ReturnType> {
        CacheProvider(cachableProvider: self.asAny).asAny
    }
    
    func map<NewReturnType>(keyPath: KeyPath<ReturnType, NewReturnType>) -> AnyProvider<NewReturnType> {
        let selfRequest = self.request
        
        return AnyProvider<NewReturnType>(
            request: { resource, resultCompletion -> CancellableTask? in
                selfRequest(resource) { result in
                    resultCompletion(result.map { result -> NewReturnType in
                        result[keyPath: keyPath]
                    })
                }
            }
        )
    }
    
    func map<NewReturnType>(transformer: @escaping (ReturnType) -> NewReturnType) -> AnyProvider<NewReturnType> {
        let selfRequest = self.request
        
        return AnyProvider<NewReturnType>(
            request: { resource, resultCompletion -> CancellableTask? in
                selfRequest(resource) { result in
                    resultCompletion(result.map(transformer))
                }
            }
        )
    }
}

public extension Provider where ReturnType == Data {
    func includeParsing<ParserType: Parser>(parser: ParserType) -> AnyProvider<ParserType.ParsableType> {
        return DefaultParserProvider(parser: parser, provider: self).asAny
    }
}
