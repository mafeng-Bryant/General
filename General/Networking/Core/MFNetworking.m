//
//  PPRequestManager.m
//  PatPat
//
//  Created by Yuan on 14/12/24.
//  Copyright (c) 2014年 http://www.patpat.com. All rights reserved.
//
#import "MFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "MFNetworkingHeader.h"



static NSString *const RequestMethodGet     = @"GET";
static NSString *const RequestMethodPost    = @"POST";
static NSString *const RequestMethodHead    = @"HEAD";
static NSString *const RequestMethodPut     = @"PUT";
static NSString *const RequestMethodDelete  = @"DELETE";

@implementation MFNetworking
{
    AFHTTPRequestOperationManager *_manager;
    NSMutableDictionary *_requestsRecord;
    NSMutableDictionary *_errorList;
}

+ (MFNetworking *)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        [self validateBaseUrl];
        _requestsRecord = [NSMutableDictionary dictionary];
        _manager = [AFHTTPRequestOperationManager manager];
        if ([MFNetworkingConfig sharedInstance].requestSerializer) {
            _manager.requestSerializer = [MFNetworkingConfig sharedInstance].requestSerializer;
        }
        if ([MFNetworkingConfig sharedInstance].responseSerializer) {
            _manager.responseSerializer = [MFNetworkingConfig sharedInstance].responseSerializer;
        }
        _manager.securityPolicy.allowInvalidCertificates = YES;
        _manager.responseSerializer.stringEncoding = NSUTF8StringEncoding;
        _manager.responseSerializer.acceptableContentTypes = [self acceptableContentTypes];
        _manager.operationQueue.maxConcurrentOperationCount = 4;
        [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
        [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    }
    return self;
}

- (NSSet *)acceptableContentTypes
{
    NSMutableSet *acceptableContentTypes = [NSMutableSet setWithSet:_manager.responseSerializer.acceptableContentTypes];
    [acceptableContentTypes addObject:@"text/html"];
    [acceptableContentTypes addObject:@"text/plain"];
    [acceptableContentTypes addObject:@"text/json"];
    [acceptableContentTypes addObject:@"text/xml"];
    [acceptableContentTypes addObject:@"text/javascript"];
    [acceptableContentTypes addObject:@"application/json"];
    return acceptableContentTypes;
}

- (void)addRequest:(PPRequest *)request
{
    //request serializer type
    if (request.child && [request.child respondsToSelector:@selector(requestSerializer)]) {
        _manager.requestSerializer = [request.child requestSerializer];
    }else{
        _manager.requestSerializer = [MFNetworkingConfig sharedInstance].requestSerializer;
    }
    
    //response serializer type
    if (request.child && [request.child respondsToSelector:@selector(responseSerializer)]) {
        _manager.responseSerializer = [request.child responseSerializer];
    }else{
        _manager.responseSerializer = [MFNetworkingConfig sharedInstance].responseSerializer;
    }
    
    //set request timeout
    if (request.child && [request.child respondsToSelector:@selector(requestTimeoutInterval)]) {
        _manager.requestSerializer.timeoutInterval = [request.child requestTimeoutInterval];//设置超时时间
    }else{
        _manager.requestSerializer.timeoutInterval = [MFNetworkingConfig sharedInstance].timeoutInterval;
    }
    
    //request parameters
    __block id param = nil;
    if (request.child && [request.child respondsToSelector:@selector(requestParameter)]) {
        param =[request.child requestParameter] ;
    }
    
    __block NSDictionary *headers = nil;
    if (request.child && [request.child respondsToSelector:@selector(requestHeaderFieldValueDictionary)]) {
        headers =[request.child requestHeaderFieldValueDictionary] ;
    }
    
    //对请求的header和paramers参数做reform处理
    if (request.requestReformer && [request.requestReformer respondsToSelector:@selector(requestReformerWithHeaders:parameters:finished:)]) {
        [request.requestReformer requestReformerWithHeaders:headers
                                                 parameters:param
                                                   finished:^(id new_headers, id new_params) {
                                                       param = new_params;
                                                       headers = new_headers;
                                                   }];
    }
    
    if (isValidDictionary(headers)) {
        for (id httpHeaderField in headers.allKeys) {
            id value = headers[httpHeaderField];
            if ([httpHeaderField isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
                [_manager.requestSerializer setValue:(NSString *)value forHTTPHeaderField:(NSString *)httpHeaderField];
            } else {
               // HYLog(@"Error,the headerfield's key/value must NSString.");
            }
        }
    }
    
    //construct the request
    MFRequestMethod method = MFRequestMethodPost;
    if (request.child && [request.child respondsToSelector:@selector(requestMethod)]) {
        method =[request.child requestMethod] ;
    }
    NSString *url = [self buildRequestUrl:request];
    if (method == MFRequestMethodGet) {
        request.requestOperation = [_manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self handleRequestResult:operation error:nil];
        }                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleRequestResult:operation error:error];
        }];
    } else if (method == MFRequestMethodPost) {
        if ([request.child respondsToSelector:@selector(multipartFormDataBlock)]) {
            PPRequestMultipartFormDataBlock multipartFormDataBlock = [request.child multipartFormDataBlock];
            request.requestOperation = [_manager POST:url parameters:param constructingBodyWithBlock:multipartFormDataBlock
                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                  [self handleRequestResult:operation error:nil];
                                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                  [self handleRequestResult:operation error:error];
                                              }];
            if ([request.child respondsToSelector:@selector(uploadProgressBlock)]) {
                [request.requestOperation setUploadProgressBlock:[request.child uploadProgressBlock]];
            }
        }else{
            request.requestOperation = [_manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self handleRequestResult:operation error:nil];
            }                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self handleRequestResult:operation error:error];
            }];
        }
    } else if (method == MFRequestMethodHead) {
        request.requestOperation = [_manager HEAD:url parameters:param success:^(AFHTTPRequestOperation *operation) {
            [self handleRequestResult:operation error:nil];
        }                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleRequestResult:operation error:error];
        }];
    } else if (method == MFRequestMethodPut) {
        request.requestOperation = [_manager PUT:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self handleRequestResult:operation error:nil];
        }                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleRequestResult:operation error:error];
        }];
    } else if (method == MFRequestMethodDelete) {
        request.requestOperation = [_manager DELETE:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self handleRequestResult:operation error:nil];
        }                                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleRequestResult:operation error:error];
        }];
    }
    [MFNetworkingLogger printWithRequest:NSStringFromClass([request class])
                                 methord:[self methordWithType:method]
                                     url:request.absoluteString
                                 headers:_manager.requestSerializer.HTTPRequestHeaders
                                  params:param];
    [self addOperation:request];
}

- (void)handleRequestResult:(AFHTTPRequestOperation *)operation
                      error:(NSError *)error
{
    
    NSString *key = [self requestHashKey:operation];
    PPRequest *request = _requestsRecord[key];
    request.error = error;
    [MFNetworkingLogger printResponse:request error:request.error];

    //reform response result
    if (request.responseReformer && [request.responseReformer respondsToSelector:@selector(responseReormer:)]) {
        [request.responseReformer responseReormer:request];
    }
    
    //intercept action
    if (request.interceptor && [request.interceptor respondsToSelector:@selector(interceptResponse:)]) {
        [request.interceptor interceptResponse:request];
    }    

    if (error) { //request failure
        if (request && request.failureCompletionBlock) {
            request.failureCompletionBlock(request,request.error);
        }
    }else {  //request succeed
        if (request && request.successCompletionBlock) {
            request.successCompletionBlock(request);
        }
    }
    if (request && request.completionHandler) {
        request.completionHandler(request.responseObject,request,request.error);
    }
    [self removeOperation:operation];
}

- (void)cancelAllRequests {
    NSDictionary *copyRecord = [_requestsRecord copy];
    for (NSString *key in copyRecord) {
        PPRequest *request = copyRecord[key];
        [self cancelRequest:request];
    }
}

- (void)cancelRequest:(PPRequest *)request {
    [request.requestOperation cancel];
    [self removeOperation:request.requestOperation];
    [request clearCompletionBlock];
}

#pragma mark Private methords
- (NSString *)buildRequestUrl:(PPRequest *)request {
    NSString *path = @"";
    if (request.child && [request.child respondsToSelector:@selector(path)] && [request.child path]) {
        path = [request.child path];
    }
    if ([path hasPrefix:@"http"] || [path hasPrefix:@"https"] ) {
        return path;
    }
    NSString *host = [MFNetworkingConfig sharedInstance].host;
    if (request.child && [request.child respondsToSelector:@selector(host)] && [request.child host]) {
        host = [request.child host];
    }
    //直接使用stringByAppendingPathComponent会导致http://变为http:/丢掉了一个/
    NSURL *URL = [[NSURL URLWithString:host] URLByAppendingPathComponent:path];
    return URL.absoluteString;
}

- (BOOL)statusCodeValidator:(NSInteger)statusCode {
    if (statusCode >= 200 && statusCode <=299) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)requestHashKey:(AFHTTPRequestOperation *)operation {
    NSString *key = [NSString stringWithFormat:@"%lu", (unsigned long)[operation hash]];
    return key;
}

- (void)addOperation:(PPRequest *)request {
    if (request.requestOperation != nil) {
        NSString *key = [self requestHashKey:request.requestOperation];
        _requestsRecord[key] = request;
    }
}

- (void)removeOperation:(AFHTTPRequestOperation *)operation {
    NSString *key = [self requestHashKey:operation];
    [_requestsRecord removeObjectForKey:key];
    //    HYLog(@"Request queue size = %lu", (unsigned long)[_requestsRecord count]);
}

+ (BOOL)isConnected{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

#pragma mark Private methords

- (NSString *)methordWithType:(MFRequestMethod)methord
{
    switch (methord) {
        case MFRequestMethodGet:
            return RequestMethodGet;
            break;
        case MFRequestMethodPost:
            return RequestMethodPost;
            break;
        case MFRequestMethodDelete:
            return RequestMethodDelete;
            break;
        case MFRequestMethodHead:
            return RequestMethodHead;
            break;
        case MFRequestMethodPut:
            return RequestMethodPut;
            break;
        default:
            break;
    }
    return @"unknown";
}

//检测是否设置了base url
- (void)validateBaseUrl{
    NSAssert([[MFNetworkingConfig sharedInstance].host isValidUrl], @"Error: Please set request base url,use setRequestBaseUrl: methord in PPNetworkingConfig");
}

@end







