//
//  main.m
//  quickiee
//
//  Created by Dieter Komendera on 11/14/07. http://komendera.com
//  Licence: DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
//  http://sam.zoy.org/wtfpl/COPYING

#import <Cocoa/Cocoa.h>
#import <QuickLook/QuickLook.h>
#import "NSImage+QuickLook.h"

int main(int argc, char *argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

  if(argc < 3) {
    return -1;
  }
  NSString *srcfile = [[NSString stringWithUTF8String: argv[1]] stringByExpandingTildeInPath];
  NSString *dstfile = [[NSString stringWithUTF8String: argv[2]] stringByExpandingTildeInPath];

  NSSize dstsize;
  if(argc >= 4) {
    NSArray *sizes = [[NSString stringWithUTF8String: argv[3]] componentsSeparatedByString:@"x"];
    int maxwidth   = [[sizes objectAtIndex: 0] intValue];
    int maxheight  = [[sizes objectAtIndex: 1] intValue];        
    dstsize = NSMakeSize(maxwidth, maxheight);
  } else {
    dstsize = NSMakeSize(200,200);
  }

  NSString *format;
  if(argc >= 5) {
    format = [NSString stringWithUTF8String:argv[4]];
  } else {
    format = @"png";
  }

  NSImage *image = [NSImage imageWithPreviewOfFileAtPath:srcfile
                                                  ofSize:dstsize
                                                  asIcon:NO];

  NSBitmapImageRep *rep = [[image representations] objectAtIndex: 0];

  NSData *data;
  if([format caseInsensitiveCompare:@"png"] == 0) {
      data =  [rep representationUsingType: NSPNGFileType properties: nil];
  } else if([format caseInsensitiveCompare:@"tiff"] == 0) {
      data = [rep representationUsingType: NSTIFFFileType properties: nil];
  } else if([format caseInsensitiveCompare:@"bmp"] == 0) {
      data = [rep representationUsingType: NSBMPFileType properties: nil];
  } else if([format caseInsensitiveCompare:@"gif"] == 0) {
      data = [rep representationUsingType: NSGIFFileType properties: nil];
  } else if([format caseInsensitiveCompare:@"jpg"] == 0){
      data = [rep representationUsingType: NSJPEGFileType properties: nil];
  } else {
    printf("unknown format: ");
    printf([format UTF8String]);
    printf("\n");
    return -1;
  }
  [data writeToFile: dstfile atomically: NO];

  [pool release];
  return 0;	
}
