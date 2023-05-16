import Foundation
import Scenes
import Igis

private func getColoFlightCategory(_ category: String?) -> Color {
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
func barb(canvas:Canvas, x:Int, y:Int, length: Int, angle: Double) {
    canvas.render(StrokeStyle(color:Color(.black)))

    if angle <= 90 {
        let anew = Double(angle * (Double.pi / 180.0))
        let xnew = x - Int(Float(length) * (sin(Float(anew))))
        let ynew = y + Int(Float(length) * (cos(Float(anew))))
        let lines = Lines(from:Point(x:x, y:y), to:Point(x:xnew, y:ynew))
//        lines.lineTo(Point(x:xnew , y:ynew))
//        lines.lineTo(Point(x:xnew - length / 2,y:ynew - length / 2))
//        minibarb(lines: lines, x: xnew, y: ynew, length: length / 2, angle: angle, anew: anew )
        canvas.render(lines)
    }
    if angle < 180 && angle > 90 {
        let anew = Double((180.0 - angle) * (Double.pi / 180.0))
        let xnew = x - Int(Float(length) * (sin(Float(anew))))
        let ynew = y - Int(Float(length) * (cos(Float(anew))))
        let lines = Lines(from:Point(x:x, y:y), to:Point(x:xnew, y:ynew))
//        lines.lineTo(Point(x:xnew + length / 2,y:ynew - length / 2))
//        minibarb(lines: lines, x: xnew, y: ynew, length: length / 2, angle: angle, anew: anew )
        canvas.render(lines)
    }

    if angle >= 180 && angle < 270 {
        let anew = Double((angle - 180.0) * (Double.pi / 180.0))
        let xnew = x + Int(Float(length) * (sin(Float(anew))))
        let ynew = y - Int(Float(length) * (cos(Float(anew))))
        let lines = Lines(from:Point(x:x, y:y), to:Point(x:xnew, y:ynew))
  //      lines.lineTo(Point(x:xnew - length / 2,y:ynew - length / 2))
//        minibarb(lines: lines, x: xnew, y: ynew, length: length / 2, angle: angle, anew: anew )
        canvas.render(lines)
    }
    if angle >= 270 && angle < 360 {
        let anew = Double((360.0 - angle) * (Double.pi / 180.0))
        let xnew = x + Int(Float(length) * (sin(Float(anew))))
        let ynew = y + Int(Float(length) * (cos(Float(anew))))
        let lines = Lines(from:Point(x:x, y:y), to:Point(x:xnew, y:ynew))
    //    lines.lineTo(Point(x:xnew + length / 2,y:ynew - length / 2))
//        minibarb(lines: lines, x: xnew, y: ynew, length: length / 2, angle: angle, anew: anew )
        canvas.render(lines)
    }
}


func roundToFive(_ num:Int) -> Int {
    return 5*Int(round(Float(num)/5))
} 

func drawWindBarb(turtle: Turtle, color: Color, speed: Int, angle: Int)  {

    let angle = Double(angle + 180)
    let speed = roundToFive(speed)

    let spineSize = 50
    let half = spineSize / 2
    let barbGap = half / 3

    let halfBarb = 10
    let fullBarb = 20

    turtle.penColor(color: Color(.black))
    turtle.right(degrees:angle)
    turtle.penDown()
    turtle.forward(steps: half)
    turtle.penColor(color: color)
    turtle.push() //halfway pt barbs start
    turtle.forward(steps: half)
    turtle.pop()
    turtle.push()

    if speed == 5 { //why are you special
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
            else { print("error") }

            barbGapMultiplier -= 1
        }
    }
    turtle.penUp()
    turtle.home() //reset turtle
}

func drawBarbMax(turtle: Turtle, speed: Int, angle: Int, gust: Int?, canvasSizeX: Int, canvasSizeY: Int, Point: Point) {

    turtle.penUp()
    turtle.forward(steps:canvasSizeY/2)
    turtle.left(degrees:90)
    turtle.forward(steps:canvasSizeX/2)
    turtle.right(degrees:90)

    turtle.right(degrees:90)
    turtle.forward(steps:Point.x)
    turtle.right(degrees:90)
    turtle.forward(steps:Point.y)
    turtle.right(degrees:180)
    
    
    turtle.penDown()

 
    if gust != nil && gust ?? 0 > speed ?? 0{
        let topSpeed = speed ?? 0

        drawWindBarb(turtle: turtle, color: Color(.red), speed: topSpeed, angle: angle)
        turtle.penUp()
        turtle.home()
        turtle.penDown()
        drawWindBarb(turtle: turtle, color: Color(.black), speed: speed, angle: angle)
    } else {
        drawWindBarb(turtle: turtle, color: Color(.black), speed: speed, angle: angle)
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
    private let precip: String?
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
    private let ceiling: Int? 
    private let cloud_base_ft_agl1: Int?
    private let cloud_base_ft_agl2: Int?
    private let cloud_base_ft_agl3: Int?
    private let cloud_base_ft_agl4: Int?

    //paths for circle
    let path1 = Path(fillMode:.fill)
    let path2 = Path(fillMode:.fill)
    let path3 = Path(fillMode:.fill)
    let path4 = Path(fillMode:.fill) 

    let lrain : Image
    let mrain : Image
    let hrain : Image
    let lsnow : Image
    let msnow : Image
    let hsnow : Image
    let mist : Image
    let drizzle : Image   

    
    
    init(x: Int, y: Int, size: Int=30, station_id: String, wind_dir_degrees: Int, wind_speed_kt: Int, wind_gust_kt: Int?, altim_in_hg: Double, dewpoint_c: Double, visibility: Int, precip: String?, precip_in: Double?, pcp3hr_in: Double?, pcp6hr_in: Double?, pcp24hr_in: Double?, snow_in: Double?, sky_cover1: String?, sky_cover2: String?, sky_cover3: String?, sky_cover4: String?, flight_category: String?, temp_c: Double, ceiling:Int?, cloud_base_ft_agl1: Int?, cloud_base_ft_agl2: Int?, cloud_base_ft_agl3: Int?, cloud_base_ft_agl4: Int?) {
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
        guard let lrainURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=-RA") else {
            fatalError("NO MAP")
        }
        lrain = Image(sourceURL:lrainURL)

        guard let mrainURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=RA") else {
            fatalError("NO MAP")
        }
        mrain = Image(sourceURL:mrainURL)

        guard let hrainURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=%2BRA") else {
            fatalError("NO MAP")
        }
        hrain = Image(sourceURL:hrainURL)

        guard let lsnowURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=-SN") else {
            fatalError("NO MAP")
        }
        lsnow = Image(sourceURL:lsnowURL)

        guard let msnowURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=SN") else {
            fatalError("NO MAP")
        }
        msnow = Image(sourceURL:msnowURL)

        guard let hsnowURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=%2BSN") else {
            fatalError("NO MAP")
        }
        hsnow = Image(sourceURL:hsnowURL)

        guard let mistURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=BR") else {
            fatalError("NO MAP")
        }
        mist = Image(sourceURL:mistURL)

        guard let drizzleURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=-DZ") else {
            fatalError("NO MAP")
        }
        drizzle = Image(sourceURL:drizzleURL)

        super.init(name:"stationPlot")
    } 
    
    override func setup(canvasSize:Size, canvas:Canvas) {
        canvas.setup(lrain, mrain, hrain, lsnow, msnow, hsnow, mist, drizzle)
    } 
    
    override func render(canvas: Canvas) {
        if lrain.isReady && mrain.isReady && hrain.isReady && lsnow.isReady && msnow.isReady && hsnow.isReady && mist.isReady && drizzle.isReady{
            let fillStyle = FillStyle(color:getColoFlightCategory(flight_category))
            let strokeStyle = StrokeStyle(color:getColoFlightCategory(flight_category))
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


            let id = (Text(location:Point(x:x + (size * (3/2)), y:y + (size * (3/2))), text:"\(station_id)"))
            id.font = "\(size/2)pt Arial"
            canvas.render(FillStyle(color:Color(.black)), id)

            let temp = (Text(location:Point(x:x - (size * (5/2)), y: y - (size * (3/2))), text:"\(temp_c)"))
            temp.font = "\(size/2)pt Arial"
            canvas.render(FillStyle(color:Color(.black)), temp)

            let altimeter = (Text(location:Point(x:x + (size * (3/2)), y: y - (size * (3/2))), text:"\(Int(altim_in_hg))"))
            temp.font = "\(size/2)pt Arial"
            canvas.render(FillStyle(color:Color(.black)), altimeter)

            let dew = (Text(location:Point(x:x - (size * (5/2)), y:y + (size * (3/2))), text:"\(Int(dewpoint_c))"))
            temp.font = "\(size/2)pt Arial"
            canvas.render(FillStyle(color:Color(.black)), dew)

            let visibilit = (Text(location:Point(x:x - (size * 3), y:y), text:"\(Int(visibility))"))
            temp.font = "\(size/2)pt Arial"
            canvas.render(FillStyle(color:Color(.black)), visibilit)
            

            if ceiling != nil {
                let ceilin = (Text(location:Point(x:x + (size * 2), y:y), text:"\(Int(ceiling!))"))
                temp.font = "\(size/2)pt Arial"
                canvas.render(FillStyle(color:Color(.black)), ceilin)
            }
            switch precip {
            case "-RA":
                lrain.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(lrain)
            case "RA":
                mrain.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(mrain)
            case "%2BRA":
                hrain.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(hrain)
            case "-SN":
                lsnow.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(lsnow)
            case "SN":
                msnow.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(msnow)
            case "%2BSN":
                hsnow.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(hsnow)
            case "BR":
                mist.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(mist)
            case "-DZ":
                hsnow.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(drizzle)
            default:
                do {}
            }
//            barb(canvas: canvas, x: x, y: y, length: size*2, angle: Double(wind_dir_degrees))
            if let canvasSize = canvas.canvasSize{
                let turtle = Turtle(canvasSize:canvasSize)
                drawBarbMax(turtle: turtle, speed: wind_speed_kt, angle: wind_dir_degrees, gust: wind_gust_kt, canvasSizeX: canvasSize.width, canvasSizeY: canvasSize.height, Point: Point(x:x,y:y))
                canvas.render(turtle)
            }
        }
    }
} 
