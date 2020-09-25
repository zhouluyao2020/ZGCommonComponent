//
//  ZGFileInfoModel.m
//  ZGStudentServices
//
//  Created by zhouluyao on 9/14/20.
//  Copyright © 2020 offcn. All rights reserved.
//

#import "ZGFileInfoModel.h"

@implementation ZGFileInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"courseImageUrl" : @"imgUrl",
        @"videoKey" : @"key",
        @"lastTime" : @"last_time",
        @"lengthTime" : @"length_time",
        @"lessonTitle" : @"lesson_title",
        @"lessonType" : @"lesson_type",
        @"videoName" : @"name",
        @"videoSize" : @"size",
        @"videoUrl" : @"url",
        @"videoImage" : @"video_image",
        @"videoType" : @"video_type",
        @"downloadSource" : @"download_source"
    };
}

@end

