/*import Foundation
import Scenes
import Igis

private func getColorForFlightCategory(_ category: String?) -> Color {
    guard let category = category else { return Color(.black) }
    switch category {
    case "VFR":
        return Color(.green)
    case "MVFR":
        return Color(.blue)
    case "IFR":
        return Color(.red)
    case "LIFR":
        return Color(.magenta)
    default:
        return Color(.black)
    }
} 

func createEllipse(skyCover: String, x: Int, y: Int, size: Int) -> Ellipse {
    var endAngle = 0.0

    switch skyCover {
    case "SKC":
        endAngle = 0.0
    case "FEW":
        endAngle = (1.0 / 4.0) * Double.pi
    case "SCT":
        endAngle = (2.0 / 4.0) * Double.pi
    case "BKN":
        endAngle = (3.0 / 4.0) * Double.pi
    case "OVC":
        endAngle = (4.0 / 4.0) * Double.pi
    default:
        endAngle = 0.0
    }

    let partialEllipse = Ellipse(center: Point(x: x, y: y), radiusX: size, radiusY: size / 2, rotation: 0.0, startAngle: 0.0, endAngle: endAngle, fillMode: .fill)

    return partialEllipse
}
 


class sPlot : RenderableEntity {

    //location of the station plot
    private let x: Int
    private let y: Int
    private let size: Int

    //station ID
    private let station_id: String

    //wind barb
    private let wind_barb_direction: Double //or int   
    private let wind_barb_speed: Int

    //altimeter
    private let altim_in_hg: Double
    
    //dewpoint
    private let dew_point: Double
    
    //visibility
    private let visibility: Int //????

    //weather
    private let precip: Double
    private let precip_in: Double?
    private let pcp3hr_in: Double?
    private let pcp6hr_in: Double?
    private let pcp24hr_in: Double?
    private let snow_in: Double?
    //idk if we need all this


    //cover + flight category
    private let sky_cover1: String?
    private let sky_cover2: String?
    private let sky_cover3: String?
    private let sky_cover4: String?

    private let flight_category: String?


    //temperature
    private let temp_c: Double 
    
    //ceiling
    private let ceiling: Double 
    private let cloud_base_ft_agl1: Int?
    private let cloud_base_ft_agl2: Int?
    private let cloud_base_ft_agl3: Int?
    private let cloud_base_ft_agl4: Int?

    
    init(x: Int, y: Int, size: Int = 5, station_id: String, wind_barb_direction: Double, wind_barb_speed: Int, altim_in_hg: Double, dew_point: Double, visibility: Int, precip: Double, precip_in: Double?, pcp3hr_in: Double?, pcp6hr_in: Double?, pcp24hr_in: Double?, snow_in: Double?, sky_cover1: String?, sky_cover2: String?, sky_cover3: String?, sky_cover4: String?, flight_category: String?, temp_c: Double, ceiling: Double, cloud_base_ft_agl1: Int?, cloud_base_ft_agl2: Int?, cloud_base_ft_agl3: Int?, cloud_base_ft_agl4: Int?) {
        
        self.x = x
        self.y = y
        self.size = size
        self.station_id = station_id
        self.wind_barb_direction = wind_barb_direction
        self.wind_barb_speed = wind_barb_speed
        self.altim_in_hg = altim_in_hg
        self.dew_point = dew_point
        self.visibility = visibility
        self.precip = precip
        self.precip_in = precip_in
        self.pcp3hr_in = pcp3hr_in
        self.pcp6hr_in = pcp6hr_in
        self.pcp24hr_in = pcp24hr_in
        self.snow_in = snow_in
        self.sky_cover1 = sky_cover1
        self.sky_cover2 = sky_cover2
        self.sky_cover3 = sky_cover3
        self.sky_cover4 = sky_cover4
        self.flight_category = flight_category
        self.temp_c = temp_c
        self.ceiling = ceiling
        self.cloud_base_ft_agl1 = cloud_base_ft_agl1
        self.cloud_base_ft_agl2 = cloud_base_ft_agl2
        self.cloud_base_ft_agl3 = cloud_base_ft_agl3
        self.cloud_base_ft_agl4 = cloud_base_ft_agl4


    }
    
    
    
    override func render(canvas: Canvas) {
        let color = getColorForFlightCategory(flight_category)
        let shape = createEllipse(skyCover: sky_cover1!, x: x, y: y, size: size)        
        var fillStyle = FillStyle(color:color)
        var strokeStyle = StrokeStyle(color:color)
        canvas.render(fillStyle, shape) 
        
        let cross1 = Lines(from: Point(x: x - size/2, y: y), to: Point(x: x + size/2, y: y))
        let cross2 = Lines(from: Point(x: x, y: y - size/2), to: Point(x: x, y: y + size/2))
        
        canvas.render(cross1, cross2)
    } 
}


 
*/
