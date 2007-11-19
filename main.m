//
//  main.m
//  quickiee
//
//  Created by Dieter Komendera on 11/14/07.
//  Copyright __MyCompanyName__ 2007. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuickLook/QuickLook.h>
#import "NSImage+QuickLook.h"

 int main(int argc, char *argv[])
 {
	NSString *srcfile = [[[NSString alloc] initWithCString:argv[1] encoding: NSUTF8StringEncoding] stringByExpandingTildeInPath];
    NSString *dstfile = [[[NSString alloc] initWithCString:argv[2] encoding: NSUTF8StringEncoding] stringByExpandingTildeInPath];
	NSImage *image = [NSImage imageWithPreviewOfFileAtPath:srcfile
		ofSize:NSMakeSize(300, 300)
		asIcon:NO];
	
    NSBitmapImageRep *rep = [[image representations] objectAtIndex: 0];
    
    NSData *data = [rep representationUsingType: NSPNGFileType properties: nil];
    [data writeToFile: dstfile atomically: NO];

 	return 0;	
 }
