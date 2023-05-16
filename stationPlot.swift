import Foundation
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

func roundToFive(_ number: Int) -> Int {
    let remainder = number % 5
    let multiple = number / 5
    let roundedMultiple = multiple + (remainder >= 3 ? 1 : 0)
    return roundedMultiple * 5
}
 
 
func Triangle(canvas:Canvas,fillStyle:FillStyle,leftpoint: DoublePoint,toppoint: DoublePoint,rightpoint:DoublePoint,triangle:Path) {
    //Triangle
    triangle.lineTo(Point(leftpoint))
    triangle.lineTo(Point(toppoint))
    triangle.lineTo(Point(rightpoint))
    triangle.lineTo(Point(leftpoint))
    triangle.moveTo(Point(rightpoint))
    canvas.render(fillStyle,triangle)
}
/*
func makeBarb(canvas:Canvas, center: Point, wind_dir_degrees: Double, wind_speed_kt:Int, size:Int){
    let line = Lines(from:center, to: Point(x:center.x, y:center.y - size*3))

    let strokeBlack = StrokeStyle(color:Color(.black))
    canvas.render(strokeBlack, line)

    let radians = wind_dir_degrees * Double.pi / 180.0
    let transform = Transform(rotateRadians: radians)

    
    }*/
func makeBarb(turtle:Turtle, color: Color, speed:Int, angle:Int){
    let speed = roundToFive(speed)
    let ang = Double(angle)
    
    let spineSize = 50
    let half = spineSize / 2
    let barbGap = half / 3

    let halfBarb = 10
    let fullBarb = 20

    turtle.penColor(color: color)
    turtle.right(degrees:ang)
    turtle.penDown()
    turtle.forward(steps: half)
    turtle.push() //halfway pt barbs start
    turtle.forward(steps: half)
    turtle.pop()
    turtle.push()

    if speed == 5 {
        turtle.forward(steps: barbGap * 2)
        turtle.right(degrees: 90.0)
        turtle.forward(steps: halfBarb)
        turtle.pop()
    }

    if speed > 5 && speed <= 40 {
        var drawn = speed
        var barbGapMultiplier = 3


        while drawn > 0 {

            //print(drawn)

            turtle.forward(steps: barbGap * barbGapMultiplier)
            turtle.right(degrees: 90)

            if drawn >= 10 {
                turtle.forward(steps: fullBarb)
                drawn -= 10
                turtle.pop()
                turtle.push()
            }
            else if drawn == 5 {
                turtle.forward(steps: halfBarb)
                drawn -= 5
                turtle.pop()
            }
            else { print("Unexpected wind barb interval") }

            barbGapMultiplier -= 1
        }
    }

    turtle.home() //reset turtle
}

func drawBarbComplete(turtle: Turtle, speed: Int, gust: Int?, angle: Int) {

    if gust != 0 {
        let topSpeed = gust!

        makeBarb(turtle: turtle, color: Color(.red), speed: topSpeed, angle: angle)
        makeBarb(turtle: turtle, color: Color(.black), speed: speed, angle: angle)
    } else {
        makeBarb(turtle: turtle, color: Color(.black), speed: speed, angle: angle)
    }
} 


class StationPlot : RenderableEntity {
    var didDraw = false
    
    //location of the station plot
    private let x: Int
    private let y: Int
    private let size: Int

    //station ID
    private let station_id: String

    //wind barb
    private let wind_dir_degrees: Int //or int   
    private let wind_speed_kt: Int
    private let wind_gust_kt: Int?
    
    //altimeter
    private let altim_in_hg: Double
    
    //dewpoint_c
    private let dewpoint_c: Double
    
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

    //paths for circle
    let path1 = Path(fillMode:.fill)
    let path2 = Path(fillMode:.fill)
    let path3 = Path(fillMode:.fill)
    let path4 = Path(fillMode:.fill) 

    
    
    init(x: Int, y: Int, size: Int=30, station_id: String, wind_dir_degrees: Int, wind_speed_kt: Int, wind_gust_kt: Int?, altim_in_hg: Double, dewpoint_c: Double, visibility: Int, precip: Double, precip_in: Double?, pcp3hr_in: Double?, pcp6hr_in: Double?, pcp24hr_in: Double?, snow_in: Double?, sky_cover1: String?, sky_cover2: String?, sky_cover3: String?, sky_cover4: String?, flight_category: String?, temp_c: Double, ceiling: Double, cloud_base_ft_agl1: Int?, cloud_base_ft_agl2: Int?, cloud_base_ft_agl3: Int?, cloud_base_ft_agl4: Int?) {
        self.x = x
        self.y = y
        self.size = size
        self.station_id = station_id
        self.wind_dir_degrees = wind_dir_degrees
        self.wind_speed_kt = wind_speed_kt
        self.wind_gust_kt = wind_gust_kt
        self.altim_in_hg = altim_in_hg
        self.dewpoint_c = dewpoint_c
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
        let fillStyle = FillStyle(color:getColorForFlightCategory(flight_category))
        let strokeStyle = StrokeStyle(color:getColorForFlightCategory(flight_category))
        canvas.render(fillStyle, strokeStyle)

        let circle = Ellipse(center:Point(x: x, y: y), radiusX: size, radiusY: size, fillMode: .stroke)
        let fullcircle = Ellipse(center:Point(x: x, y: y), radiusX: size, radiusY: size, fillMode: .fill)

        path1.arc(center:Point(x:x, y:y), radius:size, startAngle: -(Double.pi / 2), endAngle: 0)

        path2.arc(center:Point(x:x, y:y), radius:size, startAngle:0, endAngle:(Double.pi / 2))

        path3.arc(center:Point(x:x, y:y), radius:size, startAngle:(Double.pi / 2), endAngle: Double.pi)

        switch sky_cover1 {
        case "SKC":
            canvas.render(circle)
        case "FEW":
            canvas.render(path1, circle)
            Triangle(canvas:canvas,fillStyle:fillStyle,leftpoint:DoublePoint(x:x,y:y),toppoint:DoublePoint(x:x,y:y-size),rightpoint:DoublePoint(x:x+size,y:y),triangle:path1)
        case "SCT":
            canvas.render(path1, path2, circle)
            Triangle(canvas:canvas,fillStyle:fillStyle,leftpoint:DoublePoint(x:x,y:y),toppoint:DoublePoint(x:x,y:y-size),rightpoint:DoublePoint(x:x+size,y:y),triangle:path1)
            Triangle(canvas:canvas,fillStyle:fillStyle,leftpoint:DoublePoint(x:x,y:y+size),toppoint:DoublePoint(x:x,y:y),rightpoint:DoublePoint(x:x+size,y:y),triangle:path2)
        case "BKN":
            canvas.render(path1, path2, path3, circle)
            Triangle(canvas:canvas,fillStyle:fillStyle,leftpoint:DoublePoint(x:x,y:y),toppoint:DoublePoint(x:x,y:y-size),rightpoint:DoublePoint(x:x+size,y:y),triangle:path1)
            Triangle(canvas:canvas,fillStyle:fillStyle,leftpoint:DoublePoint(x:x,y:y+size),toppoint:DoublePoint(x:x,y:y),rightpoint:DoublePoint(x:x+size,y:y),triangle:path2)
            Triangle(canvas:canvas,fillStyle:fillStyle,leftpoint:DoublePoint(x:x-size,y:y),toppoint:DoublePoint(x:x,y:y),rightpoint:DoublePoint(x:x,y:y+size),triangle:path3)
        case "OVC":
            canvas.render(fullcircle)
        default:
            canvas.render(circle)
        }

        let id = (Text(location:Point(x:x + (size * 2) - (size / 2), y:y + (size * 2) - (size / 2)), text:"\(station_id)"))
        id.font = "\(size)pt Arial" 
        //        let rect = Rect(topLeft:Point(x:x + (size * (3/2)) - 2, y:y + (size * (3/2)) - 2), size:Size(width:(size * 2) + 4, height:size + 4))
        //        let rectangle = Rectangle(rect:rect, fillMode:.fill)
//        makeBarb(canvas: canvas, center:Point(x:x,y:y) , wind_dir_degrees: wind_dir_degrees, wind_speed_kt: wind_speed_kt, size: size)
        canvas.render(FillStyle(color:Color(.black)), FillStyle(color:Color(.white)), id)
        if let canvasSize = canvas.canvasSize{
            let turtle = Turtle(canvasSize:canvasSize)
            drawBarbComplete(turtle: turtle, speed: wind_speed_kt, gust: wind_gust_kt, angle: wind_dir_degrees)
            canvas.render(turtle)
            //        drawBarbMax(turtle: turtle, )
        didDraw = true
        }
    }
}
 

 
