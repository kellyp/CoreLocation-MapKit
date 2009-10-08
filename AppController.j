/*
 * AppController.j
 * corelocation
 *
 * Created by Yo Mama on September 23, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <MapKit/MKMapView.j>
@import <CoreLocation/CLLocationManager.j>

@implementation AppController : CPObject
{
    MKMapView _mapView;
    
    CPView contentView;
    CLLocationManager locationManager;
    
    BOOL isMapReady;
    BOOL isMapLoaded;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
      var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];
      contentView = [theWindow contentView];

      var frameRect = CGRectMake(0,0, CPRectGetWidth([contentView frame]), CPRectGetHeight([contentView frame]));
      
      locationManager = [[CLLocationManager alloc] init];
		if(![locationManager locationServicesEnabled]){
		    alert("CoreLocation Not Supported");
		}else{
		    [locationManager setDelegate: self];
			[locationManager startUpdatingLocation];
		}
      


      [theWindow orderFront:self];

			isMapReady = NO;
    		isMapLoaded = NO;
    
    
    // Uncomment the following line to turn on the standard menu bar.
    //[CPMenu setMenuBarVisible:YES];
    

}

 - (void)mapViewIsReady:(MKMapView)mapView {
		isMapReady = YES;

/*
      //draw line
      var line = [MKPolyline polyline];
      [line addLocation:[MKLocation locationWithLatitude:51.8978655 andLongitude:-8.4710941]];
      [line addLocation:[MKLocation locationWithLatitude:37.775196 andLongitude:-122.419204]];
      [line addToMapView:_mapView];

      //add another marker
      var marker = [[MKMarker alloc] initAtLocation:[MKLocation locationWithLatitude:37.775196 andLongitude:-122.419204]];
      [marker addToMapView:_mapView];
*/
  }




//CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager)manager didFailWithError:(CPError)error
{
/*
    CPLogConsole(manager);
    CPLogConsole(error);
*/
}

- (void)locationManager:(CLLocationManager)manager didUpdateHeading:(CLHeading)newHeading
{
/*
    CPLogConsole(manager);
    CPLogConsole(newHeading);
*/
}

- (void)locationManager:(CLLocationManager)manager didUpdateToLocation:(CLLocation)newLocation fromLocation:(CLLocation)oldLocation
{

     console.warn("got a location " + [newLocation description]);
	if(isMapReady && newLocation){
		     console.warn("map is ready loading location");
	 var loc = [[MKLocation alloc] initWithLatitude:[newLocation coordinate].latitude andLongitude:[newLocation coordinate].longitude];
      var marker = [[MKMarker alloc] initAtLocation:loc];
      [marker addToMapView:_mapView];
      [_mapView setCenter:loc];
	}
    
    if(!isMapLoaded){
     console.warn("loading map");

	var frameRect = [contentView frame];
      _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, frameRect.size.width, frameRect.size.height) apiKey:''];

      [_mapView setAutoresizingMask:CPViewHeightSizable | CPViewWidthSizable];
      [_mapView setDelegate:self];
  
      [contentView addSubview:_mapView];
     console.warn("added map to display");     
      isMapLoaded = YES;
    }
//         [locationManager stopUpdatingLocation];

}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager)manager
{
/*     CPLogConsole(manager); */
}
//CLLocationManagerDelegate

@end
