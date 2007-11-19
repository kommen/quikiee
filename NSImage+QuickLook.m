//
//  NSImage+QuickLook.m
//  QuickLookTest
//
//  Created by Matt Gemmell on 29/10/2007.
//

#import "NSImage+QuickLook.h"
#import <QuickLook/QuickLook.h> // Remember to import the QuickLook framework into your project!

@implementation NSImage (QuickLook)

+ (NSImage *)imageWithPreviewOfFileAtPath:(NSString *)path ofSize:(NSSize)size asIcon:(BOOL)icon
{
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    if (!path || !fileURL) {
        return nil;
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:icon] 
                                                     forKey:(NSString *)kQLThumbnailOptionIconModeKey];
    CGImageRef ref = QLThumbnailImageCreate(kCFAllocatorDefault, 
                                            (CFURLRef)fileURL, 
                                            CGSizeMake(size.width, size.height),
                                            (CFDictionaryRef)dict);
    
    if (ref != NULL) {
        NSBitmapImageRep *bitmapImageRep = [[NSBitmapImageRep alloc] initWithCGImage:ref];
        NSImage *newImage = nil;
        if (bitmapImageRep) {
            newImage = [[NSImage alloc] initWithSize:[bitmapImageRep size]];
            [newImage addRepresentation:bitmapImageRep];
            [bitmapImageRep release];
            
            if (newImage) {
                return [newImage autorelease];
            }
        }
        CFRelease(ref);
    } else {
        // If we couldn't get a Quick Look preview, fall back on the file's Finder icon.
        NSImage *icon = [[NSWorkspace sharedWorkspace] iconForFile:path];
        if (icon) {
            [icon setSize:size];
        }
        return icon;
    }
    
    return nil;
}

@end
