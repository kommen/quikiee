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
	
	NSImage *image = [NSImage imageWithPreviewOfFileAtPath:[[NSString alloc] initWithCString:argv[1] encoding:NSUTF8StringEncoding]
		ofSize:NSMakeSize(300, 300)
		asIcon:NO];
	
	[[image TIFFRepresentation] writeToFile:[[NSString alloc] initWithCString:argv[2] encoding:NSUTF8StringEncoding] atomically:YES];

 	return 0;	
 }
