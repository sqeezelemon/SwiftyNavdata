//
//  File.swift
//  
//
//  Created by Александр Никитин on 06.07.2021.
//

import Foundation

public struct Airport: Codable {
    // Autogenerated memberwise initializer so that it can be made public
    public init(rowCode: Int, elevation: Int, icao: String, name: String, runways: [Airport.Runway], pavement: [Airport.Pavement], linearFeatures: [Airport.LinearFeature], airportBoundary: [Airport.Node], viewPoint: Airport.ViewPoint? = nil, startupLocations: [Airport.StartupLocation], lightBeacon: Airport.LightBeacon? = nil, lightingObjects: [Airport.LightingObject], atcFrequencies: [Airport.AtcFacility]) {
        self.rowCode = rowCode
        self.elevation = elevation
        self.icao = icao
        self.name = name
        self.runways = runways
        self.pavement = pavement
        self.linearFeatures = linearFeatures
        self.airportBoundary = airportBoundary
        self.viewPoint = viewPoint
        self.startupLocations = startupLocations
        self.lightBeacon = lightBeacon
        self.lightingObjects = lightingObjects
        self.atcFrequencies = atcFrequencies
    }
    
    
    /// Row code for an airport, seaplane base or heliport. 1 - Land, 16 - Seaplane, 17 - Heliport
    public var rowCode: Int
    /// Elevation of airport in feet above mean sea level (AMSL)
    public var elevation: Int
    public var icao: String
    public var name: String
    
    //MARK: Runways
    public var runways: [Runway]
    public struct Runway: Codable {
        
        public init(rowCode: Int, width: Float, surfaceType: Int, shoulderSurfaceType: Int, runwayEnd1: Airport.Runway.RunwayEnd, runwayEnd2: Airport.Runway.RunwayEnd) {
            self.rowCode = rowCode
            self.width = width
            self.surfaceType = surfaceType
            self.shoulderSurfaceType = shoulderSurfaceType
            self.runwayEnd1 = runwayEnd1
            self.runwayEnd2 = runwayEnd2
        }
        
        ///Row code of the runway. 100 - Land, 101 - Water, 102 - Helipad.
        public var rowCode: Int
        ///Runway width in metres
        public var width: Float
        
        public var surfaceType: Int
        public var shoulderSurfaceType: Int
        
        public var runwayEnd1: RunwayEnd
        public var runwayEnd2: RunwayEnd
        
        public struct RunwayEnd: Codable {
            
            public init(runwayNumber: String, latitude: Float, longitude: Float, displacedThresholdLength: Float, runwayMarkingType: Int) {
                self.runwayNumber = runwayNumber
                self.latitude = latitude
                self.longitude = longitude
                self.displacedThresholdLength = displacedThresholdLength
                self.runwayMarkingType = runwayMarkingType
            }
            
            public var runwayNumber: String
            public var latitude: Float
            public var longitude: Float
            
            ///Length of displaced threshold in metres (this is included in implied runway length)
            public var displacedThresholdLength: Float
            public var runwayMarkingType: Int
        }
    }
    
    //MARK: Nodes
    var pavement: [Pavement]
    public var linearFeatures: [LinearFeature]
    public var airportBoundary: [Node]
    
    public struct Node: Codable {
        
        public init(rowCode: Int, latitude: Float, longitude: Float, beizerLatitude: Float? = nil, beizerLongitude: Float? = nil, lineType: Int? = nil) {
            self.rowCode = rowCode
            self.latitude = latitude
            self.longitude = longitude
            self.beizerLatitude = beizerLatitude
            self.beizerLongitude = beizerLongitude
            self.lineType = lineType
        }
        
        public var rowCode: Int
        public var latitude: Float
        public var longitude: Float
        
        ///Latitude of Bezier control point, only for 112, 114, 116 row codes
        public var beizerLatitude: Float?
        ///Longitude of Bezier control point, only for 112, 114, 116 row codes
        public var beizerLongitude: Float?
        
        ///Code for painted line type on line segment starting at this node
        public var lineType: Int?
    }
    
    public struct Pavement: Codable {
        
        public init(surfaceType: Int, description: String, nodes: [Airport.Node]) {
            self.surfaceType = surfaceType
            self.description = description
            self.nodes = nodes
        }
        
        public var surfaceType: Int
        public var description: String
        public var nodes: [Node]
    }
    
    public struct LinearFeature: Codable {
        
        public init(description: String, nodes: [Airport.Node]) {
            self.description = description
            self.nodes = nodes
        }
        
        public var description: String
        public var nodes: [Node]
    }
    
    //MARK: View Point
    public var viewPoint: ViewPoint?
    public struct ViewPoint: Codable {
        
        public init(latitude: Float, longitude: Float, height: Int, name: String) {
            self.latitude = latitude
            self.longitude = longitude
            self.height = height
            self.name = name
        }
        
        public var latitude: Float
        public var longitude: Float
        ///Height (in feet) of viewpoint above ground level
        public var height: Int
        public var name: String
    }
    
    //MARK: Startup locations
    public var startupLocations: [StartupLocation]
    public struct StartupLocation: Codable {
        public init(latitude: Float, longitude: Float, heading: Float, name: String, locationType: String? = nil, allowedAirplaneTypes: String? = nil, icaoWidth: String? = nil) {
            self.latitude = latitude
            self.longitude = longitude
            self.heading = heading
            self.name = name
            self.locationType = locationType
            self.allowedAirplaneTypes = allowedAirplaneTypes
            self.icaoWidth = icaoWidth
        }
        
        public var latitude: Float
        public var longitude: Float
        ///Heading (true) of an aeroplane when positioned at startup location
        public var heading: Float
        public var name: String
        
        // Stuff only present in 1300
        
        /**
         - Note: Only available for row code 1300 gates
         */
        public var locationType: String?
        
        /**
         - Note: Only available for row code 1300 gates
         */
        public var allowedAirplaneTypes: String?
        
        /**
         - Note: Only available for row code 1300 gates with 1301 metadata row
         */
        public var icaoWidth: String?
    }
    
    //MARK: Light Beacon
    public var lightBeacon: LightBeacon?
    public struct LightBeacon: Codable {
        public init(latitude: Float, longitude: Float, beaconType: Int) {
            self.latitude = latitude
            self.longitude = longitude
            self.beaconType = beaconType
        }
        
        public var latitude: Float
        public var longitude: Float
        public var beaconType: Int
    }
    
    //MARK: Lighting Objects
    var lightingObjects: [LightingObject]
    public struct LightingObject: Codable {
        public init(latitude: Float, longitude: Float, type: Int, orientation: Float, glideslopeAngle: Float, associatedRunway: String, description: String? = nil) {
            self.latitude = latitude
            self.longitude = longitude
            self.type = type
            self.orientation = orientation
            self.glideslopeAngle = glideslopeAngle
            self.associatedRunway = associatedRunway
            self.description = description
        }
        
        public var latitude: Float
        public var longitude: Float
        public var type: Int
        public var orientation: Float
        public var glideslopeAngle: Float
        public var associatedRunway: String
        public var description: String?
    }
    
    //MARK: ATC
    public var atcFrequencies: [AtcFacility]
    public struct AtcFacility: Codable {
        public init(rowCode: Int, frequency: Int, name: String) {
            self.rowCode = rowCode
            self.frequency = frequency
            self.name = name
        }
        
        public var rowCode: Int
        /// Frequency in kHz
        public var frequency: Int
        public var name: String
    }
}

extension Airport: Identifiable {
    public var id: String { icao }
}

//MARK: Convenience extensions
// Extensions that you might not use, but they're here if you don't want to spend all day checking the docs for the right surface code for gravel ;)

public extension Airport.AtcFacility {
    enum AtcFacilityType: Int {
        case unicom = 51
        //case clearanceDelivery = 52
        case ground = 53
        case tower = 54
        case approach = 55
        case departure = 56
    }
    
    var facilityTypeEnum: AtcFacilityType? {
        let value = rowCode % 1000
        return AtcFacilityType.init(rawValue: value)
    }
}

public extension Airport {
    enum SurfaceType: Int {
        case asphalt = 1
        case concrete = 2
        case turfGrass = 3
        case dirt = 4
        case gravel = 5
        case dryLakebed = 12
        case waterRunways = 13
        case snow = 14
        case transparent = 15
    }
}

public extension Airport.Pavement {
    var surfaceTypeEnum: Airport.SurfaceType? {
        return Airport.SurfaceType.init(rawValue: surfaceType)
    }
}

public extension Airport.Runway {
    var surfaceTypeEnum: Airport.SurfaceType? {
        return Airport.SurfaceType.init(rawValue: surfaceType)
    }
}

public extension Airport.Runway.RunwayEnd {
    enum RunwayMarkingType: Int {
        case noMarkings = 0
        case visualMarkings = 1
        case nonPrecisionMarkings = 2
        case presicionApproachmarkers = 3
        case ukNonPrecisionMarkers = 4
        case ukPrecisionMarkers = 5
    }
    
    var RunwayMarkingTypeEnum: Airport.Runway.RunwayEnd.RunwayMarkingType? {
        return Airport.Runway.RunwayEnd.RunwayMarkingType.init(rawValue: runwayMarkingType)
    }
}

public extension Airport.Node {
    /**
     - Note: The names might be confusing, but they're pretty much from the docs. Every enum case has a description from the docs.
     */
    enum LineType: Int {
        case nothing = 0
        ///Taxiway centre lines
        case solidYellow = 1
        ///Miscellaneous boundaries
        case brokenYellow = 2
        ///Taxiway edge lines
        case doubleSolidYellow = 3
        ///Runway hold positions
        case twoBrokenTwoSolidYellow = 4
        ///Other (non-runway) hold locations
        case brokenWithSolid = 5
        ///ILS hold
        case yellowCrossHatched = 6
        ///Taxiway centerlines in runway safety zones
        case solidWithBrokenOnTheSide = 7
        ///Mark ‘lanes’ for queuing aeroplanes
        case widelySeparatedBrokenYellow = 8
        ///Mark ‘lanes’ for queuing aeroplanes
        case widelySeparatedDoubleSolidBrokenYellow = 9
        
        ///Taxiway centre lines with a black border
        case solidYellowWithBlackBorder = 51
        ///Miscellaneous boundaries with a black border
        case brokenYellowWithBlackBorder = 52
        ///Taxiway edge lines with a black border
        case doubleSolidYellowWithBlackBorder = 53
        ///Runway hold positions with a black border
        case twoBrokenTwoSolidYellowWithBlackBorder = 54
        ///Other (non-runway) hold locations with a black border
        case brokenWithSolidWithBlackBorder = 55
        ///ILS hold with a black border
        case yellowCrossHatchedWithBlackBorder = 56
        ///Taxiway centerlines in runway safety zones with a black border
        case solidWithBrokenOnTheSideWithBlackBorder = 57
        ///Mark ‘lanes’ for queuing aeroplanes with a black border
        case widelySeparatedBrokenYellowWithBlackBorder = 58
        ///Mark ‘lanes’ for queuing aeroplanes with a black border
        case widelySeparatedDoubleSolidBrokenYellowWithBlackBorder = 59
        
        ///Roadway markings
        case solidWhite = 20
        ///Roadway markings
        case checkerboardWhite = 21
        ///Roadway markings
        case brokenWhite = 22
    }
    var lineTypeEnum: Airport.Node.LineType? {
        // 100 is just a placeholder to send nil
        return Airport.Node.LineType.init(rawValue: lineType ?? 100)
    }
}

public extension Airport.LightBeacon {
    enum BeaconType: Int {
        case none = 0
        case whiteGreen = 1
        case whiteYellow = 2
        case greenWhiteYellow = 3
        case whiteWhiteGreen = 4
    }
    
    var beaconTypeEnum: BeaconType? {
        return BeaconType.init(rawValue: beaconType)
    }
}

public extension Airport.LightingObject {
    enum LightingObjectType: Int {
        case vasi = 1
        ///Left-handed: red indication appears first on ​right​ 2 lights
        case papi4L = 2
        ///Right-handed: red indication appears first on ​left​ 2 lights
        case papi4R = 3
        ///Papi with 20 degree glidepath. Deprecated. Use normal PAPI with an appropriate angle.
        case spaceShuttlePapi = 4
        case triColorPapi = 5
        ///Pulsating double amber lights alongside runway entrances
        case runwayGuardLights = 6
    }
    var lightingObjectTypeEnum: LightingObjectType? {
        return LightingObjectType.init(rawValue: type)
    }
}
