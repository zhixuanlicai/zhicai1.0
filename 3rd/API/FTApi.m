//
//  FTApi.m
//  libFT
//
//  Created by huoding on 14-4-9.
//  Copyright (c) 2014年 HuoDing. All rights reserved.
//

#import "FTApi.h"
#import "SandboxFile.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
//#import "SVProgressHUD.h"
@implementation FTUploadFile
@synthesize name;
@synthesize fileName;
@synthesize mineType;
@synthesize fileData;
@end

@interface FTApi ()

@property (readwrite, nonatomic, strong) NSString *restURL;
@property (readwrite, nonatomic, unsafe_unretained) FTFormat format;
@property (readwrite, nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation FTApi

+ (NSString*)getAppToken
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleid = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    NSString *token =   [bundleid substringFromIndex:@"com.cwedding.yunguanwang".length];
//    token = @"ltjkng1407405224";
    NSLog(@"token==%@",token);
    return token;
}
+ (instancetype)APIWithURL:(NSString*)url withFormat:(FTFormat)format
{
    return [[self alloc] initWithURL:url withFormat:format];
}
- (NSArray *)configResponseSerializer
{
    static NSArray *serializer = nil;
    if (serializer == nil) {
        serializer = @[@"AFJSONResponseSerializer",
                       @"AFXMLParserResponseSerializer",
                       @"AFPropertyListResponseSerializer",
                       @"AFImageResponseSerializer",
                       @"AFHTTPResponseSerializer"];
    }
    return serializer;
}
- (instancetype)initWithURL:(NSString*)url withFormat:(FTFormat)format
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.restURL = url;
    self.format = format;
    self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:API_BASE_URL]];
    Class ser = NSClassFromString([[self configResponseSerializer] objectAtIndex:format]);
    AFHTTPResponseSerializer <AFURLResponseSerialization> *serializer = [ser serializer];
    self.manager.responseSerializer = serializer;
    return self;
}
+ (NSString*) MD5FromStr:(NSString *)str
{
    const char *ptr = [str UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}
- (void)get:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete
{


    [self.manager GET:_restURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"url ==%@",operation.request.URL);
//        [SVProgressHUD show];
//        [SVProgressHUD dismissWithError:[NSString stringWithFormat:@"%@",operation.request.URL] afterDelay:5.0];
        
        
        NSString *fileName = [FTApi MD5FromStr:operation.request.URL.absoluteString];
        NSString *cacheDir = [SandboxFile GetPathForCaches:fileName inDir:@"api"];
        if (responseObject) {
            [responseObject writeToFile:[cacheDir stringByAppendingPathExtension:@"plist"] atomically:YES];
        }
        complete(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *fileName = [FTApi MD5FromStr:operation.request.URL.absoluteString];
        NSString *cacheDir = [SandboxFile GetPathForCaches:fileName inDir:@"api"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[cacheDir stringByAppendingPathExtension:@"plist"]];
        if (dic) {
            complete(dic,nil);
        }
        else
        {
            NSArray *arr = [NSArray arrayWithContentsOfFile:[cacheDir stringByAppendingPathExtension:@"plist"]];
            if (arr) {
                complete(arr,nil);
            }
            else
            {
                complete(nil,error);   
            }
        }
    }];
}
- (void)post:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete
{
    [self.manager POST:_restURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"url ==%@",operation.request.URL);

        complete(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(nil,error);
    }];
}
- (void)del:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete
{
    [self.manager DELETE:_restURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        complete(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(nil,error);
    }];
}
- (void)patch:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete
{
    [self.manager PATCH:_restURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        complete(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(nil,error);
    }];
}

- (void)put:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete
{
    [self.manager PUT:_restURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        complete(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(nil,error);
    }];
}
- (void)post:(NSArray*)fileArr withParams:(NSDictionary*)params complete:(void (^)(id response,NSError *error))complete
{
    
    [self.manager POST:_restURL parameters:params constructingBodyWithBlock:^(id <AFMultipartFormData> formData)
        {
            for (FTUploadFile * p in fileArr) {
                [formData appendPartWithFileData:p.fileData name:p.name fileName:p.fileName mimeType:p.mineType];
            }
        }
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   complete(responseObject,nil);
            NSLog(@"url ==%@",operation.request.URL);

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   complete(nil,error);
        }];

}


@end


@implementation FTApi (helper)
+ (void)requestWithMethod:(NSString*)method withPath:(NSString*)path withParams:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete
{

    

//    [SVProgressHUD show];
//    [SVProgressHUD dismissWithError:token afterDelay:5.0];
    FTApi *_sharedClient = [FTApi APIWithURL:path withFormat:FTJson];

    if ([[method lowercaseString] isEqualToString:@"post"]) {
        [_sharedClient post:params complate:complete];

    }
    else
    {
        [_sharedClient get:params complate:complete];
    }
}
+ (void)requestWithPostFile:(NSArray*)file withPath:(NSString*)path withParams:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete
{
    FTApi *_sharedClient = [FTApi APIWithURL:path withFormat:FTJson];
    [_sharedClient post:file withParams:params complete:complete];
}

+ (void)downloadWithUrl:(NSString*)url toFilePath:(NSString*)filePath  isContinue:(BOOL)isContinue withProgressBlock:(void (^)(long long downBytes,long long totalBytes))block complate:(void (^)(NSError *error))complete
{
    NSString *downloadUrl = url;
    if (![url hasPrefix:@"http"]) {
        downloadUrl = [NSString stringWithFormat:@"%@/%@",API_BASE_URL,downloadUrl];
    }
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *downloadPath = [cacheDirectory stringByAppendingPathComponent:[self MD5FromStr:url]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:downloadUrl]];
    //检查文件是否已经下载了一部分
    unsigned long long downloadedBytes = 0;
    if (isContinue && [[NSFileManager defaultManager] fileExistsAtPath:downloadPath]) {
        //获取已下载的文件长度
        downloadedBytes = [self fileSizeForPath:downloadPath];
        if (downloadedBytes > 0) {
            NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
            NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
            [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
            request = mutableURLRequest;
        }
    }
    //不使用缓存，避免断点续传出现问题
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    //下载请求
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:downloadPath append:isContinue];
    //下载进度回调
    if (block) {
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            //下载进度
            
            block((totalBytesRead + downloadedBytes) ,(totalBytesExpectedToRead + downloadedBytes));
        }];
    }
    //成功和失败回调
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        __autoreleasing  NSError  * error = nil;
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        }
        BOOL result = [[NSFileManager defaultManager] moveItemAtPath:downloadPath toPath:filePath error:&error];
        if (!result || error) {
            complete(error);
        }
        else
        {
            complete(nil);
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(error);
    }];
    [operation start];
}
//获取已下载的文件大小
+ (unsigned long long)fileSizeForPath:(NSString *)path {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}
@end
